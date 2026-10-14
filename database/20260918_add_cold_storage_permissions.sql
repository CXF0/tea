INSERT INTO wms_permission(code,name,domain_code,description) VALUES
('coldStorage.view','查看冷库暂存','cold-storage','查看暂存库存与出库任务'),
('coldStorage.registerBare','登记裸花暂存','cold-storage','扫码登记裸花冷库暂存'),
('coldStorage.finishOut','完成冷库出库','cold-storage','确认冷库出库并上传凭证')
ON DUPLICATE KEY UPDATE name=VALUES(name),domain_code=VALUES(domain_code),description=VALUES(description);

INSERT INTO wms_permission_group(code,name,description) VALUES
('cold_storage_operator','冷库暂存作业','冷库暂存查看、裸花登记与出库确认')
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description);

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p ON g.code='cold_storage_operator' AND p.domain_code='cold-storage';

INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g
WHERE r.code IN ('qualityInspector','qualityLeader') AND g.code='cold_storage_operator';
