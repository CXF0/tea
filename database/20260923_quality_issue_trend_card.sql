UPDATE wms_permission
   SET name='花材问题趋势',
       description='按问题类型展示最近 7 个真实场次的花材问题数量',
       status=1
 WHERE code='dataCenter.card.quality-trend';

UPDATE wms_role
   SET data_cards_json=JSON_ARRAY_APPEND(COALESCE(data_cards_json,JSON_ARRAY()),'$','quality-trend')
 WHERE code IN ('superAdmin','siteAdmin')
   AND NOT JSON_CONTAINS(COALESCE(data_cards_json,JSON_ARRAY()),JSON_QUOTE('quality-trend'));
