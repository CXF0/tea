-- 仓管端完整角色模板。角色清单来自旧仓管源码；仅写入本地新版库。
-- 本地演示账号初始密码统一为 123456，禁止在生产环境复用。

INSERT INTO wms_permission(code,name,domain_code,description) VALUES
('collection.view','查看集货','collection','查看集货任务与汇总'),('collection.operate','执行集货','collection','确认集货数量与异常'),
('transport.view','查看运输','transport','查看车辆与运输任务'),('transport.dispatch','运输调度','transport','车辆配置、装车和发车'),('transport.drive','司机作业','transport','司机签到、装车与在途操作'),
('packing.view','查看打包','packing','查看打包任务'),('packing.operate','执行打包','packing','包花、装箱与复核'),
('logistics.view','查看物流','logistics','查看物流及发货任务'),('logistics.operate','执行物流','logistics','揽收、拍照与发货'),('logistics.assign','物流调度','logistics','分配物流人员与任务'),
('management.view','查看管理数据','management','查看人员、配置与审计'),('management.configure','管理系统配置','management','维护账户、角色与业务配置'),
('quality.revoke','撤销质检标记','quality','撤销当前有效质检标记'),('distribution.cancelAllocation','取消配货','distribution','取消已确认的配货'),
('restock.history','查看补货历史','restock','查看补货单历史'),('inventory.manage','管理库存','inventory','盘点、物资及库存配置')
ON DUPLICATE KEY UPDATE name=VALUES(name),domain_code=VALUES(domain_code),description=VALUES(description);

INSERT INTO wms_permission_group(code,name,description) VALUES
('collection_operator','集货作业','集货查看与操作'),('transport_dispatcher','运输调度','运输查看与调度'),('driver_operator','司机作业','司机运输作业'),
('packing_operator','打包作业','打包查看与执行'),('logistics_operator','物流作业','物流查看与执行'),('logistics_management','物流管理','物流任务分配'),
('patrol_operator','巡察作业','质检查看、提交、撤销与统计'),('warehouse_management','仓库管理','库存、冷库及物资管理'),
('system_management','系统管理','账户、角色、权限和业务配置')
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description);

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p ON
(g.code='collection_operator' AND p.domain_code='collection') OR
(g.code='transport_dispatcher' AND p.code IN ('transport.view','transport.dispatch')) OR
(g.code='driver_operator' AND p.code IN ('transport.view','transport.drive')) OR
(g.code='packing_operator' AND p.domain_code='packing') OR
(g.code='logistics_operator' AND p.code IN ('logistics.view','logistics.operate')) OR
(g.code='logistics_management' AND p.domain_code='logistics') OR
(g.code='patrol_operator' AND p.code IN ('quality.view','quality.scan','quality.submit','quality.revoke','quality.statistics')) OR
(g.code='warehouse_management' AND p.code IN ('inventory.view','inventory.inbound','inventory.outbound','inventory.manage','nfc.use','coldStorage.view','coldStorage.registerBare','coldStorage.finishOut')) OR
(g.code='system_management' AND p.code IN ('staff.manage','management.view','management.configure'));

INSERT INTO wms_role(code,name,description,workbench_cards_json,todo_ids_json,scan_operations_json,data_cards_json) VALUES
('siteAdmin','场地管理员','仓管端全部业务与管理能力','["admission-session","quality-session","inventory-session"]','["admission-pending","quality-pending","inventory-inbound"]','["admission-checkin","quality-inspection","inventory-inbound","inventory-outbound"]','["admission-overview","quality-overview","quality-result","inventory-overview","inventory-progress"]'),
('regionalManager','大区负责人','跨分区仓内业务管理','["quality-session"]','["quality-pending"]','[]','["quality-overview","quality-result"]'),
('zoneSupervisor','分区主管','负责分区质检、配货和打包','["quality-session"]','["quality-pending"]','["quality-inspection"]','["quality-overview"]'),
('patrolInspector','巡察员','巡察质检和业务处罚','["quality-session"]','["quality-pending"]','["quality-inspection"]','["quality-overview","quality-result"]'),
('picker','配货员','执行货架配货与异常补货','[]','[]','[]','[]'),
('packer','打包员','执行包花、装箱和复核','[]','[]','[]','[]'),
('logisticsSpecialist','物流专员','执行揽收、发货与运输协作','[]','[]','[]','[]'),
('driver','司机','执行装车、发车和在途作业','[]','[]','[]','[]'),
('baseRegionLeader','基地片区负责人','管理基地集货、入场和运输','["admission-session"]','["admission-pending"]','["admission-checkin"]','["admission-overview"]'),
('baseStationStaff','基地驻场','执行基地集货和入场','["admission-session"]','["admission-pending"]','["admission-checkin"]','[]')
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),workbench_cards_json=VALUES(workbench_cards_json),todo_ids_json=VALUES(todo_ids_json),scan_operations_json=VALUES(scan_operations_json),data_cards_json=VALUES(data_cards_json);

INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g ON
(r.code='siteAdmin') OR
(r.code='regionalManager' AND g.code IN ('collection_operator','transport_dispatcher','quality_operator','quality_management','distribution_operator','packing_operator','logistics_management')) OR
(r.code='zoneSupervisor' AND g.code IN ('quality_operator','distribution_operator','restock_operator','packing_operator','logistics_operator')) OR
(r.code='patrolInspector' AND g.code IN ('patrol_operator')) OR
(r.code='picker' AND g.code='distribution_operator') OR
(r.code='packer' AND g.code='packing_operator') OR
(r.code='logisticsSpecialist' AND g.code IN ('logistics_management','transport_dispatcher','packing_operator')) OR
(r.code='driver' AND g.code='driver_operator') OR
(r.code='warehouseManager' AND g.code='warehouse_management') OR
(r.code='baseRegionLeader' AND g.code IN ('admission_operator','collection_operator','transport_dispatcher')) OR
(r.code='baseStationStaff' AND g.code IN ('admission_operator','collection_operator'));

DELETE rg FROM wms_role_permission_group rg
JOIN wms_role r ON r.id=rg.role_id AND r.code='picker'
JOIN wms_permission_group g ON g.id=rg.group_id AND g.code='restock_operator';

-- 为旧角色补齐新增的精细能力。
INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p ON
(g.code='quality_operator' AND p.code='quality.revoke') OR
(g.code='distribution_operator' AND p.code='distribution.cancelAllocation') OR
(g.code='restock_operator' AND p.code='restock.history');

INSERT INTO wms_account(login_name,phone,display_name,password_salt,password_hash,role_id,warehouse_name)
SELECT CONCAT('demo_',r.code),CONCAT('1399',LPAD(r.id,7,'0')),r.name,CONCAT('wms_',r.code),SHA2(CONCAT('wms_',r.code,'123456'),256),r.id,'梦花仓管'
FROM wms_role r
WHERE r.code IN ('siteAdmin','regionalManager','zoneSupervisor','qualityInspector','qualityLeader','patrolInspector','picker','packer','logisticsSpecialist','driver','warehouseManager','baseRegionLeader','baseStationStaff','baseAdmissionOfficer')
ON DUPLICATE KEY UPDATE display_name=VALUES(display_name),role_id=VALUES(role_id),warehouse_name=VALUES(warehouse_name),status=1;
