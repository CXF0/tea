export interface LogisticsShelf {
  date: string;
  shelfSn: number;
  shelfNo: string;
  packageName: string;
  zone: string;
  selfPickup: boolean;
  totalNum: number;
  packedNum: number;
  shippedNum: number;
  itemNum: number;
  earlyShift: boolean;
  boxMismatch: boolean;
  restockStatus: boolean;
  deliveryTime: string;
  expressName: string;
}
export interface LogisticsPackage {
  id: number;
  serialNum: number;
  sendNo: string;
  city: string;
  itemNum: number;
  weight: number;
  estimatedWeight: number;
  freight: number;
  status: number;
  expressName: string;
  expressType: number;
  packageName: string;
  receiveName: string;
  receiveTel: string;
  receiveAddress: string;
  remark: string;
  logisticsRemark: string;
  packageUserName: string;
  packageTime: string | null;
  shipPhotos: string[];
  shipUserName: string;
  shipTime: string | null;
}
export interface LogisticsShelfDetail {
  date: string;
  shelfSn: number;
  shelfNo: string;
  warehouseName: string;
  packages: LogisticsPackage[];
}
