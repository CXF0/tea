import type { ResultSetHeader, RowDataPacket } from '../../database.js'
import { database } from '../../database.js'
import type { ColdStorageFilters, ColdStorageOperator } from './cold-storage.types.js'

const currentQuantity = `CASE WHEN s.store_type=2 THEN COALESCE(s.remaining_bunch_num,s.bunch_num) ELSE GREATEST(s.package_total-s.package_out,0) END`

export async function hasCapability(userId:number,capability:string){const [rows]=await database.query<RowDataPacket[]>(`SELECT 1 allowed FROM wms_account a JOIN wms_role_permission_group rg ON rg.role_id=a.role_id JOIN wms_permission_group g ON g.id=rg.group_id AND g.status=1 JOIN wms_permission_group_item gi ON gi.group_id=g.id JOIN wms_permission p ON p.id=gi.permission_id AND p.status=1 WHERE a.id=? AND a.status=1 AND p.code=? LIMIT 1`,[userId,capability]);return rows.length>0}

export async function getOverview() {
  const [stock] = await database.query<RowDataPacket[]>(`SELECT COUNT(DISTINCT purchaser_id) customer_count,
    COUNT(DISTINCT CASE WHEN store_type=2 THEN purchaser_id END) bare_customer_count,
    COUNT(DISTINCT CASE WHEN store_type=1 THEN purchaser_id END) package_customer_count,
    COALESCE(SUM(CASE WHEN store_type=1 THEN GREATEST(package_total-package_out,0) ELSE 0 END),0) package_total
    FROM xm_bulky_cold_stock s WHERE s.data_status=0 AND s.stock_status<>50 AND ${currentQuantity}>0`)
  const [tasks] = await database.query<RowDataPacket[]>(`SELECT COUNT(DISTINCT CASE WHEN task_status IN (10,15,20) THEN purchaser_id END) today_total,
    COUNT(DISTINCT CASE WHEN task_status=20 THEN purchaser_id END) today_finished
    FROM xm_bulky_cold_out_task WHERE data_status=0 AND DATE(COALESCE(operate_time,create_time))=CURDATE()`)
  return { ...stock[0], ...tasks[0] }
}

function filterSql(filters: ColdStorageFilters, alias: 's' | 't') {
  const clauses: string[] = []
  const params: Array<string | number> = []
  if (filters.storeType) { clauses.push(`${alias}.store_type=?`); params.push(filters.storeType) }
  if (filters.storeRoundNo) { clauses.push(alias === 's' ? 's.store_round_no=?' : 's.store_round_no=?'); params.push(filters.storeRoundNo) }
  if (filters.keyword) {
    clauses.push(`(s.purchaser_mobile LIKE ? OR s.purchaser_nick LIKE ? OR s.location_no LIKE ?)`)
    const keyword = `%${filters.keyword}%`; params.push(keyword, keyword, keyword)
  }
  return { clauses, params }
}

export async function listCurrent(filters: ColdStorageFilters) {
  const { clauses, params } = filterSql(filters, 's')
  clauses.push('s.data_status=0', 's.stock_status<>50', `${currentQuantity}>0`)
  const [rows] = await database.query<RowDataPacket[]>(`SELECT s.id cold_stock_id,s.purchaser_id,s.purchaser_mobile,s.purchaser_nick,s.store_type,s.store_round_no,s.location_no,
    s.origin_send_no,s.package_total,s.package_out,s.bunch_num,s.remaining_bunch_num,s.stock_status,s.plan_ship_date,s.remark,s.in_user_name,s.in_time,s.abnormal_flag,s.abnormal_remark
    FROM xm_bulky_cold_stock s WHERE ${clauses.join(' AND ')} ORDER BY s.in_time DESC,s.id DESC`, params)
  return rows
}

export async function listOutTasks(filters: ColdStorageFilters) {
  const { clauses, params } = filterSql(filters, 't')
  clauses.push('t.data_status=0', 't.task_status=?'); params.push(filters.taskStatus || 10)
  const [rows] = await database.query<RowDataPacket[]>(`SELECT t.id out_task_id,t.cold_stock_id,t.purchaser_id,t.store_type,t.out_type,t.link_send_no,t.link_zone_shelf,
    t.out_package_num,t.out_bunch_num,t.finish_bunch_num,t.box_repack_flag,t.task_status,t.operate_time,t.finish_time,t.finish_user_name,t.finish_image_urls,t.finish_remark,
    s.purchaser_mobile,s.purchaser_nick,s.store_round_no,s.location_no,s.package_total,s.package_out,s.bunch_num,s.remaining_bunch_num,s.remark,s.in_user_name,s.in_time
    FROM xm_bulky_cold_out_task t JOIN xm_bulky_cold_stock s ON s.id=t.cold_stock_id
    WHERE ${clauses.join(' AND ')} ORDER BY COALESCE(t.finish_time,t.operate_time,t.create_time) DESC,t.id DESC`, params)
  return rows
}

