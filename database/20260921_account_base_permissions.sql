CREATE TABLE IF NOT EXISTS wms_account_base_permission(
  account_id BIGINT UNSIGNED NOT NULL,
  base_tag_id BIGINT UNSIGNED NOT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(account_id,base_tag_id),
  KEY idx_account_sort(account_id,sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='仓管账号基地数据权限';

INSERT IGNORE INTO wms_account_base_permission(account_id,base_tag_id,sort_order)
SELECT a.id,t.id,t.id FROM wms_account a JOIN wms_role r ON r.id=a.role_id
CROSS JOIN xm_bulky_user_tag t
WHERE a.status=1 AND r.code IN('siteAdmin','baseAdmissionOfficer') AND t.type=2 AND t.tag_category='基地';
