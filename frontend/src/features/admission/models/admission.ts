export interface AdmissionRecord {
  id: number; supplierId: number; supplierName: string; phone: string; session: string
  status: 0 | 1; statusLabel: string; enterTime: string | null; nightEnabled: boolean
  nightStatus: 0 | 1; nightEnterTime: string | null; hasQualityIssue: boolean
  late: boolean; priorityInspection: boolean; itemCount: number; itemQuantity: number
}
export interface AdmissionSummary { total: number; pending: number; admitted: number; late: number; priority: number }
export interface ArrivalBusinessSummary { soldUnits:number; daySoldUnits:number; nightAddedSoldUnits:number; receivedUnits:number; nightAddedReceivedUnits:number; selfOperatedUnits:number; externalSupplierUnits:number; pickupUnits:number; pickupPeople:number; ordinaryPickupUnits:number; ordinaryPickupPeople:number; partnerPickupUnits:number; partnerPickupPeople:number }
