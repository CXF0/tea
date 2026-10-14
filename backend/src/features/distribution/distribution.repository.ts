import type { RowDataPacket } from '../../database.js'
import { database } from '../../database.js'

export interface ShelfFilters { warehouseType?: 'normal'|'city'; selfPickup?: boolean; earlyShift?: boolean; restock?: boolean; zone?: string; segments?: string[] }

export async function hasCapability(userId:number,capability:string){
  const [rows]=await database.query<RowDataPacket[]>(`SELECT 1 allowed FROM wms_account a JOIN wms_role_permission_group rg ON rg.role_id=a.role_id JOIN wms_permission_group g ON g.id=rg.group_id AND g.status=1 JOIN wms_permission_group_item gi ON gi.group_id=g.id JOIN wms_permission p ON p.id=gi.permission_id AND p.status=1 WHERE a.id=? AND a.status=1 AND p.code=? LIMIT 1`,[userId,capability])
  return rows.length>0
}

export async function listShelves(date: string, keyword?: string, filters: ShelfFilters = {}) {
  const params: Array<string | number> = [date]
  const clauses: string[] = []
  if (keyword) { clauses.push('(item.zone_shelf LIKE ? OR entry.supplier_name LIKE ? OR item.product_name LIKE ?)'); params.push(`%${keyword}%`, `%${keyword}%`, `%${keyword}%`) }
  if (filters.warehouseType) { clauses.push('COALESCE(area.ware_type, 0) = ?'); params.push(filters.warehouseType === 'city' ? 1 : 0) }
  if (filters.selfPickup) clauses.push('o.delivery_type = 2')
  if (filters.earlyShift) clauses.push('COALESCE(area.sort_config, 0) IN (3, 6)')
  if (filters.restock) clauses.push('(item.restock_item_num + item.wms_restock_num + item.lack_replenish_num + COALESCE(item.return_replenish_num, 0)) > 0')
  if (filters.zone) { clauses.push('item.zone = ?'); params.push(filters.zone) }
  if (filters.segments?.length) { clauses.push(`item.sub_shelf_sn IN (${filters.segments.map(() => '?').join(',')})`); params.push(...filters.segments) }
  const filterSql = clauses.length ? ` AND ${clauses.join(' AND ')}` : ''
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT item.zone_shelf shelf_no, COUNT(*) item_count, SUM(item.item_num) total_units,
            SUM(COALESCE(a.allocated_units, 0)) allocated_units,
            SUM(COALESCE(m.problem_units, 0)) problem_units,
            SUM(item.restock_item_num + item.wms_restock_num + item.lack_replenish_num + COALESCE(item.return_replenish_num, 0)) restock_units,
            MAX(COALESCE(o.delivery_type, 0)) delivery_type, MAX(COALESCE(area.ware_type, 0)) ware_type,
            MAX(COALESCE(area.sort_config, 0) IN (3, 6)) early_shift,
            MAX(item.zone) zone, GROUP_CONCAT(DISTINCT item.sub_shelf_sn ORDER BY item.sub_shelf_sn) segments,
            GROUP_CONCAT(DISTINCT entry.supplier_name ORDER BY entry.supplier_name SEPARATOR '、') supplier_names
       FROM xm_bulky_supplier_enter_item item
       JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
       LEFT JOIN xm_bulky_order_item oi ON oi.id = item.order_item_id AND oi.data_status = 0
       LEFT JOIN xm_bulky_order o ON o.order_sn = oi.order_sn AND o.data_status = 0
       LEFT JOIN xm_bulky_wms_area area ON area.code = item.zone AND area.status = 1
       LEFT JOIN (SELECT enter_item_id, COUNT(*) allocated_units FROM xm_quality_unit_allocation WHERE allocated = 1 GROUP BY enter_item_id) a ON a.enter_item_id = item.id
       LEFT JOIN (SELECT enter_item_id, COUNT(DISTINCT code_content) problem_units FROM xm_inspection_reason_record WHERE data_status = 0 GROUP BY enter_item_id) m ON m.enter_item_id = item.id
      WHERE item.date = ? AND item.data_status = 0 AND item.zone_shelf <> ''${filterSql}
      GROUP BY item.zone_shelf ORDER BY CAST(SUBSTRING_INDEX(item.zone_shelf, '-', 1) AS UNSIGNED), item.zone_shelf`, params)
  return rows
}

export async function getAccountDistributionTeam(accountId:number) {
  const [rows] = await database.query<RowDataPacket[]>(`SELECT t.id,t.name,t.perm_config
    FROM wms_account_source_identity s
    JOIN xm_bulky_team t ON t.type=2 AND t.active_flag=1 AND t.data_status=0
    LEFT JOIN xm_bulky_team_user tu ON tu.team_id=t.id AND tu.user_id=s.source_user_id
    WHERE s.account_id=? AND s.source_system='bulkyGoods' AND (t.leader_id=s.source_user_id OR tu.id IS NOT NULL)
    ORDER BY (t.leader_id=s.source_user_id) DESC,t.id LIMIT 1`,[accountId])
  return rows[0] || null
}

export async function getAccountRoleCode(accountId:number) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT r.code role_code FROM wms_account a JOIN wms_role r ON r.id=a.role_id WHERE a.id=? AND a.status=1 LIMIT 1`,
    [accountId],
  )
  return String(rows[0]?.role_code || '')
}

