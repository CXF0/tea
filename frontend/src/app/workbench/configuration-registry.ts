import type { BusinessDomainCode } from "./types";

export interface ConfigurableItem {
  id: string;
  title: string;
  capability: string;
}

export interface DomainEntry extends ConfigurableItem {
  domain: BusinessDomainCode;
  path: string;
  icon: string;
}

export interface ScanOperation extends ConfigurableItem {
  description: string;
}

export const domainEntries: DomainEntry[] = [
  {
    id: "dispatch-task",
    domain: "transport",
    title: "派车任务",
    capability: "transport.dispatch.view",
    path: "/features/transport/pages/dispatch/index",
    icon: "/static/icons/wms/fwms-truck-outline.svg",
  },
  {
    id: "vehicle-management",
    domain: "transport",
    title: "车辆管理",
    capability: "transport.vehicle.view",
    path: "/features/transport/pages/vehicles/index",
    icon: "/static/icons/wms/fwms-truck-outline.svg",
  },
  {
    id: "transport-base-flowers",
    domain: "transport",
    title: "基地花材明细",
    capability: "transport.baseFlower.view",
    path: "/features/transport/pages/base-flowers/index",
    icon: "/static/icons/wms/fwms-truck-outline.svg",
  },
  {
    id: "agri-delivery",
    domain: "agriDelivery",
    title: "农资送货单",
    capability: "agriDelivery.view",
    path: "/features/agri-driver/pages/delivery/index",
    icon: "/static/icons/wms/fwms-agri-delivery-outline.svg",
  },
  {
    id: "agri-driver-order",
    domain: "agriDriverOrder",
    title: "农资订单",
    capability: "agriDriverOrder.view",
    path: "/features/agri-driver/pages/orders/index",
    icon: "/static/icons/wms/fwms-agri-order-outline.svg",
  },
  {
    id: "bulk-purchase-demand",
    domain: "bulkPurchaseDemand",
    title: "集采需求",
    capability: "bulkPurchaseDemand.view",
    path: "/features/bulk-purchase/pages/demands/index",
    icon: "/static/icons/wms/fwms-bulk-demand-outline.svg",
  },
  {
    id: "bulk-purchase-order",
    domain: "bulkPurchaseOrder",
    title: "集采订单",
    capability: "bulkPurchaseOrder.view",
    path: "/features/bulk-purchase/pages/orders/index",
    icon: "/static/icons/wms/fwms-bulk-order-outline.svg",
  },
  {
    id: "system-account",
    domain: "systemAccount",
    title: "系统账户",
    capability: "systemAccount.view",
    path: "/features/system-account/pages/home/index",
    icon: "/static/icons/wms/fwms-system-account-outline.svg",
  },
  {
    id: "access-control",
    domain: "accessControl",
    title: "角色权限",
    capability: "accessControl.view",
    path: "/features/access-control/pages/home/index",
    icon: "/static/icons/wms/fwms-access-control-outline.svg",
  },
  {
    id: "agri-material",
    domain: "agriMaterial",
    title: "农资管理",
    capability: "agriMaterial.view",
    path: "/features/agri-material/pages/home/index",
    icon: "/static/icons/wms/fwms-crate-outline.svg",
  },
  {
    id: "base-return",
    domain: "baseReturn",
    title: "基地退货",
    capability: "baseReturn.view",
    path: "/features/base-return/pages/home/index",
    icon: "/static/icons/wms/fwms-base-return-outline.svg",
  },
  {
    id: "base-outsource-income",
    domain: "baseOutsourceIncome",
    title: "基地包干收益",
    capability: "baseOutsourceIncome.view",
    path: "/features/base-outsource-income/pages/home/index",
    icon: "/static/icons/wms/fwms-warehouse-income-outline.svg",
  },
  {
    id: "base-stocktaking",
    domain: "baseStocktaking",
    title: "基地盘点",
    capability: "baseStocktaking.view",
    path: "/features/base-stocktaking/pages/home/index",
    icon: "/static/icons/wms/fwms-stocktake-outline.svg",
  },
  {
    id: "base-management",
    domain: "baseManagement",
    title: "基地管理",
    capability: "baseManagement.view",
    path: "/features/base-management/pages/home/index",
    icon: "/static/icons/wms/fwms-warehouse-outline.svg",
  },
  {
    id: "admission",
    domain: "admission",
    title: "入场管理",
    capability: "admission.view",
    path: "/features/admission/pages/home/index",
    icon: "/static/icons/wms/fwms-checkin-outline.svg",
  },
  {
    id: "arrival-goods-purchase",
    domain: "arrivalGoods",
    title: "收购管理",
    capability: "arrivalGoods.purchase.view",
    path: "/features/arrival-goods/pages/purchase/index",
    icon: "/static/icons/wms/fwms-warehouse-outline.svg",
  },
  {
    id: "arrival-goods-stock",
    domain: "arrivalGoods",
    title: "库存列表",
    capability: "arrivalGoods.stock.view",
    path: "/features/arrival-goods/pages/stock/index",
    icon: "/static/icons/wms/fwms-inventory-outline.svg",
  },
  {
    id: "arrival-goods-outbound",
    domain: "arrivalGoods",
    title: "商品出库",
    capability: "arrivalGoods.outbound.view",
    path: "/features/arrival-goods/pages/outbound/index",
    icon: "/static/icons/wms/fwms-outbound-outline.svg",
  },
  {
    id: "arrival-goods-self-pickup",
    domain: "arrivalGoods",
    title: "场地自提",
    capability: "arrivalGoods.selfPickup.view",
    path: "/features/arrival-goods/pages/self-pickup/index",
    icon: "/static/icons/wms/fwms-checkin-outline.svg",
  },
  {
    id: "arrival-goods-unlabeled",
    domain: "arrivalGoods",
    title: "无标签花材",
    capability: "arrivalGoods.unlabeled.view",
    path: "/features/arrival-goods/pages/unlabeled/index",
    icon: "/static/icons/wms/fwms-warehouse-outline.svg",
  },
  {
    id: "quality",
    domain: "quality",
    title: "花材质检",
    capability: "quality.flower.view",
    path: "/features/quality/pages/suppliers/index",
    icon: "/static/icons/wms/fwms-inspection-outline.svg",
  },
  {
    id: "quality-tasks",
    domain: "qualityTask",
    title: "质检任务",
    capability: "quality.task.view",
    path: "/features/quality/pages/tasks/index",
    icon: "/static/icons/wms/fwms-task-outline.svg",
  },
  {
    id: "quality-base-statistics",
    domain: "qualityBaseStatistics",
    title: "基地质检统计",
    capability: "quality.baseStatistics.view",
    path: "/features/quality/pages/base-statistics/index",
    icon: "/static/icons/wms/fwms-inspection-outline.svg",
  },
  {
    id: "quality-exchange-records",
    domain: "qualityBaseStatistics",
    title: "换货记录",
    capability: "quality.exchange.view",
    path: "/features/quality/pages/exchange-records/index",
    icon: "/static/icons/wms/fwms-task-outline.svg",
  },
  {
    id: "distribution",
    domain: "distribution",
    title: "配货作业",
    capability: "distribution.view",
    path: "/features/distribution/pages/home/index",
    icon: "/static/icons/wms/fwms-picking-outline.svg",
  },
  {
    id: "restock",
    domain: "restock",
    title: "补货管理",
    capability: "restock.view",
    path: "/features/restock/pages/home/index",
    icon: "/static/icons/wms/fwms-replenishment-outline.svg",
  },
  {
    id: "packing",
    domain: "packing",
    title: "打包作业",
    capability: "packing.view",
    path: "/features/packing/pages/home/index",
    icon: "/static/icons/wms/fwms-packing-outline.svg",
  },
  {
    id: "logistics",
    domain: "logistics",
    title: "物流发货",
    capability: "logistics.view",
    path: "/features/logistics/pages/home/index",
    icon: "/static/icons/wms/fwms-outbound-outline.svg",
  },
  {
    id: "part-logistics",
    domain: "partLogistics",
    title: "兼职物流",
    capability: "partLogistics.view",
    path: "/features/part-logistics/pages/home/index",
    icon: "/static/icons/wms/fwms-part-logistics-outline.svg",
  },
  {
    id: "cold-storage",
    domain: "coldStorage",
    title: "冷库暂存",
    capability: "coldStorage.view",
    path: "/features/cold-storage/pages/home/index",
    icon: "/static/icons/wms/fwms-cold-storage-outline.svg",
  },
  {
    id: "inventory",
    domain: "cartonInventory",
    title: "纸箱管理",
    capability: "inventory.view",
    path: "/features/carton-inventory/pages/home/index",
    icon: "/static/icons/wms/fwms-inventory-outline.svg",
  },
  {
    id: "distribution-staff",
    domain: "distributionStaff",
    title: "配货权限",
    capability: "distributionStaff.view",
    path: "/features/workforce/pages/distribution-staff/index",
    icon: "/static/icons/wms/fwms-distribution-permission-outline.svg",
  },
  {
    id: "inspection-attendance",
    domain: "inspectionAttendance",
    title: "质检假勤",
    capability: "inspectionAttendance.view",
    path: "/features/workforce/pages/inspection-attendance/index",
    icon: "/static/icons/wms/fwms-inspection-attendance-outline.svg",
  },
  {
    id: "team-account",
    domain: "teamAccount",
    title: "团队账号",
    capability: "teamAccount.view",
    path: "/features/distribution-team/pages/accounts/index",
    icon: "/static/icons/wms/fwms-team-account-outline.svg",
  },
  {
    id: "team-distribution",
    domain: "teamDistribution",
    title: "配货明细",
    capability: "teamDistribution.view",
    path: "/features/distribution-team/pages/statistics/index",
    icon: "/static/icons/wms/fwms-team-picking-outline.svg",
  },
  {
    id: "patrol-punishment",
    domain: "patrolPunishment",
    title: "巡线处罚",
    capability: "patrolPunishment.view",
    path: "/features/patrol-punishment/pages/home/index",
    icon: "/static/icons/wms/fwms-patrol-punishment-outline.svg",
  },
];

