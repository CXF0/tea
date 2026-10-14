-- 本地开发综合演示数据：覆盖入场、供应商花材质检、客户、问题标记与配货状态。
-- 可重复执行；仅用于 menghuacangguan_v1_local。
USE `menghuacangguan_v1_local`;

START TRANSACTION;

INSERT INTO xm_bulky_supplier_enter
  (type, supplier_id, supplier_name, login_tel, date, operator_id, enter_time,
   data_status, is_qualify, is_late, quality_inspection_flag, create_time, update_time)
SELECT 4, seed.supplier_id, seed.supplier_name, seed.phone, '2026-09-18', 0,
       seed.enter_time, seed.entry_status, seed.is_qualify, seed.is_late,
       seed.priority_flag, NOW(), NOW()
FROM (
  SELECT 401 supplier_id, '晋宁高原花卉基地' supplier_name, '13800002101' phone, '' enter_time, 0 entry_status, 1 is_qualify, 0 is_late, 1 priority_flag
  UNION ALL SELECT 402, '呈贡七彩花场', '13800002102', '07:46:00', 1, 0, 0, 0
  UNION ALL SELECT 403, '斗南云上玫瑰园', '13800002103', '', 0, 0, 1, 1
  UNION ALL SELECT 404, '嵩明晨曦合作社', '13800002104', '08:18:00', 1, 1, 0, 0
  UNION ALL SELECT 405, '安宁青山园艺', '13800002105', '', 0, 0, 0, 0
  UNION ALL SELECT 406, '宜良春城鲜花基地', '13800002106', '08:32:00', 1, 0, 1, 1
  UNION ALL SELECT 407, '石林百合种植园', '13800002107', '', 0, 1, 0, 0
  UNION ALL SELECT 408, '斗南拾花供应商', '13800002108', '09:05:00', 1, 0, 0, 0
) seed
WHERE NOT EXISTS (
  SELECT 1 FROM xm_bulky_supplier_enter existing
   WHERE existing.date = '2026-09-18' AND existing.supplier_id = seed.supplier_id
);

INSERT INTO xm_bulky_supplier_enter_item
  (enter_id, ware_id, order_num, sub_shelf_sn, zone, shelf, zone_shelf, date,
   supplier_id, product_id, product_name, rank_num, sku_config, item_num,
   is_position, is_qualify, not_qualify_num, create_time, update_time, data_status)
SELECT entry.id, 1, seed.order_num, seed.segment, seed.zone_no, seed.shelf_no,
       CONCAT(seed.zone_no, '-', seed.shelf_no, '-', seed.segment), entry.date,
       entry.supplier_id, seed.product_id, seed.product_name, seed.rank_num,
       seed.sku_config, seed.item_num, seed.positioned, 0, 0, NOW(), NOW(), 0
