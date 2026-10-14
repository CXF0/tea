UPDATE wms_permission SET name='纸箱管理',domain_code='cartonInventory',description='查看纸箱进销存',route_path='/features/carton-inventory/pages/home/index',icon='/static/icons/wms/fwms-inventory-outline.svg' WHERE code='inventory.view';
UPDATE wms_permission SET domain_code='cartonInventory',name='纸箱入库' WHERE code='inventory.inbound';
UPDATE wms_permission SET domain_code='cartonInventory',name='纸箱出库' WHERE code='inventory.outbound';
UPDATE wms_permission SET domain_code='cartonInventory',name='纸箱进销存管理' WHERE code='inventory.manage';

INSERT INTO wms_sku_inventory(part,category,sku_type,sku_name,specification,brand,entry_stock,unit,status_bind,operator_id,operator_name,last_operator_id,last_operator_name,status)
VALUES
('库房',1,1,'打包箱子','110*50*60','','480','个',1,9,'陈志强',9,'陈志强',0),
('库房',1,1,'打包箱子','110*50*50','','1070','个',1,9,'陈志强',9,'陈志强',0),
('库房',1,1,'打包箱子','110*45*45箱','','640','个',1,9,'陈志强',9,'陈志强',0),
('库房',1,1,'打包箱子','天地盖大号（45*38）','','1708','个',1,9,'陈志强',9,'陈志强',0),
('库房',1,1,'打包箱子','天地盖（40*30）','','1314','个',1,9,'陈志强',9,'陈志强',0),
('库房',1,1,'打包箱子','天地盖大号（40*25）','','1659','个',1,9,'陈志强',9,'陈志强',0),
('库房',1,1,'打包箱子','天地盖小号（40*20）','','1132','个',1,9,'陈志强',9,'陈志强',0),
('库房',1,1,'打包箱子','小件（90*25）','','0','个',1,9,'陈志强',9,'陈志强',0)
ON DUPLICATE KEY UPDATE sku_name=VALUES(sku_name);

DELETE duplicate_row
FROM wms_sku_inventory duplicate_row
JOIN wms_sku_inventory retained_row
  ON retained_row.part=duplicate_row.part
 AND retained_row.category=duplicate_row.category
 AND retained_row.specification=duplicate_row.specification
 AND retained_row.id<duplicate_row.id
WHERE duplicate_row.category=1
  AND duplicate_row.part='库房'
  AND duplicate_row.specification IN ('110*50*60','110*50*50','110*45*45箱','天地盖大号（45*38）','天地盖（40*30）','天地盖大号（40*25）','天地盖小号（40*20）','小件（90*25）');

INSERT INTO wms_material_apply(apply_no,team_id,team_name,sku_id,sku_name,specification,unit_name,apply_quantity,issued_quantity,status,applicant_id,applicant_name,auditor_id,auditor_name,audit_time,create_time)
SELECT CONCAT('SL20260921',LPAD(s.id,3,'0')),107,'寻梦22-23区打包团队',s.id,s.sku_name,s.specification,s.unit,44,44,20,13,'袁高',9,'李江涛','2026-09-21 03:55:21','2026-09-21 03:49:38' FROM wms_sku_inventory s WHERE s.specification='天地盖（40*30）' AND NOT EXISTS(SELECT 1 FROM wms_material_apply WHERE apply_no=CONCAT('SL20260921',LPAD(s.id,3,'0')));
INSERT INTO wms_material_apply(apply_no,team_id,team_name,sku_id,sku_name,specification,unit_name,apply_quantity,status,applicant_id,applicant_name,create_time)
SELECT CONCAT('SL20260922',LPAD(s.id,3,'0')),108,'寻梦7-11区打包组',s.id,s.sku_name,s.specification,s.unit,80,10,13,'王明','2026-09-21 08:20:00' FROM wms_sku_inventory s WHERE s.specification='天地盖大号（45*38）' AND NOT EXISTS(SELECT 1 FROM wms_material_apply WHERE apply_no=CONCAT('SL20260922',LPAD(s.id,3,'0')));
