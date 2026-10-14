import { AppError } from '../../shared/errors.js'
import * as repository from './quality.repository.js'
import type { QualityTaskRow, SubmitInspectionCommand, SupplierFlowerItemRow } from './quality.types.js'

const rankLabels: Record<number, string> = { 1: 'A级', 2: 'B级', 3: 'C级', 4: 'D级', 5: 'E级' }
const statusLabels: Record<number, string> = { 0: '待质检', 1: '合格', 2: '良好', 10: '不合格' }

function parseJsonArray(value?: string | null): string[] {
  if (!value) return []
  try { const parsed = JSON.parse(value); return Array.isArray(parsed) ? parsed.filter(item => typeof item === 'string') : [] }
  catch { return [] }
}

function parseFlowerSku(value: string) {
  const entries = value.split(',').map(part => part.trim()).filter(Boolean).map(part => {
    const separator = part.indexOf(':')
    return separator > -1 ? { key: part.slice(0, separator).trim(), value: part.slice(separator + 1).trim() } : { key: '', value: part }
  })
  const maturity = entries.find(entry => /成熟度|成熟/.test(entry.key))?.value ?? ''
  let bundleSpecification = entries.find(entry => /规格|枝数|每扎/.test(entry.key))?.value ?? ''
  if (!bundleSpecification) bundleSpecification = value.split('/').map(part => part.trim()).find(part => /枝/.test(part)) ?? ''
  if (bundleSpecification && /枝$/.test(bundleSpecification)) bundleSpecification = `${bundleSpecification}/扎`
  return { maturity, bundleSpecification }
}

function mapTask(row: QualityTaskRow) {
  const shelf = row.zoen_shelf || `#${String(row.shelf_sn).padStart(2, '0')}-${row.sub_shelf_sn || '001'}`
  return {
    id: row.id,
    session: row.date,
    location: shelf.startsWith('#') ? shelf : `#${shelf}`,
    flowerName: row.product_name,
    grade: rankLabels[row.rank_num] ?? `${row.rank_num}级`,
    specification: row.sku_config,
    quantity: row.item_num,
    allocatedQuantity: row.prepare_item_num,
    unit: '扎',
    supplierName: row.supplier_name || '未知供应商',
    priority: row.inspection_flag === 1,
    focused: row.focus_flag === 1,
    taskType: row.quality_product === 1 || row.refund_product === 1 || row.quality_flag === 1 ? 'self' : 'assigned',
    customerType: row.big_order === 1 ? 'big' : row.new_order === 1 ? 'new' : 'other',
    markers: { return: row.refund_product === 1, exchange: row.quality_product === 1 },
    receiverPhone: row.receive_tel || '',
    status: row.status,
    statusLabel: statusLabels[row.status] ?? '未知',
    assigneeName: row.assigned_user_name,
    remark: row.remark,
    finishedAt: row.finish_time,
  }
}

export async function getTaskPage(date: string, status?: number, assigneeUserId?: number) {
  const rows = await repository.listQualityTasks(date, status, assigneeUserId)
  return rows.map(mapTask)
}

export async function getSelfInspectionLocations(date: string, userId?: number) {
  return (await repository.listSelfInspectionLocations(date, userId)).map(row => ({
    location: formatVideoShelf(String(row.zone_shelf || ''), String(row.sub_shelf_sn || '')),
    flowerCount: Number(row.flower_count ?? 0), markedUnitCount: Number(row.marked_unit_count ?? 0),
    flowerSummary: String(row.flower_summary || ''), supplierSummary: String(row.supplier_summary || ''),
    markers: { return: Number(row.return_mark) === 1, exchange: Number(row.exchange_mark) === 1 },
    latestMarkedAt: row.latest_mark_time,
  }))
}

