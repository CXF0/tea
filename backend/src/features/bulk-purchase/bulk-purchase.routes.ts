import type { FastifyPluginAsync } from "fastify";
import { AppError } from "../../shared/errors.js";
import * as repo from "./bulk-purchase.repository.js";

export const bulkPurchaseRoutes: FastifyPluginAsync = async (app) => {
  const auth = async (req: any, capability: string) => {
    const id = Number(req.headers["x-user-id"] || 0);
    if (!id) throw new AppError(401, "LOGIN_REQUIRED", "请先登录");
    if (!(await repo.hasCapability(id, capability))) throw new AppError(403, "FORBIDDEN", "当前账号没有集采业务权限");
  };
  app.get("/demands", async (req) => { await auth(req, "bulkPurchaseDemand.view"); const q = req.query as any; return { data: await repo.demands(String(q.roundNo || ""), q.status === undefined ? -1 : Number(q.status), String(q.keyword || "")) }; });
  app.get("/demands/:id", async (req) => { await auth(req, "bulkPurchaseDemand.view"); const data = await repo.demandDetail(Number((req.params as any).id)); if (!data) throw new AppError(404, "DEMAND_NOT_FOUND", "集采需求不存在"); return { data }; });
  app.get("/orders", async (req) => { await auth(req, "bulkPurchaseOrder.view"); const q = req.query as any; return { data: await repo.orders(String(q.roundNo || ""), q.status === undefined ? -1 : Number(q.status), String(q.keyword || "")) }; });
};
