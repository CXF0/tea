INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
SELECT 0,'baseStocktaking.view','基地盘点','base-stocktaking',1,'按基地和场次查看供应商花材盘点数据','/features/base-stocktaking/pages/home/index','fwms-stocktake-outline',16,1
WHERE NOT EXISTS(SELECT 1 FROM wms_permission WHERE code='baseStocktaking.view');

UPDATE wms_permission SET icon='fwms-stocktake-outline',permission_type=1
WHERE code='baseStocktaking.view';

INSERT INTO wms_permission_group(code,name,description,status)
SELECT 'base_stocktaking_viewer','基地盘点','查看基地供应商盘点汇总及花材盘点详情',1
WHERE NOT EXISTS(SELECT 1 FROM wms_permission_group WHERE code='base_stocktaking_viewer');

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p ON p.code='baseStocktaking.view' WHERE g.code='base_stocktaking_viewer';

INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g ON g.code='base_stocktaking_viewer'
WHERE r.code IN ('baseAdmissionOfficer','siteAdmin');
