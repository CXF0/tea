import mysql from 'mysql2/promise'
import 'dotenv/config'

const connection = await mysql.createConnection({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
})

try {
  await connection.beginTransaction()
  const [bases] = await connection.query('SELECT id,name FROM xm_bulky_base_config ORDER BY id')
  for (const base of bases) {
    const [existing] = await connection.query(
      "SELECT id FROM xm_bulky_user_tag WHERE type=2 AND tag_category='基地' AND name=? LIMIT 1", [base.name],
    )
    if (!existing[0]) {
      await connection.execute(
        'INSERT INTO xm_bulky_user_tag (type,tag_category,name) VALUES (2,?,?)', ['基地', base.name],
      )
    }
  }

  await connection.query(
    `DELETE relation FROM xm_bulky_supplier_tag relation
      JOIN xm_bulky_user_tag tag ON tag.id=relation.tag_id
     WHERE tag.type=2 AND tag.tag_category='基地'`,
  )
  const [result] = await connection.query(
    `INSERT IGNORE INTO xm_bulky_supplier_tag (supplier_id,tag_id,create_time)
     SELECT supplier.id,tag.id,NOW()
       FROM xm_bulky_supplier supplier
       JOIN xm_bulky_user_tag tag
         ON tag.type=2 AND tag.tag_category='基地' AND tag.name=supplier.supplier_tag
      WHERE supplier.supplier_tag<>''`,
  )
  await connection.commit()
  console.log(JSON.stringify({ baseTags: bases.length, supplierRelations: result.affectedRows }))
} catch (error) {
  await connection.rollback()
  throw error
} finally {
  await connection.end()
}
