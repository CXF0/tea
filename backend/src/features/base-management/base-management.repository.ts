import type { RowDataPacket } from '../../database.js';
import { database } from "../../database.js";

export async function listBases(date: string, accountId: number) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT tag.id,tag.name,
 COUNT(DISTINCT st.supplier_id) supplier_count,COUNT(DISTINCT CASE WHEN e.date=? THEN e.supplier_id END) arrival_supplier_count,
 COALESCE(SUM(CASE WHEN i.date=? AND i.data_status=0 THEN i.item_num ELSE 0 END),0) inbound_num,
 COALESCE(SUM(CASE WHEN i.date=? AND i.data_status=0 THEN i.prepare_item_num ELSE 0 END),0) allocated_num,
 COUNT(DISTINCT CASE WHEN i.date=? AND i.data_status=0 THEN i.product_id END) product_count
 FROM wms_account_base_permission access JOIN xm_bulky_user_tag tag ON tag.id=access.base_tag_id LEFT JOIN xm_bulky_supplier_tag st ON st.tag_id=tag.id
 LEFT JOIN xm_bulky_supplier_enter e ON e.supplier_id=st.supplier_id AND e.date=?
 LEFT JOIN xm_bulky_supplier_enter_item i ON i.enter_id=e.id AND i.data_status=0
 WHERE access.account_id=? AND tag.type=2 AND tag.tag_category='基地' GROUP BY tag.id,tag.name,access.sort_order
 ORDER BY access.sort_order,tag.id`,
    [date, date, date, date, date, accountId],
  );
  return rows;
}

export async function getBase(tagId: number, date: string) {
  const [summary] = await database.query<RowDataPacket[]>(
    `SELECT tag.id,tag.name,
 COUNT(DISTINCT st.supplier_id) supplier_count,COUNT(DISTINCT CASE WHEN e.data_status=1 THEN e.supplier_id END) admitted_count,
 COUNT(DISTINCT i.product_id) product_count,COALESCE(SUM(i.item_num),0) inbound_num,
 COALESCE(SUM(i.prepare_item_num),0) allocated_num,
 COALESCE(SUM(GREATEST(i.item_num-i.prepare_item_num-i.refund_num-i.return_num,0)),0) stock_num
 FROM xm_bulky_user_tag tag LEFT JOIN xm_bulky_supplier_tag st ON st.tag_id=tag.id
 LEFT JOIN xm_bulky_supplier_enter e ON e.supplier_id=st.supplier_id AND e.date=?
 LEFT JOIN xm_bulky_supplier_enter_item i ON i.enter_id=e.id AND i.data_status=0
 WHERE tag.id=? AND tag.type=2 AND tag.tag_category='基地' GROUP BY tag.id,tag.name`,
    [date, tagId],
  );
  const [suppliers] = await database.query<RowDataPacket[]>(
    `SELECT s.id,s.supplier_name,s.login_tel,e.id admission_id,e.data_status,
 COUNT(DISTINCT i.product_id) product_count,COALESCE(SUM(i.item_num),0) inbound_num,COALESCE(SUM(i.prepare_item_num),0) allocated_num,
 COALESCE(SUM(GREATEST(i.item_num-i.prepare_item_num-i.refund_num-i.return_num,0)),0) stock_num
 FROM xm_bulky_supplier_tag st JOIN xm_bulky_supplier s ON s.id=st.supplier_id
 LEFT JOIN xm_bulky_supplier_enter e ON e.supplier_id=s.id AND e.date=?
 LEFT JOIN xm_bulky_supplier_enter_item i ON i.enter_id=e.id AND i.data_status=0
 WHERE st.tag_id=? GROUP BY s.id,s.supplier_name,s.login_tel,e.id,e.data_status ORDER BY inbound_num DESC,s.supplier_name`,
    [date, tagId],
  );
  return { summary: summary[0], suppliers };
}

export async function getBaseZoneItems(tagId: number, date: string) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT COALESCE(NULLIF(item.zone,''),SUBSTRING_INDEX(item.zone_shelf,'-',1),'') zone_code,
            item.product_id,item.product_name,item.rank_num,supplier.supplier_name,
            COALESCE(SUM(item.item_num),0) frame_count
       FROM xm_bulky_supplier_enter_item item
       JOIN xm_bulky_supplier_tag supplier_tag
         ON supplier_tag.supplier_id=item.supplier_id AND supplier_tag.tag_id=?
       JOIN xm_bulky_supplier supplier ON supplier.id=item.supplier_id
      WHERE item.date=? AND item.data_status=0
      GROUP BY zone_code,item.product_id,item.product_name,item.rank_num,supplier.supplier_name
      ORDER BY CAST(zone_code AS UNSIGNED),zone_code,item.product_name,item.rank_num,supplier.supplier_name`,
    [tagId, date],
  );
  return rows;
}

