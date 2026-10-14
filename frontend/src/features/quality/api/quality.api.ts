import { request } from '@/shared/api/client'
import { appConfig } from '@/app/config/env'
import { sessionStore } from '@/store/session'
import type { GoodFlowerVideoItem, GoodFlowerVideoSummary, QualityBaseIssueStatistic, QualityBusinessSummary, QualityExchangeRecord, QualityInspectionPreview, QualityIssueTrend, QualityOperationLog, QualityPunishRule, QualityStatisticsDetail, QualitySummary, QualityTask, QualityTeamTaskSummary, QualityZoneStatistics, ReasonGroup, SelfInspectionLocation, SupplierFlowerItem } from '../models/quality'

export const qualityApi = {
  getSummary(date: string) { return request<QualitySummary>({ url: `/quality/summary?date=${encodeURIComponent(date)}`, method: 'GET' }) },
  getTeamTaskSummary(date: string) { return request<QualityTeamTaskSummary>({ url: `/quality/team-task-summary?date=${encodeURIComponent(date)}`, method: 'GET' }) },
  getBusinessSummary(date: string, zone?:string) { return request<QualityBusinessSummary>({ url: `/quality/business-summary?date=${encodeURIComponent(date)}${zone?`&zone=${encodeURIComponent(zone)}`:''}`, method: 'GET' }) },
  getStatisticsDetail(date: string, zone?: string, keyword?: string, type = 'all') {
    return request<QualityStatisticsDetail>({ url: `/quality/statistics-detail?date=${encodeURIComponent(date)}${zone ? `&zone=${encodeURIComponent(zone)}` : ''}${keyword ? `&keyword=${encodeURIComponent(keyword)}` : ''}&type=${encodeURIComponent(type)}`, method: 'GET' })
  },
  getDataScope(){return request<{all:boolean;zones:Array<{code:string;name:string}>}>({url:'/quality/data-scope',method:'GET'})},
  getIssueTrend(type:string,zone?:string){return request<QualityIssueTrend[]>({url:`/quality/issue-trend?type=${encodeURIComponent(type)}${zone?`&zone=${encodeURIComponent(zone)}`:''}`,method:'GET'})},
  getBaseIssueStatistics(date:string){return request<QualityBaseIssueStatistic[]>({url:`/quality/base-issue-statistics?date=${encodeURIComponent(date)}`,method:'GET'})},
  getExchangeRecords(date:string){return request<QualityExchangeRecord[]>({url:`/quality/exchange-records?date=${encodeURIComponent(date)}`,method:'GET'})},
  getZoneStatistics(date: string) { return request<QualityZoneStatistics[]>({ url: `/quality/zone-statistics?date=${encodeURIComponent(date)}`, method: 'GET' }) },
  getTasks(date: string, status?: number, assigneeUserId?: number) {
    const query = status === undefined ? '' : `&status=${status}`
    const assigneeQuery = assigneeUserId ? `&assigneeUserId=${assigneeUserId}` : ''
    return request<QualityTask[]>({ url: `/quality/tasks?date=${encodeURIComponent(date)}${query}${assigneeQuery}`, method: 'GET' })
  },
  getGoodFlowerVideos(date:string,userId?:number){return request<GoodFlowerVideoSummary>({url:`/quality/videos?date=${encodeURIComponent(date)}${userId?`&userId=${userId}`:''}`,method:'GET'})},
  getSelfInspectionLocations(date:string,userId?:number){return request<SelfInspectionLocation[]>({url:`/quality/self-inspection-locations?date=${encodeURIComponent(date)}${userId?`&userId=${userId}`:''}`,method:'GET'})},
  scanGoodFlowerVideo(date:string,content:string){return request<GoodFlowerVideoItem>({url:'/quality/videos/scan',method:'POST',data:{date,content}})},
  submitGoodFlowerVideo(command:{date:string;enterItemId:number;videoUrl:string;remark:string}){return request<{id:number}>({url:'/quality/videos',method:'POST',data:command})},
  uploadGoodFlowerVideo(filePath:string){return new Promise<{url:string}>((resolve,reject)=>uni.uploadFile({
    url:`${appConfig.apiBaseUrl}/quality/videos/media`,filePath,name:'file',
    header:{...(sessionStore.state.token?{authorization:`Bearer ${sessionStore.state.token}`} : {}),'x-user-id':String(sessionStore.state.userId),'x-user-name':encodeURIComponent(sessionStore.state.userName)},
    success:({statusCode,data})=>{try{const payload=JSON.parse(data);statusCode>=200&&statusCode<300?resolve(payload.data):reject(new Error(payload.error?.message||'视频上传失败'))}catch{reject(new Error('视频上传响应解析失败'))}},
    fail:error=>reject(new Error(error.errMsg||'视频上传失败')),
  }))},
  getTask(taskId: number) { return request<QualityTask>({ url: `/quality/tasks/${taskId}`, method: 'GET' }) },
  getReasons() { return request<ReasonGroup[]>({ url: '/quality/reasons', method: 'GET' }) },
  getPunishRules() { return request<QualityPunishRule[]>({ url: '/quality/punish-rules', method: 'GET' }) },
  getSupplierItems(enterId: number) { return request<SupplierFlowerItem[]>({ url: `/quality/supplier-entries/${enterId}/items`, method: 'GET' }) },
  getSupplierItem(id: number) { return request<SupplierFlowerItem>({ url: `/quality/supplier-items/${id}`, method: 'GET' }) },
  getSupplierItemLogs(id: number) { return request<QualityOperationLog[]>({ url: `/quality/supplier-items/${id}/logs`, method: 'GET' }) },
  inspectSupplierItem(id: number, command: { status: 10; affectedUnits: number[]; reasonIds: number[]; operation: number; evidenceMedia: string[]; allowDowngradeRestock: boolean }) { return request<{ itemId: number; status: number }>({ url: `/quality/supplier-items/${id}/inspection`, method: 'PUT', data: command }) },
  getInspectionPreview(id: number, command: { affectedUnits: number[]; reasonIds: number[]; operation: number }) { return request<QualityInspectionPreview>({ url: `/quality/supplier-items/${id}/inspection-preview`, method: 'POST', data: command }) },
  setUnitAllocation(id:number,units:number[],allocated:boolean){return request({url:`/quality/supplier-items/${id}/allocation`,method:'PUT',data:{units,allocated}})},
  revokeInspection(id:number,units:number[]){return request({url:`/quality/supplier-items/${id}/inspection-revoke`,method:'PUT',data:{units}})},
  updateSupplierItemControls(id: number, command: { limitDistribution?: boolean; merchantResponsibility?: boolean; noAfterSale?: boolean; remark?: string; media?: string[] }) { return request<{ itemId: number }>({ url: `/quality/supplier-items/${id}/controls`, method: 'PUT', data: command }) },
  uploadSupplierItemMedia(id: number, filePath: string) {
    return new Promise<{ url: string; type: 'image' | 'video' }>((resolve, reject) => uni.uploadFile({
      url: `${appConfig.apiBaseUrl}/quality/supplier-items/${id}/media`, filePath, name: 'file',
      header: { 'x-user-id': String(sessionStore.state.userId), 'x-user-name': encodeURIComponent(sessionStore.state.userName) },
      success: ({ statusCode, data }) => {
        try { const payload = JSON.parse(data); statusCode >= 200 && statusCode < 300 ? resolve(payload.data) : reject(new Error(payload.error?.message || '上传失败')) }
        catch { reject(new Error('上传响应解析失败')) }
      },
      fail: error => reject(new Error(error.errMsg || '上传失败')),
    }))
  },
  submitInspection(taskId: number, command: { status: 1 | 2 | 10; remark?: string; reasonId?: number }) {
    return request<{ taskId: number; status: number }>({ url: `/quality/tasks/${taskId}/inspection`, method: 'POST', data: command })
  },
}
