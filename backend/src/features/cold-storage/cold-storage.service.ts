import { AppError } from '../../shared/errors.js'
import * as repository from './cold-storage.repository.js'
import type { ColdStorageFilters, ColdStorageOperator } from './cold-storage.types.js'

const number = (value: unknown) => Number(value || 0)
const text = (value: unknown) => value == null ? '' : String(value)
const pad = (value:number) => String(value).padStart(2,'0')
const dateOnly = (value:unknown) => {
  if (!value) return ''
  if (value instanceof Date) return `${value.getFullYear()}-${pad(value.getMonth()+1)}-${pad(value.getDate())}`
  const raw=String(value)
  const matched=raw.match(/\d{4}-\d{2}-\d{2}/)
  return matched?.[0] || raw
}
const dateTime = (value:unknown) => {
  if (!value) return ''
  if (value instanceof Date) return `${dateOnly(value)} ${pad(value.getHours())}:${pad(value.getMinutes())}:${pad(value.getSeconds())}`
  return String(value).replace('T',' ').slice(0,19)
}
const map = (row: any) => ({
  coldStockId:number(row.cold_stock_id),outTaskId:number(row.out_task_id),purchaserId:number(row.purchaser_id),purchaserMobile:text(row.purchaser_mobile),purchaserNick:text(row.purchaser_nick),
  storeType:number(row.store_type),storeRoundNo:dateOnly(row.store_round_no),locationNo:text(row.location_no),originSendNo:text(row.origin_send_no),packageTotal:number(row.package_total),packageOut:number(row.package_out),
  bunchNum:number(row.bunch_num),remainingBunchNum:number(row.remaining_bunch_num),stockStatus:number(row.stock_status),planShipDate:dateOnly(row.plan_ship_date),remark:text(row.remark),inUserName:text(row.in_user_name),inTime:dateTime(row.in_time),
  outType:number(row.out_type),linkSendNo:text(row.link_send_no),todayShelfNo:text(row.link_zone_shelf),outPackageNum:number(row.out_package_num),outBunchNum:number(row.out_bunch_num),finishBunchNum:number(row.finish_bunch_num),
  boxRepackFlag:number(row.box_repack_flag),taskStatus:number(row.task_status),operateTime:dateTime(row.operate_time),finishTime:dateTime(row.finish_time),finishUserName:text(row.finish_user_name),abnormalFlag:number(row.abnormal_flag),abnormalRemark:text(row.abnormal_remark),
})

export async function overview(){const row=await repository.getOverview();return{customerCount:number(row.customer_count),bareCustomerCount:number(row.bare_customer_count),packageCustomerCount:number(row.package_customer_count),packageTotal:number(row.package_total),todayOutTotalCount:number(row.today_total),todayOutFinishCount:number(row.today_finished)}}
export async function current(filters:ColdStorageFilters){return(await repository.listCurrent(filters)).map(map)}
export async function outTasks(filters:ColdStorageFilters){return(await repository.listOutTasks(filters)).map(map)}
export async function scanBare(content:string){const match=content.trim().match(/(?:enterItemId[=/:]|^)(\d+)$/i);const id=Number(match?.[1]);if(!Number.isInteger(id)||id<=0)throw new AppError(400,'INVALID_FLOWER_CODE','未识别到有效的花材二维码');const row=await repository.findScannedFlower(id);if(!row)throw new AppError(404,'FLOWER_NOT_FOUND','未找到二维码对应的入场花材');return{enterItemId:number(row.enter_item_id),roundNo:dateOnly(row.round_no),locationNo:text(row.location_no),purchaserId:number(row.purchaser_id),purchaserNick:text(row.purchaser_nick),purchaserMobile:text(row.purchaser_mobile),receiveAddress:text(row.receive_address),originSendNo:text(row.origin_send_no)}}
export async function registerBare(command:{content:string;bunchNum:number;imageUrls:string[];remark:string;operator:ColdStorageOperator}){if(!Number.isInteger(command.bunchNum)||command.bunchNum<=0)throw new AppError(400,'INVALID_BUNCH_NUM','暂存扎数必须为正整数');if(!command.imageUrls.length)throw new AppError(400,'STORAGE_IMAGE_REQUIRED','请上传入库照片');if(command.imageUrls.some(url=>!url.startsWith('/uploads/cold-storage/')))throw new AppError(400,'INVALID_STORAGE_IMAGE','入库照片地址无效');const scan=await scanBare(command.content);const row=await repository.findScannedFlower(scan.enterItemId);try{return{id:await repository.registerBare(row,command.bunchNum,command.imageUrls,command.remark.trim(),command.operator)}}catch(error:any){if(error?.code==='ER_DUP_ENTRY')throw new AppError(409,'ALREADY_STORED','该花材已登记冷库暂存');throw error}}
export async function finishOut(command:{taskId:number;finishBunchNum?:number;imageUrls:string[];remark:string;operator:ColdStorageOperator}){if(!Number.isInteger(command.taskId)||command.taskId<=0)throw new AppError(400,'INVALID_OUT_TASK','出库任务无效');if(!command.imageUrls.length)throw new AppError(400,'OUT_IMAGE_REQUIRED','请上传出库照片');if(command.imageUrls.some(url=>!url.startsWith('/uploads/cold-storage/')))throw new AppError(400,'INVALID_OUT_IMAGE','出库照片地址无效');const result=await repository.finishOutTask(command.taskId,command.finishBunchNum,command.imageUrls,command.remark.trim(),command.operator);if(result.kind==='missing')throw new AppError(404,'OUT_TASK_NOT_FOUND','出库任务不存在');if(result.kind==='finished')throw new AppError(409,'OUT_TASK_FINISHED','任务已处理，请刷新列表');if(result.kind==='invalid-bunch')throw new AppError(400,'INVALID_FINISH_BUNCH','最终出库扎数应大于0且不能超过审批数量');return{id:command.taskId,status:20}}
