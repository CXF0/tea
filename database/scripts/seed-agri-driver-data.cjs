const mysql = require('mysql2/promise')

const config = {
  host: process.env.DB_HOST || '127.0.0.1',
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER || 'menghua_local',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'menghuacangguan_v1_local',
  charset: 'utf8mb4',
}

const days = ['2026-09-20', '2026-09-21', '2026-09-22']
const firstClasses = [
  [920001, '包装耗材', 10],
  [920002, '生产工具', 20],
  [920003, '养护用品', 30],
]
const secondClasses = [
  [920011, 920001, '绑扎包装', 10],
  [920012, 920001, '花材防护', 20],
  [920021, 920002, '修剪工具', 10],
  [920031, 920003, '鲜花养护', 10],
]
const products = [
  { id: 920101, secondId: 920031, skuId: 920201, name: '鲜花保鲜剂', sku: '500ml/瓶', price: 18.8 },
  { id: 920102, secondId: 920031, skuId: 920202, name: '鲜花营养液', sku: '1L/瓶', price: 29.9 },
  { id: 920103, secondId: 920011, skuId: 920203, name: '环保扎带', sku: '1000根/包', price: 36.0 },
  { id: 920104, secondId: 920012, skuId: 920204, name: '鲜花透明套袋', sku: '500只/包', price: 42.5 },
  { id: 920105, secondId: 920021, skuId: 920205, name: '园艺剪枝剪', sku: '直刃款/把', price: 48.0 },
  { id: 920106, secondId: 920001, skuId: 920206, name: '鲜花运输纸箱', sku: '110×50×50cm', price: 12.8 },
]

