-- 本地演示数据：40 个货架，覆盖质检、配货、打包的多种状态与进度。
-- 可重复执行；仅使用专用供应商 9401 和货架号 9101-9140。
USE `menghuacangguan_v1_local`;
START TRANSACTION;

INSERT INTO xm_bulky_supplier_enter
  (type,supplier_id,supplier_name,login_tel,date,operator_id,enter_time,data_status,is_qualify,is_late,quality_inspection_flag,create_time,update_time)
SELECT 4,9401,'本地联动演示花场','13800009401','2026-09-20',0,'07:30:00',1,1,0,1,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM xm_bulky_supplier_enter WHERE date='2026-09-20' AND supplier_id=9401);

INSERT INTO xm_bulky_supplier_enter_item
  (enter_id,ware_id,order_num,sub_shelf_sn,zone,shelf,zone_shelf,order_sn,date,supplier_id,product_id,product_name,rank_num,sku_config,item_num,is_position,is_qualify,not_qualify_num,qualify_user_id,qualify_user_name,prepare_item_num,prepare_user_id,prepare_user_name,restock_item_num,lack_replenish_num,create_time,update_time,data_status)
WITH RECURSIVE seq AS (SELECT 1 n UNION ALL SELECT n+1 FROM seq WHERE n<40)
SELECT e.id,1,9100+n,CAST(1+MOD(n-1,3) AS CHAR),'09',LPAD(100+n,3,'0'),CONCAT('09-',LPAD(100+n,3,'0'),'-',1+MOD(n-1,3)),CONCAT('LOCAL-PIPE-',LPAD(n,3,'0')),'2026-09-20',9401,940000+n,
       ELT(1+MOD(n-1,8),'红玫瑰','粉雪山','向日葵','洋桔梗','康乃馨','绣球','百合','勿忘我'),1+MOD(n-1,3),'成熟度:中熟,规格:20枝/扎',12+MOD(n*3,13),1,
       CASE WHEN n<=8 THEN 0 WHEN MOD(n,5)=0 THEN 10 ELSE 1 END,
       CASE WHEN MOD(n,5)=0 THEN 2 ELSE 0 END,
       CASE WHEN n<=8 THEN 0 ELSE 1001 END,CASE WHEN n<=8 THEN '' ELSE '质检员演示' END,
       CASE WHEN n<=8 THEN 0 WHEN n<=12 THEN FLOOR((12+MOD(n*3,13))*.25) WHEN n<=16 THEN FLOOR((12+MOD(n*3,13))*.6) ELSE 12+MOD(n*3,13) END,
       CASE WHEN n<=8 THEN 0 ELSE 1002 END,CASE WHEN n<=8 THEN '' ELSE '配货员演示' END,
       CASE WHEN MOD(n,7)=0 THEN 2 ELSE 0 END,CASE WHEN MOD(n,7)=0 THEN 2 ELSE 0 END,NOW(),NOW(),0
FROM seq JOIN xm_bulky_supplier_enter e ON e.date='2026-09-20' AND e.supplier_id=9401
WHERE NOT EXISTS (SELECT 1 FROM xm_bulky_supplier_enter_item x WHERE x.date='2026-09-20' AND x.order_num=9100+n AND x.supplier_id=9401 AND x.data_status=0);

INSERT INTO xm_bulky_inspection
  (date,enter_item_id,shelf_sn,zoen_shelf,sub_shelf_sn,product_id,product_name,rank_num,sku_config,item_num,receive_tel,supplier_id,supplier_name,inspection_flag,focus_flag,status,user_id,user_name,assigned_user_id,assigned_user_name,assign_time,finish_time,remark)