export const workbenchCards: ConfigurableItem[] = [
  {
    id: "admission-session",
    title: "本场次入场作业",
    capability: "admission.view",
  },
  {
    id: "quality-session",
    title: "本场次质检任务",
    capability: "quality.view",
  },
  {
    id: "inventory-session",
    title: "本场次纸箱任务",
    capability: "inventory.view",
  },
];

export const todoDefinitions: ConfigurableItem[] = [
  { id: "admission-pending", title: "待入场", capability: "admission.view" },
  { id: "quality-pending", title: "质检待办", capability: "quality.view" },
  {
    id: "inventory-inbound",
    title: "入库待办",
    capability: "inventory.inbound",
  },
];

export const scanOperations: ScanOperation[] = [
  {
    id: "admission-checkin",
    title: "扫码入场",
    capability: "admission.scan",
    description: "扫描供应商码，定位并确认入场",
  },
  {
    id: "quality-inspection",
    title: "扫码质检",
    capability: "quality.scan",
    description: "扫描花材码，进入对应花材质检",
  },
  {
    id: "quality-video",
    title: "扫码拍视频",
    capability: "quality.task.video.submit",
    description: "扫描花材码后拍摄好花视频",
  },
  {
    id: "distribution-shelf",
    title: "扫码配货",
    capability: "distribution.view",
    description: "扫描货架码进入货架配货",
  },
  {
    id: "packing-shelf",
    title: "扫码打包",
    capability: "packing.view",
    description: "扫描货架码进入打包任务",
  },
  {
    id: "logistics-shelf",
    title: "扫码查发货",
    capability: "logistics.view",
    description: "扫描货架码查看发货详情",
  },
  {
    id: "cold-storage-bare",
    title: "裸花暂存",
    capability: "coldStorage.view",
    description: "扫描花材码登记冷库暂存",
  },
  {
    id: "base-return-confirm",
    title: "退货确认",
    capability: "baseReturn.confirm",
    description: "连续扫描退货花材进行二次确认",
  },
];

