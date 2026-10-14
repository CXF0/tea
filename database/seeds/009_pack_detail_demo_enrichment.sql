USE `menghuacangguan_v1_local`;
START TRANSACTION;
UPDATE xm_bulky_wms_express_package p
JOIN xm_bulky_pack_config suggested ON suggested.id=CASE MOD(p.shelf_sn+p.serial_num,5) WHEN 0 THEN 7 WHEN 1 THEN 13 WHEN 2 THEN 14 WHEN 3 THEN 15 ELSE 11 END
LEFT JOIN xm_bulky_pack_config actual ON actual.id=CASE WHEN MOD(p.shelf_sn+p.serial_num,4)=0 THEN 17 ELSE suggested.id END
SET p.suggest_pack_id=suggested.id,p.suggest_pack_info=suggested.pack_name,p.package_id=IF(p.express_status>=10,actual.id,0),p.package_info=IF(p.express_status>=10,actual.pack_name,''),p.update_time=NOW()
WHERE p.round_no='2026-09-20' AND p.shelf_sn BETWEEN 9117 AND 9140 AND p.data_status=0;
UPDATE xm_bulky_wms_express_package p
JOIN wms_account a
JOIN wms_role r ON r.id=a.role_id AND r.code='packer'
SET p.package_user_id=a.id,p.package_user_name=a.display_name,p.express_user_id=a.id,p.express_user_name=a.display_name,p.update_time=NOW()
WHERE p.round_no='2026-09-20' AND p.shelf_sn BETWEEN 9117 AND 9140 AND p.express_status>=10 AND p.data_status=0 AND a.status=1;
INSERT INTO xm_bulky_send_order
  (ware_id,partner_id,send_no,round_no,purchaser_id,order_num,ware_sn,shelf_sn,sub_shelf_sn,zone,shelf,zone_shelf,delivery_type,config_id,express_region,receive_name,receive_tel,province,city,district,detail,receive_address,remark,logistics_remark,create_time,update_time,data_status)
SELECT 1,0,p.send_no,'2026-09-20',0,p.shelf_sn,p.serial_num,p.shelf_sn,'',p.zone,p.shelf,p.zone_shelf,IF(p.self_take_type>0,2,1),1,1,CONCAT('演示收货人',MOD(p.shelf_sn,10)),CONCAT('1357609',LPAD(MOD(p.shelf_sn*10+p.serial_num,10000),4,'0')),'云南省','昆明市',ELT(1+MOD(p.shelf_sn,5),'西山区','盘龙区','五华区','官渡区','呈贡区'),CONCAT('演示鲜花门店 ',p.zone_shelf),CONCAT('云南省昆明市',ELT(1+MOD(p.shelf_sn,5),'西山区','盘龙区','五华区','官渡区','呈贡区'),'演示鲜花门店 ',p.zone_shelf),CASE WHEN MOD(p.shelf_sn,6)=0 THEN '轻拿轻放，优先装车' ELSE '' END,CASE p.express_type WHEN 1 THEN '早班优先出库' WHEN 2 THEN '普通班次' ELSE '' END,NOW(),NOW(),0
FROM xm_bulky_wms_express_package p WHERE p.round_no='2026-09-20' AND p.shelf_sn BETWEEN 9117 AND 9140 AND p.data_status=0
AND NOT EXISTS (SELECT 1 FROM xm_bulky_send_order s WHERE s.send_no=p.send_no);
INSERT INTO xm_bulky_order_info (order_sn,send_no,api_order_sn,has_cotton,cotton_info,promote_merchant_flag,create_time,update_time)
SELECT CONCAT('LOCAL-ORDER-',p.shelf_sn,'-',p.serial_num),p.send_no,'',IF(MOD(p.shelf_sn,4)=0,1,0),JSON_OBJECT('cottonNum',IF(MOD(p.shelf_sn,4)=0,2,0),'boardNum',IF(MOD(p.shelf_sn,4)=0,1,0),'bagNum',IF(MOD(p.shelf_sn,8)=0,1,0)),0,NOW(),NOW()
FROM xm_bulky_wms_express_package p WHERE p.round_no='2026-09-20' AND p.shelf_sn BETWEEN 9117 AND 9140 AND p.data_status=0
AND NOT EXISTS (SELECT 1 FROM xm_bulky_order_info oi WHERE oi.send_no=p.send_no);
COMMIT;
