import type { FastifyPluginAsync } from "fastify";
import { readToken } from "../auth/auth.service.js";
import { AppError } from "../../shared/errors.js";
import { getSiteLocations } from "./site-location.service.js";
import { accountHasCard } from "./site-location.repository.js";

export const siteLocationRoutes: FastifyPluginAsync = async (app) => {
  app.get("/", async (request) => {
    const authorization = String(request.headers.authorization || "");
    const accountId = readToken(authorization.replace(/^Bearer /, ""));
    if (!accountId) throw new AppError(401, "AUTH_REQUIRED", "登录已失效");
    if (!(await accountHasCard(accountId))) throw new AppError(403, "CAPABILITY_REQUIRED", "当前账号无权查看场地货位统计");
    return { data: await getSiteLocations() };
  });
};
