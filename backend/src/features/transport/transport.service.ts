import { AppError } from "../../shared/errors.js";
import * as repository from "./transport.repository.js";
const vehicleStatus: Record<number, string> = {
  1: "可用",
  2: "维修保养中",
  3: "待审核",
  4: "停用",
  5: "任务中",
};
const dispatchStatus: Record<number, string> = {
  1: "已派车",
  2: "执行中",
  3: "已完成",
  4: "已撤销",
  5: "异常终止",
  6: "超时终止",
};
const rankLabels: Record<number, string> = {
  1: "A级",
  2: "B级",
  3: "C级",
  4: "D级",
  5: "E级",
};
const mapVehicle = (r: any) => ({
  id: Number(r.id),
  vehicleNo: String(r.vehicle_no),
  plateNo: String(r.plate_no),
  typeId: Number(r.type_id),
  typeName: String(r.type_name),
  loadStandard: Number(r.load_standard),
  fuelConsumption: Number(r.fuel_consumption || 0),
  ownerUserId: Number(r.owner_user_id),
  ownerName: String(r.owner_name),
  defaultStationId: Number(r.default_station_id),
  source: Number(r.source),
  platform: String(r.platform || ""),
  drivingYears: Number(r.driving_years),
  status: Number(r.status),
  manualStatus: Number(r.manual_status),
  statusStr: vehicleStatus[Number(r.status)] || "未知",
  remark: String(r.remark || ""),
  auditRemark: String(r.audit_remark || ""),
  trackingDeviceNo: String(r.tracking_device_no || ""),
  onlineStatus: Number(r.online_status),
  onlineStatusStr: Number(r.online_status) === 1 ? "在线" : "离线",
  accStatus: Number(r.acc_status),
  accStatusUpdateTime: r.acc_status_update_time || null,
  lastAccOnTime: r.last_acc_on_time || null,
  drivingLicenseImg: String(r.driving_license_img || ""),
});
const mapDispatch = (r: any) => ({
  id: Number(r.id),
  dispatchNo: String(r.dispatch_no),
  roundNo: String(r.round_no),
  type: Number(r.type),
  typeStr: Number(r.type) === 1 ? "内部车辆" : "外部车辆",
  vehicleName: String(r.vehicle_name || ""),
  plateNo: String(r.plate_no),
  driverName: String(r.driver_name || ""),
  responsibleBaseId: Number(r.responsible_base_id),
  responsibleBaseName: String(r.responsible_base_name || ""),
  route: String(r.route || ""),
  mileage: Number(r.mileage ?? r.total_mileage ?? 0),
  fee: Number(r.fee || 0),
  status: Number(r.status),
  statusStr: dispatchStatus[Number(r.status)] || "未知",
  signStatus: Number(r.sign_status),
  createTime: r.create_time || null,
});
export async function list(q: any) {
  const page = Math.max(1, Number(q.page || 1)),
    size = Math.min(50, Math.max(10, Number(q.size || 10)));
  const result = await repository.listVehicles({
    keyword: String(q.keyword || "").trim(),
    typeId: Number(q.typeId || 0),
    status: Number(q.status || 0),
    onlineStatus:
      q.onlineStatus === "" || q.onlineStatus === undefined
        ? -1
        : Number(q.onlineStatus),
    page,
    size,
  });
  return {
    current: page,
    size,
    total: Number(result.meta.total || 0),
    summary: {
      available: Number(result.meta.available || 0),
      online: Number(result.meta.online || 0),
      tasking: Number(result.meta.tasking || 0),
      maintenance: Number(result.meta.maintenance || 0),
    },
    records: result.rows.map(mapVehicle),
  };
}
export async function detail(id: number) {
  const row = await repository.findVehicle(id);
  if (!row) throw new AppError(404, "VEHICLE_NOT_FOUND", "车辆不存在");
  return mapVehicle(row);
}
function validate(v: any) {
  if (!String(v.vehicleNo || "").trim() || !String(v.plateNo || "").trim())
    throw new AppError(400, "VEHICLE_REQUIRED", "请填写车辆编号和车牌号");
  if (!Number(v.typeId))
    throw new AppError(400, "VEHICLE_TYPE_REQUIRED", "请选择车型");
  return {
    vehicleNo: String(v.vehicleNo).trim(),
    plateNo: String(v.plateNo).trim().toUpperCase(),
    typeId: Number(v.typeId),
    typeName: String(v.typeName || ""),
    loadStandard: Math.max(0, Number(v.loadStandard || 0)),
    fuelConsumption: Math.max(0, Number(v.fuelConsumption || 0)),
    ownerUserId: Number(v.ownerUserId || 0),
    ownerName: String(v.ownerName || "").trim(),
    defaultStationId: Number(v.defaultStationId || 0),
    source: Number(v.source || 1),
    platform: String(v.platform || ""),
    drivingYears: Math.max(0, Number(v.drivingYears || 0)),
    status: [1, 2, 3, 4].includes(Number(v.manualStatus ?? v.status))
      ? Number(v.manualStatus ?? v.status)
      : 1,
    remark: String(v.remark || ""),
    trackingDeviceNo: String(v.trackingDeviceNo || "").trim(),
  };
}
export async function create(v: any) {
  const data = validate(v);
  const id = await repository.createVehicle(data);
  return detail(id);
}
export async function update(id: number, v: any) {
  await detail(id);
  await repository.updateVehicle(id, validate(v));
  return detail(id);
}
export async function changeStatus(id: number, status: number) {
  if (![1, 2, 4].includes(status))
    throw new AppError(400, "INVALID_VEHICLE_STATUS", "车辆状态无效");
  await detail(id);
  await repository.updateStatus(id, status);
  return detail(id);
}
export async function types() {
  return (await repository.listTypes()).map((r) => ({
    id: Number(r.id),
    name: String(r.name),
  }));
}
export async function dispatches(q: any) {
  const page = Math.max(1, Number(q.page || 1)),
    size = Math.min(50, Math.max(10, Number(q.size || 20)));
  const result = await repository.listDispatches({
    roundNo: String(q.roundNo || ""),
    keyword: String(q.keyword || "").trim(),
    status: Number(q.status || 0),
    page,
    size,
  });
  return {
    current: page,
    size,
    total: Number(result.meta.total || 0),
    summary: {
      dispatched: Number(result.meta.dispatched || 0),
      running: Number(result.meta.running || 0),
      completed: Number(result.meta.completed || 0),
    },
    records: result.rows.map(mapDispatch),
  };
}
export async function dispatchDetail(id: number) {
  const row = await repository.findDispatch(id);
  if (!row) throw new AppError(404, "DISPATCH_NOT_FOUND", "派车任务不存在");
  return mapDispatch(row);
}
export async function changeDispatchStatus(id: number, status: number) {
  if (![1, 2, 3, 4, 5, 6].includes(status))
    throw new AppError(400, "INVALID_DISPATCH_STATUS", "派车任务状态无效");
  await dispatchDetail(id);
  await repository.updateDispatchStatus(id, status);
  return dispatchDetail(id);
}

