import { request } from "@/shared/api/client";
export interface StocktakingBase { id:number; name:string }
export interface StocktakingSupplier { id:number; name:string; phone:string; ordinaryFlowerNum:number; inventoryNum:number }
export interface StocktakingItem { productId:number; name:string; rank:number; specification:string; totalNum:number; inventoryNum:number }
export const baseStocktakingApi = {
  bases: () => request<StocktakingBase[]>({ url:"/base-stocktaking/bases", method:"GET" }),
  suppliers: (baseId:number,date:string) => request<StocktakingSupplier[]>({ url:`/base-stocktaking/suppliers?baseId=${baseId}&date=${date}`, method:"GET" }),
  supplier: (baseId:number,id:number,date:string) => request<{supplier:{id:number;name:string;phone:string;baseName:string};items:StocktakingItem[]}>({ url:`/base-stocktaking/suppliers/${id}?baseId=${baseId}&date=${date}`, method:"GET" }),
};
