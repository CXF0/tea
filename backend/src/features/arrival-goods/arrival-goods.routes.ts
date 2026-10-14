import type { FastifyPluginAsync } from "fastify";
import { AppError } from "../../shared/errors.js";
import { readToken } from "../auth/auth.service.js";
import * as repository from "./arrival-goods.repository.js";
import * as service from "./arrival-goods.service.js";

async function auth(headers: Record<string, unknown>, capability: string) {
  const id = readToken(String(headers.authorization || "").replace(/^Bearer /, ""));
  if (!id) throw new AppError(401, "AUTH_REQUIRED", "登录已失效");
  if (!(await repository.hasCapability(id, capability))) throw new AppError(403, "CAPABILITY_REQUIRED", "当前账号无权查看到场货");
  return id;
}

export const arrivalGoodsRoutes: FastifyPluginAsync = async (app) => {
  app.get("/", async (request) => {
    const type = String((request.query as { type?: string }).type || "purchase");
    const capabilityMap: Record<string, string> = {
      all: "arrivalGoods.purchase.view",
      purchase: "arrivalGoods.purchase.view",
      stock: "arrivalGoods.stock.view",
      outbound: "arrivalGoods.outbound.view",
      selfPickup: "arrivalGoods.selfPickup.view",
      unlabeled: "arrivalGoods.unlabeled.view",
    };
    await auth(request.headers, capabilityMap[type] || "arrivalGoods.purchase.view");
    return { data: await service.list(request.query) };
  });
};
