import mysql from 'mysql2/promise'
import 'dotenv/config'

const supplierMap = new Map([
  [401, 42762], [402, 42758], [403, 42755], [404, 42742],
  [405, 42737], [406, 42718], [407, 42716], [408, 42715],
])

const connection = await mysql.createConnection({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
})

const ids = [...supplierMap.keys()]
const [targetRows] = await connection.query(
  'SELECT id,supplier_name,login_tel,supplier_tag FROM xm_bulky_supplier WHERE id IN (?)',
  [[...supplierMap.values()]],
)
const targets = new Map(targetRows.map(row => [Number(row.id), row]))
if (targets.size !== supplierMap.size) throw new Error('真实供应商数据不完整，终止替换')

const [columnRows] = await connection.query(
  `SELECT TABLE_NAME,COLUMN_NAME FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA=DATABASE() AND COLUMN_NAME IN ('supplier_id','supplier_name','login_tel')`,
)
const tableColumns = new Map()
for (const row of columnRows) {
  if (!tableColumns.has(row.TABLE_NAME)) tableColumns.set(row.TABLE_NAME, new Set())
  tableColumns.get(row.TABLE_NAME).add(row.COLUMN_NAME)
}

const affected = {}
try {
  await connection.beginTransaction()
  for (const [table, columns] of tableColumns) {
    if (!columns.has('supplier_id')) continue
    for (const [demoId, realId] of supplierMap) {
      const real = targets.get(realId)
      const assignments = ['supplier_id=?']
      const params = [realId]
      if (columns.has('supplier_name')) { assignments.push('supplier_name=?'); params.push(real.supplier_name) }
      if (columns.has('login_tel')) { assignments.push('login_tel=?'); params.push(real.login_tel) }
      params.push(demoId)
      const [result] = await connection.execute(
        `UPDATE \`${table}\` SET ${assignments.join(',')} WHERE supplier_id=?`, params,
      )
      if (result.affectedRows) affected[table] = (affected[table] || 0) + result.affectedRows
    }
  }
  const [deleted] = await connection.query('DELETE FROM xm_bulky_supplier WHERE id IN (?)', [ids])
  await connection.commit()
  console.log(JSON.stringify({ mapping: Object.fromEntries(supplierMap), affected, deletedSuppliers: deleted.affectedRows }))
} catch (error) {
  await connection.rollback()
  throw error
} finally {
  await connection.end()
}
