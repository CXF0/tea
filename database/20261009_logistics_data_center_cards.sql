SET @logistics_category = (SELECT id FROM wms_permission WHERE code='dataCenter.category.logistics');

INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status) VALUES
(@logistics_category,'dataCenter.card.logistics-outbound-collection','出库与揽收','data-center',4,'当前场次物流包裹打包、出库和揽收汇总','','',260,1),
(@logistics_category,'dataCenter.card.logistics-collection-progress','物流揽收进度','data-center',4,'按物流班次展示当前场次包裹揽收完成进度','','',261,1)
ON DUPLICATE KEY UPDATE parent_id=VALUES(parent_id),name=VALUES(name),description=VALUES(description),sort_order=VALUES(sort_order),status=1;

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id
FROM wms_permission_group g
JOIN wms_permission p ON p.code IN (
  'dataCenter.card.logistics-outbound-collection',
  'dataCenter.card.logistics-collection-progress'
)
WHERE g.code IN ('logistics_operator','logistics_management','super_admin_all');

UPDATE wms_role
SET data_cards_json = JSON_ARRAY_APPEND(COALESCE(NULLIF(data_cards_json, ''), JSON_ARRAY()), '$', 'logistics-outbound-collection')
WHERE code IN ('superAdmin','siteAdmin','logisticsSpecialist')
  AND status=1
  AND NOT JSON_CONTAINS(COALESCE(NULLIF(data_cards_json, ''), JSON_ARRAY()), JSON_QUOTE('logistics-outbound-collection'));

UPDATE wms_role
SET data_cards_json = JSON_ARRAY_APPEND(COALESCE(NULLIF(data_cards_json, ''), JSON_ARRAY()), '$', 'logistics-collection-progress')
WHERE code IN ('superAdmin','siteAdmin','logisticsSpecialist')
  AND status=1
  AND NOT JSON_CONTAINS(COALESCE(NULLIF(data_cards_json, ''), JSON_ARRAY()), JSON_QUOTE('logistics-collection-progress'));
