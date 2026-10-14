import type { RowDataPacket } from '../../database.js';
import { database } from "../../database.js";

export async function hasCapability(accountId:number, capability:string){const [rows]=await database.query<RowDataPacket[]>(`SELECT 1 FROM wms_account a JOIN wms_role_permission_group rg ON rg.role_id=a.role_id JOIN wms_permission_group g ON g.id=rg.group_id AND g.status=1 JOIN wms_permission_group_item gi ON gi.group_id=g.id JOIN wms_permission p ON p.id=gi.permission_id AND p.status=1 WHERE a.id=? AND a.status=1 AND p.code=? LIMIT 1`,[accountId,capability]);return rows.length>0}
export async function filters(date:string){const [bases]=await database.query<RowDataPacket[]>(`SELECT DISTINCT base_name name FROM xm_peasant_order WHERE date=? AND data_status=0 AND base_name<>'' ORDER BY base_name`,[date]);const [suppliers]=await database.query<RowDataPacket[]>(`SELECT DISTINCT o.peasant_supplier_id id,COALESCE(NULLIF(s.supplier_name,''),CONCAT('农资供应商',o.peasant_supplier_id)) name FROM xm_peasant_order o LEFT JOIN xm_bulky_supplier s ON s.id=o.peasant_supplier_id WHERE o.date=? AND o.data_status=0 ORDER BY name`,[date]);return{bases,suppliers}}
export async function listOrders(date:string,status:number,keyword:string,baseName:string,supplierId:number){const clauses=['o.date=?','o.data_status=0'];const params:Array<string|number>=[date];if(status){clauses.push('o.order_status=?');params.push(status)}if(keyword){clauses.push('(o.order_id LIKE ? OR buyer.supplier_name LIKE ?)');params.push(`%${keyword}%`,`%${keyword}%`)}if(baseName){clauses.push('o.base_name=?');params.push(baseName)}if(supplierId){clauses.push('o.peasant_supplier_id=?');params.push(supplierId)}const [rows]=await database.query<RowDataPacket[]>(`SELECT o.*,DATE_FORMAT(o.create_time,'%Y-%m-%d %H:%i:%s') create_time,DATE_FORMAT(o.ship_time,'%Y-%m-%d %H:%i:%s') ship_time,DATE_FORMAT(o.complete_time,'%Y-%m-%d %H:%i:%s') complete_time,COALESCE(NULLIF(buyer.supplier_name,''),CONCAT('供应商',o.buy_supplier_id)) buy_supplier_name,COALESCE(NULLIF(peasant.supplier_name,''),CONCAT('农资供应商',o.peasant_supplier_id)) peasant_supplier_name,COALESCE(SUM(i.num),0) goods_count,COUNT(i.id) item_count FROM xm_peasant_order o LEFT JOIN xm_peasant_order_item i ON i.order_id=o.order_id AND i.data_status=0 LEFT JOIN xm_bulky_supplier buyer ON buyer.id=o.buy_supplier_id LEFT JOIN xm_bulky_supplier peasant ON peasant.id=o.peasant_supplier_id WHERE ${clauses.join(' AND ')} GROUP BY o.id ORDER BY o.create_time DESC,o.id DESC`,params);return rows}
export async function findOrder(orderId:string){const [orders]=await database.query<RowDataPacket[]>(`SELECT o.*,DATE_FORMAT(o.create_time,'%Y-%m-%d %H:%i:%s') create_time,DATE_FORMAT(o.ship_time,'%Y-%m-%d %H:%i:%s') ship_time,DATE_FORMAT(o.complete_time,'%Y-%m-%d %H:%i:%s') complete_time,COALESCE(NULLIF(buyer.supplier_name,''),CONCAT('供应商',o.buy_supplier_id)) buy_supplier_name,COALESCE(NULLIF(peasant.supplier_name,''),CONCAT('农资供应商',o.peasant_supplier_id)) peasant_supplier_name FROM xm_peasant_order o LEFT JOIN xm_bulky_supplier buyer ON buyer.id=o.buy_supplier_id LEFT JOIN xm_bulky_supplier peasant ON peasant.id=o.peasant_supplier_id WHERE o.order_id=? AND o.data_status=0 LIMIT 1`,[orderId]);const [items]=await database.query<RowDataPacket[]>(`SELECT * FROM xm_peasant_order_item WHERE order_id=? AND data_status=0 ORDER BY id`,[orderId]);return{order:orders[0],items}}
export async function printRows(date:string,supplierId:number){const clauses=['o.date=?','o.data_status=0'];const params:Array<string|number>=[date];if(supplierId){clauses.push('o.peasant_supplier_id=?');params.push(supplierId)}const [rows]=await database.query<RowDataPacket[]>(`SELECT o.order_id,o.base_name,o.date session_date,o.peasant_supplier_id,COALESCE(NULLIF(s.supplier_name,''),CONCAT('农资供应商',o.peasant_supplier_id)) supplier_name,COALESCE(SUM(i.num),0) goods_count FROM xm_peasant_order o LEFT JOIN xm_peasant_order_item i ON i.order_id=o.order_id AND i.data_status=0 LEFT JOIN xm_bulky_supplier s ON s.id=o.peasant_supplier_id WHERE ${clauses.join(' AND ')} GROUP BY o.id ORDER BY supplier_name,o.order_id`,params);return rows}

