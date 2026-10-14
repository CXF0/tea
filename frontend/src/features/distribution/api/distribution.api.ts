import { request } from '@/shared/api/client'
import type { AgencyDistributionSummary, ContractorDistributionSummary, DistributionFilterOption, DistributionShelf, DistributionShelfDetail, DistributionSummary, MyDistributionDashboard, UnfinishedDistributionItem } from '../models/distribution'

export const distributionApi = {
  summary(date:string,scope:'site'|'team'='site'){return request<DistributionSummary>({url:`/distribution/summary?date=${date}&scope=${scope}`,method:'GET'})},
  agencySummary(date:string){return request<AgencyDistributionSummary>({url:`/distribution/agency-summary?date=${date}`,method:'GET'})},
  contractorSummary(date:string){return request<ContractorDistributionSummary>({url:`/distribution/contractor-summary?date=${date}`,method:'GET'})},
  shelves(date:string,status:string,keyword='',filters:{warehouseType:'normal'|'city';selfPickup:boolean;earlyShift:boolean;restock:boolean;zone:string;segments:string[]}){const query=new URLSearchParams({date,status,keyword,warehouseType:filters.warehouseType,selfPickup:filters.selfPickup?'1':'0',earlyShift:filters.earlyShift?'1':'0',restock:filters.restock?'1':'0'});if(filters.zone)query.set('zone',filters.zone);if(filters.segments.length)query.set('segments',filters.segments.join(','));return request<DistributionShelf[]>({url:`/distribution/shelves?${query}`,method:'GET'})},
  filterOptions(date:string,warehouseType?:'normal'|'city'){const query=new URLSearchParams({date});if(warehouseType)query.set('warehouseType',warehouseType);return request<DistributionFilterOption[]>({url:`/distribution/filter-options?${query}`,method:'GET'})},
  unfinishedItems(date:string,filters:{zone:string;orderNum:string;productName:string}){const query=new URLSearchParams({date});if(filters.zone)query.set('zone',filters.zone);if(filters.orderNum)query.set('orderNum',filters.orderNum);if(filters.productName)query.set('productName',filters.productName);return request<UnfinishedDistributionItem[]>({url:`/distribution/unfinished-items?${query}`,method:'GET'})},
  myAllocations(){return request<MyDistributionDashboard>({url:'/distribution/my-allocations',method:'GET'})},
  markShortage(itemIds:number[],operation:6|7,remark:string){return request<{affectedItems:number;affectedUnits:number}>({url:'/distribution/unfinished-items/shortage',method:'POST',data:{itemIds,operation,remark}})},
  shelf(date:string,shelfNo:string){return request<DistributionShelfDetail>({url:`/distribution/shelves/${encodeURIComponent(shelfNo)}?date=${date}`,method:'GET'})},
  allocation(itemId:number,units:number[],allocated:boolean){return request({url:`/distribution/items/${itemId}/allocation`,method:'PUT',data:{units,allocated}})},
}
