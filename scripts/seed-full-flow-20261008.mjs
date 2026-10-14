import mysql from 'mysql2/promise'

const sourceDate = process.argv[2] || '2026-09-22'
const targetDate = process.argv[3] || '2026-10-08'
if (!/^\d{4}-\d{2}-\d{2}$/.test(sourceDate) || !/^\d{4}-\d{2}-\d{2}$/.test(targetDate)) {
  throw new Error('用法：node scripts/seed-full-flow-20261008.mjs [sourceDate] [targetDate]，日期格式 yyyy-MM-dd')
}
const targetCompact = targetDate.replaceAll('-', '')
const sourceCompact = sourceDate.replaceAll('-', '')
const shiftMs = new Date(`${targetDate}T00:00:00+08:00`).getTime() - new Date(`${sourceDate}T00:00:00+08:00`).getTime()

const connection = await mysql.createConnection({
  host: '127.0.0.1',
  port: 3306,
  user: 'menghua_local',
  password: process.env.DB_PASSWORD,
  database: 'menghuacangguan_v1_local',
  multipleStatements: false,
})

function shifted(value) {
  if (value instanceof Date) return new Date(value.getTime() + shiftMs)
  return value
}

function rewriteBusinessNo(value) {
  if (typeof value !== 'string') return value
  return value.replaceAll(sourceCompact, targetCompact).replaceAll(sourceDate, targetDate)
}

function copyPayload(row, overrides = {}, skip = ['id']) {
  const payload = {}
  for (const [key, value] of Object.entries(row)) {
    if (skip.includes(key)) continue
    payload[key] = rewriteBusinessNo(shifted(value))
  }
  Object.assign(payload, overrides)
  return payload
}

async function insertRow(table, payload) {
  const [result] = await connection.query(`INSERT INTO ${table} SET ?`, payload)
  return Number(result.insertId)
}

async function countBy(table, column, value) {
  const [rows] = await connection.query(`SELECT COUNT(*) count FROM ${table} WHERE ${column} = ?`, [value])
  return Number(rows[0]?.count || 0)
}

async function copySupplierFlow() {
  const [entries] = await connection.query('SELECT * FROM xm_bulky_supplier_enter WHERE date = ? ORDER BY id', [sourceDate])
  if (!entries.length) throw new Error(`源场次 ${sourceDate} 没有入场数据`)

  const entryMap = new Map()
  for (const entry of entries) {
    const id = await insertRow('xm_bulky_supplier_enter', copyPayload(entry, { date: targetDate }))
    entryMap.set(Number(entry.id), id)
  }

  const [items] = await connection.query('SELECT * FROM xm_bulky_supplier_enter_item WHERE date = ? ORDER BY id', [sourceDate])
  const itemMap = new Map()
  for (const item of items) {
    const id = await insertRow('xm_bulky_supplier_enter_item', copyPayload(item, {
      enter_id: entryMap.get(Number(item.enter_id)),
      date: targetDate,
    }))
    itemMap.set(Number(item.id), id)
  }

  const oldItemIds = [...itemMap.keys()]
  if (oldItemIds.length) {
    const [marks] = await connection.query('SELECT * FROM xm_inspection_reason_record WHERE date = ? AND enter_item_id IN (?) ORDER BY id', [sourceDate, oldItemIds])
    for (const mark of marks) {
      const newItemId = itemMap.get(Number(mark.enter_item_id))
      const unit = String(mark.code_content || '').split('-').at(-1) || '1'
      await insertRow('xm_inspection_reason_record', copyPayload(mark, {
        date: targetDate,
        enter_item_id: newItemId,
        code_content: `QI-${newItemId}-${unit}`,
      }))
    }

    const [allocations] = await connection.query('SELECT * FROM xm_quality_unit_allocation WHERE enter_item_id IN (?) ORDER BY id', [oldItemIds])
    for (const allocation of allocations) {
      await insertRow('xm_quality_unit_allocation', copyPayload(allocation, {
        enter_item_id: itemMap.get(Number(allocation.enter_item_id)),
      }))
    }
  }

  return { entryMap, itemMap }
}