export async function listFilterOptions(_date: string, warehouseType?: 'normal'|'city') {
  const params: (string | number)[] = []
  const warehouseClause = warehouseType ? ' AND ware_type = ?' : ''
  if (warehouseType) params.push(warehouseType === 'city' ? 1 : 0)
  const [rows] = await database.query<RowDataPacket[]>(`SELECT code zone, area_name, segment_area FROM xm_bulky_wms_area WHERE status=1${warehouseClause} ORDER BY sequence,CAST(code AS UNSIGNED),code`, params)
  return rows
}

export async function getAgencyDistributionSummary(date:string){
  const [rows]=await database.query<RowDataPacket[]>(`SELECT
    COUNT(DISTINCT item.supplier_id) total_supplier_count,
    COALESCE(SUM(item.item_num),0) total_item_count,
    COUNT(DISTINCT CASE WHEN COALESCE(o.order_tag,0)<>2 THEN item.supplier_id END) day_supplier_count,
    COALESCE(SUM(CASE WHEN COALESCE(o.order_tag,0)<>2 THEN item.item_num ELSE 0 END),0) day_item_count,
    COUNT(DISTINCT CASE WHEN COALESCE(o.order_tag,0)=2 THEN item.supplier_id END) night_supplier_count,
    COALESCE(SUM(CASE WHEN COALESCE(o.order_tag,0)=2 THEN item.item_num ELSE 0 END),0) night_item_count
    FROM xm_bulky_supplier_enter_item item
    JOIN xm_bulky_order o ON o.order_sn=item.order_sn AND o.data_status=0 AND o.is_sale_agency=1
    WHERE item.date=? AND item.data_status=0`,[date])
  return rows[0]||{}
}

export async function getMyAllocationDashboard(userId:number){
  const [sessions]=await database.query<RowDataPacket[]>(`SELECT date,SUM(CASE WHEN op=1 THEN num WHEN op=2 THEN -num ELSE 0 END) allocated_units,MAX(create_time) last_operated_at
    FROM wms_prepare_record WHERE user_id=? AND role_type=0 AND data_status=0
    GROUP BY date HAVING allocated_units<>0 ORDER BY date DESC`,[userId])
  const [punishments]=await database.query<RowDataPacket[]>(`SELECT COUNT(*) punishment_count FROM wms_punish
    WHERE duty_user_id=? AND punish_role_type=10 AND data_status=0 AND punish_status<>2 AND date>=DATE_SUB(CURDATE(),INTERVAL 1 MONTH)`,[userId])
  return {sessions,punishmentCount:Number(punishments[0]?.punishment_count||0)}
}

