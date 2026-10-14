import type { RowDataPacket } from '../../database.js'
import { database } from '../../database.js'

export async function listRestockDemand(date:string,filters:{zone?:string;type?:number}){
  const clauses=['item.date=?','item.data_status=0'];const params:Array<string|number>=[date]
  if(filters.zone){clauses.push('item.zone=?');params.push(filters.zone)}
  if(filters.type===1)clauses.push('item.lack_replenish_num>0')
  if(filters.type===2)clauses.push('COALESCE(item.return_replenish_num,0)>0')
  const [rows]=await database.query<RowDataPacket[]>(`SELECT item.product_name,item.rank_num,item.sku_config,item.zone,
    SUM(item.lack_replenish_num) shortage_need,SUM(COALESCE(item.return_replenish_num,0)) return_need,
    SUM(item.restock_item_num+item.wms_restock_num) site_need,SUM(item.already_restock_num) completed_num,SUM(COALESCE(plan.submitted_num,0)) submitted_num,
    GROUP_CONCAT(item.id ORDER BY item.id) enter_item_ids
    FROM xm_bulky_supplier_enter_item item LEFT JOIN (SELECT enter_item_id,SUM(need_num) submitted_num FROM sale_wms_restock_plan_item WHERE data_status=0 AND status<4 GROUP BY enter_item_id) plan ON plan.enter_item_id=item.id WHERE ${clauses.join(' AND ')}
    GROUP BY item.product_name,item.rank_num,item.sku_config,item.zone
    HAVING shortage_need+return_need+site_need>0
    ORDER BY CAST(item.zone AS UNSIGNED),item.product_name,item.rank_num`,params)
  return rows
}

export async function previewRestockItems(date:string,itemIds:number[]){
  const [rows]=await database.query<RowDataPacket[]>(`SELECT item.product_name,item.rank_num,item.sku_config,item.zone,
    SUM(item.lack_replenish_num+COALESCE(item.return_replenish_num,0)+item.restock_item_num+item.wms_restock_num-item.already_restock_num) need_num,
    GROUP_CONCAT(item.id ORDER BY item.id) enter_item_ids
    FROM xm_bulky_supplier_enter_item item WHERE item.date=? AND item.id IN (?) AND item.data_status=0
    GROUP BY item.product_name,item.rank_num,item.sku_config,item.zone HAVING need_num>0`,[date,itemIds])
  for(const row of rows){const [inventory]=await database.query<RowDataPacket[]>(`SELECT id product_id,rank_num,remain_stock,price FROM xm_bulky_product WHERE name=? AND sku_config=? AND data_status=0 AND product_status=1 AND remain_stock>0 AND rank_num<=? ORDER BY rank_num DESC`,[row.product_name,row.sku_config,row.rank_num]);row.inventory=inventory}
  return rows
}

export async function getNextRestockSerial(date:string){
  const [rows]=await database.query<RowDataPacket[]>('SELECT COALESCE(MAX(serial_no),0)+1 serial_no FROM sale_wms_restock_plan WHERE round_no=? AND data_status=0',[date])
  return Number(rows[0]?.serial_no||1)
}

export async function listRestockPlans(date:string,filters:{status?:number;serialNo?:number;zone?:string}){
  const clauses=['p.round_no=?','p.data_status=0'];const params:Array<string|number>=[date]
  if(filters.status){clauses.push('p.status=?');params.push(filters.status)}
  if(filters.serialNo){clauses.push('p.serial_no=?');params.push(filters.serialNo)}
  if(filters.zone){clauses.push('EXISTS (SELECT 1 FROM sale_wms_restock_plan_zone pz WHERE pz.plan_id=p.id AND pz.data_status=0 AND pz.zone=?)');params.push(filters.zone)}
  const [rows]=await database.query<RowDataPacket[]>(`SELECT p.*,
    (SELECT GROUP_CONCAT(DISTINCT pz.zone ORDER BY CAST(pz.zone AS UNSIGNED)) FROM sale_wms_restock_plan_zone pz WHERE pz.plan_id=p.id AND pz.data_status=0) zones,
    (SELECT COUNT(*) FROM sale_wms_restock_plan_summary s WHERE s.plan_id=p.id AND s.data_status=0) variety_count
    FROM sale_wms_restock_plan p WHERE ${clauses.join(' AND ')} ORDER BY p.serial_no DESC,p.id DESC`,params)
  return rows
}

