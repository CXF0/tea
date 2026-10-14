import dotenv from 'dotenv'
import { fileURLToPath } from 'node:url'
import { resolve } from 'node:path'

dotenv.config({ path: new URL('../.env', import.meta.url), quiet: true })
const port = Number(process.env.PORT ?? 3101)
if (!Number.isInteger(port) || port < 1 || port > 65535) throw new Error('PORT 必须是有效端口')

export const config = {
  authSecret: process.env.AUTH_SECRET || 'menghua-local-auth-secret-change-in-production',
  host: process.env.HOST ?? '0.0.0.0',
  port,
  corsOrigin: process.env.CORS_ORIGIN ?? 'http://127.0.0.1:5174',
  database: { path: process.env.SQLITE_PATH ? resolve(process.env.SQLITE_PATH) : fileURLToPath(new URL('../data/menghua.sqlite', import.meta.url)) },
  webRoot: fileURLToPath(new URL('../../frontend/dist/build/h5/', import.meta.url)),
  uploadRoot: fileURLToPath(new URL('../uploads/', import.meta.url)),
}
