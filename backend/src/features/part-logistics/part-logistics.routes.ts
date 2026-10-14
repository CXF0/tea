import type { FastifyPluginAsync } from "fastify";
import { readToken } from "../auth/auth.service.js";
import { AppError } from "../../shared/errors.js";
import * as repository from "./part-logistics.repository.js";
import * as service from "./part-logistics.service.js";

async function auth(headers: Record<string, unknown>, capability: string) {
  const authorization = String(headers.authorization || "");
  const userId = readToken(
    authorization.startsWith("Bearer ") ? authorization.slice(7) : "",
  );
  if (!userId) throw new AppError(401, "AUTH_REQUIRED", "登录已失效");
  if (!(await repository.hasCapability(userId, capability)))
    throw new AppError(403, "CAPABILITY_REQUIRED", "当前账号无权使用该功能");
  return userId;
}

export const partLogisticsRoutes: FastifyPluginAsync = async (app) => {
  app.get("/overview", async (request) => {
    const userId = await auth(request.headers, "partLogistics.view");
    return {
      data: await service.overview(
        String((request.query as any).date || ""),
        userId,
      ),
    };
  });
  app.get("/leaders", async (request) => {
    await auth(request.headers, "partLogistics.assign");
    return { data: await service.leaders() };
  });
  app.post("/assign", async (request) => {
    await auth(request.headers, "partLogistics.assign");
    const body = request.body as any;
    return {
      data: await service.assign(body.ids || [], Number(body.leaderId || 0)),
    };
  });
};
