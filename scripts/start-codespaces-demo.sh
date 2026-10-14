#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
if node --input-type=module -e 'try {const r=await fetch("http://127.0.0.1:3101/api/health"); const d=await r.json(); process.exit(d.service==="menghuacangguan-api"&&d.database?.engine==="sqlite"?0:1)} catch {process.exit(1)}'; then
  echo 'Existing SQLite demo service is healthy.'
  exit 0
fi
npm run db:init
nohup npm start > /tmp/menghua-codespaces-demo.log 2>&1 &
echo $! > /tmp/menghua-codespaces-demo.pid
node --input-type=module <<'JS'
for(let attempt=0;attempt<60;attempt++) {
  try {
    const response=await fetch('http://127.0.0.1:3101/api/health')
    const data=await response.json()
    if(response.ok && data.database?.engine==='sqlite') {
      console.log('SQLite full-stack demo is ready. Open forwarded port 3101 in the Codespaces Ports panel.')
      process.exit(0)
    }
  } catch {}
  await new Promise(resolve=>setTimeout(resolve,500))
}
console.error('Service startup failed; inspect /tmp/menghua-codespaces-demo.log.')
process.exit(1)
JS