export async function getSupplier(supplierId: number, date: string) {
  const [profile] = await database.query<RowDataPacket[]>(
    `SELECT s.id,s.supplier_name,s.login_tel,tag.name base_name FROM xm_bulky_supplier s LEFT JOIN xm_bulky_supplier_tag st ON st.supplier_id=s.id LEFT JOIN xm_bulky_user_tag tag ON tag.id=st.tag_id AND tag.type=2 AND tag.tag_category='基地' WHERE s.id=? LIMIT 1`,
    [supplierId],
  );
  const [items] = await database.query<RowDataPacket[]>(
    `SELECT i.product_id,i.product_name,i.rank_num,i.sku_config,MAX(product.price) price,
            SUM(i.item_num) inbound_num,SUM(i.prepare_item_num) allocated_num,
            SUM(GREATEST(i.item_num-i.prepare_item_num-i.refund_num-i.return_num,0)) stock_num
       FROM xm_bulky_supplier_enter_item i
       LEFT JOIN xm_bulky_product product ON product.id=i.product_id
      WHERE i.supplier_id=? AND i.date=? AND i.data_status=0
      GROUP BY i.product_id,i.product_name,i.rank_num,i.sku_config
      ORDER BY stock_num DESC,i.product_name`,
    [supplierId, date],
  );
  const [statistics] = await database.query<RowDataPacket[]>(
    `SELECT
       (SELECT COUNT(DISTINCT product.second_id) FROM xm_bulky_product product WHERE product.supplier_id=? AND product.product_status=1 AND product.data_status=0) sale_variety_count,
       (SELECT COUNT(DISTINCT permission.second_id) FROM xm_bulky_supplier_class_second permission WHERE permission.supplier_id=? AND permission.data_status=0) authorized_variety_count,
       (SELECT COALESCE(SUM(order_item.item_num),0) FROM xm_bulky_order_item order_item WHERE order_item.supplier_id=? AND DATE(order_item.create_time)=? AND order_item.data_status=0) normal_sales,
       (SELECT COUNT(DISTINCT order_item.order_sn) FROM xm_bulky_order_item order_item WHERE order_item.supplier_id=? AND DATE(order_item.create_time)=? AND order_item.data_status=0) sold_order_count,
       (SELECT COALESCE(SUM(order_item.item_num),0) FROM xm_bulky_order_item order_item JOIN xm_bulky_order order_record ON order_record.order_sn=order_item.order_sn WHERE order_item.supplier_id=? AND DATE(order_item.create_time)=? AND order_item.data_status=0 AND order_record.is_sale_agency=1) agency_sales`,
    [
      supplierId,
      supplierId,
      supplierId,
      date,
      supplierId,
      date,
      supplierId,
      date,
    ],
  );
  const [permissions] = await database.query<RowDataPacket[]>(
    `SELECT permission.second_id,category.name,permission.rank_auth
       FROM xm_bulky_supplier_class_second permission
       JOIN xm_bulky_category category ON category.id=permission.second_id AND category.data_status=0
      WHERE permission.supplier_id=? AND permission.data_status=0
      ORDER BY category.sort_num,category.name`,
    [supplierId],
  );
  return { profile: profile[0], items, statistics: statistics[0], permissions };
}

export async function getSupplierPrintItems(supplierId: number, date: string) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT item.id,item.product_name,item.rank_num,item.zone_shelf,item.sub_shelf_sn,item.item_num,
            MAX(CASE WHEN reason.op=12 AND reason.data_status=0 THEN 1 ELSE 0 END) exchange_mark
       FROM xm_bulky_supplier_enter_item item
       LEFT JOIN xm_inspection_reason_record reason
         ON reason.enter_item_id=item.id AND reason.date=item.date
      WHERE item.supplier_id=? AND item.date=? AND item.data_status=0
      GROUP BY item.id,item.product_name,item.rank_num,item.zone_shelf,item.sub_shelf_sn,item.item_num
      ORDER BY item.zone_shelf,item.sub_shelf_sn,item.id`,
    [supplierId, date],
  );
  return rows;
}
