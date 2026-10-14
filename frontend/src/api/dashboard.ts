import { request } from './http'

export interface Dashboard {
  session: string
  role: string
  stockTotal: number
  arrivedToday: number
  pendingInbound: number
  pendingQuality: number
  progress: { completed: number; total: number }
}

export const getDashboard = () => request<Dashboard>({ url: '/dashboard', method: 'GET' })
