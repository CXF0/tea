import type { RowDataPacket } from '../../database.js'
import { database } from '../../database.js'
export async function findAccount(login:string){const [rows]=await database.query<RowDataPacket[]>(`SELECT a.*,r.code role_code,r.name role_name,r.workbench_cards_json,r.todo_ids_json,r.scan_operations_json,r.data_cards_json FROM wms_account a JOIN wms_role r ON r.id=a.role_id AND r.status=1 WHERE (a.login_name=? OR a.phone=?) AND a.status=1 LIMIT 1`,[login,login]);return rows[0]}
export async function listCapabilities(roleId:number){const [rows]=await database.query<RowDataPacket[]>(`SELECT DISTINCT p.code FROM wms_role_permission_group rg JOIN wms_permission_group g ON g.id=rg.group_id AND g.status=1 JOIN wms_permission_group_item gi ON gi.group_id=g.id JOIN wms_permission p ON p.id=gi.permission_id AND p.status=1 WHERE rg.role_id=? ORDER BY p.code`,[roleId]);return rows.map(row=>String(row.code))}
export async function touchLogin(id:number){await database.query('UPDATE wms_account SET last_login_time=NOW() WHERE id=?',[id])}
export async function responsibilityZones(accountId:number,teamTypes:number[]){
  const [accounts]=await database.query<RowDataPacket[]>(`SELECT r.code role_code FROM wms_account a JOIN wms_role r ON r.id=a.role_id WHERE a.id=? AND a.status=1 LIMIT 1`,[accountId])
  const [areas]=await database.query<RowDataPacket[]>(`SELECT code,area_name FROM xm_bulky_wms_area WHERE status=1 ORDER BY sequence,CAST(code AS UNSIGNED),code`)
  if(String(accounts[0]?.role_code)==='superAdmin')return{all:true,areas}
  const [identities]=await database.query<RowDataPacket[]>(`SELECT source_user_id FROM wms_account_source_identity WHERE account_id=? AND source_system='bulkyGoods'`,[accountId])
  const sourceIds=identities.map(row=>Number(row.source_user_id)).filter(Boolean)
  let teams:RowDataPacket[]=[]
  if(sourceIds.length){
    const [rows]=await database.query<RowDataPacket[]>(`SELECT DISTINCT t.perm_config FROM xm_bulky_team t LEFT JOIN xm_bulky_team_user tu ON tu.team_id=t.id WHERE t.active_flag=1 AND t.data_status=0 AND t.type IN (?) AND (t.leader_id IN (?) OR tu.user_id IN (?))`,[teamTypes,sourceIds,sourceIds])
    teams=rows
  }
  const allowed=new Set<string>()
  for(const team of teams){try{const config=JSON.parse(String(team.perm_config||'{}'));if(Array.isArray(config.zones))for(const zone of config.zones)allowed.add(String(Number(zone)))}catch{}}
  if(teamTypes.includes(4)){
    const [direct]=await database.query<RowDataPacket[]>(`SELECT zone_code FROM wms_account_inspection_area WHERE account_id=?`,[accountId])
    for(const row of direct)allowed.add(String(Number(row.zone_code)))
  }
  return{all:false,areas:areas.filter(row=>allowed.has(String(Number(row.code))))}
}
