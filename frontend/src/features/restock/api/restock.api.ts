import { request } from '@/shared/api/client'
import type { RestockDemand, RestockPlan, RestockPlanItem, RestockSubmitPreview } from '../models/restock'

export const restockApi={
  demand(date:string,filters:{zone:string;type:number}){const query=new URLSearchParams({date});if(filters.zone)query.set('zone',filters.zone);if(filters.type)query.set('type',String(filters.type));return request<RestockDemand[]>({url:`/restock/demand?${query}`,method:'GET'})},
  plans(date:string,filters:{status:number;serialNo:string;zone:string}){const query=new URLSearchParams({date});if(filters.status)query.set('status',String(filters.status));if(filters.serialNo)query.set('serialNo',filters.serialNo);if(filters.zone)query.set('zone',filters.zone);return request<RestockPlan[]>({url:`/restock/plans?${query}`,method:'GET'})},
  planItems(planId:number){return request<RestockPlanItem[]>({url:`/restock/plans/${planId}/items`,method:'GET'})},
  preview(date:string,itemIds:number[]){return request<RestockSubmitPreview>({url:'/restock/preview',method:'POST',data:{date,itemIds}})},
  submitPlan(date:string,itemIds:number[],strategy:number){return request<{planId:number;planSn:string;totalNeedNum:number;itemCount:number}>({url:'/restock/plans',method:'POST',data:{date,itemIds,strategy}})},
}
