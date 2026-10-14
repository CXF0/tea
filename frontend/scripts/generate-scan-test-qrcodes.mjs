import { mkdir, writeFile } from 'node:fs/promises'
import { fileURLToPath } from 'node:url'
import path from 'node:path'
import QRCode from 'qrcode'

const directory = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../../docs/scan-test-qrcodes')
const cases = [
  ['01-admission-checkin', '扫码入场', 'supplierId:42834', '云可鲜花，场次 2026-09-20'],
  ['02-quality-inspection', '扫码质检', 'enterItemId:990001805', '勿忘我，场次 2026-09-20'],
  ['03-quality-video', '扫码拍视频', 'enterItemId:990001805', '勿忘我，场次 2026-09-20'],
  ['04-distribution-shelf', '扫码配货', 'xm:20-020', '配货货架 20-020，场次 2026-09-20'],
  ['05-packing-shelf', '扫码打包', 'shelfSn:9140', '打包货架 09-140-1，场次 2026-09-20'],
  ['06-logistics-shelf', '扫码查发货', 'shelfSn:9140', '物流货架 09-140-1，场次 2026-09-20'],
  ['07-cold-storage-bare', '裸花暂存', 'enterItemId:990001805', '勿忘我，场次 2026-09-20'],
  ['08-base-return-confirm', '退货确认', 'enterItemId:990001805', '格式有效；当前测试库没有待退货花材'],
]

await mkdir(directory, { recursive: true })
for (const [fileName, , content] of cases) {
  await QRCode.toFile(path.join(directory, `${fileName}.png`), content, {
    type: 'png', width: 420, margin: 3, errorCorrectionLevel: 'M',
  })
}
const lines = ['# 扫码作业测试二维码', '', '> 测试场次：2026-09-20。二维码内容来自本地数据库现有供应商、花材和货架。', '']
for (const [fileName, title, content, note] of cases) {
  lines.push(`## ${title}`, '', `- 内容：\`${content}\``, `- 对象：${note}`, '', `![${title}](./${fileName}.png)`, '')
}
await writeFile(path.join(directory, 'README.md'), `${lines.join('\n')}\n`, 'utf8')
console.log(`Generated ${cases.length} QR codes in ${directory}`)