SELECT i.date,i.id,i.order_num,i.zone_shelf,i.sub_shelf_sn,i.product_id,i.product_name,i.rank_num,i.sku_config,i.item_num,'13800009401',i.supplier_id,'本地联动演示花场',IF(MOD(i.order_num,4)=0,1,0),IF(MOD(i.order_num,6)=0,1,0),
       CASE WHEN i.order_num<=9108 THEN 0 WHEN MOD(i.order_num,5)=0 THEN 10 WHEN MOD(i.order_num,4)=0 THEN 2 ELSE 1 END,
       CASE WHEN i.order_num<=9108 THEN 0 ELSE 1001 END,CASE WHEN i.order_num<=9108 THEN '' ELSE '质检员演示' END,1001,'质检员演示',NOW(),CASE WHEN i.order_num<=9108 THEN NULL ELSE NOW() END,
       CASE WHEN MOD(i.order_num,5)=0 THEN '演示：发现花头损伤' ELSE '' END
FROM xm_bulky_supplier_enter_item i
WHERE i.date='2026-09-20' AND i.supplier_id=9401
  AND NOT EXISTS (SELECT 1 FROM xm_bulky_inspection q WHERE q.date=i.date AND q.enter_item_id=i.id AND q.delete_time IS NULL);

INSERT INTO xm_inspection_reason_record
  (date,enter_item_id,order_item_id,code_content,op,reason_id,reason_name,parent_reason_id,parent_reason_name,user_id,user_name,evidence_media_json,allow_downgrade_restock,create_time,update_time,data_status)
SELECT i.date,i.id,i.order_item_id,CONCAT('QI-',i.id,'-1'),3,0,'花头损伤',0,'外观问题',1001,'质检员演示','[]',0,NOW(),NOW(),0
FROM xm_bulky_supplier_enter_item i WHERE i.date='2026-09-20' AND i.supplier_id=9401 AND MOD(i.order_num,5)=0
AND NOT EXISTS (SELECT 1 FROM xm_inspection_reason_record r WHERE r.enter_item_id=i.id AND r.code_content=CONCAT('QI-',i.id,'-1') AND r.data_status=0);

INSERT INTO xm_quality_unit_allocation (enter_item_id,unit_no,allocated,operator_id,operator_name)
WITH RECURSIVE units AS (SELECT 1 n UNION ALL SELECT n+1 FROM units WHERE n<30)
SELECT i.id,units.n,1,1002,'配货员演示'
FROM xm_bulky_supplier_enter_item i JOIN units ON units.n<=i.prepare_item_num
WHERE i.date='2026-09-20' AND i.supplier_id=9401
ON DUPLICATE KEY UPDATE allocated=1,operator_id=VALUES(operator_id),operator_name=VALUES(operator_name),update_time=NOW();

INSERT INTO xm_bulky_shelf_package_status
  (round_no,shelf_sn,ware_id,zone,zone_shelf,express_id,package_status,complete_type,box_time,complete_time,restock_status,distribution_status,has_sub_shelf,manual_user_id,self_pickup,delivery_time,create_time,update_time,data_status)
SELECT '2026-09-20',i.order_num,1,i.zone,i.zone_shelf,1,
       CASE WHEN i.order_num BETWEEN 9133 AND 9136 THEN 1 ELSE 0 END,0,NOW(),CASE WHEN i.order_num BETWEEN 9133 AND 9136 THEN NOW() ELSE NULL END,
       CASE WHEN MOD(i.order_num,7)=0 THEN 1 ELSE 0 END,1,0,0,CASE WHEN i.order_num>=9137 THEN 1 ELSE 0 END,
       CASE WHEN MOD(i.order_num,3)=0 THEN '09:30:00' WHEN MOD(i.order_num,3)=1 THEN '13:30:00' ELSE '18:30:00' END,NOW(),NOW(),0
FROM xm_bulky_supplier_enter_item i
WHERE i.date='2026-09-20' AND i.supplier_id=9401 AND i.order_num>=9117
ON DUPLICATE KEY UPDATE package_status=VALUES(package_status),complete_time=VALUES(complete_time),restock_status=VALUES(restock_status),distribution_status=1,self_pickup=VALUES(self_pickup),delivery_time=VALUES(delivery_time),update_time=NOW();

