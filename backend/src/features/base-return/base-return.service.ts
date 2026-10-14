import { AppError } from "../../shared/errors.js";
import * as repo from "./base-return.repository.js";

const num = (value: unknown) => Number(value ?? 0);

export async function bases() {
  return (await repo.listBases()).map((row) => ({ id: num(row.id), name: String(row.name) }));
}

export async function list(date: string, baseTagId?: number) {
  return (await repo.listSupplierReturns(date, baseTagId)).map((row) => {
    const refundNum = num(row.refund_num);
    const confirmNum = num(row.confirm_num);
    return {
      supplierId: num(row.supplier_id), supplierName: String(row.supplier_name),
      baseId: num(row.base_id), baseName: String(row.base_name), refundNum, confirmNum,
      status: confirmNum <= 0 ? "pending" : confirmNum < refundNum ? "partial" : "confirmed",
      statusLabel: confirmNum <= 0 ? "待确认" : confirmNum < refundNum ? "部分确认" : "已确认",
    };
  });
}

function parseItemId(content: string) {
  try {
    const value = JSON.parse(content);
    const id = Number(value.enterItemId ?? value.enter_item_id ?? value.id);
    if (Number.isInteger(id) && id > 0) return id;
  } catch {}
  const values = content.match(/\d+/g);
  return Number(values?.at(-1));
}

export async function confirm(content: string, userId: number, userName: string) {
  const itemId = parseItemId(content.trim());
  if (!Number.isInteger(itemId) || itemId <= 0) throw new AppError(400, "INVALID_RETURN_CODE", "未识别到有效的退货花材编号");
  const result = await repo.confirmReturn(itemId, userId, userName);
  if (result.kind === "not_found") throw new AppError(404, "RETURN_ITEM_NOT_FOUND", "未找到对应花材");
  if (result.kind === "not_return") throw new AppError(400, "NOT_RETURN_ITEM", "该花材没有待确认的退货数量");
  if (result.kind === "confirmed") throw new AppError(409, "RETURN_ALREADY_CONFIRMED", "该花材已经完成退货确认");
  return { itemId, productName: String(result.item.product_name), confirmedQuantity: num(result.item.refund_num) };
}
