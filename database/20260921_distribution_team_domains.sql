INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
VALUES
(0,'teamAccount.view','团队账号','teamAccount',1,'查看本人负责的外包配货团队账号','/features/distribution-team/pages/accounts/index','/static/icons/wms/fwms-team-account-outline.svg',180,1),
(0,'teamAccount.manage','团队账号管理','teamAccount',2,'绑定、创建、编辑、重置及启停本人团队账号','', '',181,1),
(0,'teamDistribution.view','团队配货明细','teamDistribution',1,'查看本人负责团队的配货明细','/features/distribution-team/pages/statistics/index','/static/icons/wms/fwms-team-picking-outline.svg',182,1)
ON DUPLICATE KEY UPDATE name=VALUES(name),domain_code=VALUES(domain_code),permission_type=VALUES(permission_type),description=VALUES(description),route_path=VALUES(route_path),icon=VALUES(icon),sort_order=VALUES(sort_order),status=1;

INSERT INTO wms_permission_group(code,name,description,status)
VALUES
('team_account_manager','团队账号管理组','团队账号入口及账号管理能力',1),
('team_distribution_viewer','团队配货明细查看组','团队配货明细入口及本人团队数据查看能力',1)
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),status=1;

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p
WHERE (g.code='team_account_manager' AND p.code IN ('teamAccount.view','teamAccount.manage'))
   OR (g.code='team_distribution_viewer' AND p.code='teamDistribution.view');

INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g
WHERE r.code='siteAdmin' AND g.code IN ('team_account_manager','team_distribution_viewer');
