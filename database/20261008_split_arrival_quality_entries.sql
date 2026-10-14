START TRANSACTION;

SET @arrival_parent := (SELECT id FROM wms_permission WHERE code='arrivalGoods.view' LIMIT 1);
SET @quality_parent := (SELECT id FROM wms_permission WHERE code='quality.baseStatistics.view' LIMIT 1);
SET @transport_parent := (SELECT id FROM wms_permission WHERE code='transport.view' LIMIT 1);

INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status) VALUES
(COALESCE(@arrival_parent,0),'arrivalGoods.purchase.view','收购管理','arrival-goods',1,'查看到场货收购/到场记录','/features/arrival-goods/pages/purchase/index','fwms-warehouse-outline',33,1),
(COALESCE(@arrival_parent,0),'arrivalGoods.stock.view','库存列表','arrival-goods',1,'查看到场货可用库存列表','/features/arrival-goods/pages/stock/index','fwms-inventory-outline',34,1),
(COALESCE(@arrival_parent,0),'arrivalGoods.outbound.view','商品出库','arrival-goods',1,'查看到场货商品出库记录','/features/arrival-goods/pages/outbound/index','fwms-outbound-outline',35,1),
(COALESCE(@arrival_parent,0),'arrivalGoods.selfPickup.view','场地自提','arrival-goods',1,'查看到场货场地自提记录','/features/arrival-goods/pages/self-pickup/index','fwms-checkin-outline',36,1),
(COALESCE(@arrival_parent,0),'arrivalGoods.unlabeled.view','无标签花材','arrival-goods',1,'查看无标签花材记录','/features/arrival-goods/pages/unlabeled/index','fwms-warehouse-outline',37,1),
(COALESCE(@quality_parent,0),'quality.exchange.view','换货记录','quality-exchange',1,'查看质检换货记录和电话通知状态','/features/quality/pages/exchange-records/index','fwms-task-outline',38,1),
(COALESCE(@transport_parent,0),'transport.baseFlower.view','基地花材明细','transport',1,'查看司机组长和司机责任基地的花材明细、货量和盘点数据','/features/transport/pages/base-flowers/index','fwms-truck-outline',39,1)
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

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id
FROM wms_permission_group g
JOIN wms_permission p ON p.code IN(
  'arrivalGoods.purchase.view',
  'arrivalGoods.stock.view',
  'arrivalGoods.outbound.view',
  'arrivalGoods.selfPickup.view',
  'arrivalGoods.unlabeled.view'
)
WHERE g.code IN('arrival_goods_operator','super_admin_all');

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id
FROM wms_permission_group g
JOIN wms_permission p ON p.code IN('quality.baseStatistics.view','quality.exchange.view')
WHERE g.code IN('quality_base_statistics_viewer','super_admin_all');

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id
FROM wms_permission_group g
JOIN wms_permission p ON p.code='transport.baseFlower.view'
WHERE g.code IN('transport_base_flower_viewer','super_admin_all');

COMMIT;
