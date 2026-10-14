import { createHash, randomBytes } from 'node:crypto'
import type { RowDataPacket, ResultSetHeader } from '../../database.js'
import { database } from '../../database.js'

export async function hasCapability(userId:number, code:string) {
  const [rows]=await database.query<RowDataPacket[]>(`SELECT 1 FROM wms_account a JOIN wms_role_permission_group rg ON rg.role_id=a.role_id JOIN wms_permission_group_item gi ON gi.group_id=rg.group_id JOIN wms_permission p ON p.id=gi.permission_id AND p.status=1 WHERE a.id=? AND a.status=1 AND p.code=? LIMIT 1`,[userId,code])
  return rows.length>0
}

export async function context(accountId:number) {
  const [rows]=await database.query<RowDataPacket[]>(`SELECT t.id team_id,t.name team_name,s.source_user_id leader_source_id FROM wms_account_source_identity s JOIN xm_bulky_team t ON t.leader_id=s.source_user_id AND t.type=2 AND t.active_flag=1 AND t.data_status=0 WHERE s.account_id=? AND s.source_system='bulkyGoods' ORDER BY t.id LIMIT 1`,[accountId])
  return rows[0] || null
}

export async function accounts(leaderSourceId:number, keyword:string, status:number) {
  const like=`%${keyword}%`
  const [rows]=await database.query<RowDataPacket[]>(`SELECT a.id,a.login_name,a.phone,a.display_name,a.status,DATE_FORMAT(a.create_time,'%Y-%m-%d %H:%i:%s') create_time,s.source_user_id FROM xm_bulky_external_distribution_contractor_account rel JOIN wms_account_source_identity s ON s.source_system='bulkyGoods' AND s.source_user_id=rel.employee_user_id JOIN wms_account a ON a.id=s.account_id WHERE rel.contractor_user_id=? AND rel.data_status=0 AND a.status=? AND (?='' OR a.display_name LIKE ? OR a.phone LIKE ? OR a.login_name LIKE ?) ORDER BY a.create_time DESC,a.id DESC`,[leaderSourceId,status,keyword,like,like,like])
  return rows
}

export async function candidates(keyword:string) {
  const like=`%${keyword}%`
  const [rows]=await database.query<RowDataPacket[]>(`SELECT a.id,a.login_name,a.phone,a.display_name,a.status,r.name role_name,s.source_user_id,IF(rel.id IS NULL,1,0) bindable,t.name bound_team_name FROM wms_account a JOIN wms_role r ON r.id=a.role_id AND r.code IN ('picker','partTimePicker') LEFT JOIN wms_account_source_identity s ON s.account_id=a.id AND s.source_system='bulkyGoods' LEFT JOIN xm_bulky_external_distribution_contractor_account rel ON rel.employee_user_id=s.source_user_id AND rel.data_status=0 LEFT JOIN xm_bulky_team_user tu ON tu.user_id=s.source_user_id LEFT JOIN xm_bulky_team t ON t.id=tu.team_id AND t.type=2 AND t.active_flag=1 AND t.data_status=0 WHERE (?='' OR a.display_name LIKE ? OR a.phone LIKE ? OR a.login_name LIKE ?) ORDER BY bindable DESC,a.display_name,a.id LIMIT 60`,[keyword,like,like,like])
  return rows
}

async function ensureIdentity(connection:any, accountId:number) {
  const [found]=await connection.query(`SELECT source_user_id FROM wms_account_source_identity WHERE account_id=? AND source_system='bulkyGoods' LIMIT 1`,[accountId])
  if(found.length)return Number(found[0].source_user_id)
  const sourceId=991000000+accountId
  await connection.query(`INSERT INTO wms_account_source_identity(account_id,source_system,source_user_id) VALUES(?,'bulkyGoods',?)`,[accountId,sourceId])
  return sourceId
}

export async function bindAccount(team:any, accountId:number, operatorId:number) {
  const c=await database.getConnection(); try { await c.beginTransaction()
    const [valid]=await c.query<RowDataPacket[]>(`SELECT a.id,a.display_name FROM wms_account a JOIN wms_role r ON r.id=a.role_id AND r.code IN ('picker','partTimePicker') WHERE a.id=? LIMIT 1 FOR UPDATE`,[accountId])
    if(!valid.length) throw new Error('INVALID_ACCOUNT')
    const sourceId=await ensureIdentity(c,accountId)
    const [used]=await c.query<RowDataPacket[]>(`SELECT id FROM xm_bulky_external_distribution_contractor_account WHERE employee_user_id=? AND data_status=0 LIMIT 1 FOR UPDATE`,[sourceId])
    if(used.length) throw new Error('ACCOUNT_BOUND')
    await c.query(`INSERT INTO xm_bulky_external_distribution_contractor_account(contractor_user_id,employee_user_id,last_operator_id,data_status) VALUES(?,?,?,0)`,[team.leader_source_id,sourceId,operatorId])
    await c.query(`INSERT INTO xm_bulky_team_user(user_id,user_name,is_sub,team_id) VALUES(?,?,1,?) ON DUPLICATE KEY UPDATE user_name=VALUES(user_name),team_id=VALUES(team_id)`,[sourceId,valid[0].display_name,team.team_id])
    await c.query(`UPDATE xm_bulky_team SET people_num=(SELECT COUNT(*) FROM xm_bulky_team_user WHERE team_id=?) WHERE id=?`,[team.team_id,team.team_id])
    await c.commit(); return 1
  } catch(e){await c.rollback();throw e} finally{c.release()}
}

