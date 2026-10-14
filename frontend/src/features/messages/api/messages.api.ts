import { request } from "@/shared/api/client";

export interface MessageItem {
  id: number;
  type: number;
  typeLabel: string;
  bizType: number;
  bizId: number;
  title: string;
  content: string;
  creatorName: string;
  createTime: string;
  isRead: boolean;
}

export const messagesApi = {
  list() {
    return request<MessageItem[]>({ url: "/messages", method: "GET" });
  },
  unreadCount() {
    return request<{ count: number }>({ url: "/messages/unread-count", method: "GET" });
  },
  markRead(id: number) {
    return request<{ count: number }>({ url: `/messages/${id}/read`, method: "PUT", data: {} });
  },
};
