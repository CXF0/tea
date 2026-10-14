import { AppError } from "../../shared/errors.js";
import * as repository from "./logistics.repository.js";

const json = (value: any) => {
  try {
    const parsed = JSON.parse(value || "[]");
    return Array.isArray(parsed) ? parsed : [];
  } catch {
    return [];
  }
};

export async function shelves(
  date: string,
  status: number,
  keyword: string,
  zone: string,
) {
  return (await repository.shelves(date, status, keyword, zone)).map(
    (row: any) => ({
      date: String(row.round_no).slice(0, 10),
      shelfSn: Number(row.shelf_sn),
      shelfNo: String(row.zone_shelf || row.shelf_sn),
      packageName: String(row.package_name || ""),
      zone: String(row.zone || ""),
      selfPickup: Number(row.self_take_type) !== 0,
      totalNum: Number(row.total_num),
      packedNum: Number(row.packed_num),
      shippedNum: Number(row.shipped_num),
      itemNum: Number(row.item_num || 0),
      earlyShift: Boolean(Number(row.early_shift)),
      boxMismatch: Boolean(Number(row.box_mismatch)),
      restockStatus: Boolean(Number(row.restock_status)),
      deliveryTime: String(row.delivery_time || "").slice(0, 5),
      expressName: String(row.express_name || ""),
    }),
  );
}

export async function zones(date: string) {
  return repository.zones(date);
}

export async function dashboard(date: string) {
  const data = await repository.dashboard(date);
  const overview: any = data.overview;
  const n = (value: unknown) => Number(value || 0);
  const totalPackages = n(overview.total_packages);
  const packedPackages = n(overview.packed_packages);
  const outboundPackages = n(overview.outbound_packages);
  const pickedPackages = n(overview.picked_packages);
  const outboundRate = totalPackages
    ? Math.round((outboundPackages / totalPackages) * 100)
    : 0;
  const pickupRate = totalPackages
    ? Math.round((pickedPackages / totalPackages) * 100)
    : 0;
  return {
    date,
    outboundCollection: {
      totalPackages,
      packedPackages,
      outboundPackages,
      pickedPackages,
      outboundRate,
      pickupRate,
    },
    collectionProgress: {
      totalPackages,
      pickedPackages,
      rate: pickupRate,
      types: data.types.map((row: any) => {
        const typeTotalPackages = n(row.total_packages);
        const typePickedPackages = n(row.picked_packages);
        return {
          expressType: n(row.express_type),
          expressName: String(row.express_name || "鲜花专线"),
          totalPackages: typeTotalPackages,
          pickedPackages: typePickedPackages,
          pendingPackages: Math.max(0, typeTotalPackages - typePickedPackages),
          rate: typeTotalPackages
            ? Math.round((typePickedPackages / typeTotalPackages) * 100)
            : 0,
        };
      }),
    },
  };
}

export async function detail(date: string, shelfSn: number) {
  const rows = await repository.packages(date, shelfSn);
  if (!rows.length)
    throw new AppError(404, "SHELF_NOT_FOUND", "未找到该货架发货数据");
  return {
    date,
    shelfSn,
    shelfNo: String(rows[0].zone_shelf || shelfSn),
    warehouseName: `${String(rows[0].city || "").replace(/市$/, "")}城市仓`,
    packages: rows.map((row: any) => ({
      id: Number(row.id),
      serialNum: Number(row.serial_num),
      sendNo: String(row.send_no || ""),
      city: String(row.city || ""),
      itemNum: Number(row.item_num || 0),
      weight: Number(row.express_actual_weight || 0),
      estimatedWeight: Number(row.total_weight || 0),
      freight: Number(row.express_actual_price || 0),
      status: Number(row.express_status),
      expressName: String(row.express_name),
      expressType: Number(row.express_type || 0),
      packageName: String(row.package_info || row.suggest_pack_info || ""),
      receiveName: String(row.receive_name || ""),
      receiveTel: String(row.receive_tel || ""),
      receiveAddress: String(row.receive_address || ""),
      remark: String(row.remark || ""),
      logisticsRemark: String(row.logistics_remark || ""),
      packageUserName: String(row.package_user_name || ""),
      packageTime: row.package_time ? String(row.package_time) : null,
      shipPhotos: json(row.ship_url),
      shipUserName: String(row.express_user_name || ""),
      shipTime: row.express_time ? String(row.express_time) : null,
    })),
  };
}

export async function ship(
  date: string,
  shelfSn: number,
  photos: string[],
  userId: number,
  userName: string,
) {
  if (!photos.length)
    throw new AppError(400, "SHIP_PHOTO_REQUIRED", "完成发货前请上传过秤照片");
  const rows = await repository.packages(date, shelfSn);
  if (
    !rows.some(
      (row: any) =>
        Number(row.express_status) >= 10 && Number(row.express_status) < 20,
    )
  )
    throw new AppError(409, "NOT_SHIPPABLE", "该货架没有可发货包裹");
  await repository.ship(date, shelfSn, photos, userId, userName);
  return detail(date, shelfSn);
}
