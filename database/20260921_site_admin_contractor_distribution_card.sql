UPDATE wms_role SET data_cards_json=JSON_ARRAY_APPEND(COALESCE(data_cards_json,JSON_ARRAY()),'$','contractor-distribution')
WHERE code='siteAdmin' AND status=1 AND NOT JSON_CONTAINS(COALESCE(data_cards_json,JSON_ARRAY()),JSON_QUOTE('contractor-distribution'));
