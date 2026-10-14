import fs from 'node:fs'
import mysql from 'mysql2/promise'
import 'dotenv/config'

const [file] = process.argv.slice(2)
if (!file) throw new Error('请传入分区 JSON 文件')

const payload = JSON.parse(fs.readFileSync(file, 'utf8'))
if (!Array.isArray(payload?.data)) throw new Error('文件不包含 data 数组')

const records = [...new Map(payload.data.map(record => [String(record.code), record])).values()]
const connection = await mysql.createConnection({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
})

const sql = `INSERT INTO xm_bulky_wms_area
  (code,area_name,start_shelf,end_shelf,ware_type,sort_config,sub_area,segment_area,
   pack_income_config,delivery_income,standby,sequence,remark,area_manager_id,
   area_manager_name,operator_id,operator_name,last_operator_id,last_operator_name,
   create_time,update_time,status)
 VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
 ON DUPLICATE KEY UPDATE
   area_name=VALUES(area_name),start_shelf=VALUES(start_shelf),end_shelf=VALUES(end_shelf),
   ware_type=VALUES(ware_type),sort_config=VALUES(sort_config),sub_area=VALUES(sub_area),
   segment_area=VALUES(segment_area),pack_income_config=VALUES(pack_income_config),
   delivery_income=VALUES(delivery_income),standby=VALUES(standby),sequence=VALUES(sequence),
   remark=VALUES(remark),area_manager_id=VALUES(area_manager_id),area_manager_name=VALUES(area_manager_name),
   operator_id=VALUES(operator_id),operator_name=VALUES(operator_name),
   last_operator_id=VALUES(last_operator_id),last_operator_name=VALUES(last_operator_name),
   create_time=VALUES(create_time),update_time=VALUES(update_time),status=VALUES(status)`

try {
  await connection.beginTransaction()
  for (const record of records) {
    await connection.execute(sql, [
      record.code, record.areaName ?? '', record.startShelf ?? 0, record.endShelf ?? 0,
      record.wareType ?? 0, record.sortConfig ?? 0, record.subArea ?? '', record.segmentArea ?? null,
      record.packIncomeConfig ?? '', record.deliveryIncome ?? 0, record.standby ?? 0,
      record.sequence ?? 1, record.remark ?? '', record.areaManagerId ?? 0,
      record.areaManagerName ?? '', record.operatorId ?? 0, record.operatorName ?? '',
      record.lastOperatorId ?? 0, record.lastOperatorName ?? '', record.createTime,
      record.updateTime, record.status ?? 1,
    ])
  }
  await connection.commit()
  console.log(JSON.stringify({ imported: records.length }))
} catch (error) {
  await connection.rollback()
  throw error
} finally {
  await connection.end()
}
