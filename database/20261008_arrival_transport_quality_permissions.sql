START TRANSACTION;

SET @admission := (SELECT id FROM wms_permission WHERE code='admission.view' LIMIT 1);
SET @quality := (SELECT id FROM wms_permission WHERE code='quality.flower.view' LIMIT 1);
SET @transport := (SELECT id FROM wms_permission WHERE code='transport.view' LIMIT 1);

INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status) VALUES
(COALESCE(@admission,0),'arrivalGoods.view','到场货管理','arrival-goods',1,'查看到场货收购、库存、出库、自提和无标签花材','/features/arrival-goods/pages/home/index','fwms-warehouse-outline',33,1),
(COALESCE(@admission,0),'arrivalGoods.outbound','到场货出库','arrival-goods',2,'维护到场货商品出库业务动作','','',34,1),
(COALESCE(@quality,0),'quality.baseStatistics.view','基地质检统计','quality-base-statistics',1,'查看基地维度降级、退货、换货及问题数量统计','/features/quality/pages/base-statistics/index','fwms-inspection-outline',35,1),
(COALESCE(@quality,0),'quality.exchange.view','换货记录','quality-base-statistics',2,'查看质检换货记录和电话通知状态','','',36,1),
(COALESCE(@transport,0),'transport.baseFlower.view','基地花材明细','transport',1,'查看司机组长和司机责任基地的花材明细、货量和盘点数据','/features/transport/pages/base-flowers/index','fwms-truck-outline',37,1)
ON DUPLICATE KEY UPDATE
  parent_id=VALUES(parent_id),
  name=VALUES(name),
  domain_code=VALUES(domain_code),
  permission_type=VALUES(permission_type),
  description=VALUES(description),
  route_path=VALUES(route_path),
  icon=VALUES(icon),
  sort_order=VALUES(sort_order),
  status=1;

INSERT INTO wms_permission_group(code,name,description,status) VALUES
('arrival_goods_operator','到场货管理','查看到场货收购、库存、出库、自提和无标签花材',1),
('quality_base_statistics_viewer','基地质检统计','查看基地问题统计、换货记录和电话通知状态',1),
('transport_base_flower_viewer','基地花材明细','查看责任基地花材明细、货量和盘点数据',1)
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),status=1;

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id
FROM wms_permission_group g
JOIN wms_permission p ON p.code IN('arrivalGoods.view','arrivalGoods.outbound')
WHERE g.code='arrival_goods_operator';

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id
FROM wms_permission_group g
JOIN wms_permission p ON p.code IN('quality.baseStatistics.view','quality.exchange.view')
WHERE g.code='quality_base_statistics_viewer';

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id
FROM wms_permission_group g
JOIN wms_permission p ON p.code='transport.baseFlower.view'
WHERE g.code='transport_base_flower_viewer';

INSERT INTO wms_role(code,name,description,workbench_cards_json,todo_ids_json,scan_operations_json,data_cards_json,status) VALUES
('arrivalGoodsManager','到场货管理员','负责到场货收购、库存列表、商品出库、场地自提和无标签花材管理','[]','[]','[]','[]',1),
('driverLeader','司机组长','围绕车辆管理和派车任务进行调度，并查看责任基地花材明细','[]','[]','[]','[]',1)
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),status=1;

INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g ON g.code='arrival_goods_operator'
WHERE r.code IN('superAdmin','siteAdmin','arrivalGoodsManager');

INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g ON g.code='quality_base_statistics_viewer'
WHERE r.code IN('superAdmin','siteAdmin','qualityLeader','qualityInspector');

INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g ON g.code='transport_base_flower_viewer'
WHERE r.code IN('superAdmin','siteAdmin','driverLeader','driver');

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id
FROM wms_permission_group g
JOIN wms_permission p ON p.code IN('arrivalGoods.view','arrivalGoods.outbound','quality.baseStatistics.view','quality.exchange.view','transport.baseFlower.view')
WHERE g.code='super_admin_all';

COMMIT;