export async function findScannedFlower(enterItemId: number) {
  const [rows] = await database.query<RowDataPacket[]>(`SELECT i.id enter_item_id,i.date round_no,i.zone_shelf location_no,i.order_sn,o.purchaser_id,o.send_no origin_send_no,o.receive_address,
    p.phone_number purchaser_mobile,p.nickname purchaser_nick
    FROM xm_bulky_supplier_enter_item i JOIN xm_bulky_order o ON o.order_sn=i.order_sn AND o.data_status=0
    JOIN xm_bulky_purchaser p ON p.id=o.purchaser_id AND p.data_status=0
    WHERE i.id=? AND i.data_status=0 LIMIT 1`, [enterItemId])
  return rows[0]
}

export async function registerBare(row: RowDataPacket, bunchNum: number, imageUrls: string[], remark: string, operator: ColdStorageOperator) {
  const stockKey = `bare:${row.enter_item_id}`
  const [result] = await database.execute<ResultSetHeader>(`INSERT INTO xm_bulky_cold_stock
    (purchaser_id,purchaser_mobile,purchaser_nick,ware_id,store_type,store_round_no,location_no,origin_send_no,source_enter_item_id,image_urls,stock_key,bunch_num,remaining_bunch_num,stock_status,remark,in_user_id,in_user_name,in_time)
    VALUES (?,?,?,?,2,?,?,?,?,?,?,?, ?,10,?,?,?,NOW())`,
    [row.purchaser_id,row.purchaser_mobile,row.purchaser_nick,null,row.round_no,row.location_no,row.origin_send_no,row.enter_item_id,JSON.stringify(imageUrls),stockKey,bunchNum,bunchNum,remark,operator.userId,operator.userName])
  return result.insertId
}

export async function finishOutTask(taskId: number, finishBunchNum: number | undefined, imageUrls: string[], remark: string, operator: ColdStorageOperator) {
  const connection = await database.getConnection()
  try {
    await connection.beginTransaction()
    const [rows] = await connection.query<RowDataPacket[]>('SELECT * FROM xm_bulky_cold_out_task WHERE id=? AND data_status=0 FOR UPDATE', [taskId])
    const task = rows[0]
    if (!task) return { kind: 'missing' as const }
    if (Number(task.task_status) !== 10) return { kind: 'finished' as const }
    const actualBunch = Number(task.out_type) === 3 ? Number(finishBunchNum) : Number(task.out_bunch_num)
    if (Number(task.out_type) === 3 && (!Number.isInteger(actualBunch) || actualBunch <= 0 || actualBunch > Number(task.out_bunch_num))) return { kind: 'invalid-bunch' as const }
    await connection.execute(`UPDATE xm_bulky_cold_out_task SET task_status=20,finish_bunch_num=?,finish_user_id=?,finish_user_name=?,finish_time=NOW(),finish_image_urls=?,finish_remark=? WHERE id=?`, [actualBunch,operator.userId,operator.userName,JSON.stringify(imageUrls),remark,taskId])
    if (Number(task.store_type) === 1) {
      await connection.execute(`UPDATE xm_bulky_cold_stock_package SET pkg_status=20,out_user_id=?,out_user_name=?,out_time=NOW(),active_key=NULL WHERE out_task_id=? AND data_status=0 AND pkg_status=15`, [operator.userId,operator.userName,taskId])
      await connection.execute(`UPDATE xm_bulky_cold_stock SET package_out=LEAST(package_total,package_out+?),stock_status=IF(package_out+?>=package_total,50,10),stock_key=IF(package_out+?>=package_total,NULL,stock_key) WHERE id=?`, [task.out_package_num,task.out_package_num,task.out_package_num,task.cold_stock_id])
    } else {
      await connection.execute(`UPDATE xm_bulky_cold_stock SET remaining_bunch_num=GREATEST(COALESCE(remaining_bunch_num,bunch_num)-?,0),stock_status=IF(COALESCE(remaining_bunch_num,bunch_num)-?<=0,50,10),stock_key=IF(COALESCE(remaining_bunch_num,bunch_num)-?<=0,NULL,stock_key) WHERE id=?`, [actualBunch,actualBunch,actualBunch,task.cold_stock_id])
    }
    await connection.commit()
    return { kind: 'success' as const }
  } catch (error) { await connection.rollback(); throw error } finally { connection.release() }
}
