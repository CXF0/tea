import type { FastifyPluginAsync } from 'fastify'
import { createWriteStream } from 'node:fs'
import { mkdir } from 'node:fs/promises'
import { randomUUID } from 'node:crypto'
import { extname, resolve } from 'node:path'
import { pipeline } from 'node:stream/promises'
import { AppError } from '../../shared/errors.js'
import * as service from './cold-storage.service.js'
import * as repository from './cold-storage.repository.js'
import { readToken } from '../auth/auth.service.js'

const operator=(headers:Record<string,unknown>)=>({userId:Number(headers['x-user-id']||0),userName:decodeURIComponent(String(headers['x-user-name']||''))})
async function requireCapability(headers:Record<string,unknown>,capability:string){const authorization=String(headers.authorization||'');const userId=readToken(authorization.startsWith('Bearer ')?authorization.slice(7):'');if(!userId)throw new AppError(401,'AUTH_REQUIRED','登录已失效，请重新登录');if(!await repository.hasCapability(userId,capability))throw new AppError(403,'CAPABILITY_REQUIRED','当前账户无权执行此操作');return userId}
async function requireAnyCapability(headers:Record<string,unknown>,capabilities:string[]){const authorization=String(headers.authorization||'');const userId=readToken(authorization.startsWith('Bearer ')?authorization.slice(7):'');if(!userId)throw new AppError(401,'AUTH_REQUIRED','登录已失效，请重新登录');for(const capability of capabilities)if(await repository.hasCapability(userId,capability))return userId;throw new AppError(403,'CAPABILITY_REQUIRED','当前账户无权执行此操作')}
export const coldStorageRoutes:FastifyPluginAsync=async app=>{
  app.get('/overview',async request=>{await requireCapability(request.headers,'coldStorage.view');return{data:await service.overview()}})
  app.get('/current',async request=>{await requireCapability(request.headers,'coldStorage.view');const q=request.query as Record<string,string|undefined>;return{data:await service.current({keyword:q.keyword?.trim(),storeType:q.storeType?Number(q.storeType):undefined,storeRoundNo:q.storeRoundNo})}})
  app.get('/out-tasks',async request=>{await requireCapability(request.headers,'coldStorage.view');const q=request.query as Record<string,string|undefined>;return{data:await service.outTasks({keyword:q.keyword?.trim(),storeType:q.storeType?Number(q.storeType):undefined,storeRoundNo:q.storeRoundNo,taskStatus:q.taskStatus?Number(q.taskStatus):10})}})
  app.post('/bare/scan',async request=>{await requireCapability(request.headers,'coldStorage.registerBare');const body=request.body as{content?:string};return{data:await service.scanBare(String(body.content||''))}})
  app.post('/bare',async request=>{const userId=await requireCapability(request.headers,'coldStorage.registerBare');const body=request.body as{content?:string;bunchNum?:number;imageUrls?:string[];remark?:string};const who={...operator(request.headers),userId};return{data:await service.registerBare({content:String(body.content||''),bunchNum:Number(body.bunchNum),imageUrls:Array.isArray(body.imageUrls)?body.imageUrls.map(String):[],remark:String(body.remark||''),operator:who})}})
  app.post('/out-tasks/:id/finish',async request=>{const userId=await requireCapability(request.headers,'coldStorage.finishOut');const body=request.body as{finishBunchNum?:number;imageUrls?:string[];remark?:string};const who={...operator(request.headers),userId};return{data:await service.finishOut({taskId:Number((request.params as{id:string}).id),finishBunchNum:body.finishBunchNum===undefined?undefined:Number(body.finishBunchNum),imageUrls:Array.isArray(body.imageUrls)?body.imageUrls.map(String):[],remark:String(body.remark||''),operator:who})}})
  app.post('/media',async request=>{await requireAnyCapability(request.headers,['coldStorage.registerBare','coldStorage.finishOut']);const file=await request.file();if(!file)throw new AppError(400,'IMAGE_REQUIRED','请选择照片');const allowed=new Set(['image/jpeg','image/png','image/webp']);if(!allowed.has(file.mimetype))throw new AppError(400,'UNSUPPORTED_IMAGE','仅支持 JPG、PNG 和 WebP 图片');const suffix=extname(file.filename).toLowerCase()||({ 'image/jpeg':'.jpg','image/png':'.png','image/webp':'.webp'} as Record<string,string>)[file.mimetype];const directory=resolve(process.cwd(),'uploads','cold-storage');await mkdir(directory,{recursive:true});const name=`${Date.now()}-${randomUUID()}${suffix}`;await pipeline(file.file,createWriteStream(resolve(directory,name)));return{data:{url:`/uploads/cold-storage/${name}`}}})
}
