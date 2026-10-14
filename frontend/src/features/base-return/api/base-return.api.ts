import { request } from "@/shared/api/client";

export interface ReturnBase { id: number; name: string }
export interface SupplierReturn {
  supplierId: number; supplierName: string; baseId: number; baseName: string;
  refundNum: number; confirmNum: number;
  status: "pending" | "partial" | "confirmed"; statusLabel: string;
}

export const baseReturnApi = {
  bases: () => request<ReturnBase[]>({ url: "/base-return/bases", method: "GET" }),
  suppliers: (date: string, baseId?: number) => request<SupplierReturn[]>({
    url: `/base-return/suppliers?date=${date}${baseId ? `&baseId=${baseId}` : ""}`,
    method: "GET",
  }),
  confirm: (content: string) => request<{ itemId: number; productName: string; confirmedQuantity: number }>({
    url: "/base-return/confirm", method: "POST", data: { content },
  }),
};
