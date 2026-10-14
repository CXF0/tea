import { buildApp } from './app.js'
import { config } from './config.js'

const app = buildApp()
try { await app.listen({ host: config.host, port: config.port }) }
catch (error) { app.log.error(error); process.exit(1) }

let closing = false
async function shutdown() {
  if (closing) return
  closing = true
  try { await app.close(); process.exit(0) }
  catch (error) { app.log.error(error); process.exit(1) }
}
process.on('SIGTERM', shutdown)
process.on('SIGINT', shutdown)
