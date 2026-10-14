import type { FastifyPluginAsync } from "fastify";
import { AppError } from "../../shared/errors.js";
import * as service from "./base-return.service.js";
import * as repo from "./base-return.repository.js";

export const baseReturnRoutes: FastifyPluginAsync = async (app) => {
  const requireCapability = async (req: any, capability: string) => {
    const accountId = Number(req.headers["x-user-id"] || 0);
    if (!accountId) throw new AppError(401, "LOGIN_REQUIRED", "请先登录");
    if (!(await repo.hasCapability(accountId, capability))) throw new AppError(403, "FORBIDDEN", "当前账号没有基地退货权限");
    return accountId;
  };
  app.get("/bases", async (req) => {
    await requireCapability(req, "baseReturn.view");
    return { data: await service.bases() };
  });
  app.get("/suppliers", async (req) => {
    await requireCapability(req, "baseReturn.view");
    const query = req.query as { date?: string; baseId?: string };
    const date = String(query.date || new Date().toISOString().slice(0, 10));
    const baseId = query.baseId ? Number(query.baseId) : undefined;
    if (baseId !== undefined && (!Number.isInteger(baseId) || baseId <= 0)) throw new AppError(400, "INVALID_BASE", "基地编号无效");
    return { data: await service.list(date, baseId) };
  });
  app.post("/confirm", async (req) => {
    const accountId = await requireCapability(req, "baseReturn.confirm");
    const body = req.body as { content?: string };
    if (!body.content?.trim()) throw new AppError(400, "RETURN_CODE_REQUIRED", "请扫描退货花材二维码");
    let userName = String(req.headers["x-user-name"] || "");
    try { userName = decodeURIComponent(userName); } catch {}
    return { data: await service.confirm(body.content, accountId, userName) };
  });
};