export async function listUnfinishedItems(date:string, filters:{zone?:string; orderNum?:number; productName?:string}) {
  const clauses=['item.date = ?','item.data_status = 0','item.zone_shelf <> \'\'']; const params:Array<string|number>=[date]
  if(filters.zone){clauses.push('item.zone = ?');params.push(filters.zone)}
  if(filters.orderNum){clauses.push('item.order_num = ?');params.push(filters.orderNum)}
  if(filters.productName){clauses.push('item.product_name LIKE ?');params.push(`%${filters.productName}%`)}
  const [rows]=await database.query<RowDataPacket[]>(`SELECT item.id enter_item_id,item.order_num,item.product_name,item.rank_num,item.zone,item.zone_shelf,item.sub_shelf_sn,item.item_num,
    entry.supplier_name,COALESCE(oi.supply_price,0) supply_price,
    GREATEST(item.item_num-COALESCE(a.allocated_count,0)-COALESCE(m.marked_count,0),0) unfinished_num
    FROM xm_bulky_supplier_enter_item item
    JOIN xm_bulky_supplier_enter entry ON entry.id=item.enter_id
    LEFT JOIN xm_bulky_order_item oi ON oi.id=item.order_item_id AND oi.data_status=0
    LEFT JOIN (SELECT enter_item_id,COUNT(*) allocated_count FROM xm_quality_unit_allocation WHERE allocated=1 GROUP BY enter_item_id) a ON a.enter_item_id=item.id
    LEFT JOIN (SELECT enter_item_id,COUNT(DISTINCT code_content) marked_count FROM xm_inspection_reason_record WHERE data_status=0 GROUP BY enter_item_id) m ON m.enter_item_id=item.id
    WHERE ${clauses.join(' AND ')}
    AND GREATEST(item.item_num-COALESCE(a.allocated_count,0)-COALESCE(m.marked_count,0),0)>0 ORDER BY CAST(item.zone AS UNSIGNED),item.order_num,item.product_name,item.id`,params)
  return rows
}

export async function markUnfinishedAsShortage(itemIds:number[],operation:6|7,remark:string,userId:number,userName:string){
  const connection=await database.getConnection();let affectedItems=0,affectedUnits=0
  try{await connection.beginTransaction();for(const itemId of itemIds){
    const [items]=await connection.query<RowDataPacket[]>('SELECT * FROM xm_bulky_supplier_enter_item WHERE id=? AND data_status=0 FOR UPDATE',[itemId]);const item=items[0];if(!item)continue
    const [allocated]=await connection.query<RowDataPacket[]>('SELECT unit_no FROM xm_quality_unit_allocation WHERE enter_item_id=? AND allocated=1',[itemId])
    const [marked]=await connection.query<RowDataPacket[]>(`SELECT CAST(SUBSTRING_INDEX(code_content,'-',-1) AS UNSIGNED) unit_no FROM xm_inspection_reason_record WHERE enter_item_id=? AND data_status=0 GROUP BY code_content`,[itemId])
    const used=new Set([...allocated,...marked].map(row=>Number(row.unit_no)));const units=Array.from({length:Number(item.item_num)},(_,index)=>index+1).filter(unit=>!used.has(unit));if(!units.length)continue
    for(const unit of units)await connection.execute(`INSERT INTO xm_inspection_reason_record (date,enter_item_id,order_item_id,code_content,op,reason_id,reason_name,parent_reason_id,parent_reason_name,user_id,user_name) VALUES (?,?,?,?,?,0,?,0,'',?,?)`,[item.date,itemId,item.order_item_id,`QI-${itemId}-${unit}`,operation,remark,userId,userName])
    const field=operation===6?'lack_replenish_num':'lack_num';await connection.execute(`UPDATE xm_bulky_supplier_enter_item SET ${field}=${field}+?,is_qualify=10,not_qualify_num=not_qualify_num+?,qualify_user_id=?,qualify_user_name=?,update_time=NOW() WHERE id=?`,[units.length,units.length,userId,userName,itemId]);affectedItems++;affectedUnits+=units.length
  }await connection.commit();return{affectedItems,affectedUnits}}catch(error){await connection.rollback();throw error}finally{connection.release()}
}

