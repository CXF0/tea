export type QualityStatus = 0 | 1 | 2 | 10

export interface QualityTask {
  id: number; session: string; location: string; flowerName: string; grade: string
  specification: string; quantity: number; allocatedQuantity: number; unit: string; supplierName: string
  priority: boolean; focused: boolean; status: QualityStatus; statusLabel: string
  assigneeName: string | null; remark: string; finishedAt: string | null
  taskType: 'assigned' | 'self'; customerType: 'big' | 'new' | 'other'
  markers: { return: boolean; exchange: boolean }; receiverPhone: string
}

export interface QualitySummary { total: number; pending: number; passed: number; rejected: number; priorityPending: number }
export interface QualityTeamTaskSummary {
  configured: boolean; teamName: string; zones: string[]; total: number; completed: number
  pending: number; passed: number; rejected: number; inspectorCount: number
  zoneBreakdown: Array<{ zone:string; name:string; total:number; completed:number; pending:number; passed:number; rejected:number; inspectorCount:number }>
}
export interface QualityBusinessSummary { requiredSuppliers:number; pendingSuppliers:number; admittedSuppliers:number; downgradeUnits:number; returnUnits:number; shortageUnits:number; exchangeUnits:number; exchangedUnits:number; resaleUnits:number; returnTransferUnits:number; involvedLocationCount:number; involvedSupplierCount:number }
export interface QualityZoneStatistics { zone:string; name:string; exchangeUnits:number; shortageUnits:number; downgradeUnits:number; resaleUnits:number }
export interface QualityStaffStatistic { inspectorId:number; inspectorName:string; downgradeUnits:number; shortageUnits:number; returnUnits:number; exchangeUnits:number; issueUnits:number }
export interface QualitySupplierLocationStatistic { supplierId:number; supplierName:string; location:string; flowerCount:number; downgradeUnits:number; shortageUnits:number; returnUnits:number; exchangeUnits:number; issueUnits:number; latestMarkedAt:string }
export interface QualityStatisticsDetail { summary:{ downgradeUnits:number; shortageUnits:number; returnUnits:number; exchangeUnits:number; returnTransferUnits:number; involvedLocationCount:number; involvedSupplierCount:number }; zoneRows:QualityZoneStatistics[]; staffRows:QualityStaffStatistic[]; supplierLocationRows:QualitySupplierLocationStatistic[] }
export interface QualityIssueTrend { date:string;count:number }
export interface ReasonGroup { id: number; name: string; reasons: Array<{ id: number; name: string }> }

export interface SupplierFlowerItem {
  id: number; enterId: number; shelf: string; orderNumber: number; subShelf: string | null
  flowerName: string; grade: string; specification: string; maturity: string
  bundleSpecification: string; quantity: number; unit: string
  positioned: boolean; qualityStatus: 0 | 1 | 10; qualityStatusLabel: string
  unqualifiedQuantity: number; inspectorName: string | null; inspectedAt: string | null
  supplier: { name: string | null; phone: string | null }; supplierPrice: number
  customer: { name: string | null; phone: string | null; partnerName: string | null; unqualifiedWay: number; unqualifiedWayLabel: string } | null
  controls: { limitDistribution: boolean; merchantResponsibility: boolean; noAfterSale: boolean; responsibilityRemark: string; responsibilityMedia: string[] }
  unitMarks?: Array<{ unit: number; operation: number }>
  allocatedUnits?: number[]
}
export interface QualityOperationLog { unit: number; operation: number; operationLabel: string; reason: string; category: string; operatorName: string; operatedAt: string; active: boolean }
export interface QualityInspectionPreview { operation: number; operationLabel: string; flowerName: string; grade: string; supplierName: string; selectedCount: number; unitPrice: number; principal: number; punishPercent: number; punishAmount: number; formula: string; reasons: Array<{ id: number; name: string }>; customerChoice: string }
export interface QualityPunishRule { operation: number; operationName: string; punishPercent: number; description: string; supplierRules: Array<{ supplierType: string; punishPercent: number; description: string }> }
export interface GoodFlowerVideoRecord { id:number;enterItemId:number;flowerName:string;grade:string;supplierName:string;supplierTag:string;location:string;videoUrl:string;remark:string;createdAt:string;updatedAt:string }
export interface GoodFlowerVideoSummary { required:number;completed:number;records:GoodFlowerVideoRecord[] }
export interface GoodFlowerVideoItem { enterItemId:number;flowerName:string;grade:string;supplierName:string;supplierTag:string;location:string;session:string }
export interface SelfInspectionLocation { location:string;flowerCount:number;markedUnitCount:number;flowerSummary:string;supplierSummary:string;markers:{return:boolean;exchange:boolean};latestMarkedAt:string }
export interface QualityBaseIssueStatistic { baseId:number;baseName:string;downgradeUnits:number;returnUnits:number;exchangeUnits:number;issueUnits:number }
export interface QualityExchangeRecord { id:number;date:string;supplierId:number;supplierName:string;flowerName:string;grade:string;specification:string;location:string;quantity:number;handledQuantity:number;handleStatus:number;handleStatusLabel:string;notifyStatus:number;notifyStatusLabel:string;notifyCount:number;lastNotifyTime:string;callResult:string;operatorName:string;createdAt:string }
