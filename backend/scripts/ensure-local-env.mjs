import { existsSync, writeFileSync } from 'node:fs'
import { randomBytes } from 'node:crypto'
const file = new URL('../.env', import.meta.url)
if (!existsSync(file)) {
  writeFileSync(file, 'HOST=0.0.0.0\nPORT=3101\nAUTH_SECRET='+randomBytes(32).toString('hex')+'\n', {mode:0o600})
  console.log('Created local demo configuration with a unique signing key.')
}
