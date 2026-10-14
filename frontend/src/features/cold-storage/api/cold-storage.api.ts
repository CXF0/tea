import { appConfig } from '@/app/config/env'
import { request } from '@/shared/api/client'
import { sessionStore } from '@/store/session'
import type { BareScanResult, ColdStorageItem, ColdStorageOverview } from '../models/cold-storage'

const query=(filters:{keyword:string;storeType:number;storeRoundNo:string})=>{const value=new URLSearchParams();if(filters.keyword.trim())value.set('keyword',filters.keyword.trim());if(filters.storeType)value.set('storeType',String(filters.storeType));if(filters.storeRoundNo)value.set('storeRoundNo',filters.storeRoundNo);return value.toString()}
export const coldStorageApi={
  overview(){return request<ColdStorageOverview>({url:'/cold-storage/overview',method:'GET'})},
  current(filters:{keyword:string;storeType:number;storeRoundNo:string}){return request<ColdStorageItem[]>({url:`/cold-storage/current?${query(filters)}`,method:'GET'})},
  outTasks(filters:{keyword:string;storeType:number;storeRoundNo:string},taskStatus:number){return request<ColdStorageItem[]>({url:`/cold-storage/out-tasks?${query(filters)}&taskStatus=${taskStatus}`,method:'GET'})},
  scanBare(content:string){return request<BareScanResult>({url:'/cold-storage/bare/scan',method:'POST',data:{content}})},
  registerBare(command:{content:string;bunchNum:number;imageUrls:string[];remark:string}){return request<{id:number}>({url:'/cold-storage/bare',method:'POST',data:command})},
  finishOut(id:number,command:{finishBunchNum?:number;imageUrls:string[];remark:string}){return request<{id:number;status:number}>({url:`/cold-storage/out-tasks/${id}/finish`,method:'POST',data:command})},
  uploadImage(filePath:string){return new Promise<{url:string}>((resolve,reject)=>uni.uploadFile({url:`${appConfig.apiBaseUrl}/cold-storage/media`,filePath,name:'file',header:{...(sessionStore.state.token?{authorization:`Bearer ${sessionStore.state.token}`}:{ }),'x-user-id':String(sessionStore.state.userId),'x-user-name':encodeURIComponent(sessionStore.state.userName)},success:({statusCode,data})=>{try{const payload=JSON.parse(data);statusCode>=200&&statusCode<300?resolve(payload.data):reject(new Error(payload.error?.message||'照片上传失败'))}catch{reject(new Error('照片上传响应解析失败'))}},fail:error=>reject(new Error(error.errMsg||'照片上传失败'))}))},
}
