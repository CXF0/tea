import type { FastifyPluginAsync } from "fastify";
import { createWriteStream } from "node:fs";
import { mkdir } from "node:fs/promises";
import { extname, resolve } from "node:path";
import { randomUUID } from "node:crypto";
import { pipeline } from "node:stream/promises";
import { readToken } from "../auth/auth.service.js";
import { AppError } from "../../shared/errors.js";
import * as repository from "./logistics.repository.js";
import * as service from "./logistics.service.js";

async function auth(headers: Record<string, unknown>, capability: string) {
  const authorization = String(headers.authorization || "");
  const userId = readToken(
    authorization.startsWith("Bearer ") ? authorization.slice(7) : "",
  );
  if (!userId) throw new AppError(401, "AUTH_REQUIRED", "登录已失效");
  if (!(await repository.hasCapability(userId, capability))) {
    throw new AppError(403, "CAPABILITY_REQUIRED", "当前账号无权使用该功能");
  }
  return {
    userId,
    userName: decodeURIComponent(String(headers["x-user-name"] || "")),
  };
}

export const logisticsRoutes: FastifyPluginAsync = async (app) => {
  app.get("/dashboard", async (req) => {
    await auth(req.headers, "logistics.view");
    return { data: await service.dashboard(String((req.query as any).date || "")) };
  });

  app.get("/shelves", async (req) => {
    await auth(req.headers, "logistics.view");
    const q = req.query as any;
    return {
      data: await service.shelves(
        String(q.date || ""),
        Number(q.status || 0),
        String(q.keyword || ""),
        String(q.zone || ""),
      ),
    };
  });

  app.get("/zones", async (req) => {
    await auth(req.headers, "logistics.view");
    return { data: await service.zones(String((req.query as any).date || "")) };
  });

  app.get("/shelves/:shelfSn", async (req) => {
    await auth(req.headers, "logistics.view");
    return {
      data: await service.detail(
        String((req.query as any).date || ""),
        Number((req.params as any).shelfSn),
      ),
    };
  });

  app.post("/shelves/:shelfSn/ship", async (req) => {
    const user = await auth(req.headers, "logistics.operate");
    const body = req.body as any;
    return {
      data: await service.ship(
        String(body.date || ""),
        Number((req.params as any).shelfSn),
        body.photos || [],
        user.userId,
        user.userName,
      ),
    };
  });

  app.post("/media", async (req) => {
    await auth(req.headers, "logistics.operate");
    const file = await req.file();
    if (!file) throw new AppError(400, "IMAGE_REQUIRED", "请选择照片");
    if (!new Set(["image/jpeg", "image/png", "image/webp"]).has(file.mimetype)) {
      throw new AppError(
        400,
        "UNSUPPORTED_IMAGE",
        "仅支持 JPG、PNG 和 WebP 图片",
      );
    }
    const dir = resolve(process.cwd(), "uploads", "logistics");
    await mkdir(dir, { recursive: true });
    const name = `${Date.now()}-${randomUUID()}${extname(file.filename).toLowerCase() || ".jpg"}`;
    await pipeline(file.file, createWriteStream(resolve(dir, name)));
    return { data: { url: `/uploads/logistics/${name}` } };
  });
};
