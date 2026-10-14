#!/usr/bin/env bash
set -euo pipefail
cd /workspace/tea
node -e 'if (Number(process.versions.node.split(".")[0]) < 24) throw new Error("Node.js 24 or later is required for built-in SQLite")'
npm ci --cache /workspace/.npm-cache --no-audit --no-fund --registry=https://registry.npmjs.org
node --input-type=module <<'JS'
import { existsSync, writeFileSync } from 'node:fs'
import { randomBytes } from 'node:crypto'
if (!existsSync('backend/.env')) {
  writeFileSync('backend/.env', 'HOST=0.0.0.0\nPORT=3101\nAUTH_SECRET='+randomBytes(32).toString('hex')+'\n', {mode:0o600})
}
JS
npm run typecheck
npm run build
npm run db:init
