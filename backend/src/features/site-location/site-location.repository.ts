import type { RowDataPacket } from '../../database.js';
import { database } from "../../database.js";

export async function listAreaConfigs() {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT code, area_name, start_shelf, end_shelf, sort_config,
            sub_area, segment_area, ware_type, standby, status
       FROM xm_bulky_wms_area
      WHERE start_shelf > 0 AND end_shelf >= start_shelf
      ORDER BY status DESC, ware_type, standby, sequence, CAST(code AS UNSIGNED), code`,
  );
  return rows;
}

export async function accountHasCard(accountId: number) {
  const [rows] = await database.query<RowDataPacket[]>(
    `SELECT 1
       FROM wms_account account
       JOIN wms_role role ON role.id = account.role_id AND role.status = 1
      WHERE account.id = ? AND account.status = 1
        AND JSON_CONTAINS(COALESCE(NULLIF(role.data_cards_json, ''), JSON_ARRAY()), JSON_QUOTE('site-location-statistics'))
      LIMIT 1`,
    [accountId],
  );
  return rows.length > 0;
}
