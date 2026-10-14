import type { FastifyPluginAsync } from 'fastify'
import { createWriteStream } from 'node:fs'
import { mkdir } from 'node:fs/promises'
import { pipeline } from 'node:stream/promises'
import { resolve, extname } from 'node:path'
import { randomUUID } from 'node:crypto'
import { AppError } from '../../shared/errors.js'
import { hasCapability } from '../agri-material/agri-material.repository.js'
import * as service from './agri-driver.service.js'

export const agriDriverRoutes: FastifyPluginAsync = async app => {
  const auth = async (request: any, capability: string) => { const userId = Number(request.headers['x-user-id'] || 0); if (!userId) throw new AppError(401, 'LOGIN_REQUIRED', '请先登录'); if (!(await hasCapability(userId, capability))) throw new AppError(403, 'FORBIDDEN', '当前账号没有该农资作业权限'); return { userId, userName: decodeURIComponent(String(request.headers['x-user-name'] || '')) } }
  app.get('/filters', async request => { await auth(request, String((request.query as any).scope) === 'delivery' ? 'agriDelivery.view' : 'agriDriverOrder.view'); return { data: await service.filters(String((request.query as any).date || '')) } })
  app.get('/deliveries', async request => { await auth(request, 'agriDelivery.view'); const q = request.query as any; return { data: await service.deliveries(String(q.date || ''), String(q.baseName || ''), Number(q.supplierId || 0), String(q.keyword || '')) } })
  app.get('/deliveries/detail', async request => { await auth(request, 'agriDelivery.view'); const q = request.query as any; return { data: await service.deliveryDetail(String(q.date || ''), Number(q.goodsId), Number(q.skuId), String(q.baseName || ''), Number(q.supplierId || 0)) } })
  app.get('/orders', async request => { await auth(request, 'agriDriverOrder.view'); const q = request.query as any; return { data: await service.orders(String(q.date || ''), Number(q.status || 0), String(q.keyword || ''), String(q.baseName || ''), Number(q.supplierId || 0)) } })
  app.get('/orders/:id', async request => { await auth(request, 'agriDriverOrder.view'); return { data: await service.detail(String((request.params as any).id)) } })
  app.post('/orders/:id/operate', async request => { const user = await auth(request, 'agriDriverOrder.operate'); const body = request.body as any; return { data: await service.operate(String((request.params as any).id), body.operation, String(body.picture || ''), user.userId, user.userName) } })
  app.post('/media', async request => { await auth(request, 'agriDriverOrder.operate'); const file = await request.file(); if (!file) throw new AppError(400, 'IMAGE_REQUIRED', '请选择照片'); if (!new Set(['image/jpeg','image/png','image/webp']).has(file.mimetype)) throw new AppError(400, 'UNSUPPORTED_IMAGE', '仅支持 JPG、PNG 和 WebP 图片'); const directory = resolve(process.cwd(), 'uploads', 'agri-driver'); await mkdir(directory, { recursive: true }); const name = `${Date.now()}-${randomUUID()}${extname(file.filename).toLowerCase() || '.jpg'}`; await pipeline(file.file, createWriteStream(resolve(directory, name))); return { data: { url: `/uploads/agri-driver/${name}` } } })
}
