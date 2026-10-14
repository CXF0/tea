import 'dotenv/config'
import mysql from './sqlite-client.mjs'

const connection = await mysql.createConnection({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
})

const roundNo = process.argv[2] || '2026-09-22'
if (!/^\d{4}-\d{2}-\d{2}$/.test(roundNo) || Number.isNaN(Date.parse(`${roundNo}T00:00:00+08:00`))) throw new Error('日期格式必须为有效的 YYYY-MM-DD')
const dateTag = roundNo.replaceAll('-', '')
const prefix = `BPDTEST${dateTag}`
const addDays = days => {
  const value = new Date(`${roundNo}T00:00:00+08:00`)
  value.setDate(value.getDate() + days)
  return value.toLocaleDateString('sv-SE', { timeZone: 'Asia/Shanghai' })
}
const nextDate = addDays(1), settlementDate = addDays(3)
const publisher = { id: 42834, name: '云可鲜花' }
const suppliers = [
  { id: 42834, name: '云可鲜花', tag: '斗南基地', dounan: 1 },
  { id: 42835, name: '近山花卉', tag: '斗南基地', dounan: 1 },
  { id: 42836, name: '李皮花卉', tag: '沈伍营基地', dounan: 0 },
  { id: 42837, name: '名轩花卉', tag: '大树营基地', dounan: 0 },
  { id: 42838, name: '元美花卉', tag: '八街基地', dounan: 0 },
  { id: 42846, name: '槿槿花卉', tag: '九厂基地', dounan: 0 },
]
const demandSpecs = [
  { no: `${prefix}01`, theme: '国庆红玫瑰备货', secondId: 93, secondName: '卡罗拉', spec: 20, ranks: '1,2', demand: 6000, append: 0, min: 1000, scope: 1, status: 0, remark: '草稿，尚未发布' },
  { no: `${prefix}02`, theme: '婚庆白玫瑰集采', secondId: 94, secondName: '雪山', spec: 20, ranks: '1,2,3', demand: 8200, append: 800, min: 800, scope: 2, status: 1, remark: '报价进行中，包含追加需求' },
  { no: `${prefix}03`, theme: '精品粉玫瑰集采', secondId: 95, secondName: '粉雪山', spec: 20, ranks: '1,2', demand: 7200, append: 0, min: 600, scope: 3, status: 2, remark: '报价结束，等待定采' },
  { no: `${prefix}04`, theme: '晚场泡泡花补充采购', secondId: 101, secondName: '狂欢泡泡', spec: 10, ranks: '1,2,3', demand: 5000, append: 500, min: 500, scope: 5, status: 3, remark: '已完成定采，供货单处理中' },
  { no: `${prefix}05`, theme: '洋桔梗稳定供应计划', secondId: 103, secondName: '白色洋桔梗', spec: 10, ranks: '2,3', demand: 4800, append: 0, min: 400, scope: 4, status: 4, remark: '采集与结算均已完成' },
  { no: `${prefix}06`, theme: '向日葵临时采购', secondId: 109, secondName: '向日葵', spec: 10, ranks: '1,2', demand: 3000, append: 0, min: 300, scope: 1, status: 5, remark: '因交货计划调整人工关闭' },
]

async function insert(sql, values) {
  const [result] = await connection.execute(sql, values)
  return Number(result.insertId)
}

