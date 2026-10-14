import type { FastifyPluginAsync } from 'fastify'
import { readToken } from '../auth/auth.service.js'
import { AppError } from '../../shared/errors.js'
import * as repo from './access-control.repository.js'
async function auth(headers:Record<string,unknown>,capability:string){const raw=String(headers.authorization||'');const id=readToken(raw.startsWith('Bearer ')?raw.slice(7):'');if(!id)throw new AppError(401,'AUTH_REQUIRED','登录已失效');if(!await repo.hasCapability(id,capability))throw new AppError(403,'CAPABILITY_REQUIRED','当前账号无权使用该功能');return id}
const ids=(value:any)=>Array.isArray(value)?value.map(Number).filter(Boolean):[]
export const accessControlRoutes:FastifyPluginAsync=async app=>{
 app.get('/accounts',async req=>{await auth(req.headers,'systemAccount.view');return{data:await repo.accounts(String((req.query as any).keyword||''))}})
 app.get('/accounts/roles',async req=>{await auth(req.headers,'systemAccount.view');return{data:await repo.roles()}})
 app.post('/accounts',async req=>{await auth(req.headers,'systemAccount.manage');const b=req.body as any;if(!b.loginName||!b.displayName||!b.password||!b.roleId)throw new AppError(400,'ACCOUNT_FIELDS_REQUIRED','请完整填写账号、姓名、密码和角色');return{data:{id:await repo.createAccount(b)}}})
 app.put('/accounts/:id',async req=>{await auth(req.headers,'systemAccount.manage');return{data:{updated:await repo.updateAccount(Number((req.params as any).id),req.body as any)}}})
 app.put('/accounts/:id/password',async req=>{await auth(req.headers,'systemAccount.manage');const password=String((req.body as any).password||'');if(password.length<6)throw new AppError(400,'PASSWORD_TOO_SHORT','密码至少6位');return{data:{updated:await repo.resetPassword(Number((req.params as any).id),password)}}})
 app.get('/roles',async req=>{await auth(req.headers,'accessControl.view');return{data:await repo.roles()}})
 app.get('/groups',async req=>{await auth(req.headers,'accessControl.view');return{data:await repo.groups()}})
 app.get('/permissions',async req=>{await auth(req.headers,'accessControl.view');return{data:await repo.permissions()}})
 app.post('/groups',async req=>{await auth(req.headers,'accessControl.manage');const b=req.body as any;if(!b.name||(!b.id&&!b.code))throw new AppError(400,'GROUP_FIELDS_REQUIRED','请填写权限组名称和编码');return{data:{id:await repo.saveGroup({...b,permissionIds:ids(b.permissionIds)})}}})
 app.put('/roles/:id/groups',async req=>{await auth(req.headers,'accessControl.manage');return{data:{updated:await repo.saveRoleGroups(Number((req.params as any).id),ids((req.body as any).groupIds))}}})
}
