import { AppError } from '../../shared/errors.js'
import * as repository from './distribution.repository.js'

const operationLabels: Record<number, string> = { 1: '降一级', 2: '降两级', 3: '退货不补', 4: '退货补货', 5: '缺货不补', 6: '缺货补货', 7: '换货', 10: '质检问题' }

export interface DistributionFilters extends repository.ShelfFilters { status?: string; keyword?: string }
export async function getShelves(date: string, filters: DistributionFilters = {}) {
  const rows = await repository.listShelves(date, filters.keyword?.trim(), filters)
  return rows.map(row => {
    const total = Number(row.total_units); const allocated = Number(row.allocated_units)
    return { shelfNo: row.shelf_no, itemCount: Number(row.item_count), totalUnits: total, allocatedUnits: allocated, problemUnits: Number(row.problem_units), restockUnits: Number(row.restock_units), deliveryType: Number(row.delivery_type), supplierNames: row.supplier_names || '', completed: total > 0 && allocated >= total, warehouseType: Number(row.ware_type) === 1 ? 'city' : 'normal', earlyShift: Number(row.early_shift) === 1, zone: row.zone, segments: String(row.segments || '').split(',').filter(Boolean) }
  }).filter(row => filters.status === 'completed' ? row.completed : filters.status === 'pending' ? !row.completed : true)
}

export async function getSummary(date: string, accountId?:number, scope:'site'|'team'='site') {
  let zones:string[]=[]
  let scopeName='全场地'
  if(scope==='team'){
    const team=accountId ? await repository.getAccountDistributionTeam(accountId) : null
    const roleCode=accountId ? await repository.getAccountRoleCode(accountId) : ''
    if(!team && roleCode==='superAdmin'){
      const allShelves = await getShelves(date)
      return { scope,scopeName:'全部责任分区',zones:[],totalShelves: allShelves.length, pendingShelves: allShelves.filter(row => !row.completed).length, completedShelves: allShelves.filter(row => row.completed).length, totalUnits: allShelves.reduce((sum, row) => sum + row.totalUnits, 0), allocatedUnits: allShelves.reduce((sum, row) => sum + row.allocatedUnits, 0), restockUnits: allShelves.reduce((sum, row) => sum + row.restockUnits, 0) }
    }
    scopeName=team ? String(team.name) : '未配置配货团队'
    if(team){try{const config=JSON.parse(String(team.perm_config||'{}'));zones=Array.isArray(config.zones)?config.zones.map(String):[]}catch{zones=[]}}
    if(!zones.length)return{scope,scopeName,zones,totalShelves:0,pendingShelves:0,completedShelves:0,totalUnits:0,allocatedUnits:0,restockUnits:0}
  }
  const allShelves = await getShelves(date)
  const shelves=scope==='team'?allShelves.filter(row=>zones.includes(String(row.zone).padStart(2,'0'))||zones.includes(String(Number(row.zone)))):allShelves
  return { scope,scopeName,zones,totalShelves: shelves.length, pendingShelves: shelves.filter(row => !row.completed).length, completedShelves: shelves.filter(row => row.completed).length, totalUnits: shelves.reduce((sum, row) => sum + row.totalUnits, 0), allocatedUnits: shelves.reduce((sum, row) => sum + row.allocatedUnits, 0), restockUnits: shelves.reduce((sum, row) => sum + row.restockUnits, 0) }
}

export async function getAgencySummary(date:string){
  const row=await repository.getAgencyDistributionSummary(date)
  return {totalSupplierCount:Number(row.total_supplier_count||0),totalItemCount:Number(row.total_item_count||0),daySupplierCount:Number(row.day_supplier_count||0),dayItemCount:Number(row.day_item_count||0),nightSupplierCount:Number(row.night_supplier_count||0),nightItemCount:Number(row.night_item_count||0)}
}

export async function getFilterOptions(date: string, warehouseType?: 'normal'|'city') {
  const rows = await repository.listFilterOptions(date, warehouseType)
  return rows.map(row => { let segments:string[]=[];try{segments=[...new Set((JSON.parse(String(row.segment_area||'[]')) as Array<{name?:string|number}>).map(item=>String(item.name||'')).filter(Boolean))]}catch{}return { zone:String(row.zone), areaName:String(row.area_name||''), segments } })
}

