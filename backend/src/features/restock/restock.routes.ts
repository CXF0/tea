import type { FastifyPluginAsync } from 'fastify'
import * as service from './restock.service.js'

export const restockRoutes:FastifyPluginAsync=async app=>{
  app.get('/demand',async request=>{const{date,zone,type}=request.query as Record<string,string|undefined>;return{data:await service.getRestockDemand(date||new Date().toISOString().slice(0,10),{zone,type:type?Number(type):undefined})}})
  app.get('/plans',async request=>{const{date,status,serialNo,zone}=request.query as Record<string,string|undefined>;return{data:await service.getRestockPlans(date||new Date().toISOString().slice(0,10),{status:status?Number(status):undefined,serialNo:serialNo?Number(serialNo):undefined,zone})}})
  app.get('/plans/:id/items',async request=>{const{id}=request.params as {id:string};return{data:await service.getRestockPlanItems(Number(id))}})
  app.post('/preview',async request=>{const body=request.body as {date?:string;itemIds?:number[]};return{data:await service.getSubmitPreview(body.date||new Date().toISOString().slice(0,10),body.itemIds||[])}})
  app.post('/plans',async request=>{const body=request.body as {date?:string;itemIds?:number[];strategy?:number};return{data:await service.submitRestockPlan(body.date||new Date().toISOString().slice(0,10),body.itemIds||[],body.strategy||1,Number(request.headers['x-user-id']||0),decodeURIComponent(String(request.headers['x-user-name']||'')))}})
}
