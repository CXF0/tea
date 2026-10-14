import type { FastifyPluginAsync } from 'fastify'
import { readToken } from '../auth/auth.service.js'
import { AppError } from '../../shared/errors.js'
import * as repo from './workforce.repository.js'

async function auth(headers: Record<string, unknown>, capability: string) {
  const authorization = String(headers.authorization || '')
  const id = readToken(authorization.startsWith('Bearer ') ? authorization.slice(7) : '')
  if (!id) throw new AppError(401, 'AUTH_REQUIRED', '登录已失效')
  if (!await repo.hasCapability(id, capability)) throw new AppError(403, 'CAPABILITY_REQUIRED', '当前账号无权使用该功能')
  return { id, name: decodeURIComponent(String(headers['x-user-name'] || '')) }
}

const stringArray = (value: unknown) => {
  if (Array.isArray(value)) return value.map(String)
  try {
    const parsed = JSON.parse(String(value || '[]'))
    return Array.isArray(parsed) ? parsed.map(String) : []
  } catch { return [] }
}

export const workforceRoutes: FastifyPluginAsync = async app => {
  app.get('/distribution-staff', async request => {
    await auth(request.headers, 'distributionStaff.view')
    const rows = await repo.distributors()
    const people = rows.map((row: any) => ({
      id: Number(row.id), userId: Number(row.id), loginName: String(row.login_name),
      name: String(row.display_name), roleCode: String(row.role_code), roleName: String(row.role_name),
      areas: String(row.area_config || '').split(',').filter(Boolean),
    }))
    const zoneRows = await repo.zones()
    const zones = zoneRows.map((row: any) => ({ code: String(row.zone), name: String(row.area_name || `${row.zone}区`) }))
    const zoneSummary = zones.map(zone => ({ zone: zone.code, name: zone.name, staffCount: people.filter(person => person.areas.includes(zone.code)).length }))
    return { data: { summary: { total: people.length, fullTime: people.filter(person => person.roleCode === 'picker').length, partTime: people.filter(person => person.roleCode === 'partTimePicker').length }, people, zones, zoneSummary } }
  })

  app.put('/distribution-staff/:id/areas', async request => {
    const user = await auth(request.headers, 'distributionStaff.configure')
    return { data: { updated: await repo.updateDistributor(Number((request.params as any).id), stringArray((request.body as any).areas), user.id) } }
  })

  app.put('/distribution-staff/areas/batch', async request => {
    const user = await auth(request.headers, 'distributionStaff.configure')
    const ids = stringArray((request.body as any).ids).map(Number).filter(Boolean)
    if (!ids.length) throw new AppError(400, 'STAFF_REQUIRED', '请选择配货人员')
    return { data: { updated: await repo.updateDistributors(ids, stringArray((request.body as any).areas), user.id) } }
  })

  app.get('/inspection-attendance', async request => {
    await auth(request.headers, 'inspectionAttendance.view')
    const query = request.query as any
    const all = (await repo.inspectors()).map((row: any) => ({ id: Number(row.id), userId: Number(row.user_id), name: String(row.user_name), status: Number(row.attendance_status), updatedAt: row.attendance_update_time ? String(row.attendance_update_time) : null, areas: String(row.area_config || '').split(',').filter(Boolean) }))
    const keyword = String(query.keyword || '')
    const status = query.status === '' || query.status == null ? null : Number(query.status)
    const areas = String(query.areas || query.area || '').split(',').filter(Boolean)
    const people = all.filter(person => (!keyword || person.name.includes(keyword) || String(person.userId).includes(keyword)) && (status === null || person.status === status) && (!areas.length || areas.some(area => person.areas.includes(area))))
    return { data: { summary: { total: people.length, present: people.filter(person => person.status === 1).length, rest: people.filter(person => person.status === 0).length }, people, zones: [...new Set(all.flatMap(person => person.areas))] } }
  })

  app.put('/inspection-attendance/:userId', async request => {
    const user = await auth(request.headers, 'inspectionAttendance.update')
    const status = Number((request.body as any).status)
    if (![0, 1].includes(status)) throw new AppError(400, 'INVALID_STATUS', '假勤状态无效')
    return { data: { updated: await repo.updateAttendance(Number((request.params as any).userId), status, user.id, user.name) } }
  })
}
