import type { FastifyPluginAsync } from 'fastify'
import { AppError } from '../../shared/errors.js'
import * as service from './auth.service.js'
export const authRoutes:FastifyPluginAsync=async app=>{app.post('/login',async request=>{const body=request.body as {loginName?:string;password?:string};if(!body.loginName?.trim()||!body.password)throw new AppError(400,'LOGIN_REQUIRED','请输入账号和密码');return{data:await service.login(body.loginName,body.password)}});app.get('/responsibility-zones',async request=>{const token=String(request.headers.authorization||'').replace(/^Bearer /,'');const accountId=service.readToken(token);if(!accountId)throw new AppError(401,'AUTH_REQUIRED','登录已失效');return{data:await service.getResponsibilityZones(accountId,String((request.query as any).category||'core'))}})}
