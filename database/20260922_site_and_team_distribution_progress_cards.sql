-- 数据中心：核心分类全场配货总进度、配货分类团队分区配货进度
UPDATE wms_permission
SET name='分区配货进度',description='按当前账号所属配货团队负责分区统计配货进度'
WHERE code='dataCenter.card.distribution-progress';

SET @data_center = (SELECT id FROM wms_permission WHERE code='dataCenter.view' LIMIT 1);
INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
SELECT COALESCE((SELECT parent_id FROM wms_permission WHERE code='dataCenter.card.distribution-progress' LIMIT 1),@data_center),
       'dataCenter.card.site-distribution-progress','场地配货总进度','data-center',4,
       '全场地配货扎数及整体完成进度，不受分区数据权限限制','','',239,1
WHERE NOT EXISTS(SELECT 1 FROM wms_permission WHERE code='dataCenter.card.site-distribution-progress');

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p ON p.code='dataCenter.card.site-distribution-progress'
WHERE g.code='super_admin_all';

UPDATE wms_role
SET data_cards_json=JSON_ARRAY_APPEND(COALESCE(data_cards_json,JSON_ARRAY()),'$', 'site-distribution-progress')
WHERE code IN ('siteAdmin','superAdmin')
  AND NOT JSON_CONTAINS(COALESCE(data_cards_json,JSON_ARRAY()),JSON_QUOTE('site-distribution-progress'));
