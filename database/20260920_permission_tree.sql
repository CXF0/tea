-- 权限树：领域入口和领域功能统一存放在 wms_permission。
INSERT INTO wms_permission (code,name,domain_code,description)
VALUES ('distribution.unfinished.view','查看未配货汇总','distribution','查看配货作业中的未配货汇总')
ON DUPLICATE KEY UPDATE name=VALUES(name),domain_code=VALUES(domain_code),description=VALUES(description),status=1;

INSERT IGNORE INTO wms_permission_group_item (group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g,wms_permission p
WHERE g.code='distribution_operator' AND p.code='distribution.unfinished.view';

INSERT INTO wms_permission (code,name,domain_code,description)
VALUES ('distribution.mine.view','查看我的配货','distribution','查看当前账号在所选场次完成的配货记录')
ON DUPLICATE KEY UPDATE name=VALUES(name),domain_code=VALUES(domain_code),description=VALUES(description),status=1;

INSERT INTO wms_permission_group (code,name,description,status)
VALUES ('distribution_personal','我的配货','查看本人配货记录',1)
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),status=1;

INSERT IGNORE INTO wms_permission_group_item (group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g,wms_permission p
WHERE g.code='distribution_personal' AND p.code='distribution.mine.view';

INSERT IGNORE INTO wms_role_permission_group (role_id,group_id)
SELECT r.id,g.id FROM wms_role r,wms_permission_group g
WHERE r.code='picker' AND g.code='distribution_personal';

UPDATE wms_permission
SET parent_id=0, permission_type=2, route_path='', icon='', sort_order=0;

UPDATE wms_permission SET permission_type=1,route_path='/features/admission/pages/home/index',icon='fwms-checkin-outline',sort_order=10 WHERE code='admission.view';
UPDATE wms_permission SET permission_type=1,route_path='',icon='fwms-collection-outline',sort_order=20 WHERE code='collection.view';
UPDATE wms_permission SET permission_type=1,route_path='',icon='fwms-truck-outline',sort_order=30 WHERE code='transport.view';
UPDATE wms_permission SET permission_type=1,route_path='/features/quality/pages/suppliers/index',icon='fwms-inspection-outline',sort_order=40 WHERE code='quality.flower.view';
UPDATE wms_permission SET permission_type=1,route_path='/features/quality/pages/tasks/index',icon='fwms-task-outline',sort_order=50 WHERE code='quality.task.view';
UPDATE wms_permission SET permission_type=1,route_path='/features/distribution/pages/home/index',icon='fwms-picking-outline',sort_order=60 WHERE code='distribution.view';
UPDATE wms_permission SET permission_type=1,route_path='/features/restock/pages/home/index',icon='fwms-replenishment-outline',sort_order=70 WHERE code='restock.view';
UPDATE wms_permission SET permission_type=1,route_path='/features/packing/pages/home/index',icon='fwms-packing-outline',sort_order=80 WHERE code='packing.view';
UPDATE wms_permission SET permission_type=1,route_path='/pages/home/index',icon='fwms-warehouse-outline',sort_order=90 WHERE code='inventory.view';
UPDATE wms_permission SET permission_type=1,route_path='/features/cold-storage/pages/home/index',icon='fwms-cold-storage-outline',sort_order=100 WHERE code='coldStorage.view';
UPDATE wms_permission SET permission_type=1,route_path='',icon='fwms-outbound-outline',sort_order=110 WHERE code='logistics.view';
UPDATE wms_permission SET permission_type=1,route_path='/features/management/pages/staff/index',icon='fwms-account-outline',sort_order=140 WHERE code='staff.manage';

UPDATE wms_permission child JOIN wms_permission parent ON parent.code='admission.view' SET child.parent_id=parent.id WHERE child.domain_code='admission' AND child.id<>parent.id;
UPDATE wms_permission child JOIN wms_permission parent ON parent.code='collection.view' SET child.parent_id=parent.id WHERE child.domain_code='collection' AND child.id<>parent.id;
UPDATE wms_permission child JOIN wms_permission parent ON parent.code='transport.view' SET child.parent_id=parent.id WHERE child.domain_code='transport' AND child.id<>parent.id;
UPDATE wms_permission child JOIN wms_permission parent ON parent.code='quality.flower.view' SET child.parent_id=parent.id WHERE child.domain_code='quality' AND child.id<>parent.id;
UPDATE wms_permission child JOIN wms_permission parent ON parent.code='quality.task.view' SET child.parent_id=parent.id WHERE child.domain_code='quality-task' AND child.id<>parent.id;
UPDATE wms_permission child JOIN wms_permission parent ON parent.code='distribution.view' SET child.parent_id=parent.id WHERE child.domain_code='distribution' AND child.id<>parent.id;
UPDATE wms_permission child JOIN wms_permission parent ON parent.code='restock.view' SET child.parent_id=parent.id WHERE child.domain_code='restock' AND child.id<>parent.id;
UPDATE wms_permission child JOIN wms_permission parent ON parent.code='packing.view' SET child.parent_id=parent.id WHERE child.domain_code='packing' AND child.id<>parent.id;
UPDATE wms_permission child JOIN wms_permission parent ON parent.code='inventory.view' SET child.parent_id=parent.id WHERE child.domain_code='inventory' AND child.id<>parent.id;
UPDATE wms_permission child JOIN wms_permission parent ON parent.code='coldStorage.view' SET child.parent_id=parent.id WHERE child.domain_code='cold-storage' AND child.id<>parent.id;
UPDATE wms_permission child JOIN wms_permission parent ON parent.code='logistics.view' SET child.parent_id=parent.id WHERE child.domain_code='logistics' AND child.id<>parent.id;
UPDATE wms_permission child JOIN wms_permission parent ON parent.code='staff.manage' SET child.parent_id=parent.id WHERE child.domain_code='management' AND child.id<>parent.id;

DROP TABLE IF EXISTS wms_business_domain;
