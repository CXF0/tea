UPDATE wms_role
SET data_cards_json = JSON_ARRAY_APPEND(
  JSON_ARRAY_APPEND(COALESCE(data_cards_json, JSON_ARRAY()), '$', 'quality-supplier-admission'),
  '$', 'quality-business-statistics'
)
WHERE code = 'siteAdmin'
  AND status = 1
  AND NOT JSON_CONTAINS(COALESCE(data_cards_json, JSON_ARRAY()), JSON_QUOTE('quality-supplier-admission'))
  AND NOT JSON_CONTAINS(COALESCE(data_cards_json, JSON_ARRAY()), JSON_QUOTE('quality-business-statistics'));

UPDATE wms_role
SET data_cards_json = JSON_ARRAY_APPEND(COALESCE(data_cards_json, JSON_ARRAY()), '$', 'quality-supplier-admission')
WHERE code = 'siteAdmin' AND status = 1
  AND NOT JSON_CONTAINS(COALESCE(data_cards_json, JSON_ARRAY()), JSON_QUOTE('quality-supplier-admission'));

UPDATE wms_role
SET data_cards_json = JSON_ARRAY_APPEND(COALESCE(data_cards_json, JSON_ARRAY()), '$', 'quality-business-statistics')
WHERE code = 'siteAdmin' AND status = 1
  AND NOT JSON_CONTAINS(COALESCE(data_cards_json, JSON_ARRAY()), JSON_QUOTE('quality-business-statistics'));
