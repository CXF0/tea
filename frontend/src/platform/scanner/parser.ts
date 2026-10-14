import type { ParsedScanCode, ScanObjectType, ScanOperationId } from './types'

const expectedType: Record<ScanOperationId, ScanObjectType> = {
  'admission-checkin': 'supplier',
  'quality-inspection': 'flower',
  'quality-video': 'flower',
  'distribution-shelf': 'shelf',
  'packing-shelf': 'shelf',
  'logistics-shelf': 'shelf',
  'cold-storage-bare': 'flower',
  'base-return-confirm': 'flower',
}

function jsonValue(raw: string) {
  try { return JSON.parse(raw) as Record<string, unknown> } catch { return undefined }
}

export function parseScanCode(rawValue: string, operation: ScanOperationId): ParsedScanCode {
  const raw = String(rawValue || '').trim()
  if (!raw) throw new Error('未读取到扫码内容')
  const expected = expectedType[operation]
  const json = jsonValue(raw)
  const candidates: Array<[ScanObjectType, unknown]> = json ? [
    ['supplier', json.supplierId],
    ['flower', json.enterItemId ?? json.itemId ?? json.content],
    ['shelf', json.shelfSn ?? json.shelfNo ?? json.orderNum],
    ['package', json.packageId ?? json.boxId],
  ] : []
  const matched = candidates.find(([type, value]) => type === expected && value !== undefined && value !== null)
  if (matched) {
    const value = String(matched[1]).trim()
    return { raw, type: matched[0], value, id: /^\d+$/.test(value) ? Number(value) : undefined }
  }
  const patterns: Array<[ScanObjectType, RegExp]> = [
    ['supplier', /^(?:supplier(?:Id)?)[:=/](\d+)$/i],
    ['flower', /^(?:enterItemId|itemId|flower|nz)[:=/](\d+)$/i],
    ['shelf', /^(?:xm|shelfSn|shelf|location)[:=/](.+)$/i],
    ['package', /^(?:package|box)[:=/](\d+)$/i],
  ]
  for (const [type, pattern] of patterns) {
    const match = raw.match(pattern)
    if (match && type === expected) {
      const value = match[1].trim()
      return { raw, type, value, id: /^\d+$/.test(value) ? Number(value) : undefined }
    }
  }
  if (/^\d+$/.test(raw)) return { raw, type: expected, value: raw, id: Number(raw) }
  if (expected === 'shelf' && /^[\w-]+$/.test(raw)) {
    return { raw, type: 'shelf', value: raw, id: /^\d+$/.test(raw) ? Number(raw) : undefined }
  }
  const objectName = expected === 'supplier' ? '供应商' : expected === 'flower' ? '花材' : '货架'
  throw new Error(`当前二维码不是有效的${objectName}码`)
}