export async function getMyAllocationDashboard(userId:number){
  const result=await repository.getMyAllocationDashboard(userId)
  const sessions=result.sessions.map(row=>({date:row.date instanceof Date?row.date.toISOString().slice(0,10):String(row.date).slice(0,10),allocatedUnits:Number(row.allocated_units),lastOperatedAt:row.last_operated_at}))
  const monthStart=new Date();monthStart.setMonth(monthStart.getMonth()-1)
  return {recentSessionUnits:sessions[0]?.allocatedUnits||0,monthlyAllocatedUnits:sessions.filter(row=>new Date(row.date)>=monthStart).reduce((sum,row)=>sum+row.allocatedUnits,0),monthlyPunishmentCount:result.punishmentCount,sessions}
}

export async function getUnfinishedItems(date:string,filters:{zone?:string;orderNum?:number;productName?:string}){
  const rows=await repository.listUnfinishedItems(date,filters)
  return rows.map(row=>({enterItemId:Number(row.enter_item_id),orderNum:Number(row.order_num),productName:row.product_name,rank:Number(row.rank_num),zone:String(row.zone||''),shelfNo:row.zone_shelf,segment:String(row.sub_shelf_sn||''),supplierName:row.supplier_name,supplyPrice:Number(row.supply_price),unfinishedUnits:Number(row.unfinished_num)}))
}

export async function batchMarkShortage(itemIds:number[],operation:6|7,remark:string,userId:number,userName:string){
  if(!itemIds.length||itemIds.some(id=>!Number.isInteger(id)||id<1))throw new AppError(400,'INVALID_ITEM_IDS','请选择需要处理的未配货花材')
  return repository.markUnfinishedAsShortage([...new Set(itemIds)],operation,remark.trim(),userId,userName)
}

export async function getShelf(date: string, shelfNo: string) {
  const rows = await repository.listShelfItems(date, shelfNo)
  if (!rows.length) throw new AppError(404, 'SHELF_NOT_FOUND', '货架不存在或当前场次没有花材')
  return { shelfNo, date, items: rows.map(row => ({ id: Number(row.id), orderItemId: Number(row.order_item_id), orderSn: row.order_sn || '', orderNo: Number(row.order_num), shelfNo: row.shelf_no, segment: row.segment, productName: row.product_name, rank: Number(row.rank_num), skuConfig: row.sku_config, supplyPrice: Number(row.supply_price || 0), totalUnits: Number(row.total_units), allocatedUnits: row.allocated_units, problemMarks: row.problem_marks.map((mark: { unit: number; operation: number }) => ({ ...mark, label: operationLabels[mark.operation] || '质检问题' })), supplierName: row.supplier_name, supplierPhone: row.supplier_phone, baseShortName: row.base_short_name || '', customerName: row.customer_name || '', customerPhone: row.customer_phone || '', limitDistribution: Number(row.limit_distribution_flag) === 1, exceptions: { shortage: Number(row.lack_num), shortageRestock: Number(row.lack_replenish_num), return: Number(row.return_num), returnRestock: Number(row.return_replenish_num), downgrade: Number(row.lower_rank_num), restock: Number(row.restock_item_num) + Number(row.wms_restock_num) } })) }
}

export async function updateAllocation(itemId: number, units: number[], allocated: boolean, userId: number, userName: string) {
  if (!units.length || units.some(unit => !Number.isInteger(unit))) throw new AppError(400, 'INVALID_UNITS', '请选择需要操作的花材扎号')
  const result = await repository.setAllocation(itemId, [...new Set(units)], allocated, userId, userName)
  if (result === 'not_found') throw new AppError(404, 'ITEM_NOT_FOUND', '花材明细不存在')
  if (result === 'invalid_unit') throw new AppError(400, 'INVALID_UNIT', '花材扎号超出有效范围')
  return { itemId, units, allocated }
}

export async function getContractorSummary(accountId:number,date:string){
  const row=await repository.getContractorDistributionSummary(accountId,date)
  if(!row)return{contracted:false}
  const prepareRate=row.itemNum?row.prepareItemNum/row.itemNum*100:0
  const previousRate=row.previous.item_num?row.previous.prepare_item_num/row.previous.item_num*100:0
  const itemNumDiff=row.itemNum-row.previous.item_num
  const rateDiff=prepareRate-previousRate
  return{contracted:true,employeeCount:row.employeeCount,itemNum:row.itemNum,returnReplenishNum:row.returnReplenishNum,prepareItemNum:row.prepareItemNum,prepareRate,deliveryIncome:row.deliveryIncome,prepareCompleteTime:prepareRate>=99.5&&row.lastPrepareTime?new Date(row.lastPrepareTime).toTimeString().slice(0,5):'',prepareTargetTime:'',itemNumDiff,itemNumDiffRate:row.previous.item_num?itemNumDiff/row.previous.item_num*100:0,prepareRateDiff:rateDiff,prepareRateDiffRate:previousRate?rateDiff/previousRate*100:0}
}
