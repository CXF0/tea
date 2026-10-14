import { AppError } from "../../shared/errors.js";
import * as repo from "./base-stocktaking.repository.js";
const num = (value: unknown) => Number(value || 0);

export async function bases(accountId: number) {
  return (await repo.listBases(accountId)).map((row) => ({ id: num(row.id), name: String(row.name) }));
}
export async function suppliers(baseId: number, date: string, accountId: number) {
  return (await repo.listSuppliers(baseId, date, accountId)).map((row) => ({
    id: num(row.id), name: String(row.supplier_name), phone: String(row.login_tel || ""),
    ordinaryFlowerNum: num(row.ordinary_flower_num), inventoryNum: num(row.inventory_num),
  }));
}
export async function supplier(baseId: number, supplierId: number, date: string, accountId: number) {
  const data = await repo.getSupplier(baseId, supplierId, date, accountId);
  if (!data.profile) throw new AppError(404, "SUPPLIER_NOT_FOUND", "供应商不存在或无权查看");
  return {
    supplier: { id: num(data.profile.id), name: String(data.profile.supplier_name), phone: String(data.profile.login_tel || ""), baseName: String(data.profile.base_name) },
    items: data.items.map((row) => ({ productId: num(row.product_id), name: String(row.product_name), rank: num(row.rank_num), specification: String(row.sku_config || ""), totalNum: num(row.total_num), inventoryNum: num(row.inventory_num) })),
  };
}
