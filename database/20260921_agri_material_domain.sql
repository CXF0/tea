INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status) VALUES
(0,'agriMaterial.view','农资管理','agri-material',1,'查看农资订单及详情','/features/agri-material/pages/home/index','fwms-crate-outline',19,1)
ON DUPLICATE KEY UPDATE name=VALUES(name),domain_code=VALUES(domain_code),permission_type=1,description=VALUES(description),route_path=VALUES(route_path),icon=VALUES(icon),sort_order=VALUES(sort_order),status=1;
INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
SELECT id,'agriMaterial.print','打印农资标签','agri-material',2,'查看农资标签数据并执行标签打印','','',10,1 FROM wms_permission WHERE code='agriMaterial.view'
ON DUPLICATE KEY UPDATE parent_id=VALUES(parent_id),name=VALUES(name),domain_code=VALUES(domain_code),permission_type=2,description=VALUES(description),status=1;
INSERT INTO wms_permission_group(code,name,description,status) VALUES('agri_material_operator','农资订单与标签','查看农资订单、详情并打印标签',1) ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),status=1;
INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id) SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p ON p.code IN('agriMaterial.view','agriMaterial.print') WHERE g.code='agri_material_operator';
INSERT INTO wms_role(code,name,description,workbench_cards_json,todo_ids_json,scan_operations_json,data_cards_json,status) VALUES('agriMaterialManager','农资管理员','管理农资订单与标签打印','[]','[]','[]','[]',1) ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),status=1;
INSERT IGNORE INTO wms_role_permission_group(role_id,group_id) SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g WHERE r.code IN('agriMaterialManager','siteAdmin') AND g.code='agri_material_operator';
INSERT INTO wms_account(login_name,phone,display_name,password_salt,password_hash,role_id,warehouse_name,status)
SELECT 'demo_agriMaterialManager','13990000015','冯晓东','wms_agriMaterialManager',SHA2('wms_agriMaterialManager123456',256),id,'梦花仓管',1 FROM wms_role WHERE code='agriMaterialManager'
ON DUPLICATE KEY UPDATE display_name=VALUES(display_name),role_id=VALUES(role_id),warehouse_name=VALUES(warehouse_name),status=1;