INSERT INTO xm_bulky_wms_express_package
  (type,round_no,ware_id,partner_id,province,city,send_no,shelf_sn,sub_shelf_sn,self_take_type,zone,shelf,zone_shelf,serial_num,package_num,item_num,express_id,region_id,express_type,express_status,express_user_id,express_user_name,package_user_id,package_user_name,url,package_time,package_id,package_info,suggest_pack_id,suggest_pack_info,valid_status,create_time,update_time,data_status)
WITH RECURSIVE serials AS (SELECT 1 n UNION ALL SELECT n+1 FROM serials WHERE n<2)
SELECT 2,'2026-09-20',1,0,'云南省','昆明市',CONCAT('LOCAL-PACK-',i.order_num,'-',serials.n),i.order_num,'',IF(i.order_num>=9137,2,0),i.zone,i.shelf,i.zone_shelf,serials.n,2,CEIL(i.item_num/2),1,1,
       CASE WHEN MOD(i.order_num,3)=0 THEN 1 ELSE 2 END,
       CASE WHEN i.order_num BETWEEN 9125 AND 9132 AND serials.n=1 THEN 10 WHEN i.order_num BETWEEN 9133 AND 9136 THEN 10 WHEN i.order_num>=9137 AND MOD(i.order_num+serials.n,2)=0 THEN 10 ELSE 0 END,
       CASE WHEN (i.order_num BETWEEN 9125 AND 9132 AND serials.n=1) OR i.order_num BETWEEN 9133 AND 9136 OR (i.order_num>=9137 AND MOD(i.order_num+serials.n,2)=0) THEN 1003 ELSE 0 END,
       CASE WHEN (i.order_num BETWEEN 9125 AND 9132 AND serials.n=1) OR i.order_num BETWEEN 9133 AND 9136 OR (i.order_num>=9137 AND MOD(i.order_num+serials.n,2)=0) THEN '打包员演示' ELSE '' END,
       CASE WHEN (i.order_num BETWEEN 9125 AND 9132 AND serials.n=1) OR i.order_num BETWEEN 9133 AND 9136 OR (i.order_num>=9137 AND MOD(i.order_num+serials.n,2)=0) THEN 1003 ELSE 0 END,
       CASE WHEN (i.order_num BETWEEN 9125 AND 9132 AND serials.n=1) OR i.order_num BETWEEN 9133 AND 9136 OR (i.order_num>=9137 AND MOD(i.order_num+serials.n,2)=0) THEN '打包员演示' ELSE '' END,
       CASE WHEN (i.order_num BETWEEN 9125 AND 9132 AND serials.n=1) OR i.order_num BETWEEN 9133 AND 9136 OR (i.order_num>=9137 AND MOD(i.order_num+serials.n,2)=0) THEN '["/uploads/packing/demo-package.jpg"]' ELSE '' END,
       CASE WHEN (i.order_num BETWEEN 9125 AND 9132 AND serials.n=1) OR i.order_num BETWEEN 9133 AND 9136 OR (i.order_num>=9137 AND MOD(i.order_num+serials.n,2)=0) THEN NOW() ELSE NULL END,
       CASE WHEN MOD(i.order_num+serials.n,3)=0 THEN 2 ELSE 1 END,CASE WHEN MOD(i.order_num+serials.n,3)=0 THEN '60×60加固箱' ELSE '标准鲜花箱' END,
       CASE WHEN MOD(i.order_num+serials.n,3)=0 THEN 2 ELSE 1 END,CASE WHEN MOD(i.order_num+serials.n,3)=0 THEN '60×60加固箱' ELSE '标准鲜花箱' END,1,NOW(),NOW(),0
FROM xm_bulky_supplier_enter_item i JOIN serials
WHERE i.date='2026-09-20' AND i.supplier_id=9401 AND i.order_num>=9117
AND NOT EXISTS (SELECT 1 FROM xm_bulky_wms_express_package p WHERE p.round_no='2026-09-20' AND p.shelf_sn=i.order_num AND p.serial_num=serials.n AND p.data_status=0);

COMMIT;
