import type { ResultSetHeader, RowDataPacket } from '../../database.js';
import { database } from "../../database.js";

export async function hasCapability(accountId: number, capability: string) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT 1 FROM wms_account a JOIN wms_role_permission_group rg ON rg.role_id=a.role_id JOIN wms_permission_group_item gi ON gi.group_id=rg.group_id JOIN wms_permission p ON p.id=gi.permission_id AND p.status=1 WHERE a.id=? AND a.status=1 AND p.code=? LIMIT 1`,
    [accountId, capability],
  );
  return rows.length > 0;
}
export async function listTypes() {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT id,name FROM hub_vehicle_type WHERE status=1 ORDER BY id`,
  );
  return rows;
}
const effectiveStatus = `CASE WHEN v.status=2 THEN 2 WHEN v.status=4 THEN 4 WHEN EXISTS(SELECT 1 FROM hub_dispatch_order d WHERE d.plate_no=v.plate_no AND d.status IN(1,2)) THEN 5 ELSE v.status END`;
export async function listVehicles(q: {
  keyword: string;
  typeId: number;
  status: number;
  onlineStatus: number;
  page: number;
  size: number;
}) {
  const clauses = ["v.status<>-100"];
  const params: Array<string | number> = [];
  if (q.keyword) {
    clauses.push(
      "(v.vehicle_no LIKE ? OR v.plate_no LIKE ? OR v.owner_name LIKE ?)",
    );
    params.push(`%${q.keyword}%`, `%${q.keyword}%`, `%${q.keyword}%`);
  }
  if (q.typeId) {
    clauses.push("v.type_id=?");
    params.push(q.typeId);
  }
  if (q.status) {
    clauses.push(`${effectiveStatus}=?`);
    params.push(q.status);
  }
  if (q.onlineStatus >= 0) {
    clauses.push("v.online_status=?");
    params.push(q.onlineStatus);
  }
  const where = clauses.join(" AND ");
  const [count] = await database.query<RowDataPacket[]>(
    `SELECT COUNT(*) total,SUM(${effectiveStatus}=1) available,SUM(v.online_status=1) online,SUM(${effectiveStatus}=5) tasking,SUM(${effectiveStatus}=2) maintenance FROM hub_vehicle v WHERE ${where}`,
    params,
  );
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT v.id,v.vehicle_no,v.plate_no,v.type_id,v.type_name,v.load_standard,v.fuel_consumption,v.owner_user_id,v.owner_name,v.default_station_id,v.source,v.platform,v.driving_years,v.status manual_status,${effectiveStatus} status,v.remark,v.audit_remark,v.tracking_device_no,v.online_status,v.acc_status,DATE_FORMAT(v.acc_status_update_time,'%Y-%m-%d %H:%i:%s') acc_status_update_time,DATE_FORMAT(v.last_acc_on_time,'%Y-%m-%d %H:%i:%s') last_acc_on_time,v.driving_license_img FROM hub_vehicle v WHERE ${where} ORDER BY v.id DESC LIMIT ? OFFSET ?`,
    [...params, q.size, (q.page - 1) * q.size],
  );
  return { meta: count[0], rows };
}
export async function findVehicle(id: number) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT v.*,v.status manual_status,${effectiveStatus} status FROM hub_vehicle v WHERE v.id=? AND v.status<>-100 LIMIT 1`,
    [id],
  );
  return rows[0];
}
export async function createVehicle(v: any) {
  const [r] = await database.execute<ResultSetHeader>(
    `INSERT INTO hub_vehicle(vehicle_no,plate_no,type_id,type_name,load_standard,fuel_consumption,owner_user_id,owner_name,default_station_id,source,platform,driving_years,status,remark,tracking_device_no) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`,
    [
      v.vehicleNo,
      v.plateNo,
      v.typeId,
      v.typeName,
      v.loadStandard,
      v.fuelConsumption,
      v.ownerUserId,
      v.ownerName,
      v.defaultStationId,
      v.source,
      v.platform,
      v.drivingYears,
      v.status,
      v.remark,
      v.trackingDeviceNo,
    ],
  );
  return r.insertId;
}
export async function updateVehicle(id: number, v: any) {
  await database.execute(
    `UPDATE hub_vehicle SET vehicle_no=?,plate_no=?,type_id=?,type_name=?,load_standard=?,fuel_consumption=?,owner_user_id=?,owner_name=?,default_station_id=?,source=?,platform=?,driving_years=?,status=?,remark=?,tracking_device_no=? WHERE id=? AND status<>-100`,
    [
      v.vehicleNo,
      v.plateNo,
      v.typeId,
      v.typeName,
      v.loadStandard,
      v.fuelConsumption,
      v.ownerUserId,
      v.ownerName,
      v.defaultStationId,
      v.source,
      v.platform,
      v.drivingYears,
      v.status,
      v.remark,
      v.trackingDeviceNo,
      id,
    ],
  );
}
export async function updateStatus(id: number, status: number) {
  await database.execute(
    `UPDATE hub_vehicle SET status=? WHERE id=? AND status<>-100`,
    [status, id],
  );
}
export async function listDispatches(q: {
  roundNo: string;
  keyword: string;
  status: number;
  page: number;
  size: number;
}) {
  const clauses = ["1=1"];
  const params: Array<string | number> = [];
  if (q.roundNo) {
    clauses.push("round_no=?");
    params.push(q.roundNo);
  }
  if (q.keyword) {
    clauses.push(
      "(dispatch_no LIKE ? OR plate_no LIKE ? OR driver_name LIKE ? OR responsible_base_name LIKE ?)",
    );
    params.push(...Array(4).fill(`%${q.keyword}%`));
  }
  if (q.status) {
    clauses.push("status=?");
    params.push(q.status);
  }
  const where = clauses.join(" AND ");
  const [count] = await database.query<RowDataPacket[]>(
    `SELECT COUNT(*) total,SUM(status=1) dispatched,SUM(status=2) running,SUM(status=3) completed FROM hub_dispatch_order WHERE ${where}`,
    params,
  );
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT id,dispatch_no,round_no,type,vehicle_name,plate_no,driver_name,responsible_base_id,responsible_base_name,CONCAT(start_station_name,' → ',end_station_name) route,total_mileage mileage,fee,status,sign_status,DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time FROM hub_dispatch_order WHERE ${where} ORDER BY id DESC LIMIT ? OFFSET ?`,
    [...params, q.size, (q.page - 1) * q.size],
  );
  return { meta: count[0], rows };
}
export async function findDispatch(id: number) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT *,CONCAT(start_station_name,' → ',end_station_name) route FROM hub_dispatch_order WHERE id=? LIMIT 1`,
    [id],
  );
  return rows[0];
}
export async function updateDispatchStatus(id: number, status: number) {
  await database.execute(`UPDATE hub_dispatch_order SET status=? WHERE id=?`, [
    status,
    id,
  ]);
}

