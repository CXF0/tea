import type { PoolConnection, RowDataPacket } from '../../database.js'
import { database } from '../../database.js'
import type { GoodFlowerVideoItemRow, QualityTaskRow, SubmitInspectionCommand, SupplierFlowerItemRow } from './quality.types.js'

export async function hasCapability(userId: number, capability: string) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT 1 allowed
       FROM wms_account account
       JOIN wms_role_permission_group role_group ON role_group.role_id = account.role_id
       JOIN wms_permission_group permission_group ON permission_group.id = role_group.group_id AND permission_group.status = 1
       JOIN wms_permission_group_item group_item ON group_item.group_id = permission_group.id
       JOIN wms_permission permission ON permission.id = group_item.permission_id AND permission.status = 1
      WHERE account.id = ? AND account.status = 1 AND permission.code = ?
      LIMIT 1`,
    [userId, capability],
  )
  return rows.length > 0
}

export async function getOwnedQualityTeam(accountId: number) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT team.id, team.name, team.perm_config
       FROM wms_account_source_identity identity_record
       JOIN xm_bulky_team team
         ON team.leader_id = identity_record.source_user_id
        AND team.type = 4
        AND team.active_flag = 1
        AND team.data_status = 0
      WHERE identity_record.account_id = ?
        AND identity_record.source_system = 'bulkyGoods'
      ORDER BY team.id
      LIMIT 1`,
    [accountId],
  )
  return rows[0] ?? null
}

export async function getQualityDataScope(accountId: number) {
  const [accounts] = await database.query<RowDataPacket[]>(`SELECT role.code role_code FROM wms_account account JOIN wms_role role ON role.id=account.role_id WHERE account.id=? AND account.status=1 LIMIT 1`, [accountId])
  const [areas] = await database.query<RowDataPacket[]>(`SELECT code,area_name FROM xm_bulky_wms_area WHERE status=1 ORDER BY sequence,CAST(code AS UNSIGNED),code`)
  if (String(accounts[0]?.role_code) === 'superAdmin') return { all: true, areas }
  const [direct] = await database.query<RowDataPacket[]>(`SELECT zone_code FROM wms_account_inspection_area WHERE account_id=?`, [accountId])
  const team = await getOwnedQualityTeam(accountId)
  let teamZones: string[] = []
  try { const config=JSON.parse(String(team?.perm_config||'{}'));teamZones=Array.isArray(config.zones)?config.zones.map(String):[] } catch {}
  const allowed = new Set([...direct.map(row=>String(row.zone_code)),...teamZones].map(zone=>String(Number(zone))))
  return { all: false, areas: areas.filter(row=>allowed.has(String(Number(row.code)))) }
}

export async function getTeamQualityTaskStatistics(date: string, zones: string[]) {
  if (!zones.length) return []
  const numericZones = zones.map(Number).filter((zone) => Number.isInteger(zone) && zone > 0)
  if (!numericZones.length) return []
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT CAST(inspection.zoen_shelf AS UNSIGNED) zone,
            COALESCE(area.area_name, CONCAT(CAST(inspection.zoen_shelf AS UNSIGNED), '区')) zone_name,
            COUNT(*) total,
            SUM(inspection.status <> 0) completed,
            SUM(inspection.status = 0) pending,
            SUM(inspection.status IN (1, 2)) passed,
            SUM(inspection.status = 10) rejected,
            COUNT(DISTINCT CASE WHEN inspection.assigned_user_id IS NOT NULL THEN inspection.assigned_user_id END) inspector_count,
            GROUP_CONCAT(DISTINCT inspection.assigned_user_id ORDER BY inspection.assigned_user_id) inspector_ids
       FROM xm_bulky_inspection inspection
       LEFT JOIN xm_bulky_wms_area area
         ON CAST(area.code AS UNSIGNED) = CAST(inspection.zoen_shelf AS UNSIGNED)
        AND area.status = 1
      WHERE inspection.date = ?
        AND inspection.delete_time IS NULL
        AND CAST(inspection.zoen_shelf AS UNSIGNED) IN (?)
      GROUP BY inspection.zoen_shelf, area.area_name
      ORDER BY CAST(inspection.zoen_shelf AS UNSIGNED)`,
    [date, numericZones],
  )
  return rows
}

export async function listQualityTasks(date: string, status?: number, assigneeUserId?: number) {
  const params: Array<string | number> = [date]
  let statusClause = ''
  if (status !== undefined) {
    statusClause = ' AND inspection.status = ?'
    params.push(status)
  }
  if (assigneeUserId !== undefined) {
    statusClause += ' AND inspection.assigned_user_id = ?'
    params.push(assigneeUserId)
  }

  const [rows] = await database.query<(QualityTaskRow & RowDataPacket)[]>(
    `SELECT id, date, enter_item_id, shelf_sn, zoen_shelf, sub_shelf_sn,
            inspection.product_name, inspection.rank_num, inspection.sku_config, inspection.item_num,
            COALESCE(item.prepare_item_num, 0) prepare_item_num, inspection.supplier_name,
            inspection_flag, focus_flag, big_order, new_order, refund_product, quality_product, quality_flag, receive_tel, status, assigned_user_id,
            assigned_user_name, remark, finish_time
       FROM xm_bulky_inspection inspection
       LEFT JOIN (SELECT id enter_item_key, prepare_item_num FROM xm_bulky_supplier_enter_item WHERE data_status = 0) item ON item.enter_item_key = inspection.enter_item_id
      WHERE inspection.date = ? AND inspection.delete_time IS NULL${statusClause}
      ORDER BY inspection_flag DESC, focus_flag DESC, shelf_sn, sub_shelf_sn, id`,
    params,
  )
  return rows
}

export async function listSelfInspectionLocations(date: string, userId?: number) {
  const userClause = userId === undefined ? '' : ' AND reason.user_id = ?'
  const params: Array<string | number> = userId === undefined ? [date] : [date, userId]
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT item.zone_shelf, item.sub_shelf_sn,
            COUNT(DISTINCT item.id) flower_count,
            COUNT(DISTINCT reason.code_content) marked_unit_count,
            MAX(reason.create_time) latest_mark_time,
            MAX(CASE WHEN reason.op IN (3, 5) THEN 1 ELSE 0 END) return_mark,
            MAX(CASE WHEN reason.op = 12 THEN 1 ELSE 0 END) exchange_mark,
            GROUP_CONCAT(DISTINCT CONCAT(item.product_name, ' ',
              CASE item.rank_num WHEN 1 THEN 'A级' WHEN 2 THEN 'B级' WHEN 3 THEN 'C级' WHEN 4 THEN 'D级' WHEN 5 THEN 'E级' ELSE CONCAT(item.rank_num, '级') END)
              ORDER BY item.id SEPARATOR '、') flower_summary,
            GROUP_CONCAT(DISTINCT entry.supplier_name ORDER BY entry.supplier_name SEPARATOR '、') supplier_summary
       FROM xm_inspection_reason_record reason
       JOIN xm_bulky_supplier_enter_item item ON item.id = reason.enter_item_id AND item.data_status = 0
       JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
      WHERE reason.date = ? AND reason.data_status = 0 AND reason.op IN (3, 5, 12)${userClause}
      GROUP BY item.zone_shelf, item.sub_shelf_sn
      ORDER BY latest_mark_time DESC, item.zone_shelf, item.sub_shelf_sn`, params,
  )
  return rows
}

