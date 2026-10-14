START TRANSACTION;

INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id
FROM wms_role r
JOIN wms_permission_group g
  ON g.code IN('agri_delivery_operator','agri_driver_order_operator')
WHERE r.code='superAdmin';

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id
FROM wms_permission_group g
JOIN wms_permission p
  ON p.code IN('agriDelivery.view','agriDriverOrder.view','agriDriverOrder.operate')
WHERE g.code='super_admin_all';

COMMIT;
