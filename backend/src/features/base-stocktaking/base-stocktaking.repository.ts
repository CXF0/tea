import type { RowDataPacket } from '../../database.js';
import { database } from "../../database.js";

export async function listBases(accountId: number) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT tag.id,tag.name FROM wms_account_base_permission access
     JOIN xm_bulky_user_tag tag ON tag.id=access.base_tag_id
     WHERE access.account_id=? AND tag.type=2 AND tag.tag_category='基地'
     ORDER BY access.sort_order,tag.id`,
    [accountId],
  );
  return rows;
}

export async function listSuppliers(baseId: number, date: string, accountId: number) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT s.id,s.supplier_name,s.login_tel,
            COALESCE(SUM(i.order_item_num),0) ordinary_flower_num,
            COALESCE(SUM(i.record_num),0) inventory_num
       FROM wms_account_base_permission access
       JOIN xm_bulky_supplier_tag st ON st.tag_id=access.base_tag_id
       JOIN xm_bulky_supplier s ON s.id=st.supplier_id
       JOIN xm_bulky_supplier_enter_item i ON i.supplier_id=s.id AND i.date=? AND i.data_status=0
      WHERE access.account_id=? AND access.base_tag_id=?
      GROUP BY s.id,s.supplier_name,s.login_tel
      ORDER BY ordinary_flower_num DESC,s.id`,
    [date, accountId, baseId],
  );
  return rows;
}

export async function getSupplier(baseId: number, supplierId: number, date: string, accountId: number) {
  const [profile] = await database.query<RowDataPacket[]>(
    `SELECT s.id,s.supplier_name,s.login_tel,tag.name base_name
       FROM wms_account_base_permission access
       JOIN xm_bulky_user_tag tag ON tag.id=access.base_tag_id
       JOIN xm_bulky_supplier_tag st ON st.tag_id=tag.id
       JOIN xm_bulky_supplier s ON s.id=st.supplier_id
      WHERE access.account_id=? AND tag.id=? AND s.id=? LIMIT 1`,
    [accountId, baseId, supplierId],
  );
  const [items] = await database.query<RowDataPacket[]>(
    `SELECT i.product_id,i.product_name,i.rank_num,i.sku_config,
            SUM(i.order_item_num) total_num,SUM(i.record_num) inventory_num
       FROM xm_bulky_supplier_enter_item i
      WHERE i.supplier_id=? AND i.date=? AND i.data_status=0
      GROUP BY i.product_id,i.product_name,i.rank_num,i.sku_config
      ORDER BY i.product_name,i.rank_num`,
    [supplierId, date],
  );
  return { profile: profile[0], items };
}
