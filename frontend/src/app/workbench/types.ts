export type BusinessDomainCode =
  | "admission"
  | "collection"
  | "transport"
  | "arrivalGoods"
  | "quality"
  | "qualityBaseStatistics"
  | "qualityTask"
  | "distribution"
  | "restock"
  | "packing"
  | "inventory"
  | "cartonInventory"
  | "coldStorage"
  | "logistics"
  | "partLogistics"
  | "distributionStaff"
  | "inspectionAttendance"
  | "teamAccount"
  | "teamDistribution"
  | "patrolPunishment"
  | "bulkPurchaseDemand"
  | "bulkPurchaseOrder"
  | "systemAccount"
  | "accessControl"
  | "baseManagement"
  | "baseStocktaking"
  | "baseOutsourceIncome"
  | "baseReturn"
  | "agriMaterial"
  | "agriDelivery"
  | "agriDriverOrder"
  | "consignment"
  | "agriMaterial"
  | "management";

export interface WorkbenchConfiguration {
  workbenchCardIds: string[];
  todoIds: string[];
  scanOperationIds: string[];
  dataCardIds: string[];
}