export async function getGoodFlowerVideoSummary(date: string, userId: number) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT COALESCE(snapshot.good_flower_video_required_num, 0) required,
            COUNT(record.id) completed
       FROM (SELECT ? round_no, ? user_id) input
       LEFT JOIN xm_bulky_inspection_assign_snapshot snapshot
         ON snapshot.round_no = input.round_no AND snapshot.user_id = input.user_id
       LEFT JOIN xm_bulky_inspection_video_record record
         ON record.date = input.round_no AND record.user_id = input.user_id
      GROUP BY snapshot.good_flower_video_required_num`, [date, userId],
  )
  return rows[0] ?? { required: 0, completed: 0 }
}

export async function listGoodFlowerVideos(date: string, userId: number) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT id, enter_item_id, item_name, rank_num, supplier_name, supplier_tag,
            sub_shelf_sn, zone_shelf, video_url, remark, create_time, update_time
       FROM xm_bulky_inspection_video_record
      WHERE date = ? AND user_id = ? ORDER BY update_time DESC, id DESC`, [date, userId],
  )
  return rows
}

export async function getGoodFlowerVideoItem(itemId: number, date: string) {
  const [rows] = await database.query<(GoodFlowerVideoItemRow & RowDataPacket)[]>(
    `SELECT item.id, item.enter_id, item.date, item.product_id, item.product_name,
            item.rank_num, item.supplier_id, entry.supplier_name,
            supplier.supplier_tag, item.sub_shelf_sn, item.zone_shelf, item.order_num
       FROM xm_bulky_supplier_enter_item item
       JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
       LEFT JOIN xm_bulky_supplier supplier ON supplier.id = item.supplier_id
      WHERE item.id = ? AND item.date = ? AND item.data_status = 0 LIMIT 1`, [itemId, date],
  )
  return rows[0]
}

export async function saveGoodFlowerVideo(command: { userId: number; userName: string; date: string; item: GoodFlowerVideoItemRow; videoUrl: string; remark: string }) {
  const connection = await database.getConnection()
  try {
    await connection.beginTransaction()
    await connection.execute(
      `INSERT INTO xm_bulky_inspection_assign_snapshot
        (round_no, user_id, user_name, good_flower_video_required_num)
       VALUES (?, ?, ?, 0)
       ON DUPLICATE KEY UPDATE user_name = VALUES(user_name)`, [command.date, command.userId, command.userName],
    )
    const [snapshots] = await connection.query<RowDataPacket[]>(
      'SELECT id FROM xm_bulky_inspection_assign_snapshot WHERE round_no = ? AND user_id = ? LIMIT 1', [command.date, command.userId],
    )
    const shelfSn = Number(String(command.item.zone_shelf ?? '').match(/\d+/g)?.at(-1) ?? command.item.order_num)
    const [result] = await connection.execute(
      `INSERT INTO xm_bulky_inspection_video_record
        (user_id, date, snapshot_id, enter_item_id, product_id, item_name, supplier_name,
         supplier_tag, sub_shelf_sn, zone_shelf, video_url, remark, rank_num, supplier_id,
         shelf_sn, create_time, update_time)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())`,
      [command.userId, command.date, snapshots[0].id, command.item.id, command.item.product_id,
        command.item.product_name, command.item.supplier_name, command.item.supplier_tag ?? '',
        command.item.sub_shelf_sn ?? '', command.item.zone_shelf ?? '', command.videoUrl,
        command.remark, command.item.rank_num, command.item.supplier_id, shelfSn || command.item.order_num],
    )
    await connection.commit()
    return Number((result as { insertId: number }).insertId)
  } catch (error) { await connection.rollback(); throw error } finally { connection.release() }
}