async function main() {
  const db = await mysql.createConnection(config)
  try {
    await db.beginTransaction()
    const [buyers] = await db.query(`SELECT id,supplier_name,owner_name,owner_tel,address_detail
      FROM xm_bulky_supplier WHERE data_status=2 AND supplier_name<>'' ORDER BY id LIMIT 12`)
    const [baseRows] = await db.query(`SELECT name,address,contact_tel FROM xm_bulky_base_config
      WHERE name<>'' ORDER BY status DESC,sequence,id LIMIT 8`)
    if (buyers.length < 6 || baseRows.length < 3) throw new Error('现有供应商或基地基础数据不足，未写入订单')

    for (const [id, name, sort] of firstClasses) {
      await db.execute(`INSERT INTO xm_peasant_class_first(id,name,icon,sell_status,sort,data_status)
        VALUES(?,?,'',1,?,0) ON DUPLICATE KEY UPDATE name=VALUES(name),sell_status=1,sort=VALUES(sort),data_status=0`, [id, name, sort])
    }
    for (const [id, firstId, name, sort] of secondClasses) {
      await db.execute(`INSERT INTO xm_peasant_class_second(id,first_id,name,icon,sell_status,sort,data_status)
        VALUES(?,?,?,'',1,?,0) ON DUPLICATE KEY UPDATE first_id=VALUES(first_id),name=VALUES(name),sell_status=1,sort=VALUES(sort),data_status=0`, [id, firstId, name, sort])
    }

    const seller = buyers[0]
    for (const [index, product] of products.entries()) {
      await db.execute(`INSERT INTO xm_peasant_product(id,second_id,peasant_supplier_id,name,description,goods_img,images,sort,sell_count,stock,min_price,dn_min_price,sell_status,data_status)
        VALUES(?,?,?,?,'仓库日常作业使用的农资商品','','',?,0,9999,?,?,1,0)
        ON DUPLICATE KEY UPDATE second_id=VALUES(second_id),peasant_supplier_id=VALUES(peasant_supplier_id),name=VALUES(name),description=VALUES(description),min_price=VALUES(min_price),dn_min_price=VALUES(dn_min_price),sell_status=1,data_status=0`,
      [product.id, product.secondId, seller.id, product.name, index + 1, product.price, product.price])
      await db.execute(`INSERT INTO xm_peasant_product_sku(id,goods_id,name,img,price,dn_price,weight,min_num,max_num,stock,sort,sell_count,sell_status,data_status)
        VALUES(?,?,?,'',?,?,500,1,9999,9999,1,0,1,0)
        ON DUPLICATE KEY UPDATE goods_id=VALUES(goods_id),name=VALUES(name),price=VALUES(price),dn_price=VALUES(dn_price),stock=VALUES(stock),sell_status=1,data_status=0`,
      [product.skuId, product.id, product.sku, product.price, product.price])
    }

    let orderIndex = 0
    let itemId = 9290000
    const statusPattern = [1, 1, 2, 2, 3, 3, 1, 2]
    for (const day of days) {
      for (let i = 0; i < 8; i += 1) {
        orderIndex += 1
        const buyer = buyers[(i + 1 + orderIndex) % buyers.length]
        const base = baseRows[(i + orderIndex) % baseRows.length]
        const status = statusPattern[i]
        const chosen = [products[(i + orderIndex) % products.length], products[(i + orderIndex + 2) % products.length]]
        const quantities = [2 + ((i * 3 + orderIndex) % 9), 1 + ((i + orderIndex) % 6)]
        const total = chosen.reduce((sum, item, itemIndex) => sum + item.price * quantities[itemIndex], 0)
        const orderId = `NZ${day.replaceAll('-', '')}${String(i + 1).padStart(3, '0')}`
        const createTime = `${day} ${String(8 + i).padStart(2, '0')}:${String((i * 7) % 60).padStart(2, '0')}:00`
        const shipTime = status >= 2 ? `${day} ${String(13 + (i % 4)).padStart(2, '0')}:20:00` : null
        const completeTime = status === 3 ? `${day} ${String(17 + (i % 3)).padStart(2, '0')}:35:00` : null
        await db.execute(`INSERT INTO xm_peasant_order
          (buy_supplier_id,base_name,peasant_supplier_id,date,order_id,order_price,total_price,origin_total_price,wx_price,flower_price_balance,pay_type,open_id,mch_id,out_trade_no,receive_name,receive_tel,receive_address,buyer_memo,order_status,after_sale_status,refund_status,pay_time,ship_time,ship_pic,complete_time,complete_pic,complete_user_id,complete_user_name,wx_pay_id,create_time,update_time,data_status,settle_flag)
          VALUES(?,?,?,?,?,?,?,?,?,0,1,'','','',?,?,?,?,?,0,0,?,?,?,?,?,?,'周凯','',?,?,0,?)
          ON DUPLICATE KEY UPDATE buy_supplier_id=VALUES(buy_supplier_id),base_name=VALUES(base_name),peasant_supplier_id=VALUES(peasant_supplier_id),order_price=VALUES(order_price),total_price=VALUES(total_price),origin_total_price=VALUES(origin_total_price),wx_price=VALUES(wx_price),receive_name=VALUES(receive_name),receive_tel=VALUES(receive_tel),receive_address=VALUES(receive_address),buyer_memo=VALUES(buyer_memo),order_status=VALUES(order_status),pay_time=VALUES(pay_time),ship_time=VALUES(ship_time),complete_time=VALUES(complete_time),complete_user_id=VALUES(complete_user_id),complete_user_name=VALUES(complete_user_name),update_time=VALUES(update_time),data_status=0`,
        [buyer.id, base.name, seller.id, day, orderId, total, total, total, total, buyer.owner_name || buyer.supplier_name, buyer.owner_tel || base.contact_tel, buyer.address_detail || base.address, i % 3 === 0 ? '到基地后请电话联系' : '', status, createTime, shipTime, status >= 2 ? '/uploads/agri-driver/demo-shipment.jpg' : '', completeTime, status === 3 ? '/uploads/agri-driver/demo-receipt.jpg' : '', status === 3 ? 1 : 0, createTime, completeTime || shipTime || createTime, status === 3 ? 1 : 0])
        await db.execute(`DELETE FROM xm_peasant_order_item WHERE order_id=?`, [orderId])
        for (let j = 0; j < chosen.length; j += 1) {
          const product = chosen[j]
          const quantity = quantities[j]
          itemId += 1
          await db.execute(`INSERT INTO xm_peasant_order_item
            (id,buy_supplier_id,peasant_supplier_id,order_id,goods_id,sku_id,img,goods_info,sku_info,remark,take_ratio,price,total_price,origin_total_price,num,origin_num,order_status,after_sale_status,refund_status,create_time,update_time,data_status)
            VALUES(?,?,?,?,?,?,'',?,?,?,0,?,?,?,?,?,?,0,0,?,?,0)`,
          [itemId, buyer.id, seller.id, orderId, product.id, product.skuId, product.name, product.sku, j === 0 && i % 4 === 0 ? '轻拿轻放' : '', product.price, product.price * quantity, product.price * quantity, quantity, quantity, status, createTime, completeTime || shipTime || createTime])
        }
      }
    }
    await db.commit()
    console.log(`已写入 ${days.length * 8} 张农资订单、${days.length * 16} 条订单商品，覆盖 ${days.join('、')}`)
  } catch (error) {
    await db.rollback()
    throw error
  } finally {
    await db.end()
  }
}

main().catch(error => { console.error(error); process.exit(1) })
