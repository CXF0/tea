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

export async function list(date: string) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT id,date,user_id,user_name,manage_id,manage_name,start_manage_name,end_manage_name,
            DATE_FORMAT(start_time,'%Y-%m-%d %H:%i:%s') start_time,
            DATE_FORMAT(end_time,'%Y-%m-%d %H:%i:%s') end_time,
            CASE WHEN end_time IS NULL THEN ROUND(TIMESTAMPDIFF(MINUTE,start_time,NOW())/60,2) ELSE duration END duration,
            price,total_price,settle_flag
     FROM xm_bulky_part_logistics
     WHERE date=? AND user_type=1
     ORDER BY end_time IS NOT NULL,manage_id=0 DESC,start_time DESC,id DESC`,
    [date],
  );
  return rows;
}

export async function listForLeader(date: string, userId: number) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT id,date,user_id,user_name,manage_id,manage_name,start_manage_name,end_manage_name,
            DATE_FORMAT(start_time,'%Y-%m-%d %H:%i:%s') start_time,
            DATE_FORMAT(end_time,'%Y-%m-%d %H:%i:%s') end_time,
            CASE WHEN end_time IS NULL THEN ROUND(TIMESTAMPDIFF(MINUTE,start_time,NOW())/60,2) ELSE duration END duration,
            price,total_price,settle_flag,manage_id=? assigned_to_me,
            (start_manage_id=? OR end_manage_id=?) checked_by_me
     FROM xm_bulky_part_logistics
     WHERE date=? AND user_type=1 AND (manage_id=? OR start_manage_id=? OR end_manage_id=?)
     ORDER BY end_time IS NOT NULL,start_time DESC,id DESC`,
    [userId, userId, userId, date, userId, userId, userId],
  );
  return rows;
}

export async function leaders() {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT DISTINCT a.id,a.display_name
     FROM wms_account a
     JOIN wms_role_permission_group rg ON rg.role_id=a.role_id
     JOIN wms_permission_group_item gi ON gi.group_id=rg.group_id
     JOIN wms_permission p ON p.id=gi.permission_id AND p.code='partLogistics.assign' AND p.status=1
     WHERE a.status=1 ORDER BY a.display_name,a.id`,
  );
  return rows;
}

export async function assign(ids: number[], leaderId: number) {
  const [leaders] = await database.query<RowDataPacket[]>(
    "SELECT id,display_name FROM wms_account WHERE id=? AND status=1 LIMIT 1",
    [leaderId],
  );
  if (!leaders.length) return 0;
  const [result] = await database.query<any>(
    `UPDATE xm_bulky_part_logistics
     SET manage_id=?,manage_name=?
     WHERE id IN (?) AND user_type=1 AND end_time IS NULL`,
    [leaderId, String(leaders[0].display_name), ids],
  );
  return Number(result.affectedRows || 0);
}
