-- 数据中心核心分类：场地货位统计卡片。
SET @data_center = (SELECT id FROM wms_permission WHERE code = 'dataCenter.view' LIMIT 1);

INSERT INTO wms_permission(parent_id, code, name, domain_code, permission_type, description, route_path, icon, sort_order, status)
SELECT @data_center, 'dataCenter.card.site-location-statistics', '场地货位统计', 'data-center', 4,
       '按件型和启用状态统计场地货位，并查看分区分段货位区间', '/pages/data-center/site-locations', '', 241, 1
WHERE NOT EXISTS (SELECT 1 FROM wms_permission WHERE code = 'dataCenter.card.site-location-statistics');

INSERT IGNORE INTO wms_permission_group_item(group_id, permission_id)
SELECT g.id, p.id
FROM wms_permission_group g
JOIN wms_permission p ON p.code = 'dataCenter.card.site-location-statistics'
WHERE g.code = 'super_admin_all';

UPDATE wms_role
SET data_cards_json = JSON_ARRAY_APPEND(COALESCE(NULLIF(data_cards_json, ''), JSON_ARRAY()), '$', 'site-location-statistics')
WHERE code IN ('siteAdmin', 'superAdmin')
  AND NOT JSON_CONTAINS(COALESCE(NULLIF(data_cards_json, ''), JSON_ARRAY()), JSON_QUOTE('site-location-statistics'));
