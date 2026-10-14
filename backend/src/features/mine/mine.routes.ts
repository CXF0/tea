import type { FastifyPluginAsync } from "fastify";
import type { RowDataPacket } from '../../database.js';
import { database } from "../../database.js";
import { AppError } from "../../shared/errors.js";
import { readToken } from "../auth/auth.service.js";

const typeNames: Record<number, string> = {
  0: "人工处罚",
  1: "设箱错误",
  2: "配货错误",
  3: "供应商配货错误",
  4: "未配货",
  5: "超时打包",
  6: "质检任务未完成",
  7: "配货超时",
  8: "售后质检",
  9: "售后配货",
  10: "售后打包",
  11: "仓库物流",
  12: "视频任务未完成",
  13: "错误质检",
};

function auth(authorization: unknown) {
  const token = String(authorization || "").replace(/^Bearer /, "");
  const userId = readToken(token);
  if (!userId) throw new AppError(401, "AUTH_REQUIRED", "登录已失效");
  return userId;
}

export const mineRoutes: FastifyPluginAsync = async (app) => {
  app.get("/punishments", async (request) => {
    const userId = auth(request.headers.authorization);
    const query = request.query as { status?: string };
    const params: any[] = [userId];
    let where = "duty_user_id=? AND data_status=0";
    if (query.status !== undefined && query.status !== "") {
      where += " AND punish_status=?";
      params.push(Number(query.status));
    }
    const [rows] = await database.query<RowDataPacket[]>(
      `SELECT id,type,punish_source,order_sn,date,zone,zone_shelf,sub_shelf_sn,
        punish_reason,punish_remark,punish_price,punish_status,pic_url,
        appeal_status,appeal_count,reject_reason,appeal_content,
        DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time
       FROM wms_punish
       WHERE ${where}
       ORDER BY date DESC,id DESC
       LIMIT 300`,
      params,
    );
    return {
      data: rows.map((row) => ({
        ...row,
        type_name: typeNames[Number(row.type)] || "其他处罚",
      })),
    };
  });
};