export async function getQualityTask(taskId: number) {
  const [rows] = await database.query<(QualityTaskRow & RowDataPacket)[]>(
    `SELECT id, date, enter_item_id, shelf_sn, zoen_shelf, sub_shelf_sn,
            inspection.product_name, inspection.rank_num, inspection.sku_config, inspection.item_num,
            COALESCE(item.prepare_item_num, 0) prepare_item_num, inspection.supplier_name,
            inspection_flag, focus_flag, big_order, new_order, refund_product, quality_product, quality_flag, receive_tel, status, assigned_user_id,
            assigned_user_name, remark, finish_time
       FROM xm_bulky_inspection inspection
       LEFT JOIN (SELECT id enter_item_key, prepare_item_num FROM xm_bulky_supplier_enter_item WHERE data_status = 0) item ON item.enter_item_key = inspection.enter_item_id
      WHERE inspection.id = ? AND inspection.delete_time IS NULL
      LIMIT 1`,
    [taskId],
  )
  return rows[0]
}

export async function listSupplierFlowerItems(enterId: number) {
  const [rows] = await database.query<(SupplierFlowerItemRow & RowDataPacket)[]>(
    `SELECT id, enter_id, zone_shelf, order_num, sub_shelf_sn, product_name,
            rank_num, sku_config, item_num, is_position, is_qualify,
            not_qualify_num, qualify_user_name, update_time
       FROM xm_bulky_supplier_enter_item
      WHERE enter_id = ? AND data_status = 0
      ORDER BY order_num, sub_shelf_sn, id`,
    [enterId],
  )
  return rows
}

export async function getSupplierFlowerItem(itemId: number) {
  const [rows] = await database.query<(SupplierFlowerItemRow & RowDataPacket)[]>(
    `SELECT item.id, item.enter_id, item.date, item.zone_shelf, item.order_num,
            item.sub_shelf_sn, item.product_name, item.rank_num, item.sku_config,
            item.item_num, item.is_position, item.is_qualify, item.not_qualify_num,
            item.qualify_user_name, item.update_time, entry.supplier_name,
            entry.login_tel supplier_phone, purchaser.nickname customer_name,
            purchaser.phone_number customer_phone, partner.name partner_name,
            order_item.supply_price supplier_price, orders.unqualified_way, item.limit_distribution_flag, item.duty_flag,
            item.no_after_sale_flag, item.duty_remark, item.duty_media_json
       FROM xm_bulky_supplier_enter_item item
       JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
       LEFT JOIN xm_bulky_order_item order_item ON order_item.id = item.order_item_id AND order_item.data_status = 0
       LEFT JOIN xm_bulky_order orders ON orders.order_sn = order_item.order_sn AND orders.data_status = 0
       LEFT JOIN xm_bulky_purchaser purchaser ON purchaser.id = order_item.purchaser_id
       LEFT JOIN partner ON partner.id = orders.partner_id
      WHERE item.id = ? AND item.data_status = 0 LIMIT 1`,
    [itemId],
  )
  return rows[0]
}

export async function listSupplierFlowerItemMarks(itemId: number) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT code_content, op
       FROM xm_inspection_reason_record
      WHERE enter_item_id = ? AND data_status = 0
      GROUP BY code_content, op
      ORDER BY code_content`,
    [itemId],
  )
  return rows
}

export async function listAllocatedUnits(itemId: number) { const [rows] = await database.query<RowDataPacket[]>('SELECT unit_no FROM xm_quality_unit_allocation WHERE enter_item_id=? AND allocated=1',[itemId]); return rows.map(row=>Number(row.unit_no)) }
export async function updateUnitAllocation(itemId:number,units:number[],allocated:boolean,userId:number,userName:string) { await database.query(`INSERT INTO xm_quality_unit_allocation (enter_item_id,unit_no,allocated,operator_id,operator_name) VALUES ? ON DUPLICATE KEY UPDATE allocated=VALUES(allocated),operator_id=VALUES(operator_id),operator_name=VALUES(operator_name),update_time=NOW()`,[units.map(unit=>[itemId,unit,allocated?1:0,userId,userName])]) }
export async function revokeInspectionMarks(itemId:number,units:number[]) { const connection=await database.getConnection(); try { await connection.beginTransaction(); const [result]=await connection.query(`UPDATE xm_inspection_reason_record SET data_status=-100,update_time=NOW() WHERE enter_item_id=? AND data_status=0 AND CAST(SUBSTRING_INDEX(code_content,'-',-1) AS UNSIGNED) IN (?)`,[itemId,units]); const [counts]=await connection.query<RowDataPacket[]>('SELECT COUNT(DISTINCT code_content) count FROM xm_inspection_reason_record WHERE enter_item_id=? AND data_status=0',[itemId]); const count=Number(counts[0]?.count??0); await connection.query('UPDATE xm_bulky_supplier_enter_item SET not_qualify_num=?,is_qualify=?,update_time=NOW() WHERE id=?',[count,count?10:0,itemId]); await connection.commit(); return (result as {affectedRows:number}).affectedRows } catch(error){await connection.rollback();throw error} finally{connection.release()} }

export async function listSupplierFlowerItemLogs(itemId: number) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT code_content, op, reason_name, parent_reason_name, user_name, create_time, data_status
       FROM xm_inspection_reason_record WHERE enter_item_id = ?
      ORDER BY create_time DESC, code_content, reason_id`, [itemId],
  )
  return rows
}

