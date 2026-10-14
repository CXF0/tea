import { createHash,createHmac,timingSafeEqual } from 'node:crypto'
import { config } from '../../config.js'
import { AppError } from '../../shared/errors.js'
import * as repository from './auth.repository.js'
const parse=(value:string)=>{try{const data=JSON.parse(value||'[]');return Array.isArray(data)?data:[]}catch{return[]}}
const encode=(value:string)=>Buffer.from(value).toString('base64url')
function sign(payload:string){return createHmac('sha256',config.authSecret).update(payload).digest('base64url')}
function tokenFor(id:number){const payload=encode(JSON.stringify({sub:id,exp:Date.now()+7*86400000}));return `${payload}.${sign(payload)}`}
export function readToken(token:string){const [payload,signature]=token.split('.');if(!payload||!signature)return null;const expected=sign(payload);if(signature.length!==expected.length||!timingSafeEqual(Buffer.from(signature),Buffer.from(expected)))return null;try{const data=JSON.parse(Buffer.from(payload,'base64url').toString());return data.exp>Date.now()?Number(data.sub):null}catch{return null}}
function map(row:any,capabilities:string[]){return{token:tokenFor(Number(row.id)),userId:Number(row.id),userName:row.display_name,phone:row.phone,roleCode:row.role_code,roleName:row.role_name,warehouseId:Number(row.warehouse_id),warehouseName:row.warehouse_name,capabilities,workbenchCardIds:parse(row.workbench_cards_json),todoIds:parse(row.todo_ids_json),scanOperationIds:parse(row.scan_operations_json),dataCardIds:parse(row.data_cards_json)}}
export async function login(loginName:string,password:string){const row=await repository.findAccount(loginName.trim());if(!row)throw new AppError(401,'INVALID_CREDENTIALS','账号或密码错误');const hash=createHash('sha256').update(String(row.password_salt)+password).digest('hex');if(hash!==row.password_hash)throw new AppError(401,'INVALID_CREDENTIALS','账号或密码错误');const capabilities=await repository.listCapabilities(Number(row.role_id));await repository.touchLogin(Number(row.id));return map(row,capabilities)}
const categoryTeamTypes:Record<string,number[]>={core:[2,3,4,5,6,7],quality:[4],distribution:[2],arrival:[2,3,4,5,6,7],packing:[3],logistics:[7],supplier:[6],centralProcurement:[2,3,4,5,6,7],agri:[6]}
export async function getResponsibilityZones(accountId:number,category:string){
  const scope=await repository.responsibilityZones(accountId,categoryTeamTypes[category]||categoryTeamTypes.core)
  return{all:scope.all,zones:scope.areas.map(row=>({code:String(row.code),name:String(row.area_name||`${row.code}区`)}))}
}
