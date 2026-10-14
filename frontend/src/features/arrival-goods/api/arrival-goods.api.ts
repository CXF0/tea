import { request } from "@/shared/api/client";

export interface ArrivalGoodsRecord {
  id: number;
  date: string;
  flowerName: string;
  grade: string;
  specification: string;
  supplierId: number;
  supplierName: string;
  location: string;
  acquiredUnits: number;
  stockUnits: number;
  outboundUnits: number;
  problemUnits: number;
  selfPickup: boolean;
  unlabeled: boolean;
  createdAt: string;
}

export interface ArrivalGoodsPage {
  current: number;
  size: number;
  total: number;
  summary: {
    acquiredUnits: number;
    stockUnits: number;
    outboundUnits: number;
    selfPickupUnits: number;
    unlabeledUnits: number;
  };
  records: ArrivalGoodsRecord[];
}

export const arrivalGoodsApi = {
  list(q: { date: string; type: string; keyword: string; page: number; size: number }) {
    const p = new URLSearchParams(Object.entries(q).map(([key, value]) => [key, String(value)]));
    return request<ArrivalGoodsPage>({ url: `/arrival-goods?${p}`, method: "GET" });
  },
};