export async function getQualityPunishRule(operation: number) {
  const [rows] = await database.query<RowDataPacket[]>(
    'SELECT operation, operation_name, punish_percent, description FROM xm_quality_punish_config WHERE operation = ? AND data_status = 0 LIMIT 1',
    [operation],
  )
  return rows[0]
}

export async function listQualityPunishRules() {
  const [rows] = await database.query<RowDataPacket[]>(
    'SELECT operation, operation_name, punish_percent, description FROM xm_quality_punish_config WHERE data_status = 0 ORDER BY operation',
  )
  return rows
}

export async function listInspectionReasons(reasonIds: number[]) {
  if (!reasonIds.length) return []
  const [rows] = await database.query<RowDataPacket[]>(
    'SELECT id, reason_name FROM xm_inspection_reason_config WHERE id IN (?) AND level = 2 AND data_status = 0',
    [reasonIds],
  )
  return rows
}

export async function updateSupplierFlowerFlags(itemId: number, flags: { limitDistribution?: boolean; merchantResponsibility?: boolean; noAfterSale?: boolean; remark?: string; media?: string[] }) {
  const updates: string[] = []
  const params: Array<string | number> = []
  if (flags.limitDistribution !== undefined) { updates.push('limit_distribution_flag = ?'); params.push(flags.limitDistribution ? 1 : 0) }
  if (flags.merchantResponsibility !== undefined) { updates.push('duty_flag = ?'); params.push(flags.merchantResponsibility ? 1 : 0); updates.push('duty_remark = ?'); params.push(flags.remark ?? ''); updates.push('duty_media_json = ?'); params.push(JSON.stringify(flags.media ?? [])) }
  if (flags.noAfterSale !== undefined) { updates.push('no_after_sale_flag = ?'); params.push(flags.noAfterSale ? 1 : 0) }
  if (!updates.length) return 0
  params.push(itemId)
  const [result] = await database.execute(`UPDATE xm_bulky_supplier_enter_item SET ${updates.join(', ')}, update_time = NOW() WHERE id = ? AND data_status = 0`, params)
  return (result as { affectedRows: number }).affectedRows
}