FROM xm_bulky_supplier_enter entry
JOIN (
  SELECT 401 supplier_id, 18001 order_num, '1' segment, '01' zone_no, '001' shelf_no, 801 product_id, '高原红' product_name, 1 rank_num, '成熟度:中熟,规格:20枝/扎' sku_config, 100 item_num, 1 positioned
  UNION ALL SELECT 401, 18002, '2', '01', '002', 802, '雪山玫瑰', 1, '成熟度:偏生,规格:20枝/扎', 32, 1
  UNION ALL SELECT 401, 18003, '3', '01', '003', 803, '蜜桃雪山', 2, '成熟度:中熟,规格:20枝/扎', 24, 1
  UNION ALL SELECT 402, 28001, '1', '02', '011', 804, '卡罗拉', 2, '成熟度:中熟,规格:20枝/扎', 48, 1
  UNION ALL SELECT 402, 28002, '2', '02', '012', 805, '戴安娜', 1, '成熟度:偏熟,规格:20枝/扎', 36, 1
  UNION ALL SELECT 402, 28003, '3', '02', '013', 806, '香槟玫瑰', 1, '成熟度:中熟,规格:20枝/扎', 28, 1
  UNION ALL SELECT 403, 38001, '1', '03', '021', 807, '自由女神', 1, '成熟度:中熟,规格:20枝/扎', 60, 1
  UNION ALL SELECT 403, 38002, '2', '03', '022', 808, '洛神玫瑰', 2, '成熟度:偏生,规格:20枝/扎', 40, 1
  UNION ALL SELECT 403, 38003, '3', '03', '023', 809, '粉红雪山', 1, '成熟度:中熟,规格:20枝/扎', 20, 0
  UNION ALL SELECT 404, 48001, '1', '04', '031', 810, '白色洋桔梗', 1, '成熟度:中熟,规格:10枝/扎', 42, 1
  UNION ALL SELECT 404, 48002, '2', '04', '032', 811, '紫色洋桔梗', 2, '成熟度:偏熟,规格:10枝/扎', 34, 1
  UNION ALL SELECT 404, 48003, '3', '04', '033', 812, '绿色洋桔梗', 1, '成熟度:中熟,规格:10枝/扎', 26, 1
  UNION ALL SELECT 405, 58001, '1', '05', '041', 813, '蓝色绣球', 1, '成熟度:中熟,规格:5枝/扎', 18, 1
  UNION ALL SELECT 405, 58002, '2', '05', '042', 814, '粉色绣球', 2, '成熟度:偏生,规格:5枝/扎', 22, 1
  UNION ALL SELECT 405, 58003, '3', '05', '043', 815, '白色绣球', 1, '成熟度:中熟,规格:5枝/扎', 16, 0
  UNION ALL SELECT 406, 68001, '1', '06', '051', 816, '粉色康乃馨', 1, '成熟度:中熟,规格:20枝/扎', 55, 1
  UNION ALL SELECT 406, 68002, '2', '06', '052', 817, '红色康乃馨', 2, '成熟度:偏熟,规格:20枝/扎', 38, 1
  UNION ALL SELECT 406, 68003, '3', '06', '053', 818, '绿色康乃馨', 1, '成熟度:中熟,规格:20枝/扎', 30, 1
  UNION ALL SELECT 407, 78001, '1', '07', '061', 819, '西伯利亚百合', 1, '成熟度:中熟,规格:10枝/扎', 44, 1
  UNION ALL SELECT 407, 78002, '2', '07', '062', 820, '索邦百合', 2, '成熟度:偏生,规格:10枝/扎', 28, 1
  UNION ALL SELECT 407, 78003, '3', '07', '063', 821, '黄天霸百合', 1, '成熟度:中熟,规格:10枝/扎', 20, 1
  UNION ALL SELECT 408, 88001, '1', '08', '071', 822, '向日葵', 1, '成熟度:中熟,规格:10枝/扎', 50, 1
  UNION ALL SELECT 408, 88002, '2', '08', '072', 823, '紫色勿忘我', 3, '成熟度:偏熟,规格:1kg/扎', 25, 1
  UNION ALL SELECT 408, 88003, '3', '08', '073', 824, '小雏菊', 2, '成熟度:中熟,规格:20枝/扎', 35, 1
) seed ON seed.supplier_id = entry.supplier_id
WHERE entry.date = '2026-09-18'
  AND NOT EXISTS (
    SELECT 1 FROM xm_bulky_supplier_enter_item existing
     WHERE existing.enter_id = entry.id AND existing.order_num = seed.order_num
       AND existing.sub_shelf_sn = seed.segment AND existing.data_status = 0
  );

INSERT INTO partner (name, app_id, contact_name, contact_tel, status)
SELECT '梦花本地测试渠道', 'demo-local-quality-partner', '测试运营', '13900003000', 1
WHERE NOT EXISTS (SELECT 1 FROM partner WHERE app_id = 'demo-local-quality-partner');

INSERT INTO xm_bulky_purchaser
  (platform, ware_id, xm_account, phone_number, password, salt, app_id, nickname,
   remark, data_status, create_time, update_time)
