-- 数据中心核心分类：场次大小件统计卡片。
-- 卡片读取打包包裹的场次重量，仅为场地管理员默认启用。
UPDATE wms_role
SET data_cards_json = JSON_ARRAY_APPEND(
  COALESCE(NULLIF(data_cards_json, ''), JSON_ARRAY()),
  '$',
  'session-size-statistics'
)
WHERE code = 'siteAdmin'
  AND NOT JSON_CONTAINS(
    COALESCE(NULLIF(data_cards_json, ''), JSON_ARRAY()),
    JSON_QUOTE('session-size-statistics')
  );
