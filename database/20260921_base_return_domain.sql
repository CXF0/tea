-- 基地退货（二次确认）独立领域：从花材质检权限组拆出。
INSERT INTO wms_permission
  (parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
VALUES
  (0,'baseReturn.view','基地退货','base-return',1,'查看基地退货二次确认列表','/features/base-return/pages/home/index','fwms-return-outline',18,1)
ON DUPLICATE KEY UPDATE
  name=VALUES(name),domain_code=VALUES(domain_code),permission_type=VALUES(permission_type),
  description=VALUES(description),route_path=VALUES(route_path),icon=VALUES(icon),sort_order=VALUES(sort_order),status=1;

INSERT INTO wms_permission
  (parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
SELECT id,'baseReturn.confirm','扫码确认基地退货','base-return',2,'扫描花材标签并完成退货二次确认','','',10,1
FROM wms_permission WHERE code='baseReturn.view'
ON DUPLICATE KEY UPDATE
  parent_id=VALUES(parent_id),name=VALUES(name),domain_code=VALUES(domain_code),permission_type=VALUES(permission_type),
  description=VALUES(description),status=1;

INSERT INTO wms_permission_group(code,name,description,status)
VALUES ('base_return_operator','基地退货确认作业','查看基地退货并进行扫码二次确认',1)
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),status=1;

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p
  ON p.code IN ('baseReturn.view','baseReturn.confirm')
WHERE g.code='base_return_operator';

INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g
WHERE r.code IN ('qualityInspector','qualityLeader','siteAdmin') AND g.code='base_return_operator';

DELETE item FROM wms_permission_group_item item
JOIN wms_permission_group permission_group ON permission_group.id=item.group_id
JOIN wms_permission permission ON permission.id=item.permission_id
WHERE permission_group.code='quality_operator' AND permission.code='quality.returnConfirm';

UPDATE wms_permission SET status=0 WHERE code='quality.returnConfirm';
