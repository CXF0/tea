export type DataCategoryKey =
  | "core"
  | "quality"
  | "distribution"
  | "arrival"
  | "centralProcurement"
  | "packing"
  | "logistics"
  | "supplier"
  | "agri";

export interface DataCardDefinition {
  id: string;
  title: string;
  description: string;
  size: "half" | "full";
}

export const dataCategoryLabels: Record<DataCategoryKey, string> = {
  core: "核心",
  quality: "质检",
  distribution: "配货",
  arrival: "到场货",
  centralProcurement: "集采",
  packing: "打包",
  logistics: "物流",
  supplier: "供应商",
  agri: "农资",
};

export const dataCardsByCategory: Record<DataCategoryKey, DataCardDefinition[]> = {
  core: [
    { id: "site-distribution-progress", title: "场地配货总进度", description: "全场场地配货扎数及整体完成进度，不受分区数据权限限制。", size: "full" },
    { id: "session-size-statistics", title: "场次大小件统计", description: "当前场次按包装重量区间统计大小件数量。", size: "full" },
    { id: "site-location-statistics", title: "场地货位统计", description: "按件型及启用状态统计场地配置货位数量。", size: "full" },
  ],
  quality: [
    { id: "quality-supplier-admission", title: "供应商入场", description: "当前场次供应商应入场、已入场与未入场情况。", size: "full" },
    { id: "quality-business-statistics", title: "质检问题统计", description: "降级、退货、缺货、换货及后续处理数量。", size: "full" },
    { id: "quality-trend", title: "花材问题趋势", description: "按问题类型展示最近 7 个真实场次的花材问题数量。", size: "full" },
    { id: "quality-staff", title: "质检假勤统计", description: "来自质检假勤模块的质检人员、出勤和休息数量。", size: "full" },
  ],
  distribution: [
    { id: "distribution-progress", title: "分区配货进度", description: "当前账号所属配货团队负责分区的配货扎数及完成进度。", size: "full" },
    { id: "agency-distribution", title: "代配货统计", description: "代配供应商及白场、晚场代配货量。", size: "full" },
    { id: "contractor-distribution", title: "配货统计（外包负责人）", description: "外包配货货量、收益、完成进度及较上一场次变化。", size: "full" },
    { id: "restock-units", title: "补货统计", description: "来自补货管理的需补、已提交和待提交数量及进度。", size: "full" },
  ],
  arrival: [
    { id: "arrival-volume", title: "到场货统计", description: "销售货量、收花量及晚场货量构成。", size: "full" },
    { id: "self-pickup", title: "自提统计", description: "普通批发与分销自提的货量和人数。", size: "full" },
  ],
  centralProcurement: [],
  packing: [
    { id: "packaging-statistics", title: "包装使用统计", description: "当前场次包装总量、使用规格数及使用量排行。", size: "full" },
  ],
  logistics: [
    { id: "logistics-outbound-collection", title: "出库与揽收", description: "当前场次物流包裹打包、出库和揽收汇总。", size: "full" },
    { id: "logistics-collection-progress", title: "物流揽收进度", description: "按物流班次展示当前场次包裹揽收完成进度。", size: "full" },
  ],
  supplier: [],
  agri: [
    { id: "agri-sales-overview", title: "农资销售概览", description: "按日期或月份展示农资订单、销售额、下单供应商和下单基地。", size: "full" },
    { id: "agri-product-sales", title: "商品销售统计", description: "按农资商品汇总销售额占比。", size: "full" },
    { id: "agri-sales-trend", title: "销售额趋势", description: "展示所选日期近一周农资销售额趋势。", size: "full" },
  ],
};

export function cardOrderStorageKey(userId: number, category: DataCategoryKey) {
  return `dataCenterCardOrder:${userId}:${category}`;
}

export function normalizeCardOrder(saved: unknown, cards: DataCardDefinition[]) {
  const ids = cards.map((card) => card.id);
  const valid = Array.isArray(saved)
    ? saved.filter((id): id is string => typeof id === "string" && ids.includes(id))
    : [];
  return [...valid, ...ids.filter((id) => !valid.includes(id))];
}
