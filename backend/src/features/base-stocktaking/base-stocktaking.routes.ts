import type { FastifyPluginAsync } from "fastify";
import { AppError } from "../../shared/errors.js";
import * as service from "./base-stocktaking.service.js";
const id = (value: unknown) => { const n=Number(value); if(!Number.isInteger(n)||n<=0) throw new AppError(400,"INVALID_ID","编号无效"); return n; };
const date = (value: unknown) => String(value || new Date().toISOString().slice(0,10));
export const baseStocktakingRoutes: FastifyPluginAsync = async (app) => {
  app.get("/bases", async (req) => ({ data: await service.bases(Number(req.headers["x-user-id"] || 0)) }));
  app.get("/suppliers", async (req) => { const q=req.query as any; return { data: await service.suppliers(id(q.baseId),date(q.date),Number(req.headers["x-user-id"] || 0)) }; });
  app.get("/suppliers/:id", async (req) => { const q=req.query as any; return { data: await service.supplier(id(q.baseId),id((req.params as any).id),date(q.date),Number(req.headers["x-user-id"] || 0)) }; });
};