export async function baseFlowerDetails(q: any) {
  const rows = await repository.listBaseFlowerDetails({
    roundNo: String(q.roundNo || new Date().toISOString().slice(0, 10)),
    keyword: String(q.keyword || "").trim(),
    driverName: String(q.driverName || "").trim(),
    baseId: Number(q.baseId || 0),
  });
  const summary = rows.reduce(
    (acc, row: any) => {
      acc.flowerUnits += Number(row.item_num || 0);
      acc.recordUnits += Number(row.record_num || 0);
      acc.preparedUnits += Number(row.prepare_item_num || 0);
      acc.problemUnits += Number(row.not_qualify_num || 0);
      acc.baseNames.add(String(row.responsible_base_name || ""));
      acc.driverNames.add(String(row.driver_name || ""));
      return acc;
    },
    { flowerUnits: 0, recordUnits: 0, preparedUnits: 0, problemUnits: 0, baseNames: new Set<string>(), driverNames: new Set<string>() },
  );
  return {
    total: rows.length,
    summary: {
      flowerUnits: summary.flowerUnits,
      recordUnits: summary.recordUnits,
      preparedUnits: summary.preparedUnits,
      problemUnits: summary.problemUnits,
      baseCount: [...summary.baseNames].filter(Boolean).length,
      driverCount: [...summary.driverNames].filter(Boolean).length,
    },
    records: rows.map((row: any) => ({
      dispatchId: Number(row.dispatch_id),
      dispatchNo: String(row.dispatch_no || ""),
      driverName: String(row.driver_name || ""),
      plateNo: String(row.plate_no || ""),
      baseId: Number(row.responsible_base_id || 0),
      baseName: String(row.responsible_base_name || ""),
      itemId: Number(row.item_id),
      flowerName: String(row.product_name || ""),
      grade: rankLabels[Number(row.rank_num)] || `${row.rank_num}级`,
      specification: String(row.sku_config || ""),
      supplierName: String(row.supplier_name || ""),
      location: [row.zone_shelf, row.sub_shelf_sn].filter(Boolean).join("-") || "未入位",
      quantity: Number(row.item_num || 0),
      recordQuantity: Number(row.record_num || 0),
      preparedQuantity: Number(row.prepare_item_num || 0),
      problemQuantity: Number(row.not_qualify_num || 0),
    })),
  };
}