async function copyOrders() {
  const [orders] = await connection.query(
    'SELECT * FROM xm_bulky_order WHERE data_status = 0 AND (round_no = ? OR order_sn LIKE ?) ORDER BY id',
    [sourceDate, `%${sourceCompact}%`],
  )
  for (const order of orders) {
    await insertRow('xm_bulky_order', copyPayload(order, {
      round_no: targetDate,
      order_sn: String(order.order_sn || '').replaceAll(sourceCompact, targetCompact).replaceAll(sourceDate, targetDate),
      send_no: String(order.send_no || '').replaceAll(sourceCompact, targetCompact).replaceAll(sourceDate, targetDate),
      delivery_type: Number(order.id || 0) % 11 === 0 ? 2 : order.delivery_type,
      distribution_type: Number(order.id || 0) % 17 === 0 ? 2 : order.distribution_type,
    }))
  }
}

async function seedArrivalSpecialScenes() {
  const [items] = await connection.query(
    'SELECT id FROM xm_bulky_supplier_enter_item WHERE date = ? AND data_status = 0 ORDER BY id LIMIT 6',
    [targetDate],
  )
  const ids = items.map(item => Number(item.id))
  if (ids.length >= 2) {
    await connection.query('UPDATE xm_bulky_supplier_enter_item SET supplier_id = 0 WHERE id IN (?)', [ids.slice(0, 2)])
  }
}

async function seedAgencyDistributionScenes() {
  const [orders] = await connection.query(
    'SELECT order_sn FROM xm_bulky_order WHERE round_no = ? AND data_status = 0 ORDER BY id LIMIT 16',
    [targetDate],
  )
  const day = orders.slice(0, 10).map(row => row.order_sn)
  const night = orders.slice(10, 16).map(row => row.order_sn)
  if (day.length) await connection.query('UPDATE xm_bulky_order SET is_sale_agency = 1, order_tag = 1 WHERE order_sn IN (?)', [day])
  if (night.length) await connection.query('UPDATE xm_bulky_order SET is_sale_agency = 1, order_tag = 2 WHERE order_sn IN (?)', [night])
}

async function seedContractorDistributionScenes() {
  const [employees] = await connection.query(
    'SELECT employee_user_id FROM xm_bulky_external_distribution_contractor_account WHERE contractor_user_id = 990000009 AND data_status = 0 ORDER BY id',
  )
  const employeeIds = employees.map(row => Number(row.employee_user_id)).filter(Boolean)
  if (!employeeIds.length) return
  const [items] = await connection.query(
    'SELECT id, zone, item_num, prepare_item_num, zone_shelf FROM xm_bulky_supplier_enter_item WHERE date = ? AND data_status = 0 AND CAST(zone AS UNSIGNED) BETWEEN 1 AND 10 ORDER BY CAST(zone AS UNSIGNED), id',
    [targetDate],
  )
  for (const [index, item] of items.entries()) {
    const employeeId = employeeIds[index % employeeIds.length]
    const num = Number(item.prepare_item_num || Math.ceil(Number(item.item_num || 0) * 0.7))
    const hour = String(10 + (index % 4)).padStart(2, '0')
    const minute = String((index * 7) % 60).padStart(2, '0')
    await insertRow('xm_bulky_wms_prepare_op', {
      enter_item_id: item.id,
      user_id: employeeId,
      date: targetDate,
      num,
      create_time: `${targetDate} ${hour}:${minute}:00`,
      update_time: `${targetDate} ${hour}:${minute}:00`,
    })
  }
  for (let zone = 1; zone <= 10; zone += 1) {
    const code = String(zone).padStart(2, '0')
    const zoneItems = items.filter(item => Number(item.zone) === zone)
    if (!zoneItems.length) continue
    const totalItem = zoneItems.reduce((sum, item) => sum + Number(item.item_num || 0), 0)
    const shelfNums = zoneItems.map(item => Number(String(item.zone_shelf || '').split('-').pop() || 0)).filter(Boolean)
    await insertRow('xm_bulky_wms_pre_income', {
      date: targetDate,
      zone: code,
      min_shelf_sn: Math.min(...shelfNums),
      max_shelf_sn: Math.max(...shelfNums),
      shelf_num: new Set(shelfNums).size,
      total_weight: (totalItem * 0.18).toFixed(2),
      total_item_num: totalItem,
      prepare_pre_income: (totalItem * 0.08 + zone * 3).toFixed(2),
      package_pre_income: (totalItem * 0.04).toFixed(2),
      create_time: `${targetDate} 12:00:00`,
    })
  }
}

