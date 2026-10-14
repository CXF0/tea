import fs from 'node:fs'
import mysql from 'mysql2/promise'
import 'dotenv/config'

const files = process.argv.slice(2)
if (!files.length) throw new Error('请传入至少一个供应商 JSON 文件')

const recordsById = new Map()
for (const file of files) {
  const payload = JSON.parse(fs.readFileSync(file, 'utf8'))
  const records = payload?.data?.records
  if (!Array.isArray(records)) throw new Error(`${file} 不包含 data.records`)
  for (const record of records) recordsById.set(record.id, record)
}

const connection = await mysql.createConnection({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
})

const toSnakeCase = value => value.replace(/[A-Z]/g, letter => `_${letter.toLowerCase()}`)
const [columnRows] = await connection.query('SHOW COLUMNS FROM xm_bulky_supplier')
const columnsByName = new Map(columnRows.map(column => [column.Field, column]))
const sample = [...recordsById.values()][0]
const mappings = Object.keys(sample)
  .map(key => ({ key, column: toSnakeCase(key) }))
  .filter(mapping => columnsByName.has(mapping.column))

const columns = mappings.map(mapping => mapping.column)
const updateColumns = columns.filter(column => column !== 'id')
const placeholders = columns.map(() => '?').join(',')
const sql = `INSERT INTO xm_bulky_supplier (${columns.map(column => `\`${column}\``).join(',')},\`update_time\`)
 VALUES (${placeholders},NOW())
 ON DUPLICATE KEY UPDATE ${updateColumns.map(column => `\`${column}\`=VALUES(\`${column}\`)`).join(',')}, update_time=NOW()`

function normalize(mapping, record) {
  let value = record[mapping.key]
  const column = columnsByName.get(mapping.column)
  if (value !== null && typeof value === 'object') value = JSON.stringify(value)
  if (value === null && column.Null === 'NO') value = column.Default ?? ''
  return value
}

try {
  await connection.beginTransaction()
  for (const record of [...recordsById.values()].sort((a, b) => a.id - b.id)) {
    await connection.execute(sql, mappings.map(mapping => normalize(mapping, record)))
  }
  await connection.commit()
  console.log(JSON.stringify({ inputFiles: files.length, imported: recordsById.size, mappedColumns: columns.length }))
} catch (error) {
  await connection.rollback()
  throw error
} finally {
  await connection.end()
}
