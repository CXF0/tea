import type { RowDataPacket } from '../../database.js';
import { database } from "../../database.js";

export async function hasCapability(accountId: number, capability: string) {
  const [rows] = await database.query<RowDataPacket[]>(`SELECT 1 FROM wms_account a JOIN wms_role_permission_group rg ON rg.role_id=a.role_id JOIN wms_permission_group g ON g.id=rg.group_id AND g.status=1 JOIN wms_permission_group_item gi ON gi.group_id=g.id JOIN wms_permission p ON p.id=gi.permission_id AND p.status=1 WHERE a.id=? AND a.status=1 AND p.code=? LIMIT 1`, [accountId, capability]);
  return rows.length > 0;
}

export async function demands(roundNo: string, status: number, keyword: string) {
  const clauses = ["1=1"], params: Array<string | number> = [];
  if (roundNo) { clauses.push("d.round_no=?"); params.push(roundNo); }
  if (status >= 0) { clauses.push("d.status=?"); params.push(status); }
  if (keyword) { clauses.push("(d.demand_no LIKE ? OR d.theme LIKE ? OR d.second_name LIKE ?)"); params.push(`%${keyword}%`, `%${keyword}%`, `%${keyword}%`); }
  const [rows] = await database.query<RowDataPacket[]>(`SELECT d.id,d.demand_no demandNo,d.theme,d.publish_supplier_name publishSupplierName,d.round_no roundNo,d.second_name secondName,d.spec_num specNum,d.spec_unit specUnit,d.rank_codes rankCodes,d.demand_num demandNum,d.append_num appendNum,d.min_quote_num minQuoteNum,d.scope_type scopeType,DATE_FORMAT(d.dounan_quote_end_time,'%Y-%m-%d %H:%i') dounanQuoteEndTime,DATE_FORMAT(d.non_dounan_quote_end_time,'%Y-%m-%d %H:%i') nonDounanQuoteEndTime,d.status,d.confirm_name confirmName,DATE_FORMAT(d.confirm_time,'%Y-%m-%d %H:%i') confirmTime,d.remark,DATE_FORMAT(d.create_time,'%Y-%m-%d %H:%i') createTime,(SELECT COUNT(*) FROM bulk_purchase_quote q WHERE q.demand_id=d.id) quoteCount,(SELECT COUNT(*) FROM bulk_purchase_order o WHERE o.demand_id=d.id) orderCount FROM bulk_purchase_demand d WHERE ${clauses.join(" AND ")} ORDER BY d.round_no DESC,d.id DESC`, params);
  return rows;
}