export const dataCards: ConfigurableItem[] = [
  { id: "site-distribution-progress", title: "场地配货总进度", capability: "distribution.view" },
  { id: "session-size-statistics", title: "场次大小件统计", capability: "packing.view" },
  {
    id: "admission-overview",
    title: "入场作业概览",
    capability: "admission.statistics",
  },
  { id: "quality-overview", title: "质检任务概览", capability: "quality.view" },
  { id: "quality-supplier-admission", title: "供应商入场", capability: "quality.statistics" },
  { id: "quality-business-statistics", title: "质检问题统计", capability: "quality.statistics" },
  { id: "quality-staff", title: "质检假勤统计", capability: "inspectionAttendance.view" },
  { id: "quality-trend", title: "花材问题趋势", capability: "quality.statistics" },
  { id: "distribution-progress", title: "分区配货进度", capability: "distribution.view" },
  { id: "agency-distribution", title: "代配货统计", capability: "distribution.view" },
  { id: "contractor-distribution", title: "配货统计（外包负责人）", capability: "distribution.view" },
  { id: "arrival-volume", title: "到场货统计", capability: "admission.view" },
  { id: "self-pickup", title: "自提统计", capability: "admission.view" },
  { id: "inventory-overview", title: "纸箱库存", capability: "inventory.view" },
  {
    id: "inventory-progress",
    title: "入库进度",
    capability: "inventory.inbound",
  },
];

export function resolveConfigured<T extends ConfigurableItem>(
  ids: string[],
  registry: T[],
  can: (capability: string) => boolean,
) {
  const idSet = new Set(ids);
  return registry.filter((item) => idSet.has(item.id) && can(item.capability));
}