try {
  await connection.beginTransaction()
  const [oldDemands] = await connection.query('SELECT id FROM bulk_purchase_demand WHERE demand_no LIKE ?', [`${prefix}%`])
  const oldIds = oldDemands.map(row => Number(row.id))
  if (oldIds.length) {
    const [oldOrders] = await connection.query('SELECT id FROM bulk_purchase_order WHERE demand_id IN (?)', [oldIds])
    const orderIds = oldOrders.map(row => Number(row.id))
    const [oldQuotes] = await connection.query('SELECT id FROM bulk_purchase_quote WHERE demand_id IN (?)', [oldIds])
    const quoteIds = oldQuotes.map(row => Number(row.id))
    if (orderIds.length) {
      await connection.query('DELETE FROM bulk_purchase_label WHERE order_id IN (?)', [orderIds])
      await connection.query('DELETE FROM bulk_purchase_order_rank WHERE order_id IN (?)', [orderIds])
      await connection.query('DELETE FROM bulk_purchase_order WHERE id IN (?)', [orderIds])
    }
    if (quoteIds.length) await connection.query('DELETE FROM bulk_purchase_quote_rank WHERE quote_id IN (?)', [quoteIds])
    await connection.query('DELETE FROM bulk_purchase_quote WHERE demand_id IN (?)', [oldIds])
    await connection.query('DELETE FROM bulk_purchase_demand_supplier WHERE demand_id IN (?)', [oldIds])
    await connection.query('DELETE FROM bulk_purchase_demand WHERE id IN (?)', [oldIds])
  }

  const demandMap = new Map()
  for (let index = 0; index < demandSpecs.length; index += 1) {
    const item = demandSpecs[index]
    const confirmed = item.status >= 3 && item.status <= 4
    const finished = item.status === 4
    const closed = item.status === 5
    const id = await insert(`INSERT INTO bulk_purchase_demand
      (demand_no,theme,publish_supplier_id,publish_supplier_name,round_no,second_id,second_name,spec_num,spec_unit,rank_codes,demand_num,append_num,min_quote_num,scope_type,scope_config,dounan_quote_end_time,non_dounan_quote_end_time,dounan_check_in_end_time,non_dounan_check_in_end_time,collect_end_time,status,terminate_type,close_reason,confirm_time,confirm_by,confirm_name,confirm_reason,finish_type,finish_time,finish_by,finish_name,remark,create_by,create_name,create_time,update_time)
      VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
      item.no, item.theme, publisher.id, publisher.name, roundNo, item.secondId, item.secondName, item.spec, '枝', item.ranks,
      item.demand, item.append, item.min, item.scope, JSON.stringify({ baseTags: ['斗南基地', '沈伍营基地'] }),
      `${roundNo} 18:00:00`, `${roundNo} 16:00:00`, `${roundNo} 22:30:00`, `${roundNo} 20:00:00`, `${nextDate} 12:00:00`, item.status,
      closed ? 2 : null, closed ? 2 : null, confirmed ? `${roundNo} 18:30:00` : null, confirmed ? 1 : null, confirmed ? '集采运营员' : null,
      null, finished ? 1 : null, finished ? `${nextDate} 10:30:00` : null, finished ? 1 : null, finished ? '集采运营员' : null,
      item.remark, 1, '集采运营员', `${roundNo} ${String(9 + index).padStart(2, '0')}:10:00`, `${roundNo} ${String(10 + index).padStart(2, '0')}:20:00`,
    ])
    demandMap.set(item.no, { ...item, id })
    for (const supplier of suppliers.slice(0, item.status === 0 ? 2 : 5)) {
      await insert(`INSERT INTO bulk_purchase_demand_supplier
        (demand_id,demand_no,supplier_id,supplier_name,supplier_tag,is_dounan,month_sell_count,hit_condition,source,create_time)
        VALUES (?,?,?,?,?,?,?,?,?,?)`, [id, item.no, supplier.id, supplier.name, supplier.tag, supplier.dounan, 12000 + supplier.id % 1000, item.scope === 1 ? '全部供应商' : '符合本次采购范围', 1, `${roundNo} 10:00:00`])
    }
  }

  const quoteMap = new Map()
  const quotePlans = [
    [2, 0, 1, 3600, 0], [2, 1, 1, 2800, 0],
    [3, 0, 1, 3200, 0], [3, 2, 1, 2600, 0], [3, 3, 1, 1800, 0],
    [4, 0, 1, 2400, 1], [4, 1, 1, 2100, 1], [4, 2, 1, 1600, 2],
    [5, 3, 1, 2600, 1], [5, 4, 1, 2200, 1],
  ]
  for (let index = 0; index < quotePlans.length; index += 1) {
    const [demandNumber, supplierNumber, version, supply, selected] = quotePlans[index]
    const demand = demandSpecs[demandNumber - 1]
    const demandRow = demandMap.get(demand.no)
    const supplier = suppliers[supplierNumber]
    const quoteNo = `BPQTEST${dateTag}${String(index + 1).padStart(2, '0')}`
    const quoteId = await insert(`INSERT INTO bulk_purchase_quote
      (quote_no,demand_id,demand_no,supplier_id,supplier_name,version,total_supply_num,is_current,select_status,submit_time,create_time)
      VALUES (?,?,?,?,?,?,?,?,?,?,?)`, [quoteNo, demandRow.id, demand.no, supplier.id, supplier.name, version, supply, 1, selected, `${roundNo} 15:${String(index).padStart(2, '0')}:00`, `${roundNo} 15:${String(index).padStart(2, '0')}:00`])
    quoteMap.set(`${demandNumber}-${supplierNumber}`, { id: quoteId, no: quoteNo, supply })
    for (const rankCode of demand.ranks.split(',').map(Number)) {
      await insert('INSERT INTO bulk_purchase_quote_rank (quote_id,demand_id,supplier_id,rank_code,price,create_time) VALUES (?,?,?,?,?,?)', [quoteId, demandRow.id, supplier.id, rankCode, 1.6 + rankCode * 0.35 + supplierNumber * 0.08, `${roundNo} 15:00:00`])
    }
  }

  const orderPlans = [
    { seq: 1, demand: 4, supplier: 0, status: 10, confirm: 1800, actual: 0, scanned: 0, late: 0 },
    { seq: 2, demand: 4, supplier: 1, status: 20, confirm: 1700, actual: 600, scanned: 60, late: 1 },
    { seq: 3, demand: 4, supplier: 2, status: 90, confirm: 1200, actual: 0, scanned: 0, late: 0 },
    { seq: 4, demand: 5, supplier: 3, status: 30, confirm: 2400, actual: 2280, scanned: 228, late: 0 },
    { seq: 5, demand: 5, supplier: 4, status: 40, confirm: 2000, actual: 1960, scanned: 196, late: 0 },
  ]
  for (const plan of orderPlans) {
    const demand = demandSpecs[plan.demand - 1]
    const demandRow = demandMap.get(demand.no)
    const supplier = suppliers[plan.supplier]
    const quote = quoteMap.get(`${plan.demand}-${plan.supplier}`)
    const orderNo = `BPOTEST${dateTag}${String(plan.seq).padStart(2, '0')}`
    const checkedIn = [20, 30, 40].includes(plan.status)
    const inventoried = [30, 40].includes(plan.status)
    const settled = plan.status === 40
    const cancelled = plan.status === 90
    const price = 2.3 + plan.supplier * 0.12
    const settleNum = inventoried ? plan.actual : null
    const totalAmount = inventoried ? Number((plan.actual * price).toFixed(2)) : null
    const orderId = await insert(`INSERT INTO bulk_purchase_order
      (order_no,shelf_code,demand_id,demand_no,quote_id,publish_supplier_id,supplier_id,supplier_name,supplier_tag,is_dounan,round_no,second_id,second_name,spec_num,total_supply_num,confirm_num,check_in_end_time,check_in_time,check_in_by,check_in_name,plate_no,delivery_addr,delivery_remark,late_flag,output_end_time,actual_num,settle_num,settle_num_modified,over_flag,inventory_by,inventory_name,inventory_start_time,inventory_remark,inventory_submit_by,inventory_submit_name,inventory_submit_time,total_amount,plan_settle_time,settle_time,settle_flag,settle_type,settle_remark,settle_by,settle_name,status,cancel_type,cancel_reason,cancel_by,cancel_name,cancel_time,create_time,update_time)
      VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
      orderNo, `JC-${String(plan.seq).padStart(3, '0')}`, demandRow.id, demand.no, quote.id, publisher.id, supplier.id, supplier.name, supplier.tag, supplier.dounan,
      roundNo, demand.secondId, demand.secondName, demand.spec, quote.supply, plan.confirm, `${roundNo} ${supplier.dounan ? '22:30' : '20:00'}:00`,
      checkedIn ? `${roundNo} ${plan.late ? '20:18' : '19:20'}:00` : null, checkedIn ? 1 : null, checkedIn ? '驻场收货员' : null,
      checkedIn ? `云A${String(36000 + plan.seq)}` : null, '梦花集采收货区', checkedIn ? `实到${plan.actual}枝` : null, plan.late, `${nextDate} 12:00:00`,
      plan.actual, settleNum, 0, 0, null, null, inventoried ? `${roundNo} 23:10:00` : null, inventoried && plan.actual < plan.confirm ? '实际到货少于定采量' : null,
      inventoried ? 1 : null, inventoried ? '盘点员周敏' : null, inventoried ? `${roundNo} 23:35:00` : null, totalAmount,
      inventoried ? `${settlementDate} 23:35:00` : null, settled ? `${nextDate} 09:20:00` : null, settled ? 1 : 0, settled ? 2 : null,
      settled ? '测试数据人工结算' : null, settled ? 1 : null, settled ? '财务审核员' : null, plan.status,
      cancelled ? 1 : null, cancelled ? '供应商无法按时供货' : null, cancelled ? 1 : null, cancelled ? '集采运营员' : null, cancelled ? `${roundNo} 18:45:00` : null,
      `${roundNo} 18:35:00`, settled ? `${nextDate} 09:20:00` : `${roundNo} 23:40:00`,
    ])
    const rankCodes = demand.ranks.split(',').map(Number)
    const totalLabels = Math.max(Math.ceil(plan.confirm / demand.spec), 1)
    let assignedScannedLabels = 0
    for (const [rankIndex, rankCode] of rankCodes.entries()) {
      const rankLabels = rankIndex === 0 ? Math.ceil(totalLabels * 0.6) : Math.floor(totalLabels * 0.4 / Math.max(rankCodes.length - 1, 1))
      const isLastRank = rankIndex === rankCodes.length - 1
      const desiredScanned = isLastRank
        ? plan.scanned - assignedScannedLabels
        : Math.floor(plan.scanned * (rankIndex === 0 ? 0.6 : 0.4 / Math.max(rankCodes.length - 1, 1)))
      const scannedForRank = Math.min(rankLabels, Math.max(desiredScanned, 0))
      assignedScannedLabels += scannedForRank
      const scannedStems = scannedForRank * demand.spec
      await insert(`INSERT INTO bulk_purchase_order_rank
        (order_id,order_no,rank_code,price,plan_label_num,printed_label_num,scanned_label_num,scanned_stem_num,settle_label_num,settle_stem_num,amount,create_time,update_time)
        VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)`, [orderId, orderNo, rankCode, price + rankCode * 0.1, rankLabels, rankLabels, scannedForRank, scannedStems, inventoried ? scannedForRank : null, inventoried ? scannedStems : null, inventoried ? scannedStems * (price + rankCode * 0.1) : null, `${roundNo} 18:40:00`, `${roundNo} 23:40:00`])
      for (let labelIndex = 1; labelIndex <= rankLabels; labelIndex += 1) {
        const labelStatus = cancelled ? 90 : labelIndex <= scannedForRank ? 30 : 10
        await insert(`INSERT INTO bulk_purchase_label
          (label_code,order_id,order_no,rank_code,seq_no,status,scan_time,scan_by,scan_name,product_id,revoke_count,void_time,void_reason,create_time,update_time)
          VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [`${orderNo}-${rankCode}-${String(labelIndex).padStart(4, '0')}`, orderId, orderNo, rankCode, labelIndex, labelStatus,
          labelStatus === 30 ? `${roundNo} 22:${String(labelIndex % 60).padStart(2, '0')}:00` : null, labelStatus === 30 ? 1 : null, labelStatus === 30 ? '盘点员周敏' : null,
          labelStatus === 30 ? 400076 : null, 0, cancelled ? `${roundNo} 18:45:00` : null, cancelled ? '供货单取消' : null, `${roundNo} 18:40:00`, `${roundNo} 23:40:00`])
      }
    }
  }

  await connection.commit()
  const [[summary]] = await connection.query(`SELECT
    (SELECT COUNT(*) FROM bulk_purchase_demand WHERE demand_no LIKE ?) demands,
    (SELECT COUNT(*) FROM bulk_purchase_quote WHERE demand_no LIKE ?) quotes,
    (SELECT COUNT(*) FROM bulk_purchase_order WHERE demand_no LIKE ?) orders,
    (SELECT COUNT(*) FROM bulk_purchase_label WHERE order_no LIKE ?) labels`, [`${prefix}%`, `${prefix}%`, `${prefix}%`, `BPOTEST${dateTag}%`])
  console.log(JSON.stringify({ roundNo, ...summary }, null, 2))
} catch (error) {
  await connection.rollback()
  throw error
} finally {
  await connection.end()
}