SELECT 1, 1, seed.phone, seed.phone, 'DEMO_ACCOUNT_DISABLED', 'DEMO_ONLY',
       'demo-local-quality-customer', seed.nickname, '本地质检演示', 0, NOW(), NOW()
FROM (
  SELECT '13900003001' phone, '昆明繁花花店' nickname
  UNION ALL SELECT '13900003002', '春城花艺馆'
  UNION ALL SELECT '13900003003', '云上花房'
  UNION ALL SELECT '13900003004', '拾光花礼'
  UNION ALL SELECT '13900003005', '南屏鲜花店'
  UNION ALL SELECT '13900003006', '滇池花艺工作室'
) seed
WHERE NOT EXISTS (
  SELECT 1 FROM xm_bulky_purchaser p
   WHERE p.phone_number = seed.phone AND p.app_id = 'demo-local-quality-customer'
);

INSERT INTO xm_bulky_order
  (purchaser_id, order_sn, ware_id, partner_id, round_no, order_num,
   total_item_num, total_weight, express, express_region, express_price,
   product_total_price, total_price, receive_name, receive_tel, order_status,
   unqualified_way, create_time, update_time, data_status)
SELECT purchaser.id, seed.order_sn, 1, partner.id, '2026-09-18', seed.order_num,
       seed.total_num, seed.total_num * 500, 0, 0, 0, seed.total_num,
       seed.total_num, purchaser.nickname, purchaser.phone_number, 1,
       seed.unqualified_way, NOW(), NOW(), 0
FROM (
  SELECT '13900003001' phone, 'LOCAL-QC-20260918-001' order_sn, 2001 order_num, 156 total_num, 1 unqualified_way
  UNION ALL SELECT '13900003002', 'LOCAL-QC-20260918-002', 2002, 112, 2
  UNION ALL SELECT '13900003003', 'LOCAL-QC-20260918-003', 2003, 120, 3
  UNION ALL SELECT '13900003004', 'LOCAL-QC-20260918-004', 2004, 102, 1
  UNION ALL SELECT '13900003005', 'LOCAL-QC-20260918-005', 2005, 93, 2
  UNION ALL SELECT '13900003006', 'LOCAL-QC-20260918-006', 2006, 119, 3
) seed
JOIN xm_bulky_purchaser purchaser
  ON purchaser.phone_number = seed.phone AND purchaser.app_id = 'demo-local-quality-customer'
JOIN partner ON partner.app_id = 'demo-local-quality-partner'
WHERE NOT EXISTS (SELECT 1 FROM xm_bulky_order existing WHERE existing.order_sn = seed.order_sn);

INSERT INTO xm_bulky_order_item
  (purchaser_id, supplier_id, supplier_name, order_num, sub_shelf_sn, zone,
   shelf, zone_shelf, order_sn, round_no, supplier_no, product_id, product_name,
   rank_num, sku_config, pic_url, supply_price, pay_price, item_num,
   origin_item_num, actual_price, origin_actual_price, total_price,
   origin_total_price, create_time, update_time, data_status)
SELECT orders.purchaser_id, item.supplier_id, entry.supplier_name, item.order_num,
       item.sub_shelf_sn, item.zone, item.shelf, item.zone_shelf, orders.order_sn,
       item.date, CONCAT('LOCAL-', item.supplier_id), item.product_id,
       item.product_name, item.rank_num, item.sku_config, '',
       CASE item.rank_num WHEN 1 THEN 2.80 WHEN 2 THEN 2.20 ELSE 1.80 END,
       CASE item.rank_num WHEN 1 THEN 3.60 WHEN 2 THEN 3.00 ELSE 2.50 END,
       item.item_num, item.item_num, item.item_num, item.item_num,
       item.item_num, item.item_num, NOW(), NOW(), 0
