UPDATE wms_role
SET data_cards_json='["admission-overview","quality-overview","quality-result","inventory-overview","inventory-progress","distribution-progress","agency-distribution","arrival-volume","self-pickup"]'
WHERE code='siteAdmin' AND status=1;