function formatVideoShelf(zoneShelf?: string | null, subShelf?: string | null) {
  let value = (zoneShelf || '').replace(/^#/, '')
  if (subShelf && !value.endsWith(`-${subShelf}`)) value = `${value}-${subShelf}`
  return value ? `#${value}${subShelf ? '段' : ''}` : '货位待确认'
}

export async function getGoodFlowerVideos(date: string, userId: number) {
  const [summary, rows] = await Promise.all([
    repository.getGoodFlowerVideoSummary(date, userId), repository.listGoodFlowerVideos(date, userId),
  ])
  return {
    required: Number(summary.required ?? 0), completed: Number(summary.completed ?? 0),
    records: rows.map(row => ({
      id: Number(row.id), enterItemId: Number(row.enter_item_id), flowerName: String(row.item_name),
      grade: rankLabels[Number(row.rank_num)] ?? `${row.rank_num}级`, supplierName: String(row.supplier_name || ''),
      supplierTag: String(row.supplier_tag || ''), location: formatVideoShelf(String(row.zone_shelf || ''), String(row.sub_shelf_sn || '')),
      videoUrl: String(row.video_url), remark: String(row.remark || ''), createdAt: row.create_time, updatedAt: row.update_time,
    })),
  }
}

export async function scanGoodFlowerVideoItem(date: string, content: string) {
  let encodedId: unknown
  try { const parsed = JSON.parse(content); encodedId = parsed.enterItemId ?? parsed.enter_item_id ?? parsed.id }
  catch { encodedId = undefined }
  const matches = content.match(/\d+/g)
  const itemId = Number(encodedId ?? matches?.at(-1))
  if (!Number.isInteger(itemId) || itemId <= 0) throw new AppError(400, 'INVALID_FLOWER_QR_CODE', '未识别到有效的花材二维码')
  const item = await repository.getGoodFlowerVideoItem(itemId, date)
  if (!item) throw new AppError(404, 'FLOWER_ITEM_NOT_FOUND', '当前场次未找到该花材，请确认二维码和场次')
  return {
    enterItemId: item.id, flowerName: item.product_name,
    grade: rankLabels[item.rank_num] ?? `${item.rank_num}级`, supplierName: item.supplier_name,
    supplierTag: item.supplier_tag ?? '', location: formatVideoShelf(item.zone_shelf, item.sub_shelf_sn), session: item.date,
  }
}

export async function submitGoodFlowerVideo(command: { date: string; enterItemId: number; videoUrl: string; remark?: string; userId: number; userName: string }) {
  if (!/^\/uploads\/quality-videos\//.test(command.videoUrl)) throw new AppError(400, 'INVALID_VIDEO_URL', '请先完成视频上传')
  if ((command.remark?.length ?? 0) > 200) throw new AppError(400, 'VIDEO_REMARK_TOO_LONG', '拍摄说明最多200字')
  const item = await repository.getGoodFlowerVideoItem(command.enterItemId, command.date)
  if (!item) throw new AppError(404, 'FLOWER_ITEM_NOT_FOUND', '当前场次未找到该花材')
  const id = await repository.saveGoodFlowerVideo({ ...command, remark: command.remark?.trim() ?? '', item })
  return { id }
}

export async function getTaskDetail(taskId: number) {
  const row = await repository.getQualityTask(taskId)
  if (!row) throw new AppError(404, 'QUALITY_TASK_NOT_FOUND', '质检任务不存在')
  return mapTask(row)
}

function mapSupplierFlowerItem(row: SupplierFlowerItemRow) {
  let shelf = (row.zone_shelf || String(row.order_num).padStart(2, '0')).replace(/^#/, '')
  if (row.sub_shelf_sn && !shelf.endsWith(`-${row.sub_shelf_sn}`)) shelf = `${shelf}-${row.sub_shelf_sn}`
  const sku = parseFlowerSku(row.sku_config)
  return {
    id: row.id, enterId: row.enter_id, shelf: `#${shelf}${row.sub_shelf_sn ? '段' : ''}`,
    orderNumber: row.order_num, subShelf: row.sub_shelf_sn, flowerName: row.product_name,
    grade: rankLabels[row.rank_num] ?? `${row.rank_num}级`, specification: row.sku_config,
    maturity: sku.maturity, bundleSpecification: sku.bundleSpecification,
    quantity: row.item_num, unit: '扎', positioned: row.is_position === 1,
    qualityStatus: row.is_qualify as 0 | 1 | 10,
    qualityStatusLabel: row.is_qualify === 10 ? `本货位问题标记 ${row.not_qualify_num} 扎` : '本货位暂无问题标记',
    unqualifiedQuantity: row.not_qualify_num, inspectorName: row.qualify_user_name,
    inspectedAt: row.update_time,
    supplier: { name: row.supplier_name ?? null, phone: row.supplier_phone ?? null },
    supplierPrice: Number(row.supplier_price ?? 0),
    customer: row.customer_name || row.customer_phone || row.partner_name ? { name: row.customer_name ?? null, phone: row.customer_phone ?? null, partnerName: row.partner_name ?? null, unqualifiedWay: row.unqualified_way ?? 0, unqualifiedWayLabel: ({ 1: '退货', 2: '降级', 3: '补货' } as Record<number, string>)[row.unqualified_way ?? 0] ?? '未设置' } : null,
    controls: { limitDistribution: row.limit_distribution_flag === 1, merchantResponsibility: row.duty_flag === 1, noAfterSale: row.no_after_sale_flag === 1, responsibilityRemark: row.duty_remark ?? '', responsibilityMedia: parseJsonArray(row.duty_media_json) },
  }
}

export async function updateSupplierFlowerControls(itemId: number, flags: { limitDistribution?: boolean; merchantResponsibility?: boolean; noAfterSale?: boolean; remark?: string; media?: string[] }) {
  if (flags.merchantResponsibility === true && !flags.remark?.trim()) throw new AppError(400, 'RESPONSIBILITY_REMARK_REQUIRED', '开启商家全责时必须填写说明')
  if (flags.merchantResponsibility === true && !flags.media?.length) throw new AppError(400, 'RESPONSIBILITY_MEDIA_REQUIRED', '开启商家全责时至少上传1个图片或视频')
  if ((flags.media?.length ?? 0) > 6) throw new AppError(400, 'RESPONSIBILITY_MEDIA_LIMIT', '图片和视频合计最多上传6个')
  if (!(await repository.updateSupplierFlowerFlags(itemId, flags))) throw new AppError(404, 'FLOWER_ITEM_NOT_FOUND', '货架花材不存在')
  return { itemId }
}

export async function getSupplierFlowerItems(enterId: number) {
  return (await repository.listSupplierFlowerItems(enterId)).map(mapSupplierFlowerItem)
}

export async function getSupplierFlowerItem(itemId: number) {
  const row = await repository.getSupplierFlowerItem(itemId)
  if (!row) throw new AppError(404, 'FLOWER_ITEM_NOT_FOUND', '货架花材不存在')
  const marks = await repository.listSupplierFlowerItemMarks(itemId)
  return {
    ...mapSupplierFlowerItem(row),
    allocatedUnits: await repository.listAllocatedUnits(itemId),
    unitMarks: marks.map(mark => ({
      unit: Number(String(mark.code_content).split('-').pop()),
      operation: Number(mark.op),
    })).filter(mark => Number.isInteger(mark.unit) && mark.unit > 0),
  }
}

export async function setUnitAllocation(itemId:number,command:{units:number[];allocated:boolean;userId:number;userName:string}) { const item=await repository.getSupplierFlowerItem(itemId); if(!item) throw new AppError(404,'FLOWER_ITEM_NOT_FOUND','货架花材不存在'); const units=[...new Set(command.units)].filter(Number.isInteger); if(!units.length||units.some(unit=>unit<1||unit>item.item_num)) throw new AppError(400,'INVALID_UNITS','请选择有效的花材扎号'); await repository.updateUnitAllocation(itemId,units,command.allocated,command.userId,command.userName); return {itemId,units,allocated:command.allocated} }
export async function revokeInspection(itemId:number,units:number[]) { if(!(await repository.getSupplierFlowerItem(itemId))) throw new AppError(404,'FLOWER_ITEM_NOT_FOUND','货架花材不存在'); const selected=[...new Set(units)].filter(Number.isInteger); if(!selected.length) throw new AppError(400,'INVALID_UNITS','请选择需要撤销的花材扎号'); if(!(await repository.revokeInspectionMarks(itemId,selected))) throw new AppError(400,'NO_INSPECTION_MARK','所选花材没有可撤销的质检问题标记'); return {itemId,units:selected} }

export async function getSupplierFlowerItemLogs(itemId: number) {
  if (!(await repository.getSupplierFlowerItem(itemId))) throw new AppError(404, 'FLOWER_ITEM_NOT_FOUND', '货架花材不存在')
  const labels: Record<number, string> = { 1: '降一级', 2: '降两级', 3: '退货不补', 5: '退货补货', 6: '缺货补货', 7: '缺货不补', 12: '换货' }
  return (await repository.listSupplierFlowerItemLogs(itemId)).map(row => ({ unit: Number(String(row.code_content).split('-').pop()), operation: Number(row.op), operationLabel: labels[Number(row.op)] ?? `操作${row.op}`, reason: row.reason_name, category: row.parent_reason_name, operatorName: row.user_name || '未知操作人', operatedAt: row.create_time, active: Number(row.data_status) === 0 }))
}

export async function getInspectionPreview(itemId: number, command: { operation: number; affectedUnits: number[]; reasonIds: number[] }) {
  const item = await repository.getSupplierFlowerItem(itemId)
  if (!item) throw new AppError(404, 'FLOWER_ITEM_NOT_FOUND', '货架花材不存在')
  const units = [...new Set(command.affectedUnits)].filter(Number.isInteger)
  if (!units.length || units.some(unit => unit < 1 || unit > item.item_num)) throw new AppError(400, 'INVALID_AFFECTED_UNITS', '请选择有效的花材扎号')
  const reasons = await repository.listInspectionReasons([...new Set(command.reasonIds)].filter(Number.isInteger))
  if (!reasons.length || reasons.length !== new Set(command.reasonIds).size) throw new AppError(400, 'INVALID_REASON', '请选择有效的质检问题类型')
  const rule = await repository.getQualityPunishRule(command.operation)
  if (!rule) throw new AppError(400, 'PUNISH_RULE_NOT_FOUND', '当前处置方式未配置处罚规则')
  const unitPrice = Number(item.supplier_price ?? 0)
  const percent = Number(rule.punish_percent)
  const principal = unitPrice * units.length
  return {
    operation: command.operation, operationLabel: rule.operation_name,
    flowerName: item.product_name, grade: rankLabels[item.rank_num] ?? `${item.rank_num}级`,
    supplierName: item.supplier_name ?? '', selectedCount: units.length, unitPrice,
    principal: Number(principal.toFixed(2)), punishPercent: percent,
    punishAmount: Number((principal * percent / 100).toFixed(2)),
    formula: rule.description, reasons: reasons.map(reason => ({ id: Number(reason.id), name: reason.reason_name })),
    customerChoice: ({ 1: '退货', 2: '降级', 3: '补货' } as Record<number, string>)[item.unqualified_way ?? 0] ?? '未设置',
  }
}

export async function getQualityPunishRules() {
  return (await repository.listQualityPunishRules()).map(row => {
    const operation = Number(row.operation)
    const commonPercent = Number(row.punish_percent)
    const dounanPercent = [6, 7].includes(operation) ? 300 : commonPercent
    const gradeNote = operation === 1 ? '；原等级为E级时按50%' : ''
    return {
      operation,
      operationName: String(row.operation_name),
      punishPercent: commonPercent,
      description: String(row.description ?? ''),
      supplierRules: [
        { supplierType: '非斗南供应商', punishPercent: commonPercent, description: `按后台通用比例执行${gradeNote}` },
        { supplierType: '斗南供应商', punishPercent: dounanPercent, description: [6, 7].includes(operation) ? '旧系统固定覆盖：涉及本金 × 300%' : `与通用规则一致${gradeNote}` },
      ],
    }
  })
}

export async function inspectSupplierFlowerItem(itemId: number, command: { status: 1 | 10; affectedUnits: number[]; reasonIds: number[]; operation: number; evidenceMedia: string[]; allowDowngradeRestock: boolean; userId: number; userName: string }) {
  const units = [...new Set(command.affectedUnits)].filter(Number.isInteger).sort((a, b) => a - b)
  const reasons = [...new Set(command.reasonIds)].filter(Number.isInteger)
  if (command.status === 10 && !units.length) throw new AppError(400, 'AFFECTED_UNITS_REQUIRED', '请选择存在问题的花材扎号')
  if (command.status === 10 && (!reasons.length || reasons.length > 10)) throw new AppError(400, 'QUALITY_REASONS_REQUIRED', '请选择1至10个具体质检问题')
  if (command.status === 10 && ![1, 2, 3, 5, 6, 7, 12].includes(command.operation)) throw new AppError(400, 'QUALITY_OPERATION_REQUIRED', '请选择质检问题的处置方式')
  const evidenceMedia = [...new Set(command.evidenceMedia.map(String).filter(Boolean))]
  if (evidenceMedia.length > 6) throw new AppError(400, 'INSPECTION_MEDIA_LIMIT', '质检凭证图片和视频合计最多6个')
  if (evidenceMedia.some(url => !url.startsWith('/uploads/quality-duty/'))) throw new AppError(400, 'INVALID_INSPECTION_MEDIA', '质检凭证地址无效')
  const allowDowngradeRestock = [5, 6].includes(command.operation) && command.allowDowngradeRestock
  const result = await repository.inspectSupplierFlowerItem(itemId, { ...command, affectedUnits: units, reasonIds: reasons, evidenceMedia, allowDowngradeRestock })
  if (result.kind === 'not_found') throw new AppError(404, 'FLOWER_ITEM_NOT_FOUND', '货架花材不存在')
  if (result.kind === 'quantity_exceeded') throw new AppError(400, 'UNQUALIFIED_QUANTITY_EXCEEDED', '不合格数量不能超过该货架花材数量')
  if (result.kind === 'invalid_reason') throw new AppError(400, 'INVALID_QUALITY_REASON', '所选质检问题已失效，请重新选择')
  return { itemId, status: command.status }
}

export async function getSummary(date: string) {
  const row = await repository.getQualitySummary(date)
  return {
    total: Number(row.total ?? 0),
    pending: Number(row.pending ?? 0),
    passed: Number(row.passed ?? 0),
    rejected: Number(row.rejected ?? 0),
    priorityPending: Number(row.priorityPending ?? 0),
  }
}

export async function getTeamTaskSummary(date: string, accountId: number) {
  const team = await repository.getOwnedQualityTeam(accountId)
  if (!team) return { configured: false, teamName: '', zones: [], total: 0, completed: 0, pending: 0, passed: 0, rejected: 0, inspectorCount: 0, zoneBreakdown: [] }

  let zones: string[] = []
  try {
    const config = JSON.parse(String(team.perm_config || '{}')) as { zones?: unknown }
    if (Array.isArray(config.zones)) {
      zones = [...new Set(config.zones.map((zone) => String(Number(zone))).filter((zone) => Number(zone) > 0))]
    }
  } catch { zones = [] }

  const rows = await repository.getTeamQualityTaskStatistics(date, zones)
  const inspectorIds = new Set<number>()
  const zoneBreakdown = rows.map((row) => {
    String(row.inspector_ids || '').split(',').map(Number).filter(Boolean).forEach((id) => inspectorIds.add(id))
    return {
    zone: String(row.zone), name: String(row.zone_name), total: Number(row.total ?? 0),
    completed: Number(row.completed ?? 0), pending: Number(row.pending ?? 0),
    passed: Number(row.passed ?? 0), rejected: Number(row.rejected ?? 0),
    inspectorCount: Number(row.inspector_count ?? 0),
    }
  })
  const sum = (key: keyof (typeof zoneBreakdown)[number]) => zoneBreakdown.reduce((total, row) => total + Number(row[key] || 0), 0)
  return {
    configured: zones.length > 0, teamName: String(team.name), zones,
    total: sum('total'), completed: sum('completed'), pending: sum('pending'),
    passed: sum('passed'), rejected: sum('rejected'),
    inspectorCount: inspectorIds.size,
    zoneBreakdown,
  }
}

export async function getQualityScope(accountId:number) {
  const scope=await repository.getQualityDataScope(accountId)
  return { all:scope.all, zones:scope.areas.map(row=>({code:String(row.code),name:String(row.area_name||`${row.code}区`)})) }
}

export async function getBusinessSummary(date: string, accountId: number, requestedZone?: string) {
  const scope=await getQualityScope(accountId)
  const available=scope.zones.map(zone=>zone.code)
  const zones=requestedZone ? available.filter(zone=>String(Number(zone))===String(Number(requestedZone))) : available
  const row = await repository.getQualityBusinessSummary(date,zones)
  const data = row as Record<string, unknown>
  const number = (key: string) => Number(data[key] ?? 0)
  return {
    requiredSuppliers: number('required_suppliers'), pendingSuppliers: number('pending_suppliers'), admittedSuppliers: number('admitted_suppliers'),
    downgradeUnits: number('downgrade_units'), returnUnits: number('return_units'), shortageUnits: number('shortage_units'),
    exchangeUnits: number('exchange_units'), exchangedUnits: number('exchanged_units'), resaleUnits: number('resale_units'),
    returnTransferUnits: number('resale_units'), involvedLocationCount: number('involved_location_count'), involvedSupplierCount: number('involved_supplier_count'),
  }
}

export async function getStatisticsDetail(date: string, accountId: number, requestedZone?: string, keyword = '', type = 'all') {
  const scope = await getQualityScope(accountId)
  const available = scope.zones.map(zone => zone.code)
  const zones = requestedZone ? available.filter(zone => String(Number(zone)) === String(Number(requestedZone))) : available
  const operations: Record<string, number[]> = { downgrade: [1, 2], return: [3, 5], shortage: [6, 7], exchange: [12] }
  const { summary, zoneRows, staffRows, supplierLocationRows } = await repository.getQualityStatisticsDetail(date, zones, keyword, operations[type] || [])
  const showResaleUnits = type === 'all' || type === 'return'
  const value = (row: Record<string, unknown>, key: string) => Number(row[key] ?? 0)
  const summaryData = summary as Record<string, unknown>
  return {
    summary: {
      downgradeUnits: value(summaryData, 'downgrade_units'),
      shortageUnits: value(summaryData, 'shortage_units'),
      returnUnits: value(summaryData, 'return_units'),
      exchangeUnits: value(summaryData, 'exchange_units'),
      returnTransferUnits: 0,
      involvedLocationCount: value(summaryData, 'involved_location_count'),
      involvedSupplierCount: value(summaryData, 'involved_supplier_count'),
    },
    zoneRows: zoneRows.map(row => ({
      zone: String(row.zone),
      name: String(row.area_name || `${row.zone}区`),
      exchangeUnits: Number(row.exchange_units || 0),
      shortageUnits: Number(row.shortage_units || 0),
      downgradeUnits: Number(row.downgrade_units || 0),
      resaleUnits: showResaleUnits ? Number(row.resale_units || 0) : 0,
    })),
    staffRows: staffRows.map(row => ({
      inspectorId: Number(row.inspector_id || 0),
      inspectorName: String(row.inspector_name || '系统'),
      downgradeUnits: Number(row.downgrade_units || 0),
      shortageUnits: Number(row.shortage_units || 0),
      returnUnits: Number(row.return_units || 0),
      exchangeUnits: Number(row.exchange_units || 0),
      issueUnits: Number(row.issue_units || 0),
    })),
    supplierLocationRows: supplierLocationRows.map(row => ({
      supplierId: Number(row.supplier_id || 0),
      supplierName: String(row.supplier_name || '未知供应商'),
      location: formatVideoShelf(String(row.zone_shelf || ''), String(row.sub_shelf_sn || '')),
      flowerCount: Number(row.flower_count || 0),
      downgradeUnits: Number(row.downgrade_units || 0),
      shortageUnits: Number(row.shortage_units || 0),
      returnUnits: Number(row.return_units || 0),
      exchangeUnits: Number(row.exchange_units || 0),
      issueUnits: Number(row.issue_units || 0),
      latestMarkedAt: row.latest_mark_time || '',
    })),
  }
}

export async function getZoneStatistics(date: string) {
  return (await repository.listQualityZoneStatistics(date)).map(row => ({
    zone: String(row.zone), name: String(row.area_name || `${row.zone}区`),
    exchangeUnits: Number(row.exchange_units ?? 0), shortageUnits: Number(row.shortage_units ?? 0),
    downgradeUnits: Number(row.downgrade_units ?? 0), resaleUnits: Number(row.resale_units ?? 0),
  }))
}

export async function getIssueTrend(accountId:number,requestedZone:string|undefined,type:string){
  const scope=await getQualityScope(accountId);const available=scope.zones.map(zone=>zone.code)
  const zones=requestedZone?available.filter(zone=>String(Number(zone))===String(Number(requestedZone))):available
  const operations:Record<string,number[]>={downgrade:[1,2],return:[3,5],shortage:[6,7],exchange:[12]}
  const rows=await repository.listQualityIssueTrend(zones,operations[type]||[])
  return rows.map(row=>({date:String(row.date).slice(0,10),count:Number(row.issue_count||0)}))
}

export async function getBaseIssueStatistics(date: string, accountId: number) {
  const scope = await getQualityScope(accountId)
  const rows = await repository.listBaseIssueStatistics(date, scope.zones.map(zone => zone.code))
  return rows.map(row => ({
    baseId: Number(row.base_id || 0),
    baseName: String(row.base_name || '未知基地'),
    downgradeUnits: Number(row.downgrade_units || 0),
    returnUnits: Number(row.return_units || 0),
    exchangeUnits: Number(row.exchange_units || 0),
    issueUnits: Number(row.issue_units || 0),
  }))
}

export async function getExchangeRecords(date: string, accountId: number) {
  const scope = await getQualityScope(accountId)
  const notifyLabels: Record<number, string> = { 0: '未通知', 1: '呼叫中', 2: '已接听', 3: '通知失败' }
  const handleLabels: Record<number, string> = { 0: '待换货', 1: '已处理' }
  const rows = await repository.listExchangeRecords(date, scope.zones.map(zone => zone.code))
  return rows.map(row => ({
    id: Number(row.id),
    date: String(row.round_no || ''),
    supplierId: Number(row.supplier_id || 0),
    supplierName: String(row.supplier_name || ''),
    flowerName: String(row.product_name || ''),
    grade: rankLabels[Number(row.rank_num)] || `${row.rank_num}级`,
    specification: String(row.sku_config || ''),
    location: [row.zone_shelf, row.sub_shelf_sn].filter(Boolean).join('-'),
    quantity: Number(row.num || 0),
    handledQuantity: Number(row.handle_num || 0),
    handleStatus: Number(row.handle_status || 0),
    handleStatusLabel: handleLabels[Number(row.handle_status || 0)] || '未知',
    notifyStatus: Number(row.call_status || 0),
    notifyStatusLabel: notifyLabels[Number(row.call_status || 0)] || '未知',
    notifyCount: Number(row.notify_count || 0),
    lastNotifyTime: row.last_notify_time || '',
    callResult: String(row.result_text || ''),
    operatorName: String(row.operator_name || ''),
    createdAt: row.create_time || '',
  }))
}

export async function getReasons() {
  const rows = await repository.listReasonGroups()
  const groups = new Map<number, { id: number; name: string; reasons: Array<{ id: number; name: string }> }>()
  for (const row of rows) {
    const id = Number(row.categoryId)
    if (!groups.has(id)) groups.set(id, { id, name: row.categoryName, reasons: [] })
    if (row.reasonId) groups.get(id)?.reasons.push({ id: Number(row.reasonId), name: row.reasonName })
  }
  return [...groups.values()]
}

export async function completeTask(taskId: number, command: SubmitInspectionCommand) {
  if (command.status === 10 && !command.reasonId) {
    throw new AppError(400, 'QUALITY_REASON_REQUIRED', '不合格时必须选择原因')
  }
  const result = await repository.submitInspection(taskId, command)
  if (result.kind === 'not_found') throw new AppError(404, 'QUALITY_TASK_NOT_FOUND', '质检任务不存在')
  if (result.kind === 'already_completed') throw new AppError(409, 'QUALITY_TASK_COMPLETED', '该任务已经完成，请刷新列表')
  return { taskId, status: command.status }
}
