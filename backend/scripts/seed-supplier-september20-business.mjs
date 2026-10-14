import mysql from 'mysql2/promise'
import 'dotenv/config'

if (process.env.DB_NAME !== 'menghuacangguan_v1_local') {
  throw new Error(`拒绝写入非本地新版库：${process.env.DB_NAME}`)
}

const date = '2026-09-20'
const catalog = [
  [1, '单头玫瑰', '卡罗拉', '红色', '60cm / 20枝/扎', 32.8],
  [1, '单头玫瑰', '雪山', '白色', '60cm / 20枝/扎', 35.6],
  [1, '单头玫瑰', '粉雪山', '粉色', '60cm / 20枝/扎', 38.8],
  [1, '单头玫瑰', '蜜桃雪山', '粉色', '70cm / 20枝/扎', 42.5],
  [1, '单头玫瑰', '香槟玫瑰', '香槟色', '60cm / 20枝/扎', 36.8],
  [1, '单头玫瑰', '洛神玫瑰', '复色', '70cm / 20枝/扎', 48.0],
  [2, '多头玫瑰', '橙色芭比', '橙色', '60cm / 10枝/扎', 39.8],
  [2, '多头玫瑰', '折射泡泡', '粉色', '60cm / 10枝/扎', 45.0],
  [2, '多头玫瑰', '狂欢泡泡', '复色', '60cm / 10枝/扎', 46.5],
  [3, '紫罗兰', '紫罗兰', '紫色', '60cm / 10枝/扎', 28.0],
  [4, '洋桔梗', '白色洋桔梗', '白色', '60cm / 10枝/扎', 31.5],
  [4, '洋桔梗', '粉色洋桔梗', '粉色', '60cm / 10枝/扎', 33.0],
  [4, '洋桔梗', '紫色洋桔梗', '紫色', '60cm / 10枝/扎', 32.0],
  [5, '康乃馨', '粉色康乃馨', '粉色', '60cm / 20枝/扎', 25.8],
  [5, '康乃馨', '红色康乃馨', '红色', '60cm / 20枝/扎', 26.8],
  [5, '康乃馨', '绿色康乃馨', '绿色', '60cm / 20枝/扎', 29.8],
  [6, '配花', '向日葵', '黄色', '单头 / 10枝/扎', 22.0],
  [6, '配花', '勿忘我', '紫色', '自然干花 / 1kg/扎', 18.0],
  [6, '配花', '满天星', '白色', '一级 / 1kg/扎', 42.0],
  [6, '配花', '绣球', '蓝色', '大头 / 5枝/扎', 55.0],
  [7, '配叶', '尤加利叶', '绿色', 'A级 / 10枝/扎', 24.0],
  [7, '配叶', '龟背叶', '绿色', 'A级 / 10片/扎', 20.0],
]

const connection = await mysql.createConnection({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
})

const categoryIds = new Map()
let productCount = 0
let orderCount = 0
let enterCount = 0
let enterItemCount = 0