async function copyRestockPlans(itemMap) {
  const [plans] = await connection.query('SELECT * FROM sale_wms_restock_plan WHERE round_no = ? AND data_status = 0 ORDER BY id', [sourceDate])
  const planMap = new Map()
  const summaryMap = new Map()
  for (const plan of plans) {
    const id = await insertRow('sale_wms_restock_plan', copyPayload(plan, {
      round_no: targetDate,
      plan_sn: String(plan.plan_sn || `WMS3D-RP-${sourceCompact}-${plan.serial_no}`).replaceAll(sourceCompact, targetCompact).replaceAll(sourceDate, targetDate),
    }))
    planMap.set(Number(plan.id), id)
  }
  if (!planMap.size) return

  const [zones] = await connection.query('SELECT * FROM sale_wms_restock_plan_zone WHERE plan_id IN (?) ORDER BY id', [[...planMap.keys()]])
  for (const zone of zones) {
    await insertRow('sale_wms_restock_plan_zone', copyPayload(zone, { plan_id: planMap.get(Number(zone.plan_id)) }))
  }

  const [summaries] = await connection.query('SELECT * FROM sale_wms_restock_plan_summary WHERE round_no = ? AND plan_id IN (?) ORDER BY id', [sourceDate, [...planMap.keys()]])
  for (const summary of summaries) {
    const id = await insertRow('sale_wms_restock_plan_summary', copyPayload(summary, {
      round_no: targetDate,
      plan_id: planMap.get(Number(summary.plan_id)),
    }))
    summaryMap.set(Number(summary.id), id)
  }

  const [items] = await connection.query('SELECT * FROM sale_wms_restock_plan_item WHERE round_no = ? AND plan_id IN (?) ORDER BY id', [sourceDate, [...planMap.keys()]])
  for (const item of items) {
    await insertRow('sale_wms_restock_plan_item', copyPayload(item, {
      round_no: targetDate,
      plan_id: planMap.get(Number(item.plan_id)),
      enter_item_id: itemMap.get(Number(item.enter_item_id)) || item.enter_item_id,
      summary_id: summaryMap.get(Number(item.summary_id)) || item.summary_id,
    }))
  }
}

async function copyPackingAndLogistics() {
  const [statuses] = await connection.query('SELECT * FROM xm_bulky_shelf_package_status WHERE round_no = ? AND data_status = 0 ORDER BY id', [sourceDate])
  for (const status of statuses) {
    await insertRow('xm_bulky_shelf_package_status', copyPayload(status, { round_no: targetDate }))
  }

  const [packages] = await connection.query('SELECT * FROM xm_bulky_wms_express_package WHERE round_no = ? AND data_status = 0 ORDER BY id', [sourceDate])
  for (const item of packages) {
    const weightSeed = Number(item.shelf_sn || 0) + Number(item.serial_num || 0)
    await insertRow('xm_bulky_wms_express_package', copyPayload(item, {
      round_no: targetDate,
      total_weight: [16.5, 22.8, 36.2, 58.6][weightSeed % 4],
    }))
  }
}

