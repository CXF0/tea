import type { RowDataPacket } from '../../database.js';
import { database } from "../../database.js";

export async function listMessages(userId: number, limit = 50) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT m.id,m.msg_type,m.biz_type,m.biz_id,m.title,m.content,m.creator_name,
      IF(r.id IS NULL,0,1) AS is_read,
      DATE_FORMAT(m.create_time,'%Y-%m-%d %H:%i:%s') create_time
     FROM logistics_message m
     LEFT JOIN logistics_message_read r
       ON r.message_id=m.id AND r.reader_type=1 AND r.read_key=?
     WHERE m.data_status=0
     ORDER BY m.create_time DESC,m.id DESC
     LIMIT ?`,
    [String(userId), limit],
  );
  return rows;
}

export async function unreadCount(userId: number) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT COUNT(1) AS total
     FROM logistics_message m
     LEFT JOIN logistics_message_read r
       ON r.message_id=m.id AND r.reader_type=1 AND r.read_key=?
     WHERE m.data_status=0 AND r.id IS NULL`,
    [String(userId)],
  );
  return Number(rows[0]?.total || 0);
}

export async function markRead(userId: number, userName: string, messageId: number) {
  await database.query(
    `INSERT IGNORE INTO logistics_message_read
      (message_id,reader_type,read_key,read_account_type,read_account_id,read_name,read_time)
     VALUES (?,1,?,1,?,?,NOW())`,
    [messageId, String(userId), userId, userName || ""],
  );
  return unreadCount(userId);
}
