import { readFile } from 'node:fs/promises'
import dotenv from 'dotenv'
import mysql from 'mysql2/promise'

dotenv.config({ path: new URL('../.env', import.meta.url) })
const migrationFiles = [
  '20260920_expand_wms_roles_accounts.sql',
  '20260920_split_quality_entry_permissions.sql',
  '20260920_add_permission_group_item_view.sql',
  '20260920_permission_tree.sql',
  '20260920_add_packing_statistics_permissions.sql',
  '20260920_grant_logistics_specialist.sql',
  '20260920_part_logistics_domain.sql',
  '20260921_workforce_domains.sql',
  '20260921_remove_site_admin_workbench_cards.sql',
  '20260921_distribution_staff_accounts.sql',
  '20260921_quality_inspector_accounts.sql',
  '20260921_base_management_domain.sql',
  '20260921_account_base_permissions.sql',
  '20260921_base_stocktaking_domain.sql',
  '20260921_base_outsource_income_domain.sql',
  '20260921_rename_demo_account_display_names.sql',
  '20260921_assign_hongta_outsource_manager.sql',
  '20260921_base_return_domain.sql',
  '20260921_agri_material_domain.sql',
  '20260921_site_admin_arrival_data_cards.sql',
  '20260921_site_admin_quality_business_cards.sql',
  '20260921_site_admin_contractor_distribution_card.sql',
  '20260921_distribution_teams.sql',
  '20260921_rename_inspection_attendance.sql',
  '20260921_rename_distribution_staff.sql',
]
const connection = await mysql.createConnection({
  host: process.env.DB_HOST, port: Number(process.env.DB_PORT || 3306), user: process.env.DB_USER,
  password: process.env.DB_PASSWORD, database: process.env.DB_NAME, multipleStatements: true,
})
try {
  if (process.env.DB_NAME !== 'menghuacangguan_v1_local') throw new Error(`拒绝写入非本地新版库：${process.env.DB_NAME}`)
  const permissionTreeColumns = [
    ['parent_id', 'BIGINT UNSIGNED NOT NULL DEFAULT 0 AFTER id'],
    ['permission_type', 'TINYINT UNSIGNED NOT NULL DEFAULT 2 AFTER domain_code'],
    ['route_path', "VARCHAR(255) NOT NULL DEFAULT '' AFTER description"],
    ['icon', "VARCHAR(255) NOT NULL DEFAULT '' AFTER route_path"],
    ['sort_order', 'INT NOT NULL DEFAULT 0 AFTER icon'],
  ]
  for (const [name, definition] of permissionTreeColumns) {
    const [columns] = await connection.query(
      `SELECT 1 FROM information_schema.COLUMNS
       WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='wms_permission' AND COLUMN_NAME=?`,
      [name],
    )
    if (!columns.length) await connection.query(`ALTER TABLE wms_permission ADD COLUMN ${name} ${definition}`)
  }
  for (const file of migrationFiles) {
    const sql = await readFile(new URL(`../../database/${file}`, import.meta.url), 'utf8')
    await connection.query(sql)
  }
  const [roles] = await connection.query('SELECT r.code,r.name,COUNT(DISTINCT a.id) account_count,COUNT(DISTINCT p.id) capability_count FROM wms_role r LEFT JOIN wms_account a ON a.role_id=r.id AND a.status=1 LEFT JOIN wms_role_permission_group rg ON rg.role_id=r.id LEFT JOIN wms_permission_group_item gi ON gi.group_id=rg.group_id LEFT JOIN wms_permission p ON p.id=gi.permission_id AND p.status=1 WHERE r.status=1 GROUP BY r.id ORDER BY r.id')
  console.table(roles)
} finally { await connection.end() }
