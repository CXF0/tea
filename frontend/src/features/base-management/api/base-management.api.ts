import { request } from "@/shared/api/client";
export interface BaseRow {
  id: number;
  name: string;
  supplierCount: number;
  arrivalSupplierCount: number;
  productCount: number;
  inboundNum: number;
  allocatedNum: number;
  stockNum: number;
}
export interface BaseSupplier {
  id: number;
  admissionId: number | null;
  name: string;
  phone: string;
  status: number | null;
  productCount: number;
  inboundNum: number;
  allocatedNum: number;
  stockNum: number;
}
export interface BaseSummary {
  id: number;
  name: string;
  supplierCount: number;
  admittedCount: number;
  productCount: number;
  inboundNum: number;
  allocatedNum: number;
  stockNum: number;
}
export interface StockItem {
  productId: number;
  productName: string;
  rank: number;
  specification: string;
  inboundNum: number;
  allocatedNum: number;
  stockNum: number;
  price: number;
}
export interface SupplierStatistics {
  saleVarietyCount: number;
  stockNum: number;
  normalSales: number;
  soldOrderCount: number;
  agencySales: number;
  authorizedVarietyCount: number;
}
export interface VarietyPermission {
  secondId: number;
  name: string;
  levels: string;
}
export interface PrintItem {
  id: number;
  name: string;
  rank: number;
  shelf: string;
  quantity: number;
  exchange: boolean;
}
export interface BaseZoneSummary {
  code: string;
  name: string;
  frameCount: number;
  varietyCount: number;
  items: Array<{ productId: number; productName: string; rank: number; supplierName: string; frameCount: number }>;
}
export const baseManagementApi = {
  bases: (date: string) =>
    request<BaseRow[]>({
      url: `/base-management/bases?date=${date}`,
      method: "GET",
    }),
  base: (id: number, date: string) =>
    request<{ summary: BaseSummary; suppliers: BaseSupplier[] }>({
      url: `/base-management/bases/${id}?date=${date}`,
      method: "GET",
    }),
  zones: (id: number, date: string) =>
    request<{ base: { id: number; name: string }; date: string; zones: BaseZoneSummary[] }>({
      url: `/base-management/bases/${id}/zones?date=${date}`,
      method: "GET",
    }),
  supplier: (id: number, date: string) =>
    request<{
      supplier: { id: number; name: string; phone: string; baseName: string };
      statistics: SupplierStatistics;
      permissions: VarietyPermission[];
      items: StockItem[];
    }>({ url: `/base-management/suppliers/${id}?date=${date}`, method: "GET" }),
  printItems: (id: number, date: string) =>
    request<{
      supplier: { id: number; name: string };
      items: PrintItem[];
    }>({
      url: `/base-management/suppliers/${id}/print-items?date=${date}`,
      method: "GET",
    }),
};
