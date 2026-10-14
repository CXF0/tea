INSERT INTO wms_permission(code,name,domain_code,description,status,permission_type,parent_id,route_path,icon,sort_order)
SELECT 'patrolPunishment.view','巡线处罚','patrol-punishment','查看巡线处罚、统计与记录',1,1,0,'/features/patrol-punishment/pages/home/index','/static/icons/wms/fwms-patrol-punishment-outline.svg',180
WHERE NOT EXISTS(SELECT 1 FROM wms_permission WHERE code='patrolPunishment.view');
INSERT INTO wms_permission(code,name,domain_code,description,status,permission_type,parent_id,route_path,icon,sort_order)
SELECT 'patrolPunishment.create','发起巡线处罚','patrol-punishment','扫码并提交配错货或设箱错误处罚',1,2,p.id,'','',181 FROM wms_permission p WHERE p.code='patrolPunishment.view' AND NOT EXISTS(SELECT 1 FROM wms_permission WHERE code='patrolPunishment.create');
INSERT INTO wms_permission(code,name,domain_code,description,status,permission_type,parent_id,route_path,icon,sort_order)
SELECT 'patrolPunishment.revoke','撤销巡线处罚','patrol-punishment','撤销本人发起且待确认的处罚',1,2,p.id,'','',182 FROM wms_permission p WHERE p.code='patrolPunishment.view' AND NOT EXISTS(SELECT 1 FROM wms_permission WHERE code='patrolPunishment.revoke');

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g CROSS JOIN wms_permission p WHERE g.code='patrol_operator' AND p.code IN('patrolPunishment.view','patrolPunishment.create','patrolPunishment.revoke');

INSERT INTO wms_punish(type,punish_source,duty_user_id,duty_user_role,duty_user_name,punish_role_type,order_sn,date,zone,shelf,zone_shelf,sub_shelf_sn,punish_reason,punish_remark,punish_price,punish_status,pic_url,appeal_status,operator_id,operator_name,last_operator_id,last_operator_name,create_time,data_status,relation_id)
SELECT 2,0,13,9,'杨晨',10,'PATROL-DEMO-001','2026-09-21','9','117','09-117-2','','09-117-2货架发现配错货','现场复核花材与订单不一致',10,0,'[]',0,12,'郑晓东',12,'郑晓东','2026-09-21 09:18:00',0,90001
WHERE NOT EXISTS(SELECT 1 FROM wms_punish WHERE order_sn='PATROL-DEMO-001');
INSERT INTO wms_punish(type,punish_source,duty_user_id,duty_user_role,duty_user_name,punish_role_type,order_sn,date,zone,shelf,zone_shelf,sub_shelf_sn,punish_reason,punish_remark,punish_price,punish_status,pic_url,appeal_status,operator_id,operator_name,last_operator_id,last_operator_name,create_time,data_status,relation_id)
SELECT 1,0,14,10,'李建军',1,'PATROL-DEMO-002','2026-09-21','12','206','12-206-1','','实际箱型与系统设箱不符','已现场拍照核验',10,1,'[]',0,12,'郑晓东',12,'郑晓东','2026-09-21 10:36:00',0,90002
WHERE NOT EXISTS(SELECT 1 FROM wms_punish WHERE order_sn='PATROL-DEMO-002');
INSERT INTO wms_punish(type,punish_source,duty_user_id,duty_user_role,duty_user_name,punish_role_type,order_sn,date,zone,shelf,zone_shelf,sub_shelf_sn,punish_reason,punish_remark,punish_price,punish_status,pic_url,appeal_status,operator_id,operator_name,last_operator_id,last_operator_name,create_time,data_status,relation_id)
SELECT 2,0,40,9,'陈宇',10,'PATROL-DEMO-003','2026-09-20','15','088','15-088-1','','配货商品等级与订单不一致','复核后撤销',10,2,'[]',0,12,'郑晓东',12,'郑晓东','2026-09-20 15:42:00',0,90003
WHERE NOT EXISTS(SELECT 1 FROM wms_punish WHERE order_sn='PATROL-DEMO-003');
INSERT INTO wms_punish(type,punish_source,duty_user_id,duty_user_role,duty_user_name,punish_role_type,order_sn,date,zone,shelf,zone_shelf,sub_shelf_sn,punish_reason,punish_remark,punish_price,punish_status,pic_url,appeal_status,operator_id,operator_name,last_operator_id,last_operator_name,create_time,data_status,relation_id)
SELECT 1,0,14,10,'李建军',1,'PATROL-DEMO-004','2026-09-18','7','031','07-031-3','','包装箱型号选择错误','货架复核记录',20,1,'[]',0,12,'郑晓东',12,'郑晓东','2026-09-18 11:05:00',0,90004
WHERE NOT EXISTS(SELECT 1 FROM wms_punish WHERE order_sn='PATROL-DEMO-004');
