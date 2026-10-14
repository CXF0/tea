import { AppError } from "../../shared/errors.js";
import * as repo from "./base-management.repository.js";
const num = (v: unknown) => Number(v ?? 0);
export async function bases(date: string, accountId: number) {
  return (await repo.listBases(date, accountId)).map((r) => ({
    id: num(r.id),
    name: String(r.name),
    supplierCount: num(r.supplier_count),
    arrivalSupplierCount: num(r.arrival_supplier_count),
    productCount: num(r.product_count),
    inboundNum: num(r.inbound_num),
    allocatedNum: num(r.allocated_num),
    stockNum: Math.max(0, num(r.inbound_num) - num(r.allocated_num)),
  }));
}
export async function base(id: number, date: string) {
  const data = await repo.getBase(id, date);
  if (!data.summary) throw new AppError(404, "BASE_NOT_FOUND", "基地不存在");
  const s = data.summary;
  return {
    summary: {
      id: num(s.id),
      name: String(s.name),
      supplierCount: num(s.supplier_count),
      admittedCount: num(s.admitted_count),
      productCount: num(s.product_count),
      inboundNum: num(s.inbound_num),
      allocatedNum: num(s.allocated_num),
      stockNum: num(s.stock_num),
    },
    suppliers: data.suppliers.map((r) => ({
      id: num(r.id),
      admissionId: r.admission_id == null ? null : num(r.admission_id),
      name: String(r.supplier_name),
      phone: String(r.login_tel || ""),
      status: r.data_status == null ? null : num(r.data_status),
      productCount: num(r.product_count),
      inboundNum: num(r.inbound_num),
      allocatedNum: num(r.allocated_num),
      stockNum: num(r.stock_num),
    })),
  };
}
export async function supplier(id: number, date: string) {
  const data = await repo.getSupplier(id, date);
  if (!data.profile)
    throw new AppError(404, "SUPPLIER_NOT_FOUND", "供应商不存在");
  return {
    supplier: {
      id: num(data.profile.id),
      name: String(data.profile.supplier_name),
      phone: String(data.profile.login_tel || ""),
      baseName: String(data.profile.base_name || "未配置基地"),
    },
    statistics: {
      saleVarietyCount: num(data.statistics.sale_variety_count),
      stockNum: data.items.reduce((sum, row) => sum + num(row.stock_num), 0),
      normalSales: num(data.statistics.normal_sales),
      soldOrderCount: num(data.statistics.sold_order_count),
      agencySales: num(data.statistics.agency_sales),
      authorizedVarietyCount: num(data.statistics.authorized_variety_count),
    },
    permissions: data.permissions.map((row) => {
      let ranks: number[] = [];
      try {
        const parsed = JSON.parse(String(row.rank_auth || "[]"));
        if (Array.isArray(parsed))
          ranks = parsed
            .map(Number)
            .filter((value) => value >= 1 && value <= 5);
      } catch {
        ranks = String(row.rank_auth || "")
          .split("")
          .map(Number)
          .filter((value) => value >= 1 && value <= 5);
      }
      return {
        secondId: num(row.second_id),
        name: String(row.name),
        levels: ranks
          .map((rank) => ["", "A", "B", "C", "D", "E"][rank])
          .join(""),
      };
    }),
    items: data.items.map((r) => ({
      productId: num(r.product_id),
      productName: String(r.product_name),
      rank: num(r.rank_num),
      specification: String(r.sku_config || ""),
      inboundNum: num(r.inbound_num),
      allocatedNum: num(r.allocated_num),
      stockNum: num(r.stock_num),
      price: num(r.price),
    })),
  };
}

export async function baseZones(id: number, date: string) {
  const data = await repo.getBase(id, date);
  if (!data.summary) throw new AppError(404, "BASE_NOT_FOUND", "基地不存在");
  const rows = await repo.getBaseZoneItems(id, date);
  const zones = new Map<string, any>();
  for (const row of rows) {
    const code = String(row.zone_code || "");
    const key = code || "unassigned";
    if (!zones.has(key)) zones.set(key, { code, name: code ? `${code}区` : "未分区", frameCount: 0, varietyCount: 0, items: [] });
    const zone = zones.get(key);
    zone.frameCount += num(row.frame_count);
    zone.items.push({ productId: num(row.product_id), productName: String(row.product_name), rank: num(row.rank_num), supplierName: String(row.supplier_name), frameCount: num(row.frame_count) });
  }
  for (const zone of zones.values()) zone.varietyCount = new Set(zone.items.map((item: any) => item.productId)).size;
  return { base: { id: num(data.summary.id), name: String(data.summary.name) }, date, zones: [...zones.values()] };
}

export async function printItems(id: number, date: string) {
  const data = await repo.getSupplier(id, date);
  if (!data.profile)
    throw new AppError(404, "SUPPLIER_NOT_FOUND", "供应商不存在");
  const rows = await repo.getSupplierPrintItems(id, date);
  return {
    supplier: {
      id: num(data.profile.id),
      name: String(data.profile.supplier_name),
    },
    items: rows.map((r) => ({
      id: num(r.id),
      name: String(r.product_name),
      rank: num(r.rank_num),
      shelf: String(r.zone_shelf || r.sub_shelf_sn || "未分配"),
      quantity: num(r.item_num),
      exchange: Number(r.exchange_mark) === 1,
    })),
  };
}
