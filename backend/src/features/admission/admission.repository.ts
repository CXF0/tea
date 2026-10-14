import type { RowDataPacket } from '../../database.js'
import { database } from '../../database.js'
import type { AdmissionRow } from './admission.types.js'

export async function listAdmissions(date: string, status?: number, keyword?: string, supplierId?: number) {
  const conditions = ['entry.date = ?']
  const params: Array<string | number> = [date]
  if (status !== undefined) { conditions.push('entry.data_status = ?'); params.push(status) }
  if (keyword) { conditions.push('(entry.supplier_name LIKE ? OR entry.login_tel LIKE ?)'); params.push(`%${keyword}%`, `%${keyword}%`) }
  if (supplierId) { conditions.push('entry.supplier_id = ?'); params.push(supplierId) }
  const [rows] = await database.query<(AdmissionRow & RowDataPacket)[]>(
    `SELECT entry.id, entry.supplier_id, entry.supplier_name, entry.login_tel,
            entry.date, entry.enter_time, entry.data_status, entry.night_enter_time,
            entry.night_data_status, entry.night_open, entry.is_qualify,
            entry.is_late, entry.quality_inspection_flag,
            COUNT(item.id) AS item_count, COALESCE(SUM(item.item_num), 0) AS item_quantity
       FROM xm_bulky_supplier_enter entry
       LEFT JOIN xm_bulky_supplier_enter_item item
         ON item.enter_id = entry.id AND item.data_status = 0
      WHERE ${conditions.join(' AND ')}
      GROUP BY entry.id
      ORDER BY entry.data_status ASC, entry.quality_inspection_flag DESC, entry.id DESC`,
    params,
  )
  return rows
}

export async function getAdmissionSummary(date: string) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT COUNT(*) AS total,
            SUM(data_status = 0) AS pending,
            SUM(data_status = 1) AS admitted,
            SUM(is_late = 1) AS late,
            SUM(quality_inspection_flag = 1) AS priority
       FROM xm_bulky_supplier_enter WHERE date = ?`,
    [date],
  )
  return rows[0]
}

export async function getArrivalBusinessSummary(date:string){
  const [arrivalRows]=await database.query<RowDataPacket[]>(`SELECT
    COALESCE(SUM(item.item_num),0) received_units,
    COALESCE(SUM(CASE WHEN COALESCE(o.order_tag,0)=2 AND COALESCE(entry.type,0)=1 THEN item.item_num ELSE 0 END),0) self_operated_units,
    COALESCE(SUM(CASE WHEN COALESCE(o.order_tag,0)=2 AND COALESCE(entry.type,0)<>1 THEN item.item_num ELSE 0 END),0) external_supplier_units,
    COALESCE(SUM(CASE WHEN COALESCE(o.order_tag,0)=2 THEN item.item_num ELSE 0 END),0) night_added_received_units
    FROM xm_bulky_supplier_enter_item item
    JOIN xm_bulky_supplier_enter entry ON entry.id=item.enter_id
    LEFT JOIN xm_bulky_order_item oi ON oi.id=item.order_item_id AND oi.data_status=0
    LEFT JOIN xm_bulky_order o ON o.order_sn=oi.order_sn AND o.data_status=0
    WHERE item.date=? AND item.data_status=0`,[date])
  const [saleRows]=await database.query<RowDataPacket[]>(`SELECT
    COALESCE(SUM(oi.item_num),0) sold_units,
    COALESCE(SUM(CASE WHEN COALESCE(o.order_tag,0)<>2 THEN oi.item_num ELSE 0 END),0) day_sold_units,
    COALESCE(SUM(CASE WHEN COALESCE(o.order_tag,0)=2 THEN oi.item_num ELSE 0 END),0) night_added_sold_units,
    COALESCE(SUM(CASE WHEN o.delivery_type=2 THEN oi.item_num ELSE 0 END),0) pickup_units,
    COUNT(DISTINCT CASE WHEN o.delivery_type=2 THEN o.purchaser_id END) pickup_people,
    COALESCE(SUM(CASE WHEN o.delivery_type=2 AND COALESCE(o.partner_id,0)=0 THEN oi.item_num ELSE 0 END),0) ordinary_pickup_units,
    COUNT(DISTINCT CASE WHEN o.delivery_type=2 AND COALESCE(o.partner_id,0)=0 THEN o.purchaser_id END) ordinary_pickup_people,
    COALESCE(SUM(CASE WHEN o.delivery_type=2 AND COALESCE(o.partner_id,0)>0 THEN oi.item_num ELSE 0 END),0) partner_pickup_units,
    COUNT(DISTINCT CASE WHEN o.delivery_type=2 AND COALESCE(o.partner_id,0)>0 THEN o.purchaser_id END) partner_pickup_people
    FROM (SELECT DISTINCT order_item_id FROM xm_bulky_supplier_enter_item WHERE date=? AND data_status=0 AND order_item_id>0) entered
    JOIN xm_bulky_order_item oi ON oi.id=entered.order_item_id AND oi.data_status=0
    JOIN xm_bulky_order o ON o.order_sn=oi.order_sn AND o.data_status=0`,[date])
  return {...(arrivalRows[0]||{}),...(saleRows[0]||{})}
}

export async function changeAdmissionStatus(id: number, status: 0 | 1, operatorId: number) {
  const [result] = await database.execute(
    `UPDATE xm_bulky_supplier_enter
        SET data_status = ?, operator_id = ?, enter_time = CASE WHEN ? = 1 THEN DATE_FORMAT(NOW(), '%H:%i:%s') ELSE '' END,
            update_time = NOW()
      WHERE id = ? AND data_status <> ?`,
    [status, operatorId, status, id, status],
  )
  return (result as { affectedRows: number }).affectedRows
}

export async function admissionExists(id: number) {
  const [rows] = await database.query<RowDataPacket[]>('SELECT id FROM xm_bulky_supplier_enter WHERE id = ? LIMIT 1', [id])
  return rows.length > 0
}
