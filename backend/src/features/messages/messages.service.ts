import * as repository from "./messages.repository.js";

function typeLabel(type: number) {
  if (type === 21) return "处罚通知";
  if (type === 22) return "处罚撤销";
  if (type === 23) return "处罚申诉通过";
  return "系统通知";
}

export async function listMessages(userId: number) {
  return (await repository.listMessages(userId)).map((row: any) => ({
    id: Number(row.id),
    type: Number(row.msg_type || 0),
    typeLabel: typeLabel(Number(row.msg_type || 0)),
    bizType: Number(row.biz_type || 0),
    bizId: Number(row.biz_id || 0),
    title: String(row.title || ""),
    content: String(row.content || ""),
    creatorName: String(row.creator_name || ""),
    createTime: String(row.create_time || ""),
    isRead: Boolean(Number(row.is_read || 0)),
  }));
}

export async function unreadCount(userId: number) {
  return repository.unreadCount(userId);
}

export async function markRead(userId: number, userName: string, messageId: number) {
  return repository.markRead(userId, userName, messageId);
}