export async function inspectSupplierFlowerItem(itemId: number, command: { status: 1 | 10; affectedUnits: number[]; reasonIds: number[]; operation: number; evidenceMedia: string[]; allowDowngradeRestock: boolean; userId: number; userName: string }) {
  const connection = await database.getConnection()
  try {
    await connection.beginTransaction()
    const [rows] = await connection.query<(SupplierFlowerItemRow & RowDataPacket)[]>(
      'SELECT * FROM xm_bulky_supplier_enter_item WHERE id = ? AND data_status = 0 FOR UPDATE', [itemId],
    )
    const item = rows[0]
    if (!item) { await connection.rollback(); return { kind: 'not_found' as const } }
    if (command.affectedUnits.some(unit => unit > item.item_num)) { await connection.rollback(); return { kind: 'quantity_exceeded' as const } }
    const reasons = command.reasonIds.length ? await connection.query<RowDataPacket[]>(
      `SELECT child.id, child.reason_name, parent.id parent_id, parent.reason_name parent_name
         FROM xm_inspection_reason_config child
         JOIN xm_inspection_reason_config parent ON parent.id = child.parent_id
        WHERE child.id IN (?) AND child.level = 2 AND child.data_status = 0 AND parent.data_status = 0`, [command.reasonIds],
    ).then(([reasonRows]) => reasonRows) : []
    if (command.status === 10 && reasons.length !== command.reasonIds.length) { await connection.rollback(); return { kind: 'invalid_reason' as const } }
    if (command.status === 10) {
      await connection.query(
        `UPDATE xm_inspection_reason_record
            SET data_status = -100, update_time = NOW()
          WHERE date = ? AND enter_item_id = ? AND data_status = 0
            AND CAST(SUBSTRING_INDEX(code_content, '-', -1) AS UNSIGNED) IN (?)`,
        [item.date, itemId, command.affectedUnits],
      )
    } else {
      await connection.execute(
        `UPDATE xm_inspection_reason_record
            SET data_status = -100, update_time = NOW()
          WHERE date = ? AND enter_item_id = ? AND data_status = 0`,
        [item.date, itemId],
      )
    }
    if (command.status === 10) {
      for (const unit of command.affectedUnits) {
        for (const reason of reasons) {
          await connection.execute(
            `INSERT INTO xm_inspection_reason_record
              (date, enter_item_id, order_item_id, code_content, op, reason_id, reason_name,
               parent_reason_id, parent_reason_name, user_id, user_name, evidence_media_json, allow_downgrade_restock)
             VALUES (?, ?, 0, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [item.date, itemId, `QI-${itemId}-${unit}`, command.operation, reason.id, reason.reason_name, reason.parent_id, reason.parent_name, command.userId, command.userName, JSON.stringify(command.evidenceMedia), command.allowDowngradeRestock ? 1 : 0],
          )
        }
      }
    }
    const [activeMarks] = await connection.query<RowDataPacket[]>(
      `SELECT COUNT(DISTINCT code_content) AS count
         FROM xm_inspection_reason_record
        WHERE date = ? AND enter_item_id = ? AND data_status = 0`,
      [item.date, itemId],
    )
    const activeMarkedUnits = Number(activeMarks[0]?.count ?? 0)
    await connection.execute(
      `UPDATE xm_bulky_supplier_enter_item
          SET is_qualify = ?, not_qualify_num = ?, qualify_user_id = ?,
              qualify_user_name = ?, update_time = NOW()
        WHERE id = ?`,
      [activeMarkedUnits > 0 ? 10 : 0, activeMarkedUnits, command.userId, command.userName, itemId],
    )
    await connection.execute(
      `UPDATE xm_bulky_supplier_enter entry
          SET is_qualify = EXISTS(
            SELECT 1 FROM xm_bulky_supplier_enter_item item
             WHERE item.enter_id = entry.id AND item.data_status = 0 AND item.is_qualify = 10
          ), update_time = NOW()
        WHERE entry.id = ?`,
      [item.enter_id],
    )
    await connection.commit()
    return { kind: 'success' as const }
  } catch (error) { await connection.rollback(); throw error } finally { connection.release() }
}

export async function getQualitySummary(date: string) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT COUNT(*) AS total,
            SUM(status = 0) AS pending,
            SUM(status IN (1, 2)) AS passed,
            SUM(status = 10) AS rejected,
            SUM(inspection_flag = 1 AND status = 0) AS priorityPending
       FROM xm_bulky_inspection
      WHERE date = ? AND delete_time IS NULL`,
    [date],
  )
  return rows[0]
}

export async function getQualityBusinessSummary(date: string, zones: string[]) {
  if (!zones.length) return {}
  const numericZones=zones.map(Number).filter(Boolean)
  const [entryRows] = await database.query<RowDataPacket[]>(
    `SELECT COUNT(DISTINCT entry.id) required_suppliers,
            COUNT(DISTINCT CASE WHEN entry.data_status=0 THEN entry.id END) pending_suppliers,
            COUNT(DISTINCT CASE WHEN entry.data_status=1 THEN entry.id END) admitted_suppliers
       FROM xm_bulky_supplier_enter entry
       JOIN xm_bulky_supplier_enter_item item ON item.enter_id=entry.id AND item.data_status=0
      WHERE entry.date = ? AND CAST(item.zone AS UNSIGNED) IN (?)`, [date,numericZones],
  )
  const [inspectionRows] = await database.query<RowDataPacket[]>(
    `SELECT COUNT(DISTINCT CASE WHEN op IN (1, 2) THEN code_content END) downgrade_units,
            COUNT(DISTINCT CASE WHEN op IN (3, 5) THEN code_content END) return_units,
            COUNT(DISTINCT CASE WHEN op IN (6, 7) THEN code_content END) shortage_units,
            COUNT(DISTINCT CASE WHEN op = 12 THEN code_content END) exchange_units,
            COUNT(DISTINCT CASE WHEN reason.op IN (1, 2, 3, 5, 6, 7, 12) THEN CONCAT(item.zone_shelf, '#', COALESCE(item.sub_shelf_sn, '')) END) involved_location_count,
            COUNT(DISTINCT CASE WHEN reason.op IN (1, 2, 3, 5, 6, 7, 12) THEN entry.supplier_id END) involved_supplier_count
       FROM xm_inspection_reason_record reason
       JOIN xm_bulky_supplier_enter_item item ON item.id=reason.enter_item_id AND item.data_status=0
       JOIN xm_bulky_supplier_enter entry ON entry.id=item.enter_id
      WHERE reason.date = ? AND reason.data_status = 0 AND CAST(item.zone AS UNSIGNED) IN (?)`, [date,numericZones],
  )
  const [exchangeRows] = await database.query<RowDataPacket[]>(
    `SELECT COALESCE(SUM(handle_num), 0) exchanged_units
       FROM xm_bulky_exchange_log
      WHERE round_no = ? AND status = 0 AND CAST(zone_shelf AS UNSIGNED) IN (?)`, [date,numericZones],
  )
  const [resaleRows] = await database.query<RowDataPacket[]>(
    `SELECT COUNT(*) resale_units
       FROM sale_inspection_item
      WHERE round_no = ? AND CAST(zone AS UNSIGNED) IN (?)`, [date,numericZones],
  )
  return { ...(entryRows[0] || {}), ...(inspectionRows[0] || {}), ...(exchangeRows[0] || {}), ...(resaleRows[0] || {}) }
}

export async function getQualityStatisticsDetail(date: string, zones: string[], keyword = '', operations: number[] = []) {
  if (!zones.length) return { summary: {}, zoneRows: [], staffRows: [], supplierLocationRows: [] }
  const numericZones = zones.map(Number).filter(Boolean)
  if (!numericZones.length) return { summary: {}, zoneRows: [], staffRows: [], supplierLocationRows: [] }
  const trimmedKeyword = keyword.trim()
  const operationClause = operations.length ? ' AND reason.op IN (?)' : ''
  const searchClause = trimmedKeyword
    ? ` AND (
          reason.user_name LIKE ?
          OR entry.supplier_name LIKE ?
          OR item.zone_shelf LIKE ?
          OR item.sub_shelf_sn LIKE ?
        )`
    : ''
  const scopeParams: Array<string | number | number[]> = [date, numericZones]
  if (operations.length) scopeParams.push(operations)
  if (trimmedKeyword) {
    const like = `%${trimmedKeyword}%`
    scopeParams.push(like, like, like, like)
  }
  const resaleSearchClause = trimmedKeyword
    ? ` AND (
          entry.supplier_name LIKE ?
          OR item.zone_shelf LIKE ?
          OR item.sub_shelf_sn LIKE ?
        )`
    : ''
  const resaleParams: Array<string | number | number[]> = [date, numericZones]
  if (trimmedKeyword) {
    const like = `%${trimmedKeyword}%`
    resaleParams.push(like, like, like)
  }
  const [summaryRows] = await database.query<RowDataPacket[]>(
    `SELECT COUNT(DISTINCT CASE WHEN reason.op IN (1, 2) THEN reason.code_content END) downgrade_units,
            COUNT(DISTINCT CASE WHEN reason.op IN (6, 7) THEN reason.code_content END) shortage_units,
            COUNT(DISTINCT CASE WHEN reason.op IN (3, 5) THEN reason.code_content END) return_units,
            COUNT(DISTINCT CASE WHEN reason.op = 12 THEN reason.code_content END) exchange_units,
            COUNT(DISTINCT CONCAT(item.zone_shelf, '#', COALESCE(item.sub_shelf_sn, ''))) involved_location_count,
            COUNT(DISTINCT entry.supplier_id) involved_supplier_count
       FROM xm_inspection_reason_record reason
       JOIN xm_bulky_supplier_enter_item item ON item.id = reason.enter_item_id AND item.data_status = 0
       JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
      WHERE reason.date = ?
        AND reason.data_status = 0
        AND CAST(item.zone AS UNSIGNED) IN (?)${operationClause}${searchClause}`,
    scopeParams,
  )
  const [staffRows] = await database.query<RowDataPacket[]>(
    `SELECT reason.user_id inspector_id,
            COALESCE(NULLIF(reason.user_name, ''), '系统') inspector_name,
            COUNT(DISTINCT CASE WHEN reason.op IN (1, 2) THEN reason.code_content END) downgrade_units,
            COUNT(DISTINCT CASE WHEN reason.op IN (6, 7) THEN reason.code_content END) shortage_units,
            COUNT(DISTINCT CASE WHEN reason.op IN (3, 5) THEN reason.code_content END) return_units,
            COUNT(DISTINCT CASE WHEN reason.op = 12 THEN reason.code_content END) exchange_units,
            COUNT(DISTINCT reason.code_content) issue_units
       FROM xm_inspection_reason_record reason
       JOIN xm_bulky_supplier_enter_item item ON item.id = reason.enter_item_id AND item.data_status = 0
       JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
      WHERE reason.date = ?
        AND reason.data_status = 0
        AND CAST(item.zone AS UNSIGNED) IN (?)${operationClause}${searchClause}
      GROUP BY reason.user_id, reason.user_name
      ORDER BY issue_units DESC, inspector_name
      LIMIT 200`,
    scopeParams,
  )
  const [zoneRows] = await database.query<RowDataPacket[]>(
    `SELECT area.code zone, area.area_name,
            COALESCE(mark.exchange_units, 0) exchange_units,
            COALESCE(mark.shortage_units, 0) shortage_units,
            COALESCE(mark.downgrade_units, 0) downgrade_units,
            COALESCE(resale.resale_units, 0) resale_units
       FROM xm_bulky_wms_area area
       LEFT JOIN (
         SELECT item.zone,
                COUNT(DISTINCT CASE WHEN reason.op = 12 THEN reason.code_content END) exchange_units,
                COUNT(DISTINCT CASE WHEN reason.op IN (6, 7) THEN reason.code_content END) shortage_units,
                COUNT(DISTINCT CASE WHEN reason.op IN (1, 2) THEN reason.code_content END) downgrade_units
           FROM xm_inspection_reason_record reason
           JOIN xm_bulky_supplier_enter_item item ON item.id = reason.enter_item_id AND item.data_status = 0
           JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
          WHERE reason.date = ?
            AND reason.data_status = 0
            AND CAST(item.zone AS UNSIGNED) IN (?)${operationClause}${searchClause}
          GROUP BY item.zone
       ) mark ON mark.zone = area.code
       LEFT JOIN (
         SELECT item.zone, COUNT(*) resale_units
           FROM sale_inspection_item sale
           JOIN xm_bulky_supplier_enter_item item ON item.id = sale.enter_item_id AND item.data_status = 0
           JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
          WHERE sale.round_no = ?
            AND CAST(item.zone AS UNSIGNED) IN (?)${resaleSearchClause}
          GROUP BY item.zone
       ) resale ON resale.zone = area.code
      WHERE area.status = 1 AND CAST(area.code AS UNSIGNED) IN (?)
      ORDER BY area.sequence, CAST(area.code AS UNSIGNED), area.code`,
    [...scopeParams, ...resaleParams, numericZones],
  )
  const [supplierLocationRows] = await database.query<RowDataPacket[]>(
    `SELECT entry.supplier_id,
            entry.supplier_name,
            item.zone_shelf,
            item.sub_shelf_sn,
            COUNT(DISTINCT item.id) flower_count,
            COUNT(DISTINCT CASE WHEN reason.op IN (1, 2) THEN reason.code_content END) downgrade_units,
            COUNT(DISTINCT CASE WHEN reason.op IN (6, 7) THEN reason.code_content END) shortage_units,
            COUNT(DISTINCT CASE WHEN reason.op IN (3, 5) THEN reason.code_content END) return_units,
            COUNT(DISTINCT CASE WHEN reason.op = 12 THEN reason.code_content END) exchange_units,
            COUNT(DISTINCT reason.code_content) issue_units,
            MAX(reason.create_time) latest_mark_time
       FROM xm_inspection_reason_record reason
       JOIN xm_bulky_supplier_enter_item item ON item.id = reason.enter_item_id AND item.data_status = 0
       JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
      WHERE reason.date = ?
        AND reason.data_status = 0
        AND CAST(item.zone AS UNSIGNED) IN (?)${operationClause}${searchClause}
      GROUP BY entry.supplier_id, entry.supplier_name, item.zone_shelf, item.sub_shelf_sn
      ORDER BY issue_units DESC, latest_mark_time DESC
      LIMIT 300`,
    scopeParams,
  )
  return { summary: summaryRows[0] || {}, zoneRows, staffRows, supplierLocationRows }
}

export async function listQualityZoneStatistics(date: string) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT area.code zone, area.area_name,
            COALESCE(mark.exchange_units, 0) exchange_units,
            COALESCE(mark.shortage_units, 0) shortage_units,
            COALESCE(mark.downgrade_units, 0) downgrade_units,
            COALESCE(resale.resale_units, 0) resale_units
       FROM xm_bulky_wms_area area
       LEFT JOIN (
         SELECT item.zone,
                COUNT(DISTINCT CASE WHEN reason.op = 12 THEN reason.code_content END) exchange_units,
                COUNT(DISTINCT CASE WHEN reason.op IN (6, 7) THEN reason.code_content END) shortage_units,
                COUNT(DISTINCT CASE WHEN reason.op IN (1, 2) THEN reason.code_content END) downgrade_units
           FROM xm_inspection_reason_record reason
           JOIN xm_bulky_supplier_enter_item item ON item.id = reason.enter_item_id AND item.data_status = 0
          WHERE reason.date = ? AND reason.data_status = 0
          GROUP BY item.zone
       ) mark ON mark.zone = area.code
       LEFT JOIN (
         SELECT item.zone, COUNT(*) resale_units
           FROM sale_inspection_item sale
           JOIN xm_bulky_supplier_enter_item item ON item.id = sale.enter_item_id AND item.data_status = 0
          WHERE sale.round_no = ?
          GROUP BY item.zone
       ) resale ON resale.zone = area.code
      WHERE area.status = 1
      ORDER BY area.sequence, CAST(area.code AS UNSIGNED), area.code`, [date, date],
  )
  return rows
}

export async function listQualityIssueTrend(zones:string[],operations:number[]){
  if(!zones.length)return []
  const numericZones=zones.map(Number).filter(Boolean)
  const operationClause=operations.length?' AND reason.op IN (?)':''
  const params:Array<string|number|number[]>=[numericZones]
  if(operations.length)params.push(operations)
  const [rows]=await database.query<RowDataPacket[]>(`SELECT sessions.date,COALESCE(mark.issue_count,0) issue_count
    FROM (
      SELECT DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 7 DAY),'%Y-%m-%d') date UNION ALL
      SELECT DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 6 DAY),'%Y-%m-%d') UNION ALL
      SELECT DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 5 DAY),'%Y-%m-%d') UNION ALL
      SELECT DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 4 DAY),'%Y-%m-%d') UNION ALL
      SELECT DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 3 DAY),'%Y-%m-%d') UNION ALL
      SELECT DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 2 DAY),'%Y-%m-%d') UNION ALL
      SELECT DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 1 DAY),'%Y-%m-%d')
    ) sessions
    LEFT JOIN (
      SELECT reason.date,COUNT(DISTINCT reason.code_content) issue_count
      FROM xm_inspection_reason_record reason
      JOIN xm_bulky_supplier_enter_item item ON item.id=reason.enter_item_id AND item.data_status=0
      WHERE reason.data_status=0 AND CAST(item.zone AS UNSIGNED) IN (?)${operationClause}
      GROUP BY reason.date
    ) mark ON mark.date=sessions.date
    ORDER BY sessions.date`,params)
  return rows
}

export async function listBaseIssueStatistics(date: string, zones: string[]) {
  if (!zones.length) return [];
  const numericZones = zones.map(Number).filter(Boolean);
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT entry.supplier_id base_id,
            entry.supplier_name base_name,
            COUNT(DISTINCT CASE WHEN reason.op IN (1, 2) THEN reason.code_content END) downgrade_units,
            COUNT(DISTINCT CASE WHEN reason.op IN (3, 5) THEN reason.code_content END) return_units,
            COUNT(DISTINCT CASE WHEN reason.op = 12 THEN reason.code_content END) exchange_units,
            COUNT(DISTINCT reason.code_content) issue_units
       FROM xm_inspection_reason_record reason
       JOIN xm_bulky_supplier_enter_item item ON item.id = reason.enter_item_id AND item.data_status = 0
       JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
      WHERE reason.date = ?
        AND reason.data_status = 0
        AND CAST(item.zone AS UNSIGNED) IN (?)
      GROUP BY entry.supplier_id, entry.supplier_name
      ORDER BY issue_units DESC, entry.supplier_name`,
    [date, numericZones],
  );
  return rows;
}

