INSERT INTO wms_role(code,name,description,workbench_cards_json,todo_ids_json,scan_operations_json,data_cards_json,status)
VALUES('superAdmin','超级管理员','系统最高管理账号，可管理全部领域、账户、角色及权限组','[]','["admission-pending","quality-pending","inventory-inbound"]','["admission-checkin","quality-inspection","inventory-inbound","inventory-outbound"]','["session-size-statistics","admission-overview","quality-overview","quality-result","quality-supplier-admission","quality-business-statistics","inventory-overview","inventory-progress","distribution-progress","agency-distribution","contractor-distribution","arrival-volume","self-pickup"]',1)
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),workbench_cards_json=VALUES(workbench_cards_json),todo_ids_json=VALUES(todo_ids_json),scan_operations_json=VALUES(scan_operations_json),data_cards_json=VALUES(data_cards_json),status=1;
INSERT INTO wms_permission_group(code,name,description,status)
VALUES('super_admin_all','超级管理员全部权限','超级管理员专用，包含当前全部有效权限',1)
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),status=1;
SET @super_group=(SELECT id FROM wms_permission_group WHERE code='super_admin_all');
INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT @super_group,id FROM wms_permission WHERE status=1;
INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g ON g.status=1 WHERE r.code='superAdmin';
SET @admin_salt='wms_super_admin';
INSERT INTO wms_account(login_name,phone,display_name,password_salt,password_hash,role_id,warehouse_id,warehouse_name,status)
SELECT 'admin','13990000000','超级管理员',@admin_salt,SHA2(CONCAT(@admin_salt,'123456'),256),r.id,1,'梦花仓',1 FROM wms_role r WHERE r.code='superAdmin'
ON DUPLICATE KEY UPDATE display_name=VALUES(display_name),role_id=VALUES(role_id),warehouse_id=VALUES(warehouse_id),warehouse_name=VALUES(warehouse_name),status=1;
