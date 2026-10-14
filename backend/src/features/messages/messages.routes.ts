import type { FastifyPluginAsync } from "fastify";
import { readToken } from "../auth/auth.service.js";
import { AppError } from "../../shared/errors.js";
import * as service from "./messages.service.js";

function auth(headers: Record<string, unknown>) {
  const authorization = String(headers.authorization || "");
  const userId = readToken(
    authorization.startsWith("Bearer ") ? authorization.slice(7) : "",
  );
  if (!userId) throw new AppError(401, "AUTH_REQUIRED", "登录已失效");
  return {
    userId,
    userName: decodeURIComponent(String(headers["x-user-name"] || "")),
  };
}

export const messagesRoutes: FastifyPluginAsync = async (app) => {
  app.get("/", async (request) => {
    const user = auth(request.headers);
    return { data: await service.listMessages(user.userId) };
  });

  app.get("/unread-count", async (request) => {
    const user = auth(request.headers);
    return { data: { count: await service.unreadCount(user.userId) } };
  });

  app.put<{ Params: { id: string } }>("/:id/read", async (request) => {
    const user = auth(request.headers);
    const messageId = Number(request.params.id);
    if (!Number.isFinite(messageId) || messageId <= 0) {
      throw new AppError(400, "INVALID_MESSAGE", "消息不存在");
    }
    return {
      data: {
        count: await service.markRead(user.userId, user.userName, messageId),
      },
    };
  });
};
