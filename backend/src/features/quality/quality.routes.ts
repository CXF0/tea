import type { FastifyPluginAsync } from 'fastify'
import { AppError } from '../../shared/errors.js'
import { createWriteStream } from 'node:fs'
import { mkdir } from 'node:fs/promises'
import { extname, resolve } from 'node:path'
import { randomUUID } from 'node:crypto'
import { pipeline } from 'node:stream/promises'
import * as service from './quality.service.js'
import * as repository from './quality.repository.js'
import { readToken } from '../auth/auth.service.js'

async function requireCapability(headers: Record<string, unknown>, capability: string) {
  const authorization = String(headers.authorization || '')
  const userId = readToken(authorization.startsWith('Bearer ') ? authorization.slice(7) : '')
  if (!userId) throw new AppError(401, 'AUTH_REQUIRED', '登录已失效，请重新登录')
  if (!await repository.hasCapability(userId, capability)) throw new AppError(403, 'CAPABILITY_REQUIRED', '当前账号无权查看质检统计')
  return userId
}

export const qualityRoutes: FastifyPluginAsync = async (app) => {
  app.get('/punish-rules', async () => ({ data: await service.getQualityPunishRules() }))
  app.get('/summary', async (request) => {
    const { date } = request.query as { date?: string }
    return { data: await service.getSummary(date || new Date().toISOString().slice(0, 10)) }
  })
  app.get('/team-task-summary', async (request) => {
    const accountId = await requireCapability(request.headers, 'quality.statistics')
    const { date } = request.query as { date?: string }
    return { data: await service.getTeamTaskSummary(date || new Date().toISOString().slice(0, 10), accountId) }
  })
  app.get('/business-summary', async (request) => {
    const accountId=await requireCapability(request.headers,'quality.statistics')
    const { date,zone } = request.query as { date?: string;zone?:string }
    return { data: await service.getBusinessSummary(date || new Date().toISOString().slice(0, 10),accountId,zone) }
  })
  app.get('/statistics-detail', async (request) => {
    const accountId = await requireCapability(request.headers, 'quality.statistics')
    const { date, zone, keyword, type } = request.query as { date?: string; zone?: string; keyword?: string; type?: string }
    return { data: await service.getStatisticsDetail(date || new Date().toISOString().slice(0, 10), accountId, zone, keyword || '', type || 'all') }
  })
  app.get('/data-scope',async request=>{const accountId=await requireCapability(request.headers,'quality.statistics');return{data:await service.getQualityScope(accountId)}})
  app.get('/issue-trend',async request=>{const accountId=await requireCapability(request.headers,'quality.statistics');const q=request.query as {zone?:string;type?:string};return{data:await service.getIssueTrend(accountId,q.zone,q.type||'all')}})
  app.get('/base-issue-statistics',async request=>{const accountId=await requireCapability(request.headers,'quality.baseStatistics.view');const q=request.query as {date?:string};return{data:await service.getBaseIssueStatistics(q.date||new Date().toISOString().slice(0,10),accountId)}})
  app.get('/exchange-records',async request=>{const accountId=await requireCapability(request.headers,'quality.exchange.view');const q=request.query as {date?:string};return{data:await service.getExchangeRecords(q.date||new Date().toISOString().slice(0,10),accountId)}})
  app.get('/zone-statistics', async (request) => {
    const { date } = request.query as { date?: string }
    return { data: await service.getZoneStatistics(date || new Date().toISOString().slice(0, 10)) }
  })

  app.get('/tasks', async (request) => {
    const { date, status, assigneeUserId } = request.query as { date?: string; status?: string; assigneeUserId?: string }
    const numericStatus = status === undefined || status === '' ? undefined : Number(status)
    const numericAssignee = assigneeUserId ? Number(assigneeUserId) : undefined
    if (numericAssignee !== undefined && (!Number.isInteger(numericAssignee) || numericAssignee <= 0)) throw new AppError(400, 'INVALID_ASSIGNEE_ID', '质检人员账号无效')
    return { data: await service.getTaskPage(date || new Date().toISOString().slice(0, 10), numericStatus, numericAssignee) }
  })

  app.get('/self-inspection-locations', async (request) => {
    const { date, userId } = request.query as { date?: string; userId?: string }
    const numericUserId = userId ? Number(userId) : undefined
    if (numericUserId !== undefined && (!Number.isInteger(numericUserId) || numericUserId <= 0)) throw new AppError(400, 'INVALID_INSPECTOR_ID', '质检人员账号无效')
    return { data: await service.getSelfInspectionLocations(date || new Date().toISOString().slice(0, 10), numericUserId) }
  })

  app.get('/videos', async (request) => {
    const { date, userId } = request.query as { date?: string; userId?: string }
    const targetUserId = userId ? Number(userId) : Number(request.headers['x-user-id'] ?? 0)
    if (!Number.isInteger(targetUserId) || targetUserId <= 0) throw new AppError(400, 'INVALID_INSPECTOR_ID', '质检人员账号无效')
    return { data: await service.getGoodFlowerVideos(date || new Date().toISOString().slice(0, 10), targetUserId) }
  })

  app.post('/videos/scan', async (request) => {
    const body = request.body as { date?: string; content?: string }
    return { data: await service.scanGoodFlowerVideoItem(body.date || new Date().toISOString().slice(0, 10), String(body.content || '')) }
  })

  app.post('/videos/media', async (request) => {
    const file = await request.file()
    if (!file) throw new AppError(400, 'VIDEO_REQUIRED', '请选择要上传的视频')
    if (!new Set(['video/mp4', 'video/quicktime', 'video/webm']).has(file.mimetype)) throw new AppError(400, 'UNSUPPORTED_VIDEO', '仅支持 MP4、MOV 或 WebM 视频')
    const suffix = extname(file.filename).toLowerCase() || ({ 'video/mp4': '.mp4', 'video/quicktime': '.mov', 'video/webm': '.webm' } as Record<string, string>)[file.mimetype]
    const directory = resolve(process.cwd(), 'uploads', 'quality-videos')
    await mkdir(directory, { recursive: true })
    const name = `${Date.now()}-${randomUUID()}${suffix}`
    await pipeline(file.file, createWriteStream(resolve(directory, name)))
    return { data: { url: `/uploads/quality-videos/${name}` } }
  })

  app.post('/videos', async (request) => {
    const body = request.body as { date?: string; enterItemId?: number; videoUrl?: string; remark?: string }
    return { data: await service.submitGoodFlowerVideo({
      date: body.date || new Date().toISOString().slice(0, 10), enterItemId: Number(body.enterItemId),
      videoUrl: String(body.videoUrl || ''), remark: body.remark,
      userId: Number(request.headers['x-user-id'] ?? 0), userName: decodeURIComponent(String(request.headers['x-user-name'] ?? '')),
    }) }
  })

  app.get('/tasks/:id', async (request) => {
    const taskId = Number((request.params as { id: string }).id)
    if (!Number.isInteger(taskId) || taskId <= 0) throw new AppError(400, 'INVALID_TASK_ID', '任务编号无效')
    return { data: await service.getTaskDetail(taskId) }
  })

  app.get('/reasons', async () => ({ data: await service.getReasons() }))

  app.get('/supplier-entries/:enterId/items', async (request) => {
    const enterId = Number((request.params as { enterId: string }).enterId)
    if (!Number.isInteger(enterId) || enterId <= 0) throw new AppError(400, 'INVALID_ADMISSION_ID', '入场记录编号无效')
    return { data: await service.getSupplierFlowerItems(enterId) }
  })

  app.get('/supplier-items/:id', async (request) => {
    const id = Number((request.params as { id: string }).id)
    if (!Number.isInteger(id) || id <= 0) throw new AppError(400, 'INVALID_FLOWER_ITEM_ID', '货架花材编号无效')
    return { data: await service.getSupplierFlowerItem(id) }
  })

  app.get('/supplier-items/:id/logs', async (request) => {
    const id = Number((request.params as { id: string }).id)
    if (!Number.isInteger(id) || id <= 0) throw new AppError(400, 'INVALID_FLOWER_ITEM_ID', '货架花材编号无效')
    return { data: await service.getSupplierFlowerItemLogs(id) }
  })

  app.put('/supplier-items/:id/inspection', async (request) => {
    const id = Number((request.params as { id: string }).id)
    const body = request.body as { status?: number; affectedUnits?: number[]; reasonIds?: number[]; operation?: number; evidenceMedia?: string[]; allowDowngradeRestock?: boolean }
    if (!Number.isInteger(id) || id <= 0) throw new AppError(400, 'INVALID_FLOWER_ITEM_ID', '货架花材编号无效')
    if (Number(body.status) !== 10) throw new AppError(400, 'INVALID_QUALITY_STATUS', '花材质检只记录问题标记，正常花材无需提交')
    return { data: await service.inspectSupplierFlowerItem(id, {
      status: Number(body.status) as 1 | 10,
      affectedUnits: Array.isArray(body.affectedUnits) ? body.affectedUnits.map(Number) : [],
      reasonIds: Array.isArray(body.reasonIds) ? body.reasonIds.map(Number) : [],
      operation: Number(body.operation ?? 0),
      evidenceMedia: Array.isArray(body.evidenceMedia) ? body.evidenceMedia.map(String) : [],
      allowDowngradeRestock: body.allowDowngradeRestock === true,
      userId: Number(request.headers['x-user-id'] ?? 0), userName: decodeURIComponent(String(request.headers['x-user-name'] ?? '')),
    }) }
  })

  app.post('/supplier-items/:id/inspection-preview', async (request) => {
    const id = Number((request.params as { id: string }).id)
    const body = request.body as { affectedUnits?: number[]; reasonIds?: number[]; operation?: number }
    if (!Number.isInteger(id) || id <= 0) throw new AppError(400, 'INVALID_FLOWER_ITEM_ID', '货架花材编号无效')
    return { data: await service.getInspectionPreview(id, {
      affectedUnits: Array.isArray(body.affectedUnits) ? body.affectedUnits.map(Number) : [],
      reasonIds: Array.isArray(body.reasonIds) ? body.reasonIds.map(Number) : [],
      operation: Number(body.operation ?? 0),
    }) }
  })
  app.put('/supplier-items/:id/allocation', async(request)=>{const id=Number((request.params as {id:string}).id);const body=request.body as {units?:number[];allocated?:boolean};return {data:await service.setUnitAllocation(id,{units:Array.isArray(body.units)?body.units.map(Number):[],allocated:body.allocated===true,userId:Number(request.headers['x-user-id']??0),userName:decodeURIComponent(String(request.headers['x-user-name']??''))})}})
  app.put('/supplier-items/:id/inspection-revoke',async(request)=>{const id=Number((request.params as {id:string}).id);const body=request.body as {units?:number[]};return {data:await service.revokeInspection(id,Array.isArray(body.units)?body.units.map(Number):[])}})

  app.put('/supplier-items/:id/controls', async (request) => {
    const id = Number((request.params as { id: string }).id)
    if (!Number.isInteger(id) || id <= 0) throw new AppError(400, 'INVALID_FLOWER_ITEM_ID', '货架花材编号无效')
    const body = request.body as { limitDistribution?: boolean; merchantResponsibility?: boolean; noAfterSale?: boolean; remark?: string; media?: string[] }
    return { data: await service.updateSupplierFlowerControls(id, body) }
  })

  app.post('/supplier-items/:id/media', async (request) => {
    const id = Number((request.params as { id: string }).id)
    if (!Number.isInteger(id) || id <= 0) throw new AppError(400, 'INVALID_FLOWER_ITEM_ID', '货架花材编号无效')
    await service.getSupplierFlowerItem(id)
    const file = await request.file()
    if (!file) throw new AppError(400, 'MEDIA_REQUIRED', '请选择图片或视频')
    const allowed = new Set(['image/jpeg', 'image/png', 'image/webp', 'video/mp4', 'video/quicktime'])
    if (!allowed.has(file.mimetype)) throw new AppError(400, 'UNSUPPORTED_MEDIA', '仅支持 JPG、PNG、WebP、MP4 和 MOV')
    const suffix = extname(file.filename).toLowerCase() || ({ 'image/jpeg': '.jpg', 'image/png': '.png', 'image/webp': '.webp', 'video/mp4': '.mp4', 'video/quicktime': '.mov' } as Record<string, string>)[file.mimetype]
    const directory = resolve(process.cwd(), 'uploads', 'quality-duty')
    await mkdir(directory, { recursive: true })
    const name = `${Date.now()}-${randomUUID()}${suffix}`
    await pipeline(file.file, createWriteStream(resolve(directory, name)))
    return { data: { url: `/uploads/quality-duty/${name}`, type: file.mimetype.startsWith('video/') ? 'video' : 'image' } }
  })

  app.post('/tasks/:id/inspection', async (request) => {
    const taskId = Number((request.params as { id: string }).id)
    const body = request.body as { status?: number; remark?: string; reasonId?: number }
    const userId = Number(request.headers['x-user-id'] ?? 1001)
    const userName = decodeURIComponent(String(request.headers['x-user-name'] ?? '测试质检员'))
    if (!Number.isInteger(taskId) || taskId <= 0) throw new AppError(400, 'INVALID_TASK_ID', '任务编号无效')
    if (![1, 2, 10].includes(Number(body.status))) throw new AppError(400, 'INVALID_QUALITY_STATUS', '质检结果无效')
    return { data: await service.completeTask(taskId, {
      status: Number(body.status) as 1 | 2 | 10,
      remark: body.remark?.trim(),
      reasonId: body.reasonId,
      userId,
      userName,
    }) }
  })
}
