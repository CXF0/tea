-- 仅当 2026-09-17 场次没有入场数据时追加演示记录，不覆盖原数据。
INSERT INTO xm_bulky_supplier_enter
  (type, supplier_id, supplier_name, login_tel, date, operator_id, enter_time,
   data_status, is_qualify, is_late, quality_inspection_flag, create_time, update_time)
SELECT seed.type, seed.supplier_id, seed.supplier_name, seed.login_tel, seed.date, 0,
       seed.enter_time, seed.data_status, seed.is_qualify, seed.is_late,
       seed.quality_inspection_flag, NOW(), NOW()
FROM (
  SELECT 4 type, 301 supplier_id, '晋宁云花基地' supplier_name, '13800001001' login_tel, '2026-09-17' date, '' enter_time, 0 data_status, 0 is_qualify, 0 is_late, 1 quality_inspection_flag
  UNION ALL SELECT 4, 302, '呈贡四季花场', '13800001002', '2026-09-17', '08:42:00', 1, 0, 0, 0
  UNION ALL SELECT 4, 303, '嵩明晨露合作社', '13800001003', '2026-09-17', '', 0, 1, 1, 0
) seed
WHERE NOT EXISTS (SELECT 1 FROM xm_bulky_supplier_enter existing WHERE existing.date = '2026-09-17');

-- 给演示供应商补充真实层级的货架花材；按供应商与场次定位入场记录，重复执行不重复插入。
INSERT INTO xm_bulky_supplier_enter_item
  (enter_id, ware_id, order_num, sub_shelf_sn, zone, shelf, zone_shelf, date,
   supplier_id, product_id, product_name, rank_num, sku_config, item_num,
   is_position, is_qualify, not_qualify_num, create_time, update_time, data_status)
SELECT entry.id, 1, seed.order_num, seed.sub_shelf_sn, seed.zone, seed.shelf,
       seed.zone_shelf, entry.date, entry.supplier_id, seed.product_id,
       seed.product_name, seed.rank_num, seed.sku_config, seed.item_num,
       1, seed.is_qualify, seed.not_qualify_num, NOW(), NOW(), 0
FROM xm_bulky_supplier_enter entry
JOIN (
  SELECT 301 supplier_id, 11209 order_num, '3' sub_shelf_sn, '11' zone, '209' shelf, '11-209-3' zone_shelf, 701 product_id, '高原红' product_name, 1 rank_num, '成熟度:中熟,规格:20枝/扎' sku_config, 12 item_num, 0 is_qualify, 0 not_qualify_num
  UNION ALL SELECT 301, 22001, '1', '22', '001', '22-001-1', 702, '雪山玫瑰', 1, '成熟度:中熟,规格:20枝/扎', 8, 1, 0
  UNION ALL SELECT 302, 70301, '1', '07', '301', '07-301-1', 703, '卡罗拉', 2, '成熟度:偏生,规格:20枝/扎', 16, 0, 0
  UNION ALL SELECT 302, 70302, '2', '07', '302', '07-302-2', 704, '戴安娜', 1, '成熟度:中熟,规格:20枝/扎', 10, 1, 0
  UNION ALL SELECT 303, 90408, '1', '09', '408', '09-408-1', 705, '向日葵', 1, '成熟度:中熟,规格:10枝/扎', 20, 10, 3
  UNION ALL SELECT 303, 90409, '2', '09', '409', '09-409-2', 706, '洋桔梗', 2, '成熟度:偏熟,规格:20枝/扎', 14, 0, 0
) seed ON seed.supplier_id = entry.supplier_id
WHERE entry.date = '2026-09-17'
  AND NOT EXISTS (
    SELECT 1 FROM xm_bulky_supplier_enter_item existing
     WHERE existing.enter_id = entry.id AND existing.order_num = seed.order_num
       AND existing.sub_shelf_sn = seed.sub_shelf_sn AND existing.data_status = 0
  );

-- 花材质检客户侧演示数据：使用真实采购方、分销商、订单和订单商品关系。
INSERT INTO partner (name, app_id, contact_name, contact_tel, status)
SELECT '繁花测试门店', 'demo-wms-quality-partner', '测试联系人', '13900002000', 1
WHERE NOT EXISTS (SELECT 1 FROM partner WHERE app_id = 'demo-wms-quality-partner');

INSERT INTO xm_bulky_purchaser
  (platform, ware_id, xm_account, phone_number, password, salt, app_id, nickname,
   remark, data_status, create_time, update_time)
SELECT seed.platform, 1, seed.phone, seed.phone, 'DEMO_ACCOUNT_DISABLED',
       'DEMO_ONLY', 'demo-wms-quality-customer', seed.nickname, '仓管质检演示', 0, NOW(), NOW()
