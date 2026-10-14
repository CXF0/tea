INSERT INTO wms_account_source_identity(account_id,source_system,source_user_id)
SELECT id,'bulkyGoods',990000009 FROM wms_account WHERE login_name='demo_siteAdmin'
ON DUPLICATE KEY UPDATE source_user_id=VALUES(source_user_id);

UPDATE xm_bulky_base_config
SET outsource_flag=1,outsource_user_id=990000009,outsource_user_name='陈志强'
WHERE id=14 AND name='红塔基地';
