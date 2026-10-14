SET @ddl=(SELECT IF(COUNT(*)=0,"ALTER TABLE hub_vehicle ADD COLUMN tracking_device_no varchar(32) NOT NULL DEFAULT '' COMMENT '定位设备号' AFTER audit_remark",'SELECT 1') FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='hub_vehicle' AND column_name='tracking_device_no'); PREPARE s FROM @ddl; EXECUTE s; DEALLOCATE PREPARE s;
SET @ddl=(SELECT IF(COUNT(*)=0,"ALTER TABLE hub_vehicle ADD COLUMN online_status tinyint NOT NULL DEFAULT 0 COMMENT '0离线 1在线' AFTER tracking_device_no",'SELECT 1') FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='hub_vehicle' AND column_name='online_status'); PREPARE s FROM @ddl; EXECUTE s; DEALLOCATE PREPARE s;
SET @ddl=(SELECT IF(COUNT(*)=0,"ALTER TABLE hub_vehicle ADD COLUMN acc_status tinyint NOT NULL DEFAULT 0 COMMENT '0关闭 1开启' AFTER online_status",'SELECT 1') FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='hub_vehicle' AND column_name='acc_status'); PREPARE s FROM @ddl; EXECUTE s; DEALLOCATE PREPARE s;
SET @ddl=(SELECT IF(COUNT(*)=0,'ALTER TABLE hub_vehicle ADD COLUMN acc_status_update_time datetime NULL AFTER acc_status','SELECT 1') FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='hub_vehicle' AND column_name='acc_status_update_time'); PREPARE s FROM @ddl; EXECUTE s; DEALLOCATE PREPARE s;
SET @ddl=(SELECT IF(COUNT(*)=0,'ALTER TABLE hub_vehicle ADD COLUMN last_acc_on_time datetime NULL AFTER acc_status_update_time','SELECT 1') FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='hub_vehicle' AND column_name='last_acc_on_time'); PREPARE s FROM @ddl; EXECUTE s; DEALLOCATE PREPARE s;

INSERT INTO hub_vehicle_type(id,name,status) VALUES (1,'4.2米',1),(3,'8.1米',1),(4,'9.6米',1)
ON DUPLICATE KEY UPDATE name=VALUES(name),status=1;

INSERT INTO hub_vehicle(id,vehicle_no,plate_no,type_id,type_name,load_standard,fuel_consumption,owner_user_id,owner_name,status,tracking_device_no,online_status,acc_status,acc_status_update_time,last_acc_on_time)
VALUES
(38,'38号车','云AQ2H60',1,'4.2米',48,13.60,203241,'赵发磊',1,'016073084385',1,0,'2026-09-23 14:14:10','2026-09-23 14:05:30'),
(39,'39号车','云A3J21W',1,'4.2米',48,15.55,200192,'张顺发',1,'016073084384',1,1,'2026-09-23 14:15:33','2026-09-23 14:03:26'),
(40,'40号车','云AN62A8',1,'4.2米',48,13.50,200310,'李树华',1,'016073084383',1,0,'2026-09-23 14:15:33','2026-09-23 14:05:09'),
(41,'41号车','云A6E2F6',1,'4.2米',48,14.30,200989,'肖洪',1,'016073084428',0,0,'2026-09-23 14:11:40','2026-09-23 14:04:49'),
(42,'42号车','云A8D92S',1,'4.2米',48,14.50,201985,'李少伟',1,'016073084427',1,0,'2026-09-23 14:13:22','2026-09-23 14:03:42'),
(43,'43号车','云AM839D',1,'4.2米',48,14.50,200282,'付宏伟',1,'016073084422',1,0,'2026-09-23 14:14:52','2026-09-23 14:07:03'),
(44,'44号车','云A6K7H8',1,'4.2米',48,14.50,202500,'李春',1,'016073084424',1,1,'2026-09-23 14:15:31','2026-09-23 14:15:31'),
(45,'46号车','云AF9454',4,'9.6米',0,17.90,202718,'邹秀明',1,'016073084397',0,0,'2026-09-23 14:06:49','2026-09-23 14:01:24'),
(46,'47号车','云AV3664',4,'9.6米',0,19.50,200194,'廖光兴',1,'016073084401',1,1,'2026-09-23 14:15:28','2026-09-23 14:14:05'),
(47,'48号车','云AG9449',3,'8.1米',0,19.40,200320,'高帅',1,'016073084419',1,0,'2026-09-23 13:58:22','2026-09-22 22:03:51')
ON DUPLICATE KEY UPDATE vehicle_no=VALUES(vehicle_no),plate_no=VALUES(plate_no),type_id=VALUES(type_id),type_name=VALUES(type_name),load_standard=VALUES(load_standard),fuel_consumption=VALUES(fuel_consumption),owner_user_id=VALUES(owner_user_id),owner_name=VALUES(owner_name),status=VALUES(status),tracking_device_no=VALUES(tracking_device_no),online_status=VALUES(online_status),acc_status=VALUES(acc_status),acc_status_update_time=VALUES(acc_status_update_time),last_acc_on_time=VALUES(last_acc_on_time);

SET @transport=(SELECT id FROM wms_permission WHERE code='transport.view' LIMIT 1);
INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
VALUES
(@transport,'transport.vehicle.view','查看车辆管理','transport',1,'查看车辆档案、在线状态与设备状态','/features/transport/pages/vehicles/index','fwms-truck-outline',31,1),
(@transport,'transport.vehicle.manage','维护车辆档案','transport',2,'新增、编辑车辆及维护可用状态','','',32,1)
ON DUPLICATE KEY UPDATE parent_id=VALUES(parent_id),name=VALUES(name),description=VALUES(description),route_path=VALUES(route_path),icon=VALUES(icon),status=1;

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p ON p.code IN ('transport.vehicle.view','transport.vehicle.manage')
WHERE g.code IN ('transport_dispatcher','super_admin_all');