export async function listShelfItems(date: string, shelfNo: string) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT item.id, item.order_item_id, item.order_sn, item.order_num, item.zone_shelf shelf_no, item.sub_shelf_sn segment, item.product_name,
            item.rank_num, item.sku_config, item.item_num total_units, item.prepare_item_num,
            item.restock_item_num, item.wms_restock_num, item.lack_num, item.lack_replenish_num,
            item.return_num, item.return_replenish_num, item.lower_rank_num,
            item.limit_distribution_flag, entry.supplier_name, entry.login_tel supplier_phone,
            purchaser.nickname customer_name, purchaser.phone_number customer_phone, oi.supply_price,
            CASE
              WHEN COALESCE(base_tag.name, supplier.supplier_tag, '') = '' THEN ''
              WHEN RIGHT(COALESCE(base_tag.name, supplier.supplier_tag), 2) = '基地'
                THEN LEFT(COALESCE(base_tag.name, supplier.supplier_tag), CHAR_LENGTH(COALESCE(base_tag.name, supplier.supplier_tag)) - 2)
              ELSE COALESCE(base_tag.name, supplier.supplier_tag)
            END base_short_name
       FROM xm_bulky_supplier_enter_item item
       JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
       LEFT JOIN xm_bulky_supplier supplier ON supplier.id = item.supplier_id
       LEFT JOIN xm_bulky_supplier_tag supplier_tag ON supplier_tag.supplier_id = item.supplier_id
       LEFT JOIN xm_bulky_user_tag base_tag ON base_tag.id = supplier_tag.tag_id AND base_tag.type = 2 AND base_tag.tag_category = '基地'
       LEFT JOIN xm_bulky_order_item oi ON oi.id = item.order_item_id AND oi.data_status = 0
       LEFT JOIN xm_bulky_purchaser purchaser ON purchaser.id = oi.purchaser_id
      WHERE item.date = ? AND item.zone_shelf = ? AND item.data_status = 0
      ORDER BY item.order_num, item.sub_shelf_sn, item.id`, [date, shelfNo])
  for (const row of rows) {
    const [allocated] = await database.query<RowDataPacket[]>('SELECT unit_no FROM xm_quality_unit_allocation WHERE enter_item_id = ? AND allocated = 1 ORDER BY unit_no', [row.id])
    const [marks] = await database.query<RowDataPacket[]>(`SELECT CAST(SUBSTRING_INDEX(code_content, '-', -1) AS UNSIGNED) unit_no, op FROM xm_inspection_reason_record WHERE enter_item_id = ? AND data_status = 0 GROUP BY code_content, op ORDER BY unit_no`, [row.id])
    row.allocated_units = allocated.map(value => Number(value.unit_no))
    row.problem_marks = marks.map(value => ({ unit: Number(value.unit_no), operation: Number(value.op) }))
  }
  return rows
}

export async function itemExists(itemId: number) {
  const [rows] = await database.query<RowDataPacket[]>('SELECT id FROM xm_bulky_supplier_enter_item WHERE id = ? AND data_status = 0 LIMIT 1', [itemId])
  return Boolean(rows[0])
}

export async function setAllocation(itemId: number, units: number[], allocated: boolean, userId: number, userName: string) {
  const [items] = await database.query<RowDataPacket[]>('SELECT item_num,date,zone,zone_shelf,sub_shelf_sn,supplier_id FROM xm_bulky_supplier_enter_item WHERE id = ? AND data_status = 0 LIMIT 1', [itemId])
  if (!items[0]) return 'not_found' as const
  if (units.some(unit => unit < 1 || unit > Number(items[0].item_num))) return 'invalid_unit' as const
  const [currentRows]=await database.query<RowDataPacket[]>(`SELECT unit_no FROM xm_quality_unit_allocation WHERE enter_item_id=? AND allocated=1 AND unit_no IN (${units.map(()=>'?').join(',')})`,[itemId,...units])
  const currentAllocated=new Set(currentRows.map(row=>Number(row.unit_no)))
  const changedUnits=units.filter(unit=>allocated?!currentAllocated.has(unit):currentAllocated.has(unit))
  if(!changedUnits.length)return 'success' as const
  await database.query(`INSERT INTO xm_quality_unit_allocation (enter_item_id, unit_no, allocated, operator_id, operator_name) VALUES ? ON DUPLICATE KEY UPDATE allocated=VALUES(allocated), operator_id=VALUES(operator_id), operator_name=VALUES(operator_name), update_time=NOW()`, [changedUnits.map(unit => [itemId, unit, allocated ? 1 : 0, userId, userName])])
  await database.query(`UPDATE xm_bulky_supplier_enter_item SET prepare_item_num=(SELECT COUNT(*) FROM xm_quality_unit_allocation WHERE enter_item_id=? AND allocated=1), prepare_user_id=?, prepare_user_name=?, prepare_time=NOW(), update_time=NOW() WHERE id=?`, [itemId, userId, userName, itemId])
  const item=items[0];const shelfParts=String(item.zone_shelf||'').split('-')
  await database.query(`INSERT INTO wms_prepare_record (date,shelf_sn,sub_shelf_sn,zone,shelf,zone_shelf,enter_item_id,supplier_id,user_id,user_name,op,op_type,num,role_type,remark,data_status) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,0,'新版仓管配货操作',0)`,[item.date,Number(shelfParts.at(-1))||0,item.sub_shelf_sn,item.zone,shelfParts.at(-1)||'',item.zone_shelf,itemId,item.supplier_id,userId,userName,allocated?1:2,1,changedUnits.length])
  return 'success' as const
}

export async function getContractorDistributionSummary(accountId:number,date:string){
  const [identities]=await database.query<RowDataPacket[]>(`SELECT source_user_id FROM wms_account_source_identity WHERE account_id=? AND source_system='bulkyGoods' LIMIT 1`,[accountId])
  const contractorId=Number(identities[0]?.source_user_id||0)
  if(!contractorId)return null
  const [employees]=await database.query<RowDataPacket[]>(`SELECT employee_user_id FROM xm_bulky_external_distribution_contractor_account WHERE contractor_user_id=? AND data_status=0`,[contractorId])
  const employeeIds=employees.map(row=>Number(row.employee_user_id)).filter(Boolean)
  if(!employeeIds.length)return null
  const [current]=await database.query<RowDataPacket[]>(`SELECT COALESCE(SUM(op.num),0) prepare_item_num,MAX(op.update_time) last_prepare_time,GROUP_CONCAT(DISTINCT item.zone) zones FROM xm_bulky_wms_prepare_op op JOIN xm_bulky_supplier_enter_item item ON item.id=op.enter_item_id AND item.data_status=0 WHERE op.date=? AND op.user_id IN (?)`,[date,employeeIds])
  const zones=String(current[0]?.zones||'').split(',').filter(Boolean)
  const [totals]=zones.length?await database.query<RowDataPacket[]>(`SELECT COALESCE(SUM(item_num),0) item_num,COALESCE(SUM(return_replenish_num+lack_replenish_num),0) return_replenish_num FROM xm_bulky_supplier_enter_item WHERE date=? AND data_status=0 AND zone IN (?)`,[date,zones]):[[{item_num:0,return_replenish_num:0}] as RowDataPacket[],[] as any]
  const [income]=zones.length?await database.query<RowDataPacket[]>(`SELECT COALESCE(SUM(prepare_pre_income),0) delivery_income FROM xm_bulky_wms_pre_income WHERE date=? AND zone IN (?)`,[date,zones]):[[{delivery_income:0}] as RowDataPacket[],[] as any]
  const [previousDates]=await database.query<RowDataPacket[]>(`SELECT MAX(date) previous_date FROM xm_bulky_wms_prepare_op WHERE date<? AND user_id IN (?)`,[date,employeeIds])
  const previousDate=String(previousDates[0]?.previous_date||'')
  let previous={item_num:0,prepare_item_num:0}
  if(previousDate){const [rows]=await database.query<RowDataPacket[]>(`SELECT COALESCE(SUM(item.item_num),0) item_num,COALESCE(SUM(op.num),0) prepare_item_num FROM xm_bulky_wms_prepare_op op JOIN xm_bulky_supplier_enter_item item ON item.id=op.enter_item_id AND item.data_status=0 WHERE op.date=? AND op.user_id IN (?)`,[previousDate,employeeIds]);previous={item_num:Number(rows[0]?.item_num||0),prepare_item_num:Number(rows[0]?.prepare_item_num||0)}}
  return{contractorId,employeeCount:employeeIds.length,itemNum:Number(totals[0]?.item_num||0),returnReplenishNum:Number(totals[0]?.return_replenish_num||0),prepareItemNum:Number(current[0]?.prepare_item_num||0),lastPrepareTime:current[0]?.last_prepare_time,deliveryIncome:Number(income[0]?.delivery_income||0),previous}
}
