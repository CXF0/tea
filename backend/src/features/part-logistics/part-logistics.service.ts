import { AppError } from "../../shared/errors.js";
import * as repository from "./part-logistics.repository.js";

const text = (value: unknown) => (value == null ? "" : String(value));
const mapRow = (row: any) => ({
  id: Number(row.id),
  date: text(row.date).slice(0, 10),
  userId: Number(row.user_id),
  userName: text(row.user_name),
  leaderId: Number(row.manage_id),
  leaderName: text(row.manage_name),
  startCheckerName: text(row.start_manage_name),
  endCheckerName: text(row.end_manage_name),
  startTime: text(row.start_time) || null,
  endTime: text(row.end_time) || null,
  duration: Number(row.duration || 0),
  unitPrice: Number(row.price || 0),
  totalPrice: Number(row.total_price || 0),
  settled: Number(row.settle_flag) === 1,
});

export async function overview(date: string, userId: number) {
  const source = await repository.listForLeader(date, userId);
  const records = source.map(mapRow);
  const assigned = source.filter((row: any) => Number(row.assigned_to_me));
  const checked = source.filter((row: any) => Number(row.checked_by_me));
  return {
    summary: {
      assigned: assigned.length,
      checked: checked.length,
      ended: records.filter((row) => !!row.endTime).length,
    },
    assignedRecords: assigned.map(mapRow),
    checkedRecords: checked.map(mapRow),
  };
}

export async function leaders() {
  return (await repository.leaders()).map((row: any) => ({
    id: Number(row.id),
    name: text(row.display_name),
  }));
}

export async function assign(ids: number[], leaderId: number) {
  const cleanIds = [...new Set(ids.map(Number).filter((id) => id > 0))];
  if (!cleanIds.length)
    throw new AppError(400, "RECORD_REQUIRED", "请选择要分配的兼职物流员");
  if (!leaderId) throw new AppError(400, "LEADER_REQUIRED", "请选择管理组长");
  const affected = await repository.assign(cleanIds, leaderId);
  if (!affected)
    throw new AppError(
      409,
      "ASSIGN_NOT_AVAILABLE",
      "所选人员已结束工作或不可分配",
    );
  return { affected };
}
