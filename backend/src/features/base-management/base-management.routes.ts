import type { FastifyPluginAsync } from "fastify";
import { AppError } from "../../shared/errors.js";
import * as service from "./base-management.service.js";
const date = (v: unknown) => String(v || new Date().toISOString().slice(0, 10));
const id = (v: unknown) => {
  const n = Number(v);
  if (!Number.isInteger(n) || n <= 0)
    throw new AppError(400, "INVALID_ID", "编号无效");
  return n;
};
export const baseManagementRoutes: FastifyPluginAsync = async (app) => {
  app.get("/bases", async (req) => ({
    data: await service.bases(
      date((req.query as any).date),
      Number(req.headers["x-user-id"] || 0),
    ),
  }));
  app.get("/bases/:id", async (req) => ({
    data: await service.base(
      id((req.params as any).id),
      date((req.query as any).date),
    ),
  }));
  app.get("/bases/:id/zones", async (req) => ({
    data: await service.baseZones(id((req.params as any).id), date((req.query as any).date)),
  }));
  app.get("/suppliers/:id", async (req) => ({
    data: await service.supplier(
      id((req.params as any).id),
      date((req.query as any).date),
    ),
  }));
  app.get("/suppliers/:id/print-items", async (req) => ({
    data: await service.printItems(
      id((req.params as any).id),
      date((req.query as any).date),
    ),
  }));
};
