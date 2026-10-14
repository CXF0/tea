import { request } from '@/shared/api/client'
export interface TeamAccount { id:number;login_name:string;phone:string;display_name:string;status:number;create_time:string;source_user_id:number }
export interface AccountCandidate extends TeamAccount { role_name:string;bindable:number;bound_team_name:string|null }
export interface TeamStatistic { account_id:number;display_name:string;phone:string;source_user_id:number;total_num:number;zoneList:{zone:string;zone_name:string;num:number}[] }
export const distributionTeamApi={
  accounts:(keyword:string,status:number)=>request<{configured:boolean;teamName?:string;list:TeamAccount[]}>({url:`/distribution-team/accounts?keyword=${encodeURIComponent(keyword)}&status=${status}`,method:'GET'}),
  candidates:(keyword:string)=>request<AccountCandidate[]>({url:`/distribution-team/account-candidates?keyword=${encodeURIComponent(keyword)}`,method:'GET'}),
  bind:(accountId:number)=>request<{updated:number}>({url:'/distribution-team/accounts/bind',method:'POST',data:{accountId}}),
  create:(data:{loginName:string;name:string;phone:string})=>request<{id:number;initialPassword:string}>({url:'/distribution-team/accounts',method:'POST',data}),
  update:(id:number,data:{loginName:string;name:string;phone:string})=>request<{updated:number}>({url:`/distribution-team/accounts/${id}`,method:'PUT',data}),
  status:(id:number,status:number)=>request<{updated:number}>({url:`/distribution-team/accounts/${id}/status`,method:'PUT',data:{status}}),
  reset:(id:number)=>request<{updated:number;initialPassword:string}>({url:`/distribution-team/accounts/${id}/reset-password`,method:'POST'}),
  statistics:(keyword:string,type:'session'|'month',period:string)=>request<{configured:boolean;teamName?:string;list:TeamStatistic[]}>({url:`/distribution-team/statistics?keyword=${encodeURIComponent(keyword)}&type=${type}&period=${period}`,method:'GET'}),
}
