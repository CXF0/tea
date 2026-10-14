import { request } from "@/shared/api/client";
import { appConfig } from "@/app/config/env";
import { sessionStore } from "@/store/session";
import type { LogisticsShelf, LogisticsShelfDetail } from "../models/logistics";
export interface LogisticsDashboard {
  date: string;
  outboundCollection: {
    totalPackages: number;
    packedPackages: number;
    outboundPackages: number;
    pickedPackages: number;
    outboundRate: number;
    pickupRate: number;
  };
  collectionProgress: {
    totalPackages: number;
    pickedPackages: number;
    rate: number;
    types: Array<{
      expressType: number;
      expressName: string;
      totalPackages: number;
      pickedPackages: number;
      pendingPackages: number;
      rate: number;
    }>;
  };
}
export const logisticsApi = {
  dashboard(date: string) {
    return request<LogisticsDashboard>({
      url: `/logistics/dashboard?date=${date}`,
      method: "GET",
    });
  },
  shelves(p: { date: string; status: number; keyword: string; zone: string }) {
    const q = new URLSearchParams({
      date: p.date,
      status: String(p.status),
      keyword: p.keyword,
      zone: p.zone,
    });
    return request<LogisticsShelf[]>({
      url: `/logistics/shelves?${q}`,
      method: "GET",
    });
  },
  zones(date: string) {
    return request<string[]>({
      url: `/logistics/zones?date=${date}`,
      method: "GET",
    });
  },
  detail(date: string, shelfSn: number) {
    return request<LogisticsShelfDetail>({
      url: `/logistics/shelves/${shelfSn}?date=${date}`,
      method: "GET",
    });
  },
  ship(date: string, shelfSn: number, photos: string[]) {
    return request<LogisticsShelfDetail>({
      url: `/logistics/shelves/${shelfSn}/ship`,
      method: "POST",
      data: { date, photos },
    });
  },
  upload(filePath: string) {
    return new Promise<{ url: string }>((resolve, reject) =>
      uni.uploadFile({
        url: `${appConfig.apiBaseUrl}/logistics/media`,
        filePath,
        name: "file",
        header: {
          authorization: `Bearer ${sessionStore.state.token}`,
          "x-user-name": encodeURIComponent(sessionStore.state.userName),
        },
        success: (r) => {
          try {
            const p = JSON.parse(r.data);
            r.statusCode < 300
              ? resolve(p.data)
              : reject(new Error(p.error?.message || "照片上传失败"));
          } catch {
            reject(new Error("照片上传失败"));
          }
        },
        fail: (e) => reject(new Error(e.errMsg)),
      }),
    );
  },
};
