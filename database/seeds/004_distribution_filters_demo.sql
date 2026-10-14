-- 本地配货大厅筛选演示数据：分区仓型、早班、自提、待补。
INSERT INTO xm_bulky_wms_area
  (code, area_name, start_shelf, end_shelf, ware_type, sort_config, sub_area, segment_area,
   pack_income_config, standby, sequence, remark, area_manager_id, area_manager_name,
   operator_id, operator_name, last_operator_id, last_operator_name, status)
VALUES
  ('01','一区',1,10,0,5,'','["1","2","3"]','',0,1,'自提区',0,'',0,'本地测试',0,'本地测试',1),
  ('02','二区',11,20,0,0,'','["1","2","3"]','',0,2,'普通区',0,'',0,'本地测试',0,'本地测试',1),
  ('03','三区',21,30,0,6,'','["1","2","3"]','',0,3,'早班区',0,'',0,'本地测试',0,'本地测试',1),
  ('04','四区',31,40,0,3,'','["1","2","3"]','',0,4,'自提早班区',0,'',0,'本地测试',0,'本地测试',1),
  ('05','五区',41,50,0,0,'','["1","2","3"]','',0,5,'待补区',0,'',0,'本地测试',0,'本地测试',1),
  ('06','六区',51,60,0,0,'','["1","2","3"]','',0,6,'普通区',0,'',0,'本地测试',0,'本地测试',1),
  ('07','七区',61,70,1,0,'','["1","2","3"]','',0,7,'城市仓',0,'',0,'本地测试',0,'本地测试',1),
  ('08','八区',71,80,1,6,'','["1","2","3"]','',0,8,'城市仓早班',0,'',0,'本地测试',0,'本地测试',1)
ON DUPLICATE KEY UPDATE area_name=VALUES(area_name),ware_type=VALUES(ware_type),sort_config=VALUES(sort_config),segment_area=VALUES(segment_area),remark=VALUES(remark),status=1;

UPDATE xm_bulky_order o
JOIN xm_bulky_order_item oi ON oi.order_sn=o.order_sn AND oi.data_status=0
JOIN xm_bulky_supplier_enter_item item ON item.order_item_id=oi.id AND item.data_status=0
SET o.delivery_type=IF(item.zone IN ('01','04','08'),2,1)
WHERE item.date='2026-09-18' AND o.data_status=0;

UPDATE xm_bulky_supplier_enter_item
SET restock_item_num=CASE WHEN zone='05' THEN 3 WHEN zone='08' THEN 2 ELSE restock_item_num END,
    update_time=NOW()
WHERE date='2026-09-18' AND data_status=0;
