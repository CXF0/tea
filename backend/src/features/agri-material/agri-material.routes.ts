import type { FastifyPluginAsync } from "fastify";
import { AppError } from "../../shared/errors.js";
import * as repo from "./agri-material.repository.js";
import * as service from "./agri-material.service.js";

export const agriMaterialRoutes: FastifyPluginAsync = async (app) => {
  const auth = async (req: any, cap: string) => {
    const id = Number(req.headers["x-user-id"] || 0);
    if (!id) throw new AppError(401, "LOGIN_REQUIRED", "请先登录");
    if (!(await repo.hasCapability(id, cap)))
      throw new AppError(403, "FORBIDDEN", "当前账号没有农资管理权限");
  };

  app.get("/dashboard", async (req) => {
    await auth(req, "agriMaterial.view");
    const q = req.query as any;
    return {
      data: await service.dashboard(
        String(q.date || new Date().toISOString().slice(0, 10)),
        String(q.mode || "day"),
      ),
    };
  });

  app.get("/filters", async (req) => {
    await auth(req, "agriMaterial.view");
    const q = req.query as any;
    return {
      data: await service.filters(
        String(q.date || new Date().toISOString().slice(0, 10)),
      ),
    };
  });

  app.get("/orders", async (req) => {
    await auth(req, "agriMaterial.view");
    const q = req.query as any;
    return {
      data: await service.orders(
        String(q.date || ""),
        Number(q.status || 0),
        String(q.keyword || ""),
        String(q.baseName || ""),
        Number(q.supplierId || 0),
      ),
    };
  });

  app.get("/orders/:id", async (req) => {
    await auth(req, "agriMaterial.view");
    return { data: await service.detail(String((req.params as any).id)) };
  });

  app.get("/labels", async (req) => {
    await auth(req, "agriMaterial.print");
    const q = req.query as any;
    return {
      data: await service.labels(String(q.date || ""), Number(q.supplierId || 0)),
    };
  });
};
