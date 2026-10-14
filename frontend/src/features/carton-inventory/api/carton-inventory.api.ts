import { request } from '@/shared/api/client'

export interface CartonStock { id:number; sku_id:number; sku_name:string; specification:string; part:string; quantity:number; unit:string }
export interface CartonOptions { skus:Array<{sku_id:number;sku_name:string;specification:string;unit:string}>; parts:string[] }
export interface MaterialApply { id:number;apply_no:string;team_name:string;sku_id:number;sku_name:string;specification:string;unit_name:string;apply_quantity:number;issued_quantity:number;status:number;reject_reason:string;applicant_name:string;auditor_name:string;remark:string;voucher_info:string;create_time:string;audit_time:string }
export interface InventoryTrace { id:number;sku_id:number;sku_name:string;specification:string;part:string;quantity:number;unit_name:string;reason_type:number;outbound_reason:number;outbound_failed:number;failure_message:string;related_order:string;recipient:string;remark:string;invoice_info:string;operator_name:string;create_time:string }

export const cartonInventoryApi = {
  overview:(spec='',part='')=>request<{stocks:CartonStock[];options:CartonOptions}>({url:`/carton-inventory/overview?spec=${encodeURIComponent(spec)}&part=${encodeURIComponent(part)}`,method:'GET'}),
  applications:(status=0)=>request<MaterialApply[]>({url:`/carton-inventory/applications?status=${status}`,method:'GET'}),
  audit:(id:number,data:{approved:boolean;quantity:number;reason?:string})=>request<{updated:number}>({url:`/carton-inventory/applications/${id}/audit`,method:'PUT',data}),
  traces:(kind:'inbound'|'outbound',q:{skuId?:number;part?:string;start?:string;end?:string}={})=>request<InventoryTrace[]>({url:`/carton-inventory/traces/${kind}?skuId=${q.skuId||''}&part=${encodeURIComponent(q.part||'')}&start=${q.start||''}&end=${q.end||''}`,method:'GET'}),
  inbound:(data:{skuId:number;part:string;quantity:number;reason:string;remark:string})=>request<{id:number}>({url:'/carton-inventory/inbound',method:'POST',data}),
  outbound:(data:{skuId:number;part:string;quantity:number;recipient:string;reasonType:number;remark:string})=>request<{id:number;order:string}>({url:'/carton-inventory/outbound',method:'POST',data}),
}
