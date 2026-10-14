-- 仅用于独立开发库 menghuacangguan_v1；所有插入均受空表保护。
USE `menghuacangguan_v1`;

START TRANSACTION;

INSERT INTO `xm_inspection_reason_config`
  (`parent_id`, `reason_name`, `level`, `sequence`, `create_user_id`, `create_user_name`, `update_user_id`, `update_user_name`)
SELECT seed.parent_id, seed.reason_name, seed.level, seed.sequence, 0, '系统种子', 0, '系统种子'
FROM (
  SELECT 0 AS parent_id, '花材品质' AS reason_name, 1 AS level, 10 AS sequence
  UNION ALL SELECT 0, '包装与数量', 1, 20
  UNION ALL SELECT 0, '运输损伤', 1, 30
) seed
WHERE NOT EXISTS (SELECT 1 FROM `xm_inspection_reason_config` LIMIT 1);

INSERT INTO `xm_inspection_reason_config`
  (`parent_id`, `reason_name`, `level`, `sequence`, `create_user_id`, `create_user_name`, `update_user_id`, `update_user_name`)
SELECT parent.id, child.reason_name, 2, child.sequence, 0, '系统种子', 0, '系统种子'
FROM (
  SELECT '花材品质' AS parent_name, '花头损伤' AS reason_name, 10 AS sequence
  UNION ALL SELECT '花材品质', '开放度不符', 20
  UNION ALL SELECT '花材品质', '病虫害或腐烂', 30
  UNION ALL SELECT '包装与数量', '扎数不足', 10
  UNION ALL SELECT '包装与数量', '规格混装', 20
  UNION ALL SELECT '运输损伤', '挤压折断', 10
  UNION ALL SELECT '运输损伤', '失水萎蔫', 20
) child
JOIN `xm_inspection_reason_config` parent
  ON parent.parent_id = 0 AND parent.level = 1 AND parent.reason_name = child.parent_name
WHERE NOT EXISTS (SELECT 1 FROM `xm_inspection_reason_config` WHERE level = 2 LIMIT 1);

INSERT INTO `xm_bulky_inspection`
  (`date`, `enter_item_id`, `shelf_sn`, `zoen_shelf`, `sub_shelf_sn`, `product_id`, `product_name`,
   `rank_num`, `sku_config`, `item_num`, `receive_tel`, `supplier_id`, `supplier_name`,
   `inspection_flag`, `focus_flag`, `status`, `assigned_user_id`, `assigned_user_name`, `remark`)
SELECT seed.date, seed.enter_item_id, seed.shelf_sn, seed.zoen_shelf, seed.sub_shelf_sn, seed.product_id,
       seed.product_name, seed.rank_num, seed.sku_config, seed.item_num, '', seed.supplier_id,
       seed.supplier_name, seed.inspection_flag, seed.focus_flag, 0, 1001, '李师傅', ''
FROM (
  SELECT '2026-09-17' AS date, 91001 AS enter_item_id, 7 AS shelf_sn, '07-001' AS zoen_shelf, '001' AS sub_shelf_sn, 501 AS product_id, '红玫瑰' AS product_name, 2 AS rank_num, '60cm / 20枝' AS sku_config, 42 AS item_num, 201 AS supplier_id, '晋宁花语基地' AS supplier_name, 1 AS inspection_flag, 1 AS focus_flag
  UNION ALL SELECT '2026-09-17', 91002, 7, '07-002', '002', 502, '香槟玫瑰', 1, '70cm / 20枝', 36, 202, '呈贡繁花合作社', 0, 0
  UNION ALL SELECT '2026-09-17', 91003, 8, '08-003', '003', 503, '白色洋桔梗', 1, '60cm / 10枝', 28, 203, '斗南云花供应商', 1, 0
  UNION ALL SELECT '2026-09-17', 91004, 9, '09-001', '001', 504, '向日葵', 2, '单头 / 10枝', 24, 204, '嵩明阳光花田', 0, 0
  UNION ALL SELECT '2026-09-17', 91005, 10, '10-006', '006', 505, '粉色康乃馨', 1, '60cm / 20枝', 50, 205, '宜良春城花卉', 0, 1
  UNION ALL SELECT '2026-09-17', 91006, 11, '11-002', '002', 506, '蓝色绣球', 1, 'A级 / 5枝', 18, 206, '安宁青山园艺', 1, 1
  UNION ALL SELECT '2026-09-17', 91007, 12, '12-004', '004', 507, '多头百合', 2, '3头 / 10枝', 32, 207, '石林百合基地', 0, 0
  UNION ALL SELECT '2026-09-17', 91008, 13, '13-005', '005', 508, '紫色勿忘我', 3, '自然束 / 1kg', 16, 208, '斗南拾花供应商', 0, 0
) seed
WHERE NOT EXISTS (SELECT 1 FROM `xm_bulky_inspection` LIMIT 1);

COMMIT;
