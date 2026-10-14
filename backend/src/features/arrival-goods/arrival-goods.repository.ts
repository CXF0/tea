import type { RowDataPacket } from '../../database.js';
import { database } from "../../database.js";

export async function hasCapability(accountId: number, capability: string) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT 1
       FROM wms_account account
       JOIN wms_role_permission_group role_group ON role_group.role_id = account.role_id
       JOIN wms_permission_group_item group_item ON group_item.group_id = role_group.group_id
       JOIN wms_permission permission ON permission.id = group_item.permission_id AND permission.status = 1
      WHERE account.id = ? AND account.status = 1 AND permission.code = ?
      LIMIT 1`,
    [accountId, capability],
  );
  return rows.length > 0;
}

export async function listArrivalGoods(q: {
  date: string;
  type: string;
  keyword: string;
  page: number;
  size: number;
}) {
  const clauses = ["item.date = ?", "item.data_status = 0"];
  const params: Array<string | number> = [q.date];
  if (q.keyword) {
    clauses.push("(item.product_name LIKE ? OR entry.supplier_name LIKE ? OR item.zone_shelf LIKE ?)");
    params.push(`%${q.keyword}%`, `%${q.keyword}%`, `%${q.keyword}%`);
  }
  if (q.type === "selfPickup") clauses.push("(COALESCE(ord.delivery_type, 0) IN (2, 3) OR COALESCE(ord.distribution_type, 0) = 2)");
  if (q.type === "unlabeled") clauses.push("item.supplier_id = 0 OR entry.supplier_name LIKE '%无标签%'");
  if (q.type === "outbound") clauses.push("COALESCE(item.prepare_item_num, 0) > 0");
  if (q.type === "stock") clauses.push("(CAST(item.item_num AS SIGNED) - CAST(COALESCE(item.prepare_item_num, 0) AS SIGNED) - CAST(COALESCE(item.not_qualify_num, 0) AS SIGNED)) > 0");
  const where = clauses.join(" AND ");
  const joins = `FROM xm_bulky_supplier_enter_item item
    JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
    LEFT JOIN xm_bulky_order ord ON ord.order_sn = item.order_sn AND ord.data_status = 0`;
  const [summaryRows] = await database.query<RowDataPacket[]>(
    `SELECT COUNT(*) total_items,
            COALESCE(SUM(item.item_num), 0) acquired_units,
            COALESCE(SUM(GREATEST(CAST(item.item_num AS SIGNED) - CAST(COALESCE(item.prepare_item_num, 0) AS SIGNED) - CAST(COALESCE(item.not_qualify_num, 0) AS SIGNED), 0)), 0) stock_units,
            COALESCE(SUM(COALESCE(item.prepare_item_num, 0)), 0) outbound_units,
            COALESCE(SUM(CASE WHEN COALESCE(ord.delivery_type, 0) IN (2, 3) OR COALESCE(ord.distribution_type, 0) = 2 THEN item.item_num ELSE 0 END), 0) self_pickup_units,
            COALESCE(SUM(CASE WHEN item.supplier_id = 0 OR entry.supplier_name LIKE '%无标签%' THEN item.item_num ELSE 0 END), 0) unlabeled_units
       ${joins}
      WHERE ${where}`,
    params,
  );
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT item.id, item.date, item.product_name, item.rank_num, item.sku_config,
            item.item_num, COALESCE(item.prepare_item_num, 0) prepare_item_num,
            COALESCE(item.not_qualify_num, 0) not_qualify_num,
            GREATEST(CAST(item.item_num AS SIGNED) - CAST(COALESCE(item.prepare_item_num, 0) AS SIGNED) - CAST(COALESCE(item.not_qualify_num, 0) AS SIGNED), 0) available_num,
            item.zone_shelf, item.sub_shelf_sn, item.supplier_id, entry.supplier_name,
            CASE WHEN COALESCE(ord.delivery_type, 0) IN (2, 3) OR COALESCE(ord.distribution_type, 0) = 2 THEN 1 ELSE 0 END self_take_type,
            DATE_FORMAT(item.create_time, '%Y-%m-%d %H:%i:%s') create_time
       ${joins}
      WHERE ${where}
      ORDER BY item.create_time DESC, item.id DESC
      LIMIT ? OFFSET ?`,
    [...params, q.size, (q.page - 1) * q.size],
  );
  return { summary: summaryRows[0] ?? {}, rows };
}
