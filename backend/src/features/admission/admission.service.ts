import { AppError } from '../../shared/errors.js'
import * as repository from './admission.repository.js'
import type { AdmissionRow } from './admission.types.js'

function mapAdmission(row: AdmissionRow) {
  return {
    id: row.id,
    supplierId: row.supplier_id,
    supplierName: row.supplier_name,
    phone: row.login_tel,
    session: row.date,
    status: row.data_status as 0 | 1,
    statusLabel: row.data_status === 1 ? '已入场' : '未入场',
    enterTime: row.enter_time || null,
    nightEnabled: row.night_open === 1,
    nightStatus: row.night_data_status as 0 | 1,
    nightEnterTime: row.night_enter_time || null,
    hasQualityIssue: row.is_qualify === 1,
    late: row.is_late === 1,
    priorityInspection: row.quality_inspection_flag === 1,
    itemCount: Number(row.item_count ?? 0),
    itemQuantity: Number(row.item_quantity ?? 0),
  }
}

export async function getAdmissions(date: string, status?: number, keyword?: string, supplierId?: number) {
  return (await repository.listAdmissions(date, status, keyword?.trim(), supplierId)).map(mapAdmission)
}

export async function getSummary(date: string) {
  const row = await repository.getAdmissionSummary(date)
  return { total: Number(row.total ?? 0), pending: Number(row.pending ?? 0), admitted: Number(row.admitted ?? 0), late: Number(row.late ?? 0), priority: Number(row.priority ?? 0) }
}

export async function getBusinessSummary(date:string){
  const row=await repository.getArrivalBusinessSummary(date)
  const number=(key:string)=>Number(row[key]||0)
  return {soldUnits:number('sold_units'),daySoldUnits:number('day_sold_units'),nightAddedSoldUnits:number('night_added_sold_units'),receivedUnits:number('received_units'),nightAddedReceivedUnits:number('night_added_received_units'),selfOperatedUnits:number('self_operated_units'),externalSupplierUnits:number('external_supplier_units'),pickupUnits:number('pickup_units'),pickupPeople:number('pickup_people'),ordinaryPickupUnits:number('ordinary_pickup_units'),ordinaryPickupPeople:number('ordinary_pickup_people'),partnerPickupUnits:number('partner_pickup_units'),partnerPickupPeople:number('partner_pickup_people')}
}

export async function setAdmissionStatus(id: number, status: 0 | 1, operatorId: number) {
  const affected = await repository.changeAdmissionStatus(id, status, operatorId)
  if (!affected) {
    if (!(await repository.admissionExists(id))) throw new AppError(404, 'ADMISSION_NOT_FOUND', '入场记录不存在')
    throw new AppError(409, 'ADMISSION_STATUS_UNCHANGED', status === 1 ? '供应商已经入场' : '供应商已经取消入场')
  }
  return { id, status }
}
