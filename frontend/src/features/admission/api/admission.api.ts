import { request } from '@/shared/api/client'
import type { AdmissionRecord, AdmissionSummary, ArrivalBusinessSummary } from '../models/admission'

export const admissionApi = {
  getSummary(date: string) { return request<AdmissionSummary>({ url: `/admission/summary?date=${encodeURIComponent(date)}`, method: 'GET' }) },
  getBusinessSummary(date: string) { return request<ArrivalBusinessSummary>({ url: `/admission/business-summary?date=${encodeURIComponent(date)}`, method: 'GET' }) },
  getRecords(date: string, status?: number, keyword = '', supplierId?: number) {
    const params = [`date=${encodeURIComponent(date)}`]
    if (status !== undefined) params.push(`status=${status}`)
    if (keyword.trim()) params.push(`keyword=${encodeURIComponent(keyword.trim())}`)
    if (supplierId) params.push(`supplierId=${supplierId}`)
    return request<AdmissionRecord[]>({ url: `/admission/records?${params.join('&')}`, method: 'GET' })
  },
  setStatus(id: number, status: 0 | 1) { return request<{ id: number; status: number }>({ url: `/admission/records/${id}/status`, method: 'PUT', data: { status } }) },
}