async function seedColdStorage(newItemIds) {
  const [fallbackPurchasers] = await connection.query('SELECT id, nickname, phone_number FROM xm_bulky_purchaser WHERE data_status = 0 ORDER BY id LIMIT 1')
  const fallback = fallbackPurchasers[0] || { id: 0, nickname: '测试客户', phone_number: '13800000000' }
  const [items] = await connection.query(
    `SELECT item.id,item.date,item.zone_shelf,item.order_sn,ord.purchaser_id,ord.send_no,p.nickname,p.phone_number
       FROM xm_bulky_supplier_enter_item item
       LEFT JOIN xm_bulky_order ord ON ord.order_sn = item.order_sn AND ord.data_status = 0
       LEFT JOIN xm_bulky_purchaser p ON p.id = ord.purchaser_id
      WHERE item.id IN (?) ORDER BY item.id LIMIT 4`,
    [newItemIds],
  )
  let index = 0
  for (const item of items) {
    index += 1
    const purchaserId = Number(item.purchaser_id || fallback.id || 0)
    const storeType = index % 2 === 0 ? 1 : 2
    const stockId = await insertRow('xm_bulky_cold_stock', {
      purchaser_id: purchaserId,
      purchaser_mobile: item.phone_number || fallback.phone_number,
      purchaser_nick: item.nickname || fallback.nickname,
      ware_id: 1,
      store_type: storeType,
      store_round_no: targetDate,
      location_no: item.zone_shelf,
      origin_send_no: item.send_no || item.order_sn,
      source_enter_item_id: item.id,
      image_urls: JSON.stringify(['/uploads/seed/cold-storage.jpg']),
      stock_key: `seed-${targetCompact}-${item.id}`,
      package_total: storeType === 1 ? 3 : 0,
      package_out: 0,
      bunch_num: storeType === 2 ? 18 + index : 0,
      remaining_bunch_num: storeType === 2 ? 18 + index : null,
      stock_status: 10,
      plan_ship_date: targetDate,
      remark: '10月8日全流程演示数据',
      in_user_id: 110,
      in_user_name: '陈晓峰',
      in_time: `${targetDate} ${String(8 + index).padStart(2, '0')}:20:00`,
      data_status: 0,
    })
    await insertRow('xm_bulky_cold_out_task', {
      cold_stock_id: stockId,
      out_type: storeType === 1 ? 1 : 3,
      purchaser_id: purchaserId,
      store_type: storeType,
      link_send_no: item.send_no || item.order_sn,
      link_zone_shelf: item.zone_shelf,
      out_package_num: storeType === 1 ? 1 : 0,
      out_bunch_num: storeType === 2 ? 6 + index : 0,
      box_repack_flag: 0,
      task_status: index === 1 ? 20 : 10,
      out_remark: '全流程演示出库任务',
      operator_id: 110,
      operator_name: '陈晓峰',
      operate_time: `${targetDate} 10:${String(index * 8).padStart(2, '0')}:00`,
      finish_user_id: index === 1 ? 110 : null,
      finish_user_name: index === 1 ? '陈晓峰' : null,
      finish_time: index === 1 ? `${targetDate} 11:10:00` : null,
      finish_image_urls: index === 1 ? JSON.stringify(['/uploads/seed/cold-out.jpg']) : null,
      finish_remark: index === 1 ? '已完成演示出库' : null,
      data_status: 0,
    })
  }
}

async function seedTransport() {
  const [vehicles] = await connection.query('SELECT * FROM hub_vehicle WHERE status <> -100 ORDER BY id LIMIT 4')
  if (!vehicles.length) return
  const [entries] = await connection.query('SELECT supplier_id,supplier_name FROM xm_bulky_supplier_enter WHERE date = ? ORDER BY id LIMIT 4', [targetDate])
  let index = 0
  for (const vehicle of vehicles) {
    const supplier = entries[index % Math.max(entries.length, 1)] || { supplier_id: 0, supplier_name: '全部基地' }
    index += 1
    await insertRow('hub_dispatch_order', {
      dispatch_no: `DC${targetCompact}${String(index).padStart(3, '0')}`,
      round_no: targetDate,
      type: index % 2 === 0 ? 2 : 1,
      vehicle_id: vehicle.id,
      vehicle_name: vehicle.vehicle_no || vehicle.plate_no,
      plate_no: vehicle.plate_no,
      driver_id: vehicle.owner_user_id || 0,
      driver_name: vehicle.owner_name || `司机${index}`,
      driver_phone: '13800000000',
      platform: vehicle.platform || '自有车队',
      fee: 260 + index * 35,
      start_station_id: 1,
      start_station_name: '斗南仓',
      end_station_id: Number(supplier.supplier_id || 0),
      end_station_name: supplier.supplier_name || '基地',
      responsible_base_id: Number(supplier.supplier_id || 0),
      responsible_base_name: supplier.supplier_name || '基地',
      checkin_count: 2 + index,
      status: index === 1 ? 2 : index === 2 ? 3 : 1,
      sign_status: index === 2 ? 1 : 0,
      settle_status: index === 2 ? 1 : 0,
      settle_amount: index === 2 ? 320 : 0,
      total_mileage: 18 + index * 5,
      total_duration: 45 + index * 12,
      dounan_depart_time: `${targetDate} 07:${String(20 + index * 5).padStart(2, '0')}:00`,
      direct_minutes: 40 + index * 5,
      support_base_flag: index === 4 ? 1 : 0,
      remark: '10月8日全流程演示派车任务',
      operator_id: 110,
      operator_name: '陈晓峰',
    })
  }
}

