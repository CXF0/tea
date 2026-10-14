START TRANSACTION;

INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
VALUES(0,'bulkPurchaseDemand.view','集采需求','bulkPurchaseDemand',1,'查看包花厂集采需求及报价、定采进度','/features/bulk-purchase/pages/demands/index','/static/icons/wms/fwms-bulk-demand-outline.svg',230,1)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id),name=VALUES(name),route_path=VALUES(route_path),icon=VALUES(icon),status=1;
SET @demand_permission=LAST_INSERT_ID();

INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
VALUES(0,'bulkPurchaseOrder.view','集采订单','bulkPurchaseOrder',1,'查看定采形成的供货单、签到、盘点与结算进度','/features/bulk-purchase/pages/orders/index','/static/icons/wms/fwms-bulk-order-outline.svg',231,1)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id),name=VALUES(name),route_path=VALUES(route_path),icon=VALUES(icon),status=1;
SET @order_permission=LAST_INSERT_ID();

INSERT INTO wms_permission_group(code,name,description,status)
VALUES('bulk_purchase_demand_viewer','集采需求查看','查看集采需求、报价供应商数量及定采结果',1)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id),name=VALUES(name),description=VALUES(description),status=1;
SET @demand_group=LAST_INSERT_ID();
INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id) VALUES(@demand_group,@demand_permission);

INSERT INTO wms_permission_group(code,name,description,status)
VALUES('bulk_purchase_order_viewer','集采订单查看','查看集采供货单、标签、签到、盘点及结算进度',1)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id),name=VALUES(name),description=VALUES(description),status=1;
SET @order_group=LAST_INSERT_ID();
INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id) VALUES(@order_group,@order_permission);

INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT id,@demand_group FROM wms_role WHERE code='superAdmin';
INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT id,@order_group FROM wms_role WHERE code='superAdmin';

COMMIT;
