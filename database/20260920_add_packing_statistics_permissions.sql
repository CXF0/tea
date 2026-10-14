SET @packing_parent=(SELECT id FROM wms_permission WHERE code='packing.view' LIMIT 1);

INSERT INTO wms_permission (parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
VALUES
(@packing_parent,'packing.statistics.packaging','打包包装统计','packing',2,'查看包装箱型使用数量','','',320,1),
(@packing_parent,'packing.statistics.zoneWeight','分区重量统计','packing',2,'查看分区货架数量与重量','','',321,1),
(@packing_parent,'packing.statistics.income','打包收益统计','packing',2,'查看打包人员收益明细','','',322,1),
(@packing_parent,'packing.statistics.cotton','保温棉统计','packing',2,'查看货架保温棉数量','','',323,1)
ON DUPLICATE KEY UPDATE name=VALUES(name),parent_id=VALUES(parent_id),permission_type=VALUES(permission_type),description=VALUES(description),sort_order=VALUES(sort_order),status=1;

INSERT IGNORE INTO wms_permission_group_item (group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g CROSS JOIN wms_permission p
WHERE g.code='packing_operator' AND p.code IN ('packing.statistics.packaging','packing.statistics.zoneWeight','packing.statistics.income','packing.statistics.cotton');
