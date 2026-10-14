INSERT IGNORE INTO wms_role_permission_group (role_id,group_id)
SELECT r.id,g.id FROM wms_role r CROSS JOIN wms_permission_group g
WHERE r.code='logisticsSpecialist' AND g.code='logistics_operator';
