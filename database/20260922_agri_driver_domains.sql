START TRANSACTION;

INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status) VALUES
(0,'agriDelivery.view','农资送货单','agri-delivery',1,'按商品查看农资送货汇总及供应商明细','/features/agri-driver/pages/delivery/index','fwms-agri-delivery-outline',28,1),
(0,'agriDriverOrder.view','农资订单','agri-driver-order',1,'查看司机组农资订单及配送状态','/features/agri-driver/pages/orders/index','fwms-agri-order-outline',29,1)
ON DUPLICATE KEY UPDATE name=VALUES(name),domain_code=VALUES(domain_code),permission_type=VALUES(permission_type),description=VALUES(description),route_path=VALUES(route_path),icon=VALUES(icon),sort_order=VALUES(sort_order),status=1;

INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
SELECT id,'agriDriverOrder.operate','农资订单发货与签收','agri-driver-order',2,'拍照记录农资订单发货及农户签收','','',10,1 FROM wms_permission WHERE code='agriDriverOrder.view'
ON DUPLICATE KEY UPDATE parent_id=VALUES(parent_id),name=VALUES(name),domain_code=VALUES(domain_code),permission_type=2,description=VALUES(description),status=1;

INSERT INTO wms_permission_group(code,name,description,status) VALUES
('agri_delivery_operator','农资送货单作业','查看农资商品送货汇总和供应商明细',1),
('agri_driver_order_operator','农资订单配送作业','查看农资订单并执行发货、签收',1)
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),status=1;

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p ON p.code='agriDelivery.view' WHERE g.code='agri_delivery_operator';
INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p ON p.code IN('agriDriverOrder.view','agriDriverOrder.operate') WHERE g.code='agri_driver_order_operator';

INSERT INTO wms_role(code,name,description,workbench_cards_json,todo_ids_json,scan_operations_json,data_cards_json,status) VALUES
('driverLeader','司机组长','管理农资送货单，并执行农资订单发货与签收','[]','[]','[]','[]',1)
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),status=1;

INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g ON g.code IN('agri_delivery_operator','agri_driver_order_operator') WHERE r.code='driverLeader';

INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g ON g.code IN('agri_delivery_operator','agri_driver_order_operator') WHERE r.code='superAdmin';

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p ON p.code IN('agriDelivery.view','agriDriverOrder.view','agriDriverOrder.operate') WHERE g.code='super_admin_all';

INSERT INTO wms_account(login_name,phone,display_name,password_salt,password_hash,role_id,warehouse_name,status)
SELECT 'demo_driverLeader','13990000016','周凯','wms_driverLeader',SHA2('wms_driverLeader123456',256),id,'梦花仓管',1 FROM wms_role WHERE code='driverLeader'
ON DUPLICATE KEY UPDATE display_name=VALUES(display_name),role_id=VALUES(role_id),warehouse_name=VALUES(warehouse_name),status=1;

COMMIT;