export async function getRestockPlanItems(planId:number){
  const [rows]=await database.query<RowDataPacket[]>(`SELECT product_name,need_rank_num,need_sku_config,zone,
    SUM(need_num) need_num,SUM(prepare_num) prepare_num,
    SUM(allocated_0_num+allocated_1_num+allocated_2_num+allocated_downgrade_num) allocated_num
    FROM sale_wms_restock_plan_summary WHERE plan_id=? AND data_status=0
    GROUP BY product_name,need_rank_num,need_sku_config,zone ORDER BY CAST(zone AS UNSIGNED),product_name,need_rank_num`,[planId])
  return rows
}

export async function createRestockPlan(date:string,itemIds:number[],strategy:number,userId:number,userName:string){
  const connection=await database.getConnection()
  try{await connection.beginTransaction()
    const [items]=await connection.query<RowDataPacket[]>(`SELECT item.* FROM xm_bulky_supplier_enter_item item WHERE item.date=? AND item.id IN (?) AND item.data_status=0 FOR UPDATE`,[date,itemIds])
    const valid=[] as RowDataPacket[]
    for(const item of items){const [exists]=await connection.query<RowDataPacket[]>('SELECT id FROM sale_wms_restock_plan_item WHERE enter_item_id=? AND data_status=0 AND status<4 LIMIT 1',[item.id]);const need=Number(item.lack_replenish_num)+Number(item.return_replenish_num||0)+Number(item.restock_item_num)+Number(item.wms_restock_num)-Number(item.already_restock_num);if(!exists.length&&need>0)valid.push({...item,submit_need:need})}
    if(!valid.length){await connection.rollback();return{kind:'empty' as const}}
    const [serialRows]=await connection.query<RowDataPacket[]>('SELECT COALESCE(MAX(serial_no),0)+1 serial FROM sale_wms_restock_plan WHERE round_no=? AND data_status=0',[date]);const serial=Number(serialRows[0].serial);const planSn=`RP${date.replaceAll('-','')}${String(serial).padStart(3,'0')}`;const total=valid.reduce((sum,item)=>sum+Number(item.submit_need),0)
    const [planResult]=await connection.execute(`INSERT INTO sale_wms_restock_plan (plan_sn,round_no,serial_no,total_need_num,allocated_num,prepare_num,status,restock_strategy,submitter_id,submitter_name) VALUES (?,?,?,?,0,0,1,?,?,?)`,[planSn,date,serial,total,strategy,userId,userName]);const planId=Number((planResult as {insertId:number}).insertId)
    const zones=[...new Set(valid.map(item=>String(item.zone)))];for(const zone of zones)await connection.execute('INSERT INTO sale_wms_restock_plan_zone (plan_id,zone,data_status,create_time,update_time) VALUES (?,?,0,NOW(),NOW())',[planId,zone])
    for(const item of valid){const shortage=Number(item.lack_replenish_num),returned=Number(item.return_replenish_num||0);const restockType=shortage>0&&returned>0?3:shortage>0?1:2
      const [summaryResult]=await connection.execute(`INSERT INTO sale_wms_restock_plan_summary (round_no,zone,need_rank_num,need_sku_config,product_name,need_num,plan_id,status,prepare_num,operator_id,operator_name,data_status,create_time,update_time) VALUES (?,?,?,?,?,?,?,2,0,?,?,0,NOW(),NOW())`,[date,item.zone,item.rank_num,item.sku_config,item.product_name,item.submit_need,planId,userId,userName]);const summaryId=Number((summaryResult as {insertId:number}).insertId)
      await connection.execute(`INSERT INTO sale_wms_restock_plan_item (plan_id,restock_type,round_no,zone,shelf,zone_shelf,enter_item_id,order_item_id,order_sn,summary_id,shelf_sn,product_name,need_rank_num,need_sku_config,need_num,prepare_num,status,operator_id,operator_name,data_status) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,0,2,?,?,0)`,[planId,restockType,date,item.zone,item.shelf,item.zone_shelf,item.id,item.order_item_id,item.order_sn,summaryId,item.order_num,item.product_name,item.rank_num,item.sku_config,item.submit_need,userId,userName])
    }
    await connection.commit();return{kind:'success' as const,planId,planSn,totalNeedNum:total,itemCount:valid.length}
  }catch(error){await connection.rollback();throw error}finally{connection.release()}
}
