import { spawnSync } from 'node:child_process'
import 'dotenv/config'



const [startDate, endDate = startDate] = process.argv.slice(2)
const valid = value => /^\d{4}-\d{2}-\d{2}$/.test(value || '') && !Number.isNaN(Date.parse(`${value}T00:00:00+08:00`))
if (!valid(startDate) || !valid(endDate)) {
  console.error('用法：node scripts/seed-realistic-date-range.mjs YYYY-MM-DD [YYYY-MM-DD]')
  process.exit(1)
}

const start = new Date(`${startDate}T00:00:00+08:00`)
const end = new Date(`${endDate}T00:00:00+08:00`)
if (end < start) throw new Error('结束日期不能早于开始日期')
const dayCount = Math.floor((end - start) / 86400000) + 1
if (dayCount > 31) throw new Error('单次最多生成 31 天数据，请拆分日期范围')

const dates = []
for (let cursor = new Date(start); cursor <= end; cursor.setDate(cursor.getDate() + 1)) {
  dates.push(cursor.toLocaleDateString('sv-SE', { timeZone: 'Asia/Shanghai' }))
}

function run(script, args = []) {
  const result = spawnSync(process.execPath, [`scripts/${script}`, ...args], { cwd: process.cwd(), encoding: 'utf8', stdio: 'pipe' })
  if (result.stdout) process.stdout.write(result.stdout)
  if (result.stderr) process.stderr.write(result.stderr)
  if (result.status !== 0) throw new Error(`${script} 执行失败`)
}

console.log(`开始生成 ${startDate} 至 ${endDate} 的真实关联测试数据（${dates.length} 天）`)
const warehouseDates = dates
if (warehouseDates.length) run('seed-recent-warehouse-scenarios.mjs', warehouseDates)
for (const date of dates) run('seed-bulk-purchase-scenarios.mjs', [date])
run('seed-recent-restock-scenarios.mjs', dates)
console.log(JSON.stringify({ success: true, startDate, endDate, days: dates.length, dates }, null, 2))
