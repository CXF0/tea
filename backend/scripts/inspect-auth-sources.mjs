import dotenv from 'dotenv'
import mysql from 'mysql2/promise'

dotenv.config({ path: new URL('../.env', import.meta.url) })

const connection = await mysql.createConnection({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
})

try {
  const lookupType = process.argv[2]
  const lookupValue = process.argv[3]
  if (lookupType === 'tree') {
    const [rows] = await connection.query(
      `SELECT p.id,p.parent_id,p.permission_type,p.code,p.name,p.domain_code,p.route_path,p.sort_order
       FROM wms_permission p ORDER BY IF(p.parent_id=0,p.sort_order,9999),p.parent_id,p.sort_order,p.id`,
    )
    console.table(rows)
  } else if (lookupType === 'group' && lookupValue) {
    const [rows] = await connection.query(
      `SELECT g.id group_id,g.code group_code,g.name group_name,p.id permission_id,p.code permission_code,p.name permission_name
       FROM wms_permission_group g
       LEFT JOIN wms_permission_group_item gi ON gi.group_id=g.id
       LEFT JOIN wms_permission p ON p.id=gi.permission_id
       WHERE g.id=? OR g.code=? ORDER BY p.id`,
      [Number(lookupValue) || 0, lookupValue],
    )
    console.table(rows)
    const [roles] = await connection.query(
      `SELECT g.id group_id,g.code group_code,r.id role_id,r.code role_code,r.name role_name
       FROM wms_permission_group g
       LEFT JOIN wms_role_permission_group rg ON rg.group_id=g.id
       LEFT JOIN wms_role r ON r.id=rg.role_id
       WHERE g.id=? OR g.code=? ORDER BY r.id`,
      [Number(lookupValue) || 0, lookupValue],
    )
    console.table(roles)
  } else if (lookupType === 'permission' && Number(lookupValue) > 0) {
    const permissionId = Number(lookupValue)
    const [rows] = await connection.query(
      `SELECT p.id,p.code,p.name,p.status,g.id group_id,g.code group_code,g.name group_name
       FROM wms_permission p
       LEFT JOIN wms_permission_group_item gi ON gi.permission_id=p.id
       LEFT JOIN wms_permission_group g ON g.id=gi.group_id
       WHERE p.id=?`,
      [permissionId],
    )
    console.table(rows)
  } else {
    const [databases] = await connection.query('SHOW DATABASES')
    console.log(databases.map((row) => row.Database).join('\n'))
  }
} finally {
  await connection.end()
}
