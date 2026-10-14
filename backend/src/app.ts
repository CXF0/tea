import cors from "@fastify/cors";
import multipart from "@fastify/multipart";
import fastifyStatic from "@fastify/static";
import Fastify from "fastify";
import { existsSync, mkdirSync } from "node:fs";
import { config } from "./config.js";
import { checkDatabaseConnection, database } from "./database.js";
import { qualityRoutes } from "./features/quality/quality.routes.js";
import { admissionRoutes } from "./features/admission/admission.routes.js";
import { distributionRoutes } from "./features/distribution/distribution.routes.js";
import { restockRoutes } from "./features/restock/restock.routes.js";
import { authRoutes } from "./features/auth/auth.routes.js";
import { coldStorageRoutes } from "./features/cold-storage/cold-storage.routes.js";
import { packingRoutes } from "./features/packing/packing.routes.js";
import { logisticsRoutes } from "./features/logistics/logistics.routes.js";
import { partLogisticsRoutes } from "./features/part-logistics/part-logistics.routes.js";
import { workforceRoutes } from "./features/workforce/workforce.routes.js";
import { baseManagementRoutes } from "./features/base-management/base-management.routes.js";
import { baseStocktakingRoutes } from "./features/base-stocktaking/base-stocktaking.routes.js";
import { baseOutsourceIncomeRoutes } from "./features/base-outsource-income/base-outsource-income.routes.js";
import { baseReturnRoutes } from "./features/base-return/base-return.routes.js";
import { agriMaterialRoutes } from "./features/agri-material/agri-material.routes.js";
import { agriDriverRoutes } from "./features/agri-driver/agri-driver.routes.js";
import { distributionTeamRoutes } from "./features/distribution-team/distribution-team.routes.js";
import { cartonInventoryRoutes } from "./features/carton-inventory/carton-inventory.routes.js";
import { mineRoutes } from "./features/mine/mine.routes.js";
import { patrolPunishmentRoutes } from "./features/patrol-punishment/patrol-punishment.routes.js";
import { accessControlRoutes } from "./features/access-control/access-control.routes.js";
import { bulkPurchaseRoutes } from "./features/bulk-purchase/bulk-purchase.routes.js";
import { siteLocationRoutes } from "./features/site-location/site-location.routes.js";
import { transportRoutes } from "./features/transport/transport.routes.js";
import { arrivalGoodsRoutes } from "./features/arrival-goods/arrival-goods.routes.js";
import { messagesRoutes } from "./features/messages/messages.routes.js";
import { AppError } from "./shared/errors.js";

export function buildApp(options: {logger?: boolean} = {}) {
  const app = Fastify({ logger: options.logger ?? true });
  app.register(cors, {
    origin: config.corsOrigin.split(",").map((item) => item.trim()),
    methods: ["GET", "HEAD", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"],
  });
  app.register(multipart, { limits: { fileSize: 20 * 1024 * 1024, files: 1 } });
  mkdirSync(config.uploadRoot, {recursive: true});
  app.register(fastifyStatic, {
    root: config.uploadRoot,
    prefix: "/uploads/",
  });

  if (existsSync(config.webRoot)) {
    app.register(fastifyStatic, {root: config.webRoot, prefix: "/", decorateReply: false});
  }

  app.addHook("onClose", async () => database.end());

  app.setErrorHandler((error, _request, reply) => {
    if (error instanceof AppError) {
      return reply
        .code(error.statusCode)
        .send({ error: { code: error.code, message: error.message } });
    }
    app.log.error(error);
    return reply
      .code(500)
      .send({
        error: {
          code: "INTERNAL_ERROR",
          message: "服务暂时不可用，请稍后重试",
        },
      });
  });

  app.register(qualityRoutes, { prefix: "/api/quality" });
  app.register(admissionRoutes, { prefix: "/api/admission" });
  app.register(distributionRoutes, { prefix: "/api/distribution" });
  app.register(restockRoutes, { prefix: "/api/restock" });
  app.register(authRoutes, { prefix: "/api/auth" });
  app.register(coldStorageRoutes, { prefix: "/api/cold-storage" });
  app.register(packingRoutes, { prefix: "/api/packing" });
  app.register(logisticsRoutes, { prefix: "/api/logistics" });
  app.register(partLogisticsRoutes, { prefix: "/api/part-logistics" });
  app.register(workforceRoutes, { prefix: "/api/workforce" });
  app.register(baseManagementRoutes, { prefix: "/api/base-management" });
  app.register(baseStocktakingRoutes, { prefix: "/api/base-stocktaking" });
  app.register(baseOutsourceIncomeRoutes, { prefix: "/api/base-outsource-income" });
  app.register(baseReturnRoutes, { prefix: "/api/base-return" });
  app.register(agriMaterialRoutes, { prefix: "/api/agri-material" });
  app.register(agriDriverRoutes, { prefix: "/api/agri-driver" });
  app.register(distributionTeamRoutes, { prefix: "/api/distribution-team" });
  app.register(cartonInventoryRoutes, { prefix: "/api/carton-inventory" });
  app.register(mineRoutes, { prefix: "/api/mine" });
  app.register(patrolPunishmentRoutes, { prefix: "/api/patrol-punishment" });
  app.register(accessControlRoutes, { prefix: "/api/access-control" });
  app.register(bulkPurchaseRoutes, { prefix: "/api/bulk-purchase" });
  app.register(siteLocationRoutes, { prefix: "/api/site-locations" });
  app.register(transportRoutes, { prefix: "/api/transport" });
  app.register(arrivalGoodsRoutes, { prefix: "/api/arrival-goods" });
  app.register(messagesRoutes, { prefix: "/api/messages" });

  app.get("/api/health", async (_request, reply) => {
    try {
      const db = await checkDatabaseConnection();
      return {
        status: "ok",
        service: "menghuacangguan-api",
        database: { status: "ok", engine: "sqlite", name: db.databaseName, version: db.version },
        timestamp: new Date().toISOString(),
      };
    } catch (error) {
      app.log.error(error, "Database health check failed");
      return reply
        .code(503)
        .send({
          status: "error",
          service: "menghuacangguan-api",
          database: { status: "error" },
          timestamp: new Date().toISOString(),
        });
    }
  });
  app.get("/api/dashboard", async () => ({
    session: new Date().toISOString().slice(0, 10),
    role: "仓库管理员",
    stockTotal: 1286,
    arrivedToday: 96,
    pendingInbound: 24,
    pendingQuality: 8,
    progress: { completed: 18, total: 42 },
  }));

  return app;
}
