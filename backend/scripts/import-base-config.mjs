import fs from 'node:fs'
import mysql from 'mysql2/promise'
import 'dotenv/config'

const files = process.argv.slice(2)
if (!files.length) throw new Error('请传入至少一个基地 JSON 文件')

const recordsById = new Map()
for (const file of files) {
  const payload = JSON.parse(fs.readFileSync(file, 'utf8'))
  const records = payload?.data?.records
  if (!Array.isArray(records)) throw new Error(`${file} 不包含 data.records`)
  for (const record of records) {
    const existing = recordsById.get(record.id)
    if (!existing || String(record.updateTime) >= String(existing.updateTime)) recordsById.set(record.id, record)
  }
}

const connection = await mysql.createConnection({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
})

const sql = `INSERT INTO xm_bulky_base_config
  (id,name,short_name,area_id,area_name,contact_tel,station_fee,credit_require,sequence,status,
   latest_check_time,late_auto_punish,single_punish_amount,longitude,latitude,address,adcode,helper,
   outsource_flag,outsource_user_id,outsource_user_name,base_volume,base_salary,subsidy_unit_price,
   outsource_income_rule_id,create_time,update_time)
 VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
 ON DUPLICATE KEY UPDATE
   name=VALUES(name),short_name=VALUES(short_name),area_id=VALUES(area_id),area_name=VALUES(area_name),
   contact_tel=VALUES(contact_tel),station_fee=VALUES(station_fee),credit_require=VALUES(credit_require),
   sequence=VALUES(sequence),status=VALUES(status),latest_check_time=VALUES(latest_check_time),
   late_auto_punish=VALUES(late_auto_punish),single_punish_amount=VALUES(single_punish_amount),
   longitude=VALUES(longitude),latitude=VALUES(latitude),address=VALUES(address),adcode=VALUES(adcode),
   helper=VALUES(helper),outsource_flag=VALUES(outsource_flag),outsource_user_id=VALUES(outsource_user_id),
   outsource_user_name=VALUES(outsource_user_name),base_volume=VALUES(base_volume),base_salary=VALUES(base_salary),
   subsidy_unit_price=VALUES(subsidy_unit_price),outsource_income_rule_id=VALUES(outsource_income_rule_id),
   create_time=VALUES(create_time),update_time=VALUES(update_time)`

try {
  await connection.beginTransaction()
  for (const record of [...recordsById.values()].sort((a, b) => a.id - b.id)) {
    await connection.execute(sql, [
      record.id, record.name, record.shortName, record.areaId ?? 0, record.areaName ?? '',
      record.contactTel ?? '', record.stationFee ?? 0, record.creditRequire ?? 0, record.sequence ?? 0,
      record.status ?? 0, record.latestCheckTime ?? '', record.lateAutoPunish ?? 0,
      record.singlePunishAmount ?? 0, record.longitude ?? '', record.latitude ?? '', record.address ?? '',
      record.adcode ?? '', record.helper ?? null, record.outsourceFlag ?? 0, record.outsourceUserId ?? null,
      record.outsourceUserName ?? null, record.baseVolume ?? 0, record.baseSalary ?? 0,
      record.subsidyUnitPrice ?? 0, record.outsourceIncomeRuleId ?? null, record.createTime, record.updateTime,
    ])
  }
  await connection.commit()
  console.log(JSON.stringify({ inputFiles: files.length, imported: recordsById.size }))
} catch (error) {
  await connection.rollback()
  throw error
} finally {
  await connection.end()
}