FROM (
  SELECT 1 platform, '13900002001' phone, '昆明繁花花店' nickname
  UNION ALL SELECT 1, '13900002002', '春城花艺'
  UNION ALL SELECT 1, '13900002003', '云上花房'
) seed
WHERE NOT EXISTS (
  SELECT 1 FROM xm_bulky_purchaser purchaser
   WHERE purchaser.phone_number = seed.phone AND purchaser.app_id = 'demo-wms-quality-customer'
);

INSERT INTO xm_bulky_order
  (purchaser_id, order_sn, ware_id, partner_id, round_no, order_num,
   total_item_num, total_weight, express, express_region, express_price,
   product_total_price, total_price, receive_name, receive_tel, order_status,
   unqualified_way, create_time, update_time, data_status)
SELECT purchaser.id, seed.order_sn, 1, partner.id, '2026-09-17', seed.order_num,
       seed.total_item_num, seed.total_item_num * 500, 0, 0, 0,
       seed.total_item_num, seed.total_item_num, purchaser.nickname,
       purchaser.phone_number, 1, seed.unqualified_way, NOW(), NOW(), 0
FROM (
  SELECT '13900002001' phone, 'DEMO-QC-20260917-001' order_sn, 1001 order_num, 20 total_item_num, 1 unqualified_way
  UNION ALL SELECT '13900002002', 'DEMO-QC-20260917-002', 1002, 26, 2
  UNION ALL SELECT '13900002003', 'DEMO-QC-20260917-003', 1003, 34, 3
) seed
JOIN xm_bulky_purchaser purchaser ON purchaser.phone_number = seed.phone AND purchaser.app_id = 'demo-wms-quality-customer'
JOIN partner ON partner.app_id = 'demo-wms-quality-partner'
WHERE NOT EXISTS (SELECT 1 FROM xm_bulky_order existing WHERE existing.order_sn = seed.order_sn);

INSERT INTO xm_bulky_order_item
  (purchaser_id, supplier_id, supplier_name, order_num, sub_shelf_sn, zone,
   shelf, zone_shelf, order_sn, round_no, supplier_no, product_id, product_name,
   rank_num, sku_config, pic_url, supply_price, pay_price, item_num,
   origin_item_num, actual_price, origin_actual_price, total_price,
   origin_total_price, create_time, update_time, data_status)
SELECT orders.purchaser_id, item.supplier_id, entry.supplier_name, item.order_num,
       item.sub_shelf_sn, item.zone, item.shelf, item.zone_shelf, orders.order_sn,
       item.date, CONCAT('DEMO-', item.supplier_id), item.product_id,
       item.product_name, item.rank_num, item.sku_config, '', 1.00, 1.00,
       item.item_num, item.item_num, item.item_num, item.item_num,
       item.item_num, item.item_num, NOW(), NOW(), 0
FROM xm_bulky_supplier_enter_item item
JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
JOIN xm_bulky_order orders ON orders.order_sn = CASE entry.supplier_id
  WHEN 301 THEN 'DEMO-QC-20260917-001'
  WHEN 302 THEN 'DEMO-QC-20260917-002'
  WHEN 303 THEN 'DEMO-QC-20260917-003' END
WHERE item.date = '2026-09-17' AND item.data_status = 0
  AND entry.supplier_id IN (301, 302, 303)
  AND NOT EXISTS (
    SELECT 1 FROM xm_bulky_order_item existing
     WHERE existing.order_sn = orders.order_sn AND existing.order_num = item.order_num
       AND existing.product_id = item.product_id AND existing.data_status = 0
  );

UPDATE xm_bulky_supplier_enter_item item
JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
JOIN xm_bulky_order_item order_item
  ON order_item.round_no = item.date AND order_item.supplier_id = item.supplier_id
 AND order_item.order_num = item.order_num AND order_item.product_id = item.product_id
 AND order_item.data_status = 0
SET item.order_item_id = order_item.id, item.update_time = NOW()
WHERE item.date = '2026-09-17' AND item.data_status = 0
  AND entry.supplier_id IN (301, 302, 303)
  AND item.order_item_id = 0;

UPDATE xm_bulky_supplier_enter_item
SET sku_config = CASE product_id
  WHEN 701 THEN '成熟度:中熟,规格:20枝/扎'
  WHEN 702 THEN '成熟度:中熟,规格:20枝/扎'
  WHEN 703 THEN '成熟度:偏生,规格:20枝/扎'
  WHEN 704 THEN '成熟度:中熟,规格:20枝/扎'
  WHEN 705 THEN '成熟度:中熟,规格:10枝/扎'
  WHEN 706 THEN '成熟度:偏熟,规格:20枝/扎'
  ELSE sku_config END,
  update_time = NOW()
WHERE date = '2026-09-17' AND product_id IN (701, 702, 703, 704, 705, 706);

UPDATE xm_bulky_order_item order_item
JOIN xm_bulky_supplier_enter_item enter_item ON enter_item.order_item_id = order_item.id
SET order_item.sku_config = enter_item.sku_config, order_item.update_time = NOW()
WHERE enter_item.date = '2026-09-17' AND enter_item.product_id IN (701, 702, 703, 704, 705, 706);