export async function listExchangeRecords(date: string, zones: string[]) {
  if (!zones.length) return [];
  const numericZones = zones.map(Number).filter(Boolean);
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT log.id, log.round_no, log.supplier_id, log.supplier_name, log.product_name,
            log.rank_num, log.sku_config, log.zone_shelf, log.sub_shelf_sn,
            log.num, log.handle_num, log.handle_status,
            notify.call_status, notify.notify_count, DATE_FORMAT(notify.last_notify_time, '%Y-%m-%d %H:%i:%s') last_notify_time,
            call_record.task_status, call_record.result_text, call_record.operator_name,
            DATE_FORMAT(log.create_time, '%Y-%m-%d %H:%i:%s') create_time
       FROM xm_bulky_exchange_log log
       LEFT JOIN xm_bulky_exchange_voice_notify notify
         ON notify.round_no = log.round_no AND notify.supplier_id = log.supplier_id
       LEFT JOIN xm_bulky_exchange_voice_call_record call_record
         ON call_record.id = notify.current_call_record_id
      WHERE log.round_no = ?
        AND log.status = 0
        AND CAST(log.zone_shelf AS UNSIGNED) IN (?)
      ORDER BY log.create_time DESC, log.id DESC
      LIMIT 300`,
    [date, numericZones],
  );
  return rows;
}

export async function listReasonGroups() {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT parent.id AS categoryId, parent.reason_name AS categoryName,
            child.id AS reasonId, child.reason_name AS reasonName
       FROM xm_inspection_reason_config parent
       LEFT JOIN xm_inspection_reason_config child
         ON child.parent_id = parent.id AND child.data_status = 0
      WHERE parent.parent_id = 0 AND parent.level = 1 AND parent.data_status = 0
      ORDER BY parent.sequence, parent.id, child.sequence, child.id`,
  )
  return rows
}

