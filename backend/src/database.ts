import { DatabaseSync } from 'node:sqlite'
import { mkdirSync } from 'node:fs'
import { dirname } from 'node:path'
import { config } from './config.js'
import { installFunctions } from './sqlite/functions.js'
import { bindArrays, translateSql } from './sqlite/sql.js'

export interface RowDataPacket { [column: string]: any }
export interface ResultSetHeader { affectedRows: number; insertId: number; changedRows: number }
export type PoolConnection = SQLiteConnection

mkdirSync(dirname(config.database.path), {recursive: true})
const sqlite = new DatabaseSync(config.database.path)
sqlite.exec('PRAGMA journal_mode=WAL; PRAGMA foreign_keys=ON; PRAGMA busy_timeout=5000;')
installFunctions(sqlite)

// A transaction retains exclusive ownership until release(). Requests outside the
// transaction queue asynchronously instead of joining another request's transaction.
let tail: Promise<void> = Promise.resolve()
async function acquire() {
  let unlock!: () => void
  const next = new Promise<void>(resolve => { unlock = resolve })
  const previous = tail; tail = previous.then(() => next)
  await previous
  return unlock
}

function run<T>(source: string, values: unknown[] = []): [T, unknown[]] {
  const bound = bindArrays(source, values)
  const sql = translateSql(bound.sql)
  try {
    const statement = sqlite.prepare(sql)
    if (statement.columns().length) return [statement.all(...bound.params) as T, []]
    const result = statement.run(...bound.params)
    return [{affectedRows: Number(result.changes), changedRows: Number(result.changes), insertId: Number(result.lastInsertRowid)} as T, []]
  } catch (error) {
    // Include statement shape only: bindings may contain private user data.
    throw new Error(`SQLite query failed: ${(error as Error).message}\n${sql}`, {cause: error})
  }
}

export class SQLiteConnection {
  private active = false
  private released = false
  constructor(private readonly unlock: () => void) {}
  async query<T = any>(sql: string, values: unknown[] = []) {
    if (this.released) throw new Error('Connection already released')
    return run<T>(sql, values)
  }
  execute<T = ResultSetHeader>(sql: string, values: unknown[] = []) { return this.query<T>(sql, values) }
  async beginTransaction() {
    if (this.released || this.active) throw new Error('Invalid transaction state')
    sqlite.exec('BEGIN IMMEDIATE'); this.active = true
  }
  async commit() { if (this.active) { sqlite.exec('COMMIT'); this.active = false } }
  async rollback() { if (this.active) { sqlite.exec('ROLLBACK'); this.active = false } }
  release() {
    if (this.released) return
    try { if (this.active) sqlite.exec('ROLLBACK') }
    finally { this.active = false; this.released = true; this.unlock() }
  }
  async end() { this.release() }
}

export const database = {
  async query<T = any>(sql: string, values: unknown[] = []) {
    const unlock = await acquire()
    try { return run<T>(sql, values) } finally { unlock() }
  },
  async execute<T = ResultSetHeader>(sql: string, values: unknown[] = []) { return this.query<T>(sql, values) },
  async getConnection() { return new SQLiteConnection(await acquire()) },
  async end() { const unlock = await acquire(); try { sqlite.close() } finally { unlock() } },
}

export async function checkDatabaseConnection() {
  const [rows] = await database.query('SELECT DATABASE() databaseName, sqlite_version() version, 1 connected')
  return rows[0] as {databaseName: string; version: string; connected: number}
}
