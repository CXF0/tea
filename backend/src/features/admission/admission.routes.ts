import type { FastifyPluginAsync } from 'fastify'
import { AppError } from '../../shared/errors.js'
import * as service from './admission.service.js'

export const admissionRoutes: FastifyPluginAsync = async (app) => {
  app.get('/summary', async (request) => {
    const { date } = request.query as { date?: string }
    return { data: await service.getSummary(date || new Date().toISOString().slice(0, 10)) }
  })
  app.get('/business-summary', async (request) => {
    const { date } = request.query as { date?: string }
    return { data: await service.getBusinessSummary(date || new Date().toISOString().slice(0, 10)) }
  })
  app.get('/records', async (request) => {
    const { date, status, keyword, supplierId } = request.query as { date?: string; status?: string; keyword?: string; supplierId?: string }
    const numericStatus = status === undefined || status === '' ? undefined : Number(status)
    if (numericStatus !== undefined && ![0, 1].includes(numericStatus)) throw new AppError(400, 'INVALID_ADMISSION_STATUS', '入场状态无效')
    const numericSupplierId = supplierId ? Number(supplierId) : undefined
    if (numericSupplierId !== undefined && (!Number.isInteger(numericSupplierId) || numericSupplierId <= 0)) throw new AppError(400, 'INVALID_SUPPLIER_ID', '供应商编号无效')
    return { data: await service.getAdmissions(date || new Date().toISOString().slice(0, 10), numericStatus, keyword, numericSupplierId) }
  })
  app.put('/records/:id/status', async (request) => {
    const id = Number((request.params as { id: string }).id)
    const status = Number((request.body as { status?: number }).status)
    if (!Number.isInteger(id) || id <= 0) throw new AppError(400, 'INVALID_ADMISSION_ID', '入场记录编号无效')
    if (![0, 1].includes(status)) throw new AppError(400, 'INVALID_ADMISSION_STATUS', '入场状态无效')
    return { data: await service.setAdmissionStatus(id, status as 0 | 1, Number(request.headers['x-user-id'] ?? 0)) }
  })
}
