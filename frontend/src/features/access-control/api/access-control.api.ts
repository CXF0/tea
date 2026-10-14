import { request } from '@/shared/api/client'
export interface SystemAccount{id:number;login_name:string;phone:string;display_name:string;role_id:number;role_code:string;role_name:string;warehouse_id:number;warehouse_name:string;status:number;last_login_time:string|null}
export interface Role{id:number;code:string;name:string;description:string;status:number;account_count:number;group_ids:string|null}
export interface PermissionGroup{id:number;code:string;name:string;description:string;status:number;role_count:number;permission_ids:string|null}
export interface Permission{id:number;parent_id:number;code:string;name:string;domain_code:string;permission_type:number;description:string;sort_order:number}
export const accessControlApi={
 accounts(keyword=''){return request<SystemAccount[]>({url:`/access-control/accounts?keyword=${encodeURIComponent(keyword)}`,method:'GET'})},accountRoles(){return request<Role[]>({url:'/access-control/accounts/roles',method:'GET'})},
 createAccount(data:any){return request<{id:number}>({url:'/access-control/accounts',method:'POST',data})},
 updateAccount(id:number,data:any){return request<{updated:number}>({url:`/access-control/accounts/${id}`,method:'PUT',data})},
 resetPassword(id:number,password:string){return request<{updated:number}>({url:`/access-control/accounts/${id}/password`,method:'PUT',data:{password}})},
 roles(){return request<Role[]>({url:'/access-control/roles',method:'GET'})},groups(){return request<PermissionGroup[]>({url:'/access-control/groups',method:'GET'})},permissions(){return request<Permission[]>({url:'/access-control/permissions',method:'GET'})},
 saveGroup(data:any){return request<{id:number}>({url:'/access-control/groups',method:'POST',data})},
 saveRoleGroups(id:number,groupIds:number[]){return request<{updated:number}>({url:`/access-control/roles/${id}/groups`,method:'PUT',data:{groupIds}})},
}
