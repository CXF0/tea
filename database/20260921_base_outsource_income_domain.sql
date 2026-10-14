CREATE TABLE IF NOT EXISTS wms_account_source_identity(
  account_id BIGINT UNSIGNED NOT NULL,
  source_system VARCHAR(32) NOT NULL,
  source_user_id BIGINT NOT NULL,
  create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(account_id,source_system),
  UNIQUE KEY uk_source_identity(source_system,source_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='仓管账号与来源系统用户身份映射';

INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
SELECT parent_permission.id,'baseOutsourceIncome.view','基地包干收益','base-outsource-income',1,'查看当前账号承包基地的包干收益','/features/base-outsource-income/pages/home/index','fwms-warehouse-outline',17,1
FROM wms_permission parent_permission
WHERE parent_permission.code='baseManagement.view' AND NOT EXISTS(SELECT 1 FROM wms_permission WHERE code='baseOutsourceIncome.view');

UPDATE wms_permission child_permission JOIN wms_permission parent_permission ON parent_permission.code='baseManagement.view'
SET child_permission.parent_id=parent_permission.id,child_permission.permission_type=1
WHERE child_permission.code='baseOutsourceIncome.view';

INSERT INTO wms_permission_group(code,name,description,status)
SELECT 'base_outsource_income_viewer','基地包干收益','查看账号本人承包基地的月度包干收益',1
WHERE NOT EXISTS(SELECT 1 FROM wms_permission_group WHERE code='base_outsource_income_viewer');

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p ON p.code='baseOutsourceIncome.view' WHERE g.code='base_outsource_income_viewer';

INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g ON g.code='base_outsource_income_viewer' WHERE r.code='siteAdmin';