async function seedQualitySnapshots(newItemIds) {
  const inspectors = [
    { user_id: 1, user_name: '李师傅', required: 8 },
    { user_id: 2, user_name: '王主管', required: 6 },
    { user_id: 110, user_name: '陈晓峰', required: 5 },
  ]
  for (const inspector of inspectors) {
    const snapshotId = await insertRow('xm_bulky_inspection_assign_snapshot', {
      round_no: targetDate,
      user_id: inspector.user_id,
      user_name: inspector.user_name,
      leader_flag: inspector.user_id === 110 ? 1 : 0,
      special_area_flag: 0,
      good_flower_video_required_num: inspector.required,
    })
    const itemId = newItemIds[inspectors.indexOf(inspector)]
    if (!itemId) continue
    const [rows] = await connection.query('SELECT * FROM xm_bulky_supplier_enter_item WHERE id = ? LIMIT 1', [itemId])
    const item = rows[0]
    await insertRow('xm_bulky_inspection_video_record', {
      user_id: inspector.user_id,
      date: targetDate,
      snapshot_id: snapshotId,
      enter_item_id: item.id,
      product_id: item.product_id,
      item_name: item.product_name,
      supplier_name: '',
      supplier_tag: '',
      sub_shelf_sn: item.sub_shelf_sn || '',
      zone_shelf: item.zone_shelf || '',
      video_url: '/uploads/seed/good-flower.mp4',
      remark: '好花视频演示数据',
      rank_num: item.rank_num,
      supplier_id: item.supplier_id,
      shelf_sn: item.order_num,
      create_time: `${targetDate} 09:30:00`,
      update_time: `${targetDate} 09:30:00`,
    })
  }
}

async function seedQualityIssueCoverage() {
  const inspectors = [
    { id: 1, name: '李师傅' },
    { id: 60, name: '吴宗兴' },
    { id: 110, name: '陈晓峰' },
    { id: 2, name: '王主管' },
  ]
  const problems = [
    { op: 1, reason: '花头损伤', parent: '外观问题' },
    { op: 6, reason: '实收缺货', parent: '数量问题' },
    { op: 5, reason: '品质退货', parent: '退货问题' },
    { op: 12, reason: '客户换货', parent: '换货问题' },
  ]
  const [items] = await connection.query(
    'SELECT id, zone, item_num FROM xm_bulky_supplier_enter_item WHERE date = ? AND data_status = 0 ORDER BY CAST(zone AS UNSIGNED), id',
    [targetDate],
  )
  for (const item of items) {
    const zoneNum = Number(item.zone || 0)
    if (!zoneNum || zoneNum > 20) continue
    const [exists] = await connection.query(
      'SELECT COUNT(*) count FROM xm_inspection_reason_record WHERE date = ? AND enter_item_id = ? AND data_status = 0',
      [targetDate, item.id],
    )
    if (Number(exists[0]?.count || 0) > 0) continue
    const problem = problems[(zoneNum - 1) % problems.length]
    const inspector = inspectors[(zoneNum - 1) % inspectors.length]
    const unit = Math.min(Math.max(1, (zoneNum % 3) + 1), Number(item.item_num || 1))
    const minute = String((zoneNum * 3) % 60).padStart(2, '0')
    const hour = String(9 + (zoneNum % 5)).padStart(2, '0')
    await insertRow('xm_inspection_reason_record', {
      date: targetDate,
      enter_item_id: item.id,
      order_item_id: 0,
      code_content: `QI-${item.id}-${unit}`,
      op: problem.op,
      reason_id: 0,
      reason_name: problem.reason,
      parent_reason_id: 0,
      parent_reason_name: problem.parent,
      user_id: inspector.id,
      user_name: inspector.name,
      evidence_media_json: '[]',
      allow_downgrade_restock: problem.op === 1 ? 1 : 0,
      create_time: `${targetDate} ${hour}:${minute}:00`,
      update_time: `${targetDate} ${hour}:${minute}:00`,
      data_status: 0,
    })
  }
  await connection.query(
    `UPDATE xm_bulky_supplier_enter_item item
      JOIN (
        SELECT enter_item_id, COUNT(DISTINCT code_content) count
        FROM xm_inspection_reason_record
        WHERE date = ? AND data_status = 0
        GROUP BY enter_item_id
      ) mark ON mark.enter_item_id = item.id
      SET item.not_qualify_num = mark.count, item.is_qualify = 10, item.update_time = NOW()
      WHERE item.date = ? AND item.data_status = 0`,
    [targetDate, targetDate],
  )
}