try {
  await connection.beginTransaction()

  for (const [, firstName, secondName] of catalog) {
    const key = `${firstName}/${secondName}`
    if (categoryIds.has(key)) continue
    const [found] = await connection.execute(
      'SELECT id FROM xm_bulky_category WHERE name=? AND data_status=0 LIMIT 1',
      [secondName],
    )
    if (found[0]) categoryIds.set(key, Number(found[0].id))
    else {
      const [created] = await connection.execute(
        `INSERT INTO xm_bulky_category
          (ware_type,name,icon,router_type,redirect,sort_num,last_operator_id,data_status)
         VALUES (1,?,'',2,?, ?,0,0)`,
        [secondName, `一级分类:${firstName}`, categoryIds.size + 1],
      )
      categoryIds.set(key, Number(created.insertId))
    }
  }

  const [suppliers] = await connection.query(
    `SELECT DISTINCT s.id,s.supplier_name,s.login_tel,s.supplier_tag
       FROM xm_bulky_supplier s
       JOIN xm_bulky_supplier_tag st ON st.supplier_id=s.id
       JOIN xm_bulky_user_tag tag ON tag.id=st.tag_id AND tag.type=2 AND tag.tag_category='基地'
      WHERE DATE(s.create_time)=? AND s.type IN (1,2) AND s.data_status=2
      ORDER BY s.id DESC LIMIT 30`,
    [date],
  )

  for (let index = 0; index < suppliers.length; index += 1) {
    const supplier = suppliers[index]
    const admitted = index % 5 !== 0
    const enterTime = admitted ? `${String(6 + (index % 7)).padStart(2, '0')}:${String((index * 7) % 60).padStart(2, '0')}:00` : ''
    await connection.execute(
      `DELETE item FROM xm_bulky_supplier_enter_item item
        JOIN xm_bulky_supplier_enter enter_record ON enter_record.id=item.enter_id
       WHERE enter_record.date=? AND enter_record.supplier_id=? AND item.order_sn LIKE 'LOCAL-0920-%'`,
      [date, supplier.id],
    )
    await connection.execute(
      `DELETE FROM xm_bulky_supplier_enter WHERE date=? AND supplier_id=? AND id NOT IN
       (SELECT enter_id FROM xm_bulky_supplier_enter_item WHERE enter_id>0)`,
      [date, supplier.id],
    )
    const [existingEnter] = await connection.execute(
      'SELECT id FROM xm_bulky_supplier_enter WHERE date=? AND supplier_id=? LIMIT 1',
      [date, supplier.id],
    )
    let enterId
    if (existingEnter[0]) {
      enterId = Number(existingEnter[0].id)
      await connection.execute(
        `UPDATE xm_bulky_supplier_enter SET supplier_name=?,login_tel=?,enter_time=?,data_status=?,
         is_qualify=?,is_late=?,quality_inspection_flag=?,update_time=? WHERE id=?`,
        [supplier.supplier_name, supplier.login_tel, enterTime, admitted ? 1 : 0, admitted ? 1 : 0,
          admitted && enterTime > '10:00:00' ? 1 : 0, index % 7 === 0 ? 1 : 0, `${date} 18:00:00`, enterId],
      )
    } else {
      const [createdEnter] = await connection.execute(
        `INSERT INTO xm_bulky_supplier_enter
          (type,supplier_id,supplier_name,login_tel,date,operator_id,enter_time,data_status,night_enter_time,
           night_data_status,night_open,is_qualify,is_late,night_is_late,is_force_flag,quality_inspection_flag,
           distribution_overtime,create_time,update_time)
         VALUES (1,?,?,?,?,0,?,?, '',0,0,?,?,0,0,?,0,?,?)`,
        [supplier.id, supplier.supplier_name, supplier.login_tel, date, enterTime, admitted ? 1 : 0,
          admitted ? 1 : 0, admitted && enterTime > '10:00:00' ? 1 : 0, index % 7 === 0 ? 1 : 0,
          `${date} 05:30:00`, `${date} 18:00:00`],
      )
      enterId = Number(createdEnter.insertId)
      enterCount += 1
    }

    for (let itemIndex = 0; itemIndex < 2; itemIndex += 1) {
      const definition = catalog[(index * 2 + itemIndex) % catalog.length]
      const [firstId, firstName, productName, color, skuConfig, price] = definition
      const secondId = categoryIds.get(`${firstName}/${productName}`)
      const code = `LOCAL-${supplier.id}-${String(itemIndex + 1).padStart(2, '0')}`
      const rankNum = 1 + ((index + itemIndex) % 3)
      const itemNum = 12 + ((index * 5 + itemIndex * 7) % 34)
      const preparedNum = admitted ? Math.min(itemNum, (index * 3 + itemIndex * 4) % (itemNum + 1)) : 0
      let productId
      const [existingProduct] = await connection.execute('SELECT id FROM xm_bulky_product WHERE code=? LIMIT 1', [code])
      if (existingProduct[0]) {
        productId = Number(existingProduct[0].id)
        await connection.execute(
          `UPDATE xm_bulky_product SET first_id=?,second_id=?,name=?,rank_num=?,sku_config=?,color=?,price=?,
           supplier_id=?,remain_stock=?,product_status=1,data_status=0,update_time=? WHERE id=?`,
          [firstId, secondId, productName, rankNum, skuConfig, color, price, supplier.id,
            Math.max(itemNum - preparedNum, 0), `${date} 18:00:00`, productId],
        )
      } else {
        const [createdProduct] = await connection.execute(
          `INSERT INTO xm_bulky_product
            (second_id,first_id,ware_id,code,name,rank_num,sku_config,color,price,description,remark,supplier_id,
             remain_stock,product_status,on_sale_time_str,not_sale_time_str,expire_time,create_time,update_time,data_status)
           VALUES (?,?,1,?,?,?,?,?,?,?,'9月20日基地供应商品',?, ?,1,'06:00','23:59',?,?,?,0)`,
          [secondId, firstId, code, productName, rankNum, skuConfig, color, price,
            `${firstName} / ${productName}`, supplier.id, Math.max(itemNum - preparedNum, 0),
            `${date} 23:59:59`, `${date} 05:00:00`, `${date} 18:00:00`],
        )
        productId = Number(createdProduct.insertId)
        productCount += 1
      }

      const orderSn = `LOCAL-0920-${supplier.id}-${itemIndex + 1}`
      await connection.execute('DELETE FROM xm_bulky_order_item WHERE order_sn=?', [orderSn])
      await connection.execute('DELETE FROM xm_bulky_order WHERE order_sn=?', [orderSn])
      const [createdOrder] = await connection.execute(
        `INSERT INTO xm_bulky_order
          (purchaser_id,vip_name,order_sn,ware_id,send_no,round_no,order_num,total_item_num,total_weight,
           express,express_region,express_price,product_total_price,total_price,actual_price,receive_name,
           receive_tel,province,city,district,detail,receive_address,order_status,wx_pay_time,create_time,update_time,data_status)
         VALUES (?,?,?,?,?,?,1,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,0)`,
        [900000 + index, `9月20日采购商${index + 1}`, orderSn, 1, `SEND-${supplier.id}`,
          date, itemNum, itemNum * 500, 1, 1, 0, Number((price * itemNum).toFixed(2)),
          Number((price * itemNum).toFixed(2)), Number((price * itemNum).toFixed(2)), `收货人${index + 1}`,
          `1380000${String(index).padStart(4, '0')}`, '云南省', '昆明市', '呈贡区', '斗南花卉市场',
          '云南省昆明市呈贡区斗南花卉市场', admitted ? 30 : 20, `${date} 04:30:00`,
          `${date} 04:20:00`, `${date} 18:00:00`],
      )
      const [createdOrderItem] = await connection.execute(
        `INSERT INTO xm_bulky_order_item
          (purchaser_id,supplier_id,supplier_name,order_num,order_sn,round_no,supplier_no,product_id,product_name,
           second_id,rank_num,sku_config,pic_url,spec_and_num,description,remark,supply_price,pay_price,item_num,origin_item_num,total_price,
           total_weight,origin_total_weight,create_time,update_time,data_status)
         VALUES (?,?,?,1,?,?,?,?,?,?,?,?,'',?,'9月20日基地订单','',?,?,?,?,?,?,?,?,?,0)`,
        [900000 + index, supplier.id, supplier.supplier_name, orderSn, date, String(supplier.id), productId,
          productName, secondId, rankNum, skuConfig, skuConfig, price, price, itemNum, itemNum,
          Number((price * itemNum).toFixed(2)), itemNum * 500, itemNum * 500,
          `${date} 04:20:00`, `${date} 18:00:00`],
      )
      orderCount += 1

      await connection.execute(
        `INSERT INTO xm_bulky_supplier_enter_item
          (enter_id,ware_id,order_num,sub_shelf_sn,zone,shelf,zone_shelf,order_sn,date,supplier_id,order_item_id,
           product_id,product_name,rank_num,sku_config,item_num,order_item_num,order_item_weight,is_position,
           is_qualify,qualify_user_id,qualify_user_name,prepare_item_num,qualify_process_status,create_time,update_time,data_status)
         VALUES (?,1,1,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,0)`,
        [enterId, String(index + 1).padStart(3, '0'), String((index % 20) + 1),
          String(index + 1).padStart(3, '0'), `${String((index % 20) + 1).padStart(2, '0')}-${String(index + 1).padStart(3, '0')}`,
          orderSn, date, supplier.id, createdOrderItem.insertId, productId, productName, rankNum, skuConfig,
          itemNum, itemNum, itemNum * 500, admitted ? 1 : 0, admitted ? 1 : 0, admitted ? 63 : 0,
          admitted ? '孙一丽' : '', preparedNum, admitted ? 2 : 0,
          `${date} 05:30:00`, `${date} 18:00:00`],
      )
      enterItemCount += 1
    }
  }

  await connection.commit()
  console.log(JSON.stringify({ date, suppliers: suppliers.length, categories: categoryIds.size,
    productsCreated: productCount, ordersCreated: orderCount, admissionsCreated: enterCount,
    admissionItemsCreated: enterItemCount }))
} catch (error) {
  await connection.rollback()
  throw error
} finally {
  await connection.end()
}
