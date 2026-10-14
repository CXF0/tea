import { DatabaseSync } from 'node:sqlite'
import { readFileSync, mkdirSync } from 'node:fs'
import { dirname } from 'node:path'
import { config } from '../dist/config.js'
import { installFunctions } from '../dist/sqlite/functions.js'
import { translateSql } from '../dist/sqlite/sql.js'

mkdirSync(dirname(config.database.path), { recursive: true })
const db = new DatabaseSync(config.database.path)
const functions = installFunctions(db)
db.exec('PRAGMA foreign_keys=ON; PRAGMA journal_mode=WAL; PRAGMA busy_timeout=5000;')
db.exec('CREATE TABLE IF NOT EXISTS _sqlite_migrations (version TEXT PRIMARY KEY, applied_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP)')
if (db.prepare('SELECT 1 FROM _sqlite_migrations WHERE version=?').get('demo-v1')) {
  console.log('SQLite demo already initialized; existing data preserved.')
  db.close(); process.exit(0)
}

const extraColumns = {
  xm_bulky_supplier_enter_item: { duty_media_json: 'TEXT' },
  xm_inspection_reason_record: { evidence_media_json: 'TEXT', allow_downgrade_restock: 'INTEGER NOT NULL DEFAULT 0' },
  xm_bulky_pack_config: { wms_bind_flag: 'INTEGER NOT NULL DEFAULT 0' },
  wms_permission: { parent_id: 'INTEGER NOT NULL DEFAULT 0', permission_type: 'INTEGER NOT NULL DEFAULT 2', route_path: "TEXT NOT NULL DEFAULT ''", icon: "TEXT NOT NULL DEFAULT ''", sort_order: 'INTEGER NOT NULL DEFAULT 0' },
  hub_vehicle: { tracking_device_no: "TEXT NOT NULL DEFAULT ''", online_status: 'INTEGER NOT NULL DEFAULT 0', acc_status: 'INTEGER NOT NULL DEFAULT 0', acc_status_update_time: 'TEXT', last_acc_on_time: 'TEXT' },
}
const variables = new Map()
const literal = value => value === undefined || value === null ? 'NULL' : typeof value === 'number' ? String(value) : "'" + String(value).replaceAll("'", "''") + "'"
function execute(sql) {
  sql = sql.replace(/@([\w]+)/g, (_, name) => literal(variables.get(name)))
  sql = translateSql(sql)
  if (/^INSERT\b/i.test(sql)) functions.resetLastInsertId()
  try { return db.prepare(sql).columns().length ? db.prepare(sql).all() : db.prepare(sql).run() } catch (error) { console.error(sql); throw error }
}
let current = ''
try {
  db.exec('BEGIN IMMEDIATE')
  db.exec(readFileSync(new URL('../../database/sqlite/schema.sql', import.meta.url), 'utf8'))
  for (const [table, columns] of Object.entries(extraColumns)) {
    const present = new Set(db.prepare(`PRAGMA table_info(${table})`).all().map(row => row.name))
    for (const [name, definition] of Object.entries(columns)) {
      if (!present.has(name)) db.exec(`ALTER TABLE ${table} ADD COLUMN ${name} ${definition}`)
    }
  }
  const statements = JSON.parse(readFileSync(new URL('../../database/sqlite/data-statements.json', import.meta.url), 'utf8'))
  for (const {file, sql} of statements) {
    current = file
    const assignment = /^SET\s+@(\w+)\s*(?::=|=)\s*([\s\S]+)$/i.exec(sql)
    if (assignment) {
      let expression = assignment[2].trim()
      if (expression.startsWith('(') && expression.endsWith(')')) expression = expression.slice(1, -1)
      const rows = execute(/^SELECT\b/i.test(expression) ? expression : `SELECT ${expression} value`)
      variables.set(assignment[1], Object.values(rows[0] || {})[0] ?? null)
    } else execute(sql)
  }
  // Outgoing stock is maintained by the repository transaction, as specified by
  // 20260918_fix_local_cold_storage_triggers.sql. Do not also decrement in a trigger.
  db.exec(`CREATE TRIGGER IF NOT EXISTS cold_stock_initial_bunch AFTER INSERT ON xm_bulky_cold_stock WHEN NEW.store_type=2 AND NEW.remaining_bunch_num IS NULL BEGIN UPDATE xm_bulky_cold_stock SET remaining_bunch_num=NEW.bunch_num WHERE id=NEW.id; END;`)
  db.exec(`INSERT OR IGNORE INTO xm_bulky_supplier(id,supplier_name,login_tel,supplier_tag,data_status)
    SELECT supplier_id,MAX(supplier_name),MAX(login_tel),'演示基地',0 FROM xm_bulky_supplier_enter WHERE supplier_id>0 GROUP BY supplier_id;`)
  const area = db.prepare('INSERT OR IGNORE INTO xm_bulky_wms_area(code,area_name,sequence,status) VALUES (?,?,?,1)')
  for (let n=1;n<=30;n++) area.run(String(n).padStart(2,'0'),`${n}区`,n)
  const group = db.prepare("SELECT id FROM wms_permission_group WHERE code='super_admin_all'").get()
  db.prepare('INSERT OR IGNORE INTO wms_permission_group_item(group_id,permission_id) SELECT ?,id FROM wms_permission WHERE status=1').run(group.id)
  // Keep demo dates current without hard-coding the day the environment was built.
  const today = new Date().toLocaleDateString('sv-SE', { timeZone: 'Asia/Shanghai' })
  const delta = Math.round((Date.parse(today) - Date.parse('2026-09-20')) / 86400000)
  for (const {name} of db.prepare("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE '_sqlite_%'").all()) {
    for (const column of db.prepare(`PRAGMA table_info("${name}")`).all()) {
      if (!['date','round_no','store_round_no','plan_ship_date'].includes(column.name)) continue
      db.prepare(`UPDATE "${name}" SET "${column.name}"=date("${column.name}",?) WHERE "${column.name}" GLOB '2026-09-??'`).run(`${delta} days`)
    }
  }
  db.prepare('INSERT INTO _sqlite_migrations(version) VALUES (?)').run('demo-v1')
  db.exec('COMMIT')
  console.log(JSON.stringify({database:config.database.path, tables:db.prepare("SELECT COUNT(*) n FROM sqlite_master WHERE type='table'").get().n, accounts:db.prepare('SELECT COUNT(*) n FROM wms_account').get().n, items:db.prepare('SELECT COUNT(*) n FROM xm_bulky_supplier_enter_item').get().n, demoDate:today}, null, 2))
} catch (error) {
  db.exec('ROLLBACK')
  console.error(`Initialization rolled back. Failed file: ${current}`)
  throw error
} finally { db.close() }