export async function submitInspection(taskId: number, command: SubmitInspectionCommand) {
  const connection = await database.getConnection()
  try {
    await connection.beginTransaction()
    const [tasks] = await connection.query<(QualityTaskRow & RowDataPacket)[]>(
      `SELECT * FROM xm_bulky_inspection WHERE id = ? AND delete_time IS NULL FOR UPDATE`,
      [taskId],
    )
    const task = tasks[0]
    if (!task) {
      await connection.rollback()
      return { kind: 'not_found' as const }
    }
    if (task.status !== 0) {
      await connection.rollback()
      return { kind: 'already_completed' as const }
    }

    await connection.query(
      `UPDATE xm_bulky_inspection
          SET status = ?, user_id = ?, user_name = ?, remark = ?, finish_time = NOW()
        WHERE id = ?`,
      [command.status, command.userId, command.userName, command.remark ?? '', taskId],
    )

    if (command.status === 10 && command.reasonId) {
      await insertReasonRecord(connection, task, command)
    }
    await connection.commit()
    return { kind: 'success' as const }
  } catch (error) {
    await connection.rollback()
    throw error
  } finally {
    connection.release()
  }
}

async function insertReasonRecord(
  connection: PoolConnection,
  task: QualityTaskRow,
  command: SubmitInspectionCommand,
) {
  const [reasons] = await connection.query<RowDataPacket[]>(
    `SELECT child.id, child.reason_name, parent.id AS parentId, parent.reason_name AS parentName
       FROM xm_inspection_reason_config child
       JOIN xm_inspection_reason_config parent ON parent.id = child.parent_id
      WHERE child.id = ? AND child.level = 2 AND child.data_status = 0 AND parent.data_status = 0`,
    [command.reasonId],
  )
  const reason = reasons[0]
  if (!reason) throw new Error('Invalid inspection reason')

  await connection.query(
    `INSERT INTO xm_inspection_reason_record
      (date, enter_item_id, order_item_id, code_content, op, reason_id,
       reason_name, parent_reason_id, parent_reason_name, user_id, user_name)
     VALUES (?, ?, 0, ?, 10, ?, ?, ?, ?, ?, ?)`,
    [task.date, task.enter_item_id, `QI-${task.id}`, reason.id, reason.reason_name,
      reason.parentId, reason.parentName, command.userId, command.userName],
  )
}
