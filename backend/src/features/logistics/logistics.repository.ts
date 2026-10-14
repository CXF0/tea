import type { RowDataPacket } from '../../database.js';
import { database } from "../../database.js";

export async function hasCapability(userId: number, capability: string) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT 1 FROM wms_account a
     JOIN wms_role_permission_group rg ON rg.role_id=a.role_id
     JOIN wms_permission_group g ON g.id=rg.group_id AND g.status=1
     JOIN wms_permission_group_item gi ON gi.group_id=g.id
     JOIN wms_permission p ON p.id=gi.permission_id AND p.status=1
     WHERE a.id=? AND a.status=1 AND p.code=? LIMIT 1`,
    [userId, capability],
  );
  return rows.length > 0;
}

export async function shelves(
  date: string,
  status: number,
  keyword: string,
  zone: string,
) {
  const clauses = ["p.round_no=?", "p.data_status=0"];
  const params: Array<string | number> = [date];
  if (status === 0) clauses.push("p.express_status<20", "p.self_take_type=0");
  if (status === 1) clauses.push("p.express_status>=20", "p.self_take_type=0");
  if (status === 2) clauses.push("p.self_take_type<>0");
  if (keyword) {
    clauses.push(
      "(p.zone_shelf LIKE ? OR CAST(p.shelf_sn AS CHAR) LIKE ? OR p.city LIKE ?)",
    );
    params.push(`%${keyword}%`, `%${keyword}%`, `%${keyword}%`);
  }
  if (zone) {
    clauses.push("p.zone=?");
    params.push(zone);
  }
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT p.round_no,p.shelf_sn,p.zone,p.zone_shelf,p.self_take_type,
      COUNT(*) total_num,
      SUM(p.express_status>=10) packed_num,
      SUM(p.express_status>=20) shipped_num,
      SUM(p.item_num) item_num,
      GROUP_CONCAT(DISTINCT COALESCE(NULLIF(p.package_info,''),NULLIF(p.suggest_pack_info,'')) ORDER BY p.serial_num SEPARATOR '、') package_name,
      MAX(p.express_type=1) early_shift,
      MAX(p.package_id>0 AND p.package_id<>p.suggest_pack_id) box_mismatch,
      MAX(s.restock_status=1) restock_status,
      MIN(s.delivery_time) delivery_time,
      GROUP_CONCAT(DISTINCT CASE p.express_type WHEN 1 THEN '鲜花空运早班' WHEN 2 THEN '鲜花专线普通班' WHEN 3 THEN '鲜花空运晚班' ELSE '鲜花专线' END ORDER BY p.express_type SEPARATOR '、') express_name
     FROM xm_bulky_wms_express_package p
     LEFT JOIN xm_bulky_shelf_package_status s ON s.round_no=p.round_no AND s.shelf_sn=p.shelf_sn AND s.data_status=0
     WHERE ${clauses.join(" AND ")}
     GROUP BY p.round_no,p.shelf_sn,p.zone,p.zone_shelf,p.self_take_type
     ORDER BY delivery_time,p.zone_shelf`,
    params,
  );
  return rows;
}

export async function zones(date: string) {
  const [rows] = await database.query<RowDataPacket[]>(
    "SELECT DISTINCT zone FROM xm_bulky_wms_express_package WHERE round_no=? AND data_status=0 AND zone<>'' ORDER BY CAST(zone AS UNSIGNED),zone",
    [date],
  );
  return rows.map((r) => String(r.zone));
}

export async function dashboard(date: string) {
  const [overviewRows] = await database.query<RowDataPacket[]>(
    `SELECT
      SUM(CASE WHEN self_take_type=0 THEN 1 ELSE 0 END) total_packages,
      SUM(CASE WHEN self_take_type=0 AND express_status>=10 THEN 1 ELSE 0 END) packed_packages,
      SUM(CASE WHEN self_take_type=0 AND express_status>=20 THEN 1 ELSE 0 END) outbound_packages,
      SUM(CASE WHEN self_take_type=0 AND pickup_flag=1 THEN 1 ELSE 0 END) picked_packages
     FROM xm_bulky_wms_express_package
     WHERE round_no=? AND data_status=0`,
    [date],
  );
  const [typeRows] = await database.query<RowDataPacket[]>(
    `SELECT express_type,
      CASE express_type
        WHEN 1 THEN '鲜花空运早班'
        WHEN 2 THEN '鲜花专线普通班'
        WHEN 3 THEN '鲜花空运晚班'
        ELSE '鲜花专线'
      END express_name,
      COUNT(*) total_packages,
      SUM(pickup_flag=1) picked_packages
     FROM xm_bulky_wms_express_package
     WHERE round_no=? AND data_status=0 AND self_take_type=0
     GROUP BY express_type
     ORDER BY express_type`,
    [date],
  );
  return { overview: overviewRows[0] ?? {}, types: typeRows };
}

export async function packages(date: string, shelfSn: number) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT p.*,s.receive_name,s.receive_tel,s.receive_address,s.remark,s.logistics_remark,
      DATE_FORMAT(p.package_time,'%Y-%m-%d %H:%i:%s') package_time,
      DATE_FORMAT(p.express_time,'%Y-%m-%d %H:%i:%s') express_time,
      CASE p.express_type WHEN 1 THEN '鲜花空运早班' WHEN 2 THEN '鲜花专线普通班' WHEN 3 THEN '鲜花空运晚班' ELSE '鲜花专线' END express_name
     FROM xm_bulky_wms_express_package p
     LEFT JOIN xm_bulky_send_order s ON s.send_no=p.send_no AND s.data_status=0
     WHERE p.round_no=? AND p.shelf_sn=? AND p.data_status=0
     ORDER BY p.serial_num,p.id`,
    [date, shelfSn],
  );
  return rows;
}

export async function ship(
  date: string,
  shelfSn: number,
  photos: string[],
  userId: number,
  userName: string,
) {
  await database.query(
    `UPDATE xm_bulky_wms_express_package
     SET express_status=20,ship_url=?,express_user_id=?,express_user_name=?,express_time=NOW(),update_time=NOW()
     WHERE round_no=? AND shelf_sn=? AND data_status=0 AND express_status>=10 AND express_status<20`,
    [JSON.stringify(photos), userId, userName, date, shelfSn],
  );
  await database.query(
    `UPDATE xm_bulky_shelf_package_status
     SET outbound_time=NOW(),update_time=NOW()
     WHERE round_no=? AND shelf_sn=? AND data_status=0
       AND NOT EXISTS(SELECT 1 FROM xm_bulky_wms_express_package p WHERE p.round_no=? AND p.shelf_sn=? AND p.data_status=0 AND p.express_status<20)`,
    [date, shelfSn, date, shelfSn],
  );
  return packages(date, shelfSn);
}