FROM xm_bulky_supplier_enter_item item
JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
JOIN xm_bulky_order orders ON orders.order_sn = CASE
  WHEN entry.supplier_id IN (401, 402) THEN 'LOCAL-QC-20260918-001'
  WHEN entry.supplier_id = 403 THEN 'LOCAL-QC-20260918-002'
  WHEN entry.supplier_id = 404 THEN 'LOCAL-QC-20260918-003'
  WHEN entry.supplier_id = 405 THEN 'LOCAL-QC-20260918-004'
  WHEN entry.supplier_id = 406 THEN 'LOCAL-QC-20260918-005'
  ELSE 'LOCAL-QC-20260918-006' END
WHERE item.date = '2026-09-18' AND item.data_status = 0
  AND entry.supplier_id BETWEEN 401 AND 408
  AND NOT EXISTS (
    SELECT 1 FROM xm_bulky_order_item existing
     WHERE existing.order_sn = orders.order_sn AND existing.order_num = item.order_num
       AND existing.product_id = item.product_id AND existing.data_status = 0
  );

UPDATE xm_bulky_supplier_enter_item item
JOIN xm_bulky_order_item order_item
  ON order_item.round_no = item.date AND order_item.supplier_id = item.supplier_id
 AND order_item.order_num = item.order_num AND order_item.product_id = item.product_id
 AND order_item.data_status = 0
SET item.order_item_id = order_item.id, item.update_time = NOW()
WHERE item.date = '2026-09-18' AND item.supplier_id BETWEEN 401 AND 408;

UPDATE xm_bulky_supplier_enter_item item
JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
SET item.limit_distribution_flag = IF(entry.supplier_id IN (403, 407), 1, 0),
    item.duty_flag = IF(entry.supplier_id IN (404, 407), 1, 0),
    item.no_after_sale_flag = IF(entry.supplier_id = 406, 1, 0),
    item.duty_remark = IF(entry.supplier_id IN (404, 407), '本地演示：供应商包装与到货品质责任', ''),
    item.update_time = NOW()
WHERE item.date = '2026-09-18' AND item.supplier_id BETWEEN 401 AND 408;

INSERT INTO xm_bulky_inspection
  (date, enter_item_id, shelf_sn, zoen_shelf, sub_shelf_sn, product_id,
   product_name, rank_num, sku_config, item_num, receive_tel, supplier_id,
   supplier_name, inspection_flag, focus_flag, status, assigned_user_id,
   assigned_user_name, remark)
SELECT item.date, item.id, CAST(item.zone AS UNSIGNED), item.zone_shelf,
       item.sub_shelf_sn, item.product_id, item.product_name, item.rank_num,
       item.sku_config, item.item_num, entry.login_tel, item.supplier_id,
       entry.supplier_name, entry.quality_inspection_flag,
       IF(item.item_num >= 50, 1, 0), 0, 1001, '李师傅', ''
FROM xm_bulky_supplier_enter_item item
JOIN xm_bulky_supplier_enter entry ON entry.id = item.enter_id
WHERE item.date = '2026-09-18' AND item.supplier_id BETWEEN 401 AND 408
  AND NOT EXISTS (
    SELECT 1 FROM xm_bulky_inspection existing
     WHERE existing.date = item.date AND existing.enter_item_id = item.id
       AND existing.delete_time IS NULL
  );

-- 给部分花材预置不同质检处置，便于验证状态颜色、筛选和重复标记不互相覆盖。
INSERT INTO xm_inspection_reason_record
  (date, enter_item_id, order_item_id, code_content, op, reason_id, reason_name,
   parent_reason_id, parent_reason_name, user_id, user_name,
   evidence_media_json, allow_downgrade_restock, create_time, update_time, data_status)
SELECT item.date, item.id, item.order_item_id, CONCAT('QI-', item.id, '-', mark.unit_no),
       mark.operation, reason.id, reason.reason_name, parent.id, parent.reason_name,
       1001, '李师傅', '[]', mark.allow_downgrade, NOW(), NOW(), 0
