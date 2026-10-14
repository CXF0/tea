import { request } from '@/shared/api/client'
import type { RoleCode } from '@/app/permission/role-profiles'
export interface AuthSession {token:string;userId:number;userName:string;phone:string;roleCode:RoleCode;roleName:string;warehouseId:number;warehouseName:string;capabilities:string[];workbenchCardIds:string[];todoIds:string[];scanOperationIds:string[];dataCardIds:string[]}
export const authApi={login(loginName:string,password:string){return request<AuthSession>({url:'/auth/login',method:'POST',data:{loginName,password}})},responsibilityZones(category:string){return request<{all:boolean;zones:Array<{code:string;name:string}>}>({url:`/auth/responsibility-zones?category=${encodeURIComponent(category)}`,method:'GET'})}}
