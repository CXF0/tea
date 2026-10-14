import { request } from '@/shared/api/client'
import { appConfig } from '@/app/config/env'
import { sessionStore } from '@/store/session'

export interface DeliverySummary { goodsId:number;skuId:number;image:string;goodsName:string;skuName:string;totalCount:number;orderCount:number }
export interface DriverOrder { orderId:string;date:string;baseName:string;buySupplierName:string;peasantSupplierName:string;receiverName:string;receiverPhone:string;goodsCount:number;itemCount:number;totalPrice:number;orderStatus:number;statusLabel:string;createTime:string }
const query=(value:unknown)=>encodeURIComponent(String(value??''))
export const agriDriverApi={
  filters:(date:string,scope:'delivery'|'order')=>request<{bases:string[];suppliers:Array<{id:number;name:string}>}>({url:`/agri-driver/filters?date=${query(date)}&scope=${scope}`,method:'GET'}),
  deliveries:(q:{date:string;baseName:string;supplierId:number;keyword:string})=>request<DeliverySummary[]>({url:`/agri-driver/deliveries?date=${query(q.date)}&baseName=${query(q.baseName)}&supplierId=${q.supplierId}&keyword=${query(q.keyword)}`,method:'GET'}),
  deliveryDetail:(q:{date:string;goodsId:number;skuId:number;baseName:string;supplierId:number})=>request<any[]>({url:`/agri-driver/deliveries/detail?date=${query(q.date)}&goodsId=${q.goodsId}&skuId=${q.skuId}&baseName=${query(q.baseName)}&supplierId=${q.supplierId}`,method:'GET'}),
  orders:(q:{date:string;status:number;keyword:string;baseName:string;supplierId:number})=>request<DriverOrder[]>({url:`/agri-driver/orders?date=${query(q.date)}&status=${q.status}&keyword=${query(q.keyword)}&baseName=${query(q.baseName)}&supplierId=${q.supplierId}`,method:'GET'}),
  detail:(id:string)=>request<any>({url:`/agri-driver/orders/${query(id)}`,method:'GET'}),
  operate:(id:string,operation:'ship'|'receive',picture:string)=>request<any>({url:`/agri-driver/orders/${query(id)}/operate`,method:'POST',data:{operation,picture}}),
  upload(filePath:string){return new Promise<{url:string}>((resolve,reject)=>uni.uploadFile({url:`${appConfig.apiBaseUrl}/agri-driver/media`,filePath,name:'file',header:{authorization:`Bearer ${sessionStore.state.token}`,'x-user-id':String(sessionStore.state.userId),'x-user-name':encodeURIComponent(sessionStore.state.userName)},success:r=>{try{const p=JSON.parse(r.data);r.statusCode<300?resolve(p.data):reject(new Error(p.error?.message||'照片上传失败'))}catch{reject(new Error('照片上传失败'))}},fail:e=>reject(new Error(e.errMsg))}))},
}
