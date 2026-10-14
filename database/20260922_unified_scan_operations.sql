-- 统一扫码作业配置。扫码入口只决定可用作业，不替代领域能力校验。
UPDATE wms_role SET scan_operations_json = JSON_ARRAY(
  'admission-checkin','quality-inspection','quality-video','distribution-shelf',
  'packing-shelf','logistics-shelf','cold-storage-bare','base-return-confirm'
) WHERE code IN ('superAdmin','siteAdmin');

UPDATE wms_role SET scan_operations_json = JSON_ARRAY(
  'admission-checkin','quality-inspection','quality-video','base-return-confirm'
) WHERE code = 'qualityInspector';

UPDATE wms_role SET scan_operations_json = JSON_ARRAY(
  'quality-inspection','quality-video','base-return-confirm'
) WHERE code = 'qualityLeader';

UPDATE wms_role SET scan_operations_json = JSON_ARRAY('distribution-shelf')
WHERE code IN ('picker','partTimePicker');

UPDATE wms_role SET scan_operations_json = JSON_ARRAY('packing-shelf')
WHERE code = 'packer';

UPDATE wms_role SET scan_operations_json = JSON_ARRAY('logistics-shelf')
WHERE code = 'logisticsSpecialist';

UPDATE wms_role SET scan_operations_json = JSON_ARRAY('cold-storage-bare')
WHERE code = 'warehouseManager';