export async function demandDetail(id: number) {
  const [demandRows] = await database.query<RowDataPacket[]>(`SELECT d.id,d.demand_no demandNo,d.theme,d.publish_supplier_id publishSupplierId,d.publish_supplier_name publishSupplierName,d.round_no roundNo,d.second_id secondId,d.second_name secondName,d.spec_num specNum,d.spec_unit specUnit,d.rank_codes rankCodes,d.demand_num demandNum,d.append_num appendNum,d.min_quote_num minQuoteNum,d.scope_type scopeType,d.scope_config scopeConfig,DATE_FORMAT(d.dounan_quote_end_time,'%Y-%m-%d %H:%i') dounanQuoteEndTime,DATE_FORMAT(d.non_dounan_quote_end_time,'%Y-%m-%d %H:%i') nonDounanQuoteEndTime,DATE_FORMAT(d.dounan_check_in_end_time,'%Y-%m-%d %H:%i') dounanCheckInEndTime,DATE_FORMAT(d.non_dounan_check_in_end_time,'%Y-%m-%d %H:%i') nonDounanCheckInEndTime,DATE_FORMAT(d.collect_end_time,'%Y-%m-%d %H:%i') collectEndTime,d.status,d.confirm_name confirmName,DATE_FORMAT(d.confirm_time,'%Y-%m-%d %H:%i') confirmTime,d.remark,d.create_name createName,DATE_FORMAT(d.create_time,'%Y-%m-%d %H:%i') createTime,(SELECT COUNT(DISTINCT ds.supplier_id) FROM bulk_purchase_demand_supplier ds WHERE ds.demand_id=d.id) eligibleSupplierCount,(SELECT COUNT(DISTINCT q.supplier_id) FROM bulk_purchase_quote q WHERE q.demand_id=d.id AND q.is_current=1) quotedSupplierCount,(SELECT COALESCE(SUM(o.confirm_num),0) FROM bulk_purchase_order o WHERE o.demand_id=d.id AND o.status<>90) confirmedQuantity FROM bulk_purchase_demand d WHERE d.id=? LIMIT 1`, [id]);
  if (!demandRows.length) return null;
  const demand = demandRows[0] as any;
  const [quoteRows] = await database.query<RowDataPacket[]>(`SELECT q.id,q.quote_no quoteNo,q.supplier_id supplierId,q.supplier_name supplierName,q.total_supply_num totalSupplyNum,q.select_status selectStatus,DATE_FORMAT(q.submit_time,'%Y-%m-%d %H:%i') submitTime,ds.supplier_tag supplierTag,ds.is_dounan isDounan,qr.rank_code rankCode,qr.price FROM bulk_purchase_quote q LEFT JOIN bulk_purchase_demand_supplier ds ON ds.demand_id=q.demand_id AND ds.supplier_id=q.supplier_id LEFT JOIN bulk_purchase_quote_rank qr ON qr.quote_id=q.id WHERE q.demand_id=? AND q.is_current=1 ORDER BY q.select_status DESC,q.total_supply_num DESC,q.id,qr.rank_code`, [id]);
  const quoteMap = new Map<number, any>();
  for (const row of quoteRows as any[]) {
    let quote = quoteMap.get(row.id);
    if (!quote) {
      quote = { id: row.id, quoteNo: row.quoteNo, supplierId: row.supplierId, supplierName: row.supplierName, supplierTag: row.supplierTag || "", isDounan: Number(row.isDounan || 0), totalSupplyNum: Number(row.totalSupplyNum || 0), selectStatus: Number(row.selectStatus || 0), submitTime: row.submitTime || "", rankPrices: [] };
      quoteMap.set(row.id, quote);
    }
    if (row.rankCode !== null) quote.rankPrices.push({ rankCode: Number(row.rankCode), price: Number(row.price || 0) });
  }
  const [orderRows] = await database.query<RowDataPacket[]>(`SELECT o.id,o.order_no orderNo,o.shelf_code shelfCode,o.supplier_id supplierId,o.supplier_name supplierName,o.total_supply_num totalSupplyNum,o.confirm_num confirmNum,o.actual_num actualNum,o.settle_num settleNum,o.total_amount totalAmount,o.status,DATE_FORMAT(o.check_in_end_time,'%Y-%m-%d %H:%i') checkInEndTime,DATE_FORMAT(o.check_in_time,'%Y-%m-%d %H:%i') checkInTime,DATE_FORMAT(o.settle_time,'%Y-%m-%d %H:%i') settleTime FROM bulk_purchase_order o WHERE o.demand_id=? ORDER BY o.id`, [id]);
  return { demand, quotes: [...quoteMap.values()], orders: orderRows };
}

export async function orders(roundNo: string, status: number, keyword: string) {
  const clauses = ["1=1"], params: Array<string | number> = [];
  if (roundNo) { clauses.push("o.round_no=?"); params.push(roundNo); }
  if (status >= 0) { clauses.push("o.status=?"); params.push(status); }
  if (keyword) { clauses.push("(o.order_no LIKE ? OR o.shelf_code LIKE ? OR o.supplier_name LIKE ? OR o.second_name LIKE ?)"); params.push(`%${keyword}%`, `%${keyword}%`, `%${keyword}%`, `%${keyword}%`); }
  const [rows] = await database.query<RowDataPacket[]>(`SELECT o.id,o.order_no orderNo,o.shelf_code shelfCode,o.demand_no demandNo,o.supplier_name supplierName,o.supplier_tag supplierTag,o.is_dounan isDounan,o.round_no roundNo,o.second_name secondName,o.spec_num specNum,o.total_supply_num totalSupplyNum,o.confirm_num confirmNum,DATE_FORMAT(o.check_in_end_time,'%Y-%m-%d %H:%i') checkInEndTime,DATE_FORMAT(o.check_in_time,'%Y-%m-%d %H:%i') checkInTime,o.plate_no plateNo,o.late_flag lateFlag,o.actual_num actualNum,o.settle_num settleNum,o.total_amount totalAmount,o.settle_flag settleFlag,o.status,o.inventory_submit_name inventorySubmitName,DATE_FORMAT(o.inventory_submit_time,'%Y-%m-%d %H:%i') inventorySubmitTime,DATE_FORMAT(o.create_time,'%Y-%m-%d %H:%i') createTime,(SELECT COUNT(*) FROM bulk_purchase_label l WHERE l.order_id=o.id AND l.status=10) unscannedLabelCount,(SELECT COUNT(*) FROM bulk_purchase_label l WHERE l.order_id=o.id AND l.status=30) scannedLabelCount FROM bulk_purchase_order o WHERE ${clauses.join(" AND ")} ORDER BY o.round_no DESC,o.id DESC`, params);
  return rows;
}
