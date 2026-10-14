import type{FastifyPluginAsync}from'fastify';import{AppError}from'../../shared/errors.js';import{readToken}from'../auth/auth.service.js';import*as repo from'./patrol-punishment.repository.js';
async function auth(h:Record<string,unknown>,cap:string){const id=readToken(String(h.authorization||'').replace(/^Bearer /,''));if(!id)throw new AppError(401,'AUTH_REQUIRED','登录已失效');if(!await repo.hasCapability(id,cap))throw new AppError(403,'CAPABILITY_REQUIRED','当前账号无权使用巡线处罚');return{id,name:decodeURIComponent(String(h['x-user-name']||''))}}
export const patrolPunishmentRoutes:FastifyPluginAsync=async app=>{
  app.get('/records',async req=>{const u=await auth(req.headers,'patrolPunishment.view');const q=(req.query||{})as Record<string,unknown>;return{data:await repo.list({...q,operatorId:u.id})}})
  app.get('/statistics',async req=>{const u=await auth(req.headers,'patrolPunishment.view');return{data:await repo.statistics(u.id,String((req.query as any).date||new Date().toISOString().slice(0,10)))}})
  app.get('/offenders',async req=>{await auth(req.headers,'patrolPunishment.create');return{data:await repo.offenders()}})
  app.post('/records',async req=>{const u=await auth(req.headers,'patrolPunishment.create');const b=req.body as any;if(![1,2].includes(Number(b.type))||!b.dutyUserId||!b.reason||!(Number(b.price)>0&&Number(b.price)<=10000))throw new AppError(400,'INVALID_PUNISHMENT','请完整填写处罚人员、原因及有效金额');return{data:{id:await repo.create({...b,type:Number(b.type),price:Number(b.price)},u)}}})
  app.put('/records/:id/revoke',async req=>{const u=await auth(req.headers,'patrolPunishment.revoke');const n=await repo.revoke(Number((req.params as any).id),u);if(!n)throw new AppError(409,'PUNISHMENT_NOT_REVOCABLE','仅可撤销本人发起且待确认的处罚');return{data:{updated:n}}})
}