FROM xm_bulky_supplier_enter_item item
JOIN (
  SELECT 801 product_id, 1 unit_no, 7 operation, '扎数不足' reason_name, 0 allow_downgrade
  UNION ALL SELECT 801, 2, 3, '花头损伤', 0
  UNION ALL SELECT 801, 3, 1, '开放度不符', 0
  UNION ALL SELECT 801, 7, 12, '挤压折断', 0
  UNION ALL SELECT 801, 18, 6, '扎数不足', 1
  UNION ALL SELECT 804, 4, 2, '病虫害或腐烂', 0
  UNION ALL SELECT 804, 9, 5, '失水萎蔫', 1
  UNION ALL SELECT 807, 2, 7, '扎数不足', 0
  UNION ALL SELECT 810, 5, 3, '花头损伤', 0
  UNION ALL SELECT 813, 3, 12, '规格混装', 0
  UNION ALL SELECT 816, 6, 1, '开放度不符', 0
  UNION ALL SELECT 819, 8, 6, '扎数不足', 1
) mark ON mark.product_id = item.product_id
JOIN xm_inspection_reason_config reason
  ON reason.reason_name = mark.reason_name AND reason.level = 2 AND reason.data_status = 0
JOIN xm_inspection_reason_config parent ON parent.id = reason.parent_id AND parent.data_status = 0
WHERE item.date = '2026-09-18'
  AND NOT EXISTS (
    SELECT 1 FROM xm_inspection_reason_record existing
     WHERE existing.enter_item_id = item.id AND existing.data_status = 0
       AND CAST(SUBSTRING_INDEX(existing.code_content, '-', -1) AS UNSIGNED) = mark.unit_no
  );

INSERT INTO xm_quality_unit_allocation
  (enter_item_id, unit_no, allocated, operator_id, operator_name)
SELECT item.id, allocated.unit_no, 1, 1001, '李师傅'
FROM xm_bulky_supplier_enter_item item
JOIN (
  SELECT 801 product_id, 5 unit_no
  UNION ALL SELECT 801, 6
  UNION ALL SELECT 801, 10
  UNION ALL SELECT 804, 1
  UNION ALL SELECT 804, 2
  UNION ALL SELECT 807, 4
  UNION ALL SELECT 810, 1
  UNION ALL SELECT 816, 2
  UNION ALL SELECT 819, 3
) allocated ON allocated.product_id = item.product_id
WHERE item.date = '2026-09-18'
ON DUPLICATE KEY UPDATE allocated = VALUES(allocated), operator_id = VALUES(operator_id),
  operator_name = VALUES(operator_name), update_time = NOW();

UPDATE xm_bulky_supplier_enter_item item
SET item.not_qualify_num = (
      SELECT COUNT(DISTINCT record.code_content)
      FROM xm_inspection_reason_record record
      WHERE record.enter_item_id = item.id AND record.data_status = 0
    ),
    item.is_qualify = IF(EXISTS(
      SELECT 1 FROM xm_inspection_reason_record record
      WHERE record.enter_item_id = item.id AND record.data_status = 0
    ), 10, 0),
    item.qualify_user_id = 1001,
    item.qualify_user_name = IF(EXISTS(
      SELECT 1 FROM xm_inspection_reason_record record
      WHERE record.enter_item_id = item.id AND record.data_status = 0
    ), '李师傅', ''),
    item.update_time = NOW()
WHERE item.date = '2026-09-18' AND item.supplier_id BETWEEN 401 AND 408;

UPDATE xm_bulky_supplier_enter entry
SET entry.is_qualify = EXISTS(
      SELECT 1 FROM xm_bulky_supplier_enter_item item
      WHERE item.enter_id = entry.id AND item.data_status = 0 AND item.is_qualify = 10
    ),
    entry.update_time = NOW()
WHERE entry.date = '2026-09-18' AND entry.supplier_id BETWEEN 401 AND 408;

COMMIT;