export async function createAccount(team:any,input:{loginName:string;name:string;phone:string},operatorId:number){
  const c=await database.getConnection(); try{await c.beginTransaction()
    const [role]=await c.query<RowDataPacket[]>(`SELECT id FROM wms_role WHERE code='picker' AND status=1 LIMIT 1`)
    const salt=randomBytes(12).toString('hex'); const hash=createHash('sha256').update(salt+'123456').digest('hex')
    const [result]=await c.query<ResultSetHeader>(`INSERT INTO wms_account(login_name,phone,display_name,password_salt,password_hash,role_id,warehouse_id,warehouse_name,status) VALUES(?,?,?,?,?,?,1,'梦花仓管',1)`,[input.loginName,input.phone,input.name,salt,hash,role[0].id])
    const sourceId=await ensureIdentity(c,result.insertId)
    await c.query(`INSERT INTO xm_bulky_external_distribution_contractor_account(contractor_user_id,employee_user_id,last_operator_id,data_status) VALUES(?,?,?,0)`,[team.leader_source_id,sourceId,operatorId])
    await c.query(`INSERT INTO xm_bulky_team_user(user_id,user_name,is_sub,team_id) VALUES(?,?,1,?)`,[sourceId,input.name,team.team_id])
    await c.query(`UPDATE xm_bulky_team SET people_num=(SELECT COUNT(*) FROM xm_bulky_team_user WHERE team_id=?) WHERE id=?`,[team.team_id,team.team_id])
    await c.commit();return result.insertId
  }catch(e){await c.rollback();throw e}finally{c.release()}
}

async function owned(leaderSourceId:number,accountId:number){const [rows]=await database.query<RowDataPacket[]>(`SELECT 1 FROM wms_account_source_identity s JOIN xm_bulky_external_distribution_contractor_account rel ON rel.employee_user_id=s.source_user_id AND rel.contractor_user_id=? AND rel.data_status=0 WHERE s.account_id=? AND s.source_system='bulkyGoods' LIMIT 1`,[leaderSourceId,accountId]);return rows.length>0}
export async function updateAccount(leaderSourceId:number,accountId:number,input:{loginName:string;name:string;phone:string}){if(!await owned(leaderSourceId,accountId))return 0;const[r]=await database.query<ResultSetHeader>(`UPDATE wms_account SET login_name=?,display_name=?,phone=? WHERE id=?`,[input.loginName,input.name,input.phone,accountId]);return r.affectedRows}
export async function setStatus(leaderSourceId:number,accountId:number,status:number){if(!await owned(leaderSourceId,accountId))return 0;const[r]=await database.query<ResultSetHeader>(`UPDATE wms_account SET status=? WHERE id=?`,[status,accountId]);return r.affectedRows}
export async function resetPassword(leaderSourceId:number,accountId:number){if(!await owned(leaderSourceId,accountId))return 0;const salt=randomBytes(12).toString('hex');const hash=createHash('sha256').update(salt+'123456').digest('hex');const[r]=await database.query<ResultSetHeader>(`UPDATE wms_account SET password_salt=?,password_hash=? WHERE id=?`,[salt,hash,accountId]);return r.affectedRows}

export async function statistics(leaderSourceId:number,keyword:string,type:'session'|'month',period:string){const like=`%${keyword}%`;const dateSql=type==='month'?'op.date LIKE ?':'op.date=?';const periodValue=type==='month'?`${period}%`:period;const [rows]=await database.query<RowDataPacket[]>(`SELECT a.id account_id,a.display_name,a.phone,s.source_user_id,COALESCE(SUM(op.num),0) total_num FROM xm_bulky_external_distribution_contractor_account rel JOIN wms_account_source_identity s ON s.source_system='bulkyGoods' AND s.source_user_id=rel.employee_user_id JOIN wms_account a ON a.id=s.account_id LEFT JOIN xm_bulky_wms_prepare_op op ON op.user_id=s.source_user_id AND ${dateSql} WHERE rel.contractor_user_id=? AND rel.data_status=0 AND (?='' OR a.display_name LIKE ? OR a.phone LIKE ?) GROUP BY a.id,a.display_name,a.phone,s.source_user_id ORDER BY total_num DESC,a.display_name`,[periodValue,leaderSourceId,keyword,like,like]);return rows}
export async function statisticZones(sourceId:number,type:'session'|'month',period:string){const dateSql=type==='month'?'op.date LIKE ?':'op.date=?';const value=type==='month'?`${period}%`:period;const[rows]=await database.query<RowDataPacket[]>(`SELECT item.zone,COALESCE(area.area_name,CONCAT(item.zone,'区')) zone_name,SUM(op.num) num FROM xm_bulky_wms_prepare_op op JOIN xm_bulky_supplier_enter_item item ON item.id=op.enter_item_id AND item.data_status=0 LEFT JOIN xm_bulky_wms_area area ON area.code=item.zone AND area.status=1 WHERE op.user_id=? AND ${dateSql} GROUP BY item.zone,area.area_name ORDER BY CAST(item.zone AS UNSIGNED),item.zone`,[sourceId,value]);return rows}