export async function deliverySummaries(date:string,baseName:string,supplierId:number,keyword:string){
  const clauses=['o.date=?','o.data_status=0','i.data_status=0'];const params:Array<string|number>=[date];
  if(baseName){clauses.push('o.base_name=?');params.push(baseName)}
  if(supplierId){clauses.push('o.peasant_supplier_id=?');params.push(supplierId)}
  if(keyword){clauses.push('(i.goods_info LIKE ? OR i.sku_info LIKE ?)');params.push(`%${keyword}%`,`%${keyword}%`)}
  const [rows]=await database.query<RowDataPacket[]>(`SELECT i.goods_id,i.sku_id,MAX(i.img) image,MAX(i.goods_info) goods_name,MAX(i.sku_info) sku_name,SUM(i.num) total_count,COUNT(DISTINCT o.order_id) order_count FROM xm_peasant_order_item i JOIN xm_peasant_order o ON o.order_id=i.order_id WHERE ${clauses.join(' AND ')} GROUP BY i.goods_id,i.sku_id ORDER BY goods_name,sku_name`,params);return rows
}

export async function deliverySuppliers(date:string,goodsId:number,skuId:number,baseName:string,supplierId:number){
  const clauses=['o.date=?','o.data_status=0','i.data_status=0','i.goods_id=?','i.sku_id=?'];const params:Array<string|number>=[date,goodsId,skuId];
  if(baseName){clauses.push('o.base_name=?');params.push(baseName)}if(supplierId){clauses.push('o.peasant_supplier_id=?');params.push(supplierId)}
  const [rows]=await database.query<RowDataPacket[]>(`SELECT o.buy_supplier_id supplier_id,COALESCE(NULLIF(s.supplier_name,''),CONCAT('供应商',o.buy_supplier_id)) supplier_name,SUM(i.num) purchase_count,MIN(o.order_status) min_status,MAX(o.order_status) max_status,COUNT(DISTINCT o.order_id) order_count FROM xm_peasant_order_item i JOIN xm_peasant_order o ON o.order_id=i.order_id LEFT JOIN xm_bulky_supplier s ON s.id=o.buy_supplier_id WHERE ${clauses.join(' AND ')} GROUP BY o.buy_supplier_id,s.supplier_name ORDER BY supplier_name`,params);return rows
}

export async function updateOrderStatus(orderId:string,fromStatus:number,toStatus:number,picture:string,userId:number,userName:string){
  const fields=fromStatus===1?'order_status=?,ship_time=NOW(),ship_pic=?,update_time=NOW()':'order_status=?,complete_time=NOW(),complete_pic=?,complete_user_id=?,complete_user_name=?,update_time=NOW()';
  const params=fromStatus===1?[toStatus,picture,orderId,fromStatus]:[toStatus,picture,userId,userName,orderId,fromStatus];
  const [result]:any=await database.execute(`UPDATE xm_peasant_order SET ${fields} WHERE order_id=? AND order_status=? AND data_status=0`,params);return Number(result.affectedRows)>0
}

function periodClause(mode:string,date:string,alias='o'){
  if(mode==='month')return{clause:`${alias}.date LIKE ?`,params:[`${date.slice(0,7)}-%`]};
  return{clause:`${alias}.date=?`,params:[date]};
}

export async function dashboardOverview(mode:string,date:string,compareDate:string){
  const current=periodClause(mode,date);
  const previous=periodClause(mode,compareDate);
  const sql=(clause:string)=>`SELECT COUNT(DISTINCT o.order_id) order_count,COALESCE(SUM(o.total_price),0) sales_amount,COUNT(DISTINCT o.buy_supplier_id) supplier_count,COUNT(DISTINCT o.base_name) base_count FROM xm_peasant_order o WHERE o.data_status=0 AND ${clause}`;
  const [currentRows]=await database.query<RowDataPacket[]>(sql(current.clause),current.params);
  const [previousRows]=await database.query<RowDataPacket[]>(sql(previous.clause),previous.params);
  return{current:currentRows[0]??{},previous:previousRows[0]??{}};
}

export async function dashboardProductSales(mode:string,date:string){
  const period=periodClause(mode,date);
  const [rows]=await database.query<RowDataPacket[]>(`SELECT COALESCE(NULLIF(i.goods_info,''),'未命名商品') name,SUM(i.num) quantity,COALESCE(SUM(i.total_price),0) amount FROM xm_peasant_order o JOIN xm_peasant_order_item i ON i.order_id=o.order_id AND i.data_status=0 WHERE o.data_status=0 AND ${period.clause} GROUP BY i.goods_info ORDER BY amount DESC,quantity DESC`,period.params);
  return rows;
}

export async function dashboardSalesTrend(endDate:string){
  const [rows]=await database.query<RowDataPacket[]>(`SELECT o.date,COUNT(DISTINCT o.order_id) order_count,COALESCE(SUM(o.total_price),0) sales_amount FROM xm_peasant_order o WHERE o.data_status=0 AND o.date BETWEEN DATE_FORMAT(DATE_SUB(?,INTERVAL 6 DAY),'%Y-%m-%d') AND ? GROUP BY o.date ORDER BY o.date`,[endDate,endDate]);
  return rows;
}
