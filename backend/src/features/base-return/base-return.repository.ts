import type { RowDataPacket } from '../../database.js';
import { database } from "../../database.js";

export async function hasCapability(accountId: number, capability: string) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT 1
       FROM wms_account account
       JOIN wms_role_permission_group role_group ON role_group.role_id=account.role_id
       JOIN wms_permission_group permission_group ON permission_group.id=role_group.group_id AND permission_group.status=1
       JOIN wms_permission_group_item group_item ON group_item.group_id=permission_group.id
       JOIN wms_permission permission ON permission.id=group_item.permission_id AND permission.status=1
      WHERE account.id=? AND account.status=1 AND permission.code=? LIMIT 1`,
    [accountId, capability],
  );
  return rows.length > 0;
}

export async function listBases() {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT id,name FROM xm_bulky_user_tag
      WHERE type=2 AND tag_category='基地' ORDER BY id`,
  );
  return rows;
}

export async function listSupplierReturns(date: string, baseTagId?: number) {
  const params: Array<string | number> = [date];
  const baseClause = baseTagId ? "AND tag.id=?" : "";
  if (baseTagId) params.push(baseTagId);
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT supplier.id supplier_id,supplier.supplier_name,tag.id base_id,tag.name base_name,
            SUM(item.refund_num) refund_num,
            SUM(CASE WHEN item.is_confirm_refund_num=1 THEN item.refund_num ELSE 0 END) confirm_num
       FROM xm_bulky_supplier_enter_item item
       JOIN xm_bulky_supplier supplier ON supplier.id=item.supplier_id
       JOIN xm_bulky_supplier_tag supplier_tag ON supplier_tag.supplier_id=supplier.id
       JOIN xm_bulky_user_tag tag ON tag.id=supplier_tag.tag_id AND tag.type=2 AND tag.tag_category='基地'
      WHERE item.date=? AND item.data_status=0 AND item.refund_num>0 ${baseClause}
      GROUP BY supplier.id,supplier.supplier_name,tag.id,tag.name
      ORDER BY (SUM(CASE WHEN item.is_confirm_refund_num=1 THEN item.refund_num ELSE 0 END)>=SUM(item.refund_num)),supplier.supplier_name`,
    params,
  );
  return rows;
}

export async function confirmReturn(itemId: number, userId: number, userName: string) {
  const connection = await database.getConnection();
  try {
    await connection.beginTransaction();
    const [rows] = await connection.query<RowDataPacket[]>(
      `SELECT id,date,product_name,refund_num,is_confirm_refund_num
         FROM xm_bulky_supplier_enter_item
        WHERE id=? AND data_status=0 FOR UPDATE`,
      [itemId],
    );
    const item = rows[0];
    if (!item) { await connection.rollback(); return { kind: "not_found" as const }; }
    if (Number(item.refund_num) <= 0) { await connection.rollback(); return { kind: "not_return" as const }; }
    if (Number(item.is_confirm_refund_num) === 1) { await connection.rollback(); return { kind: "confirmed" as const, item }; }
    await connection.execute(
      `UPDATE xm_bulky_supplier_enter_item
          SET is_confirm_refund_num=1,re_qualify_user_id=?,re_qualify_user_name=?,update_time=NOW()
        WHERE id=?`,
      [userId, userName, itemId],
    );
    await connection.commit();
    return { kind: "success" as const, item };
  } catch (error) {
    await connection.rollback();
    throw error;
  } finally {
    connection.release();
  }
}
