import * as repository from "./arrival-goods.repository.js";

const rankLabels: Record<number, string> = { 1: "A级", 2: "B级", 3: "C级", 4: "D级", 5: "E级" };

function mapRow(row: any) {
  const location = [row.zone_shelf, row.sub_shelf_sn].filter(Boolean).join("-");
  const supplierName = String(row.supplier_name || "");
  return {
    id: Number(row.id),
    date: String(row.date),
    flowerName: String(row.product_name || ""),
    grade: rankLabels[Number(row.rank_num)] || `${row.rank_num}级`,
    specification: String(row.sku_config || ""),
    supplierId: Number(row.supplier_id || 0),
    supplierName: supplierName || "无标签花材",
    location: location || "未入位",
    acquiredUnits: Number(row.item_num || 0),
    stockUnits: Number(row.available_num || 0),
    outboundUnits: Number(row.prepare_item_num || 0),
    problemUnits: Number(row.not_qualify_num || 0),
    selfPickup: Number(row.self_take_type || 0) > 0,
    unlabeled: Number(row.supplier_id || 0) === 0 || supplierName.includes("无标签"),
    createdAt: row.create_time || "",
  };
}

export async function list(q: any) {
  const page = Math.max(1, Number(q.page || 1));
  const size = Math.min(50, Math.max(10, Number(q.size || 20)));
  const result = await repository.listArrivalGoods({
    date: String(q.date || new Date().toISOString().slice(0, 10)),
    type: String(q.type || "all"),
    keyword: String(q.keyword || "").trim(),
    page,
    size,
  });
  const summary = result.summary;
  return {
    current: page,
    size,
    total: Number(summary.total_items || 0),
    summary: {
      acquiredUnits: Number(summary.acquired_units || 0),
      stockUnits: Number(summary.stock_units || 0),
      outboundUnits: Number(summary.outbound_units || 0),
      selfPickupUnits: Number(summary.self_pickup_units || 0),
      unlabeledUnits: Number(summary.unlabeled_units || 0),
    },
    records: result.rows.map(mapRow),
  };
}
