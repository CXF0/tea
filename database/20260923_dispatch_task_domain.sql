START TRANSACTION;

SET @transport := (SELECT id FROM wms_permission WHERE code='transport.view' LIMIT 1);
INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status) VALUES
(@transport,'transport.dispatch.view','查看派车任务','transport',1,'查看派车任务、车辆、司机和运输路线','/features/transport/pages/dispatch/index','fwms-truck-outline',29,1),
(@transport,'transport.dispatch.manage','维护派车任务','transport',2,'更新派车任务执行状态','','',30,1)
ON DUPLICATE KEY UPDATE parent_id=VALUES(parent_id),name=VALUES(name),description=VALUES(description),route_path=VALUES(route_path),sort_order=VALUES(sort_order),status=1;

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p ON p.code IN ('transport.dispatch.view','transport.dispatch.manage')
WHERE g.code IN ('transport_dispatcher','super_admin_all');

INSERT INTO hub_dispatch_order(id,dispatch_no,round_no,type,vehicle_name,plate_no,driver_name,start_station_name,end_station_id,end_station_name,responsible_base_id,responsible_base_name,status,sign_status,operator_name) VALUES
(4134,'HF1790140868227042','2026-09-23',1,'8.1米','云AQ6106','赵永聪','斗南基地',51,'墩子基地',51,'墩子基地',1,0,'接口导入'),
(4133,'HF1790140868227041','2026-09-23',1,'8.1米','云AG8583','袁春波','斗南基地',54,'前所基地',54,'前所基地',1,0,'接口导入'),
(4132,'HF1790140868227040','2026-09-23',1,'8.1米','云AQ7678','李维平','斗南基地',43,'毛家营基地',43,'毛家营基地',1,0,'接口导入'),
(4131,'HF1790140868227039','2026-09-23',1,'4.2米','云A6E2F6','肖洪','斗南基地',37,'嵩明所基地',37,'嵩明所基地',1,0,'接口导入'),
(4130,'HF1790140868227038','2026-09-23',1,'8.1米','云AG9449','高清','斗南基地',24,'沈伞营基地',24,'沈伞营基地',1,0,'接口导入'),
(4129,'HF1790140868227037','2026-09-23',1,'9.6米','云AV3664','廖光兴','斗南基地',24,'沈伞营基地',24,'沈伞营基地',1,0,'接口导入'),
(4128,'HF1790140868227036','2026-09-23',1,'8.1米','云AQ8511','饶兴奎','斗南基地',22,'石林基地',22,'石林基地',1,0,'接口导入'),
(4127,'HF1790140868227035','2026-09-23',1,'9.6米','云AF9454','邹秀春','斗南基地',9,'北古城基地',9,'北古城基地',1,0,'接口导入'),
(4126,'HF1790140868227034','2026-09-23',1,'8.1米','云AR2905','张朝贵','斗南基地',4,'宜良基地',4,'宜良基地',1,0,'接口导入'),
(4125,'HF1790140868227033','2026-09-23',1,'9.6米','云AQ3950','代兴彩','斗南基地',4,'宜良基地',4,'宜良基地',1,0,'接口导入'),
(4124,'HF1790140868227032','2026-09-23',1,'4.2米','云A3J21W','张顺发','斗南基地',57,'翠华基地',57,'翠华基地',1,0,'接口导入'),
(4123,'HF1790140868227031','2026-09-23',1,'4.2米','云AN1R03','陈俊中','斗南基地',56,'中村基地',56,'中村基地',1,0,'接口导入'),
(4122,'HF1790140868227030','2026-09-23',1,'4.2米','云A3K20R','周喆','斗南基地',42,'高桥基地',42,'高桥基地',1,0,'接口导入'),
(4121,'HF1790140868227029','2026-09-23',1,'4.2米','云AV7K80','徐文杰','斗南基地',32,'恩路村基地',32,'恩路村基地',1,0,'接口导入'),
(4120,'HF1790140868227028','2026-09-23',1,'4.2米','云AAT139','胡勇','斗南基地',32,'恩路村基地',32,'恩路村基地',1,0,'接口导入'),
(4119,'HF1790140868227027','2026-09-23',1,'4.2米','云AJ8W50','王华','斗南基地',31,'禄劝基地',31,'禄劝基地',1,0,'接口导入'),
(4118,'HF1790140868227026','2026-09-23',1,'4.2米','云A5LL54','杨明辉','斗南基地',30,'王官厂基地',30,'王官厂基地',1,0,'接口导入'),
(4117,'HF1790140868227025','2026-09-23',1,'4.2米','云AM839D','付宏伟','斗南基地',25,'武定基地',25,'武定基地',1,0,'接口导入'),
(4116,'HF1790140868227024','2026-09-23',1,'8.1米','云AQ7380','赵安红','斗南基地',16,'九厂基地',16,'九厂基地',1,0,'接口导入'),
(4115,'HF1790140868227023','2026-09-23',1,'8.1米','云AQ3760','田茂尧','斗南基地',15,'旧街基地',15,'旧街基地',1,0,'接口导入')
ON DUPLICATE KEY UPDATE dispatch_no=VALUES(dispatch_no),round_no=VALUES(round_no),vehicle_name=VALUES(vehicle_name),plate_no=VALUES(plate_no),driver_name=VALUES(driver_name),end_station_id=VALUES(end_station_id),end_station_name=VALUES(end_station_name),responsible_base_id=VALUES(responsible_base_id),responsible_base_name=VALUES(responsible_base_name),status=VALUES(status),sign_status=VALUES(sign_status);

COMMIT;