async function main() {
  const targetCounts = [
    ['xm_bulky_supplier_enter', 'date'],
    ['xm_bulky_supplier_enter_item', 'date'],
    ['xm_bulky_order', 'round_no'],
    ['xm_bulky_shelf_package_status', 'round_no'],
    ['xm_bulky_wms_express_package', 'round_no'],
    ['sale_wms_restock_plan', 'round_no'],
    ['hub_dispatch_order', 'round_no'],
  ]
  for (const [table, column] of targetCounts) {
    const count = await countBy(table, column, targetDate)
    if (count > 0) throw new Error(`${table}.${column} 已存在 ${targetDate} 数据（${count} 条），为避免覆盖已中止`)
  }

  await connection.beginTransaction()
  try {
    const { itemMap } = await copySupplierFlow()
    await copyOrders()
    await seedArrivalSpecialScenes()
    await seedAgencyDistributionScenes()
    await copyRestockPlans(itemMap)
    await copyPackingAndLogistics()
    const newItemIds = [...itemMap.values()]
    await seedColdStorage(newItemIds)
    await seedTransport()
    await seedQualitySnapshots(newItemIds)
    await seedQualityIssueCoverage()
    await seedContractorDistributionScenes()
    await connection.commit()
  } catch (error) {
    await connection.rollback()
    throw error
  }

  const checks = {}
  for (const [name, sql, params] of [
    ['admissions', 'SELECT COUNT(*) count FROM xm_bulky_supplier_enter WHERE date=?', [targetDate]],
    ['arrivalItems', 'SELECT COUNT(*) count FROM xm_bulky_supplier_enter_item WHERE date=?', [targetDate]],
    ['orders', 'SELECT COUNT(*) count FROM xm_bulky_order WHERE round_no=?', [targetDate]],
    ['qualityMarks', 'SELECT COUNT(*) count FROM xm_inspection_reason_record WHERE date=?', [targetDate]],
    ['allocations', 'SELECT COUNT(*) count FROM xm_quality_unit_allocation a JOIN xm_bulky_supplier_enter_item item ON item.id=a.enter_item_id WHERE item.date=?', [targetDate]],
    ['restockPlans', 'SELECT COUNT(*) count FROM sale_wms_restock_plan WHERE round_no=?', [targetDate]],
    ['packingShelves', 'SELECT COUNT(*) count FROM xm_bulky_shelf_package_status WHERE round_no=?', [targetDate]],
    ['packages', 'SELECT COUNT(*) count FROM xm_bulky_wms_express_package WHERE round_no=?', [targetDate]],
    ['coldStocks', 'SELECT COUNT(*) count FROM xm_bulky_cold_stock WHERE store_round_no=?', [targetDate]],
    ['dispatches', 'SELECT COUNT(*) count FROM hub_dispatch_order WHERE round_no=?', [targetDate]],
  ]) {
    const [rows] = await connection.query(sql, params)
    checks[name] = Number(rows[0]?.count || 0)
  }
  console.log(JSON.stringify({ seeded: targetDate, checks }, null, 2))
}

try {
  await main()
} finally {
  await connection.end()
}
