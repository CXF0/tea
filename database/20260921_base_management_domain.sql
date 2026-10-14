INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
SELECT 0,'baseManagement.view','基地管理','base-management',1,'查看基地、供应商及库存详情','/features/base-management/pages/home/index','fwms-warehouse-outline',15,1
WHERE NOT EXISTS(SELECT 1 FROM wms_permission WHERE code='baseManagement.view');

INSERT INTO wms_permission_group(code,name,description,status)
SELECT 'base_management_viewer','基地管理','查看基地列表、基地详情和供应商库存详情',1
WHERE NOT EXISTS(SELECT 1 FROM wms_permission_group WHERE code='base_management_viewer');

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p ON p.code='baseManagement.view' WHERE g.code='base_management_viewer';

INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g ON g.code='base_management_viewer' WHERE r.code IN ('baseAdmissionOfficer','siteAdmin');
