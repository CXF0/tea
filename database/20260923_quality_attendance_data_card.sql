-- 数据中心：将原“当前在岗质检人员”卡片改为质检假勤模块统计。
UPDATE wms_permission
   SET name = '质检假勤统计',
       description = '来自质检假勤模块的人员、出勤和休息数量',
       status = 1
 WHERE code = 'dataCenter.card.quality-staff';

UPDATE wms_role
   SET data_cards_json = JSON_ARRAY_APPEND(COALESCE(data_cards_json, JSON_ARRAY()), '$', 'quality-staff')
 WHERE code IN ('superAdmin', 'siteAdmin')
   AND NOT JSON_CONTAINS(COALESCE(data_cards_json, JSON_ARRAY()), JSON_QUOTE('quality-staff'));