export async function listBaseFlowerDetails(q: {
  roundNo: string;
  keyword: string;
  driverName: string;
  baseId: number;
}) {
  const dispatchClauses = ["d.round_no=?"];
  const dispatchParams: Array<string | number> = [q.roundNo];
  if (q.driverName) {
    dispatchClauses.push("d.driver_name LIKE ?");
    dispatchParams.push(`%${q.driverName}%`);
  }
  if (q.baseId) {
    dispatchClauses.push("d.responsible_base_id=?");
    dispatchParams.push(q.baseId);
  }
  const itemClauses = ["item.date=?", "item.data_status=0"];
  const itemParams: Array<string | number> = [q.roundNo];
  if (q.keyword) {
    itemClauses.push("(item.product_name LIKE ? OR entry.supplier_name LIKE ? OR item.zone_shelf LIKE ?)");
    itemParams.push(`%${q.keyword}%`, `%${q.keyword}%`, `%${q.keyword}%`);
  }
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT dispatch.id dispatch_id, dispatch.dispatch_no, dispatch.driver_name,
            dispatch.plate_no, dispatch.responsible_base_id, dispatch.responsible_base_name,
            item.id item_id, item.product_name, item.rank_num, item.sku_config,
            item.item_num, COALESCE(item.record_num, 0) record_num,
            COALESCE(item.prepare_item_num, 0) prepare_item_num,
            COALESCE(item.not_qualify_num, 0) not_qualify_num,
            item.zone_shelf, item.sub_shelf_sn, entry.supplier_name
       FROM (
         SELECT d.*
           FROM hub_dispatch_order d
          WHERE ${dispatchClauses.join(" AND ")}
       ) dispatch
       JOIN xm_bulky_supplier_enter entry
         ON entry.date = dispatch.round_no
        AND (dispatch.responsible_base_id = 0 OR entry.supplier_id = dispatch.responsible_base_id)
       JOIN xm_bulky_supplier_enter_item item
         ON item.enter_id = entry.id
      WHERE ${itemClauses.join(" AND ")}
      ORDER BY dispatch.id DESC, item.zone_shelf, item.sub_shelf_sn, item.id
      LIMIT 500`,
    [...dispatchParams, ...itemParams],
  );
  return rows;
}
