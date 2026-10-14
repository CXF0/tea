-- 系统账户、角色与权限组管理领域，以及数据中心卡片权限树。
INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status) VALUES
(0,'systemAccount.view','系统账户','system-account',1,'查看本系统登录账户','/features/system-account/pages/home/index','',190,1),
(0,'accessControl.view','角色与权限组','access-control',1,'查看角色与权限组','/features/access-control/pages/home/index','',192,1)
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),route_path=VALUES(route_path),sort_order=VALUES(sort_order),status=1;
SET @account_root=(SELECT id FROM wms_permission WHERE code='systemAccount.view');
SET @access_root=(SELECT id FROM wms_permission WHERE code='accessControl.view');
SET @quality_root=(SELECT id FROM wms_permission WHERE code='quality.flower.view');
INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status) VALUES
(@account_root,'systemAccount.manage','管理系统账户','system-account',2,'新增、编辑、停用及重置登录账户','','',191,1),
(@access_root,'accessControl.manage','管理角色与权限组','access-control',2,'维护角色、权限组及权限关联','','',193,1)
ON DUPLICATE KEY UPDATE parent_id=VALUES(parent_id),name=VALUES(name),description=VALUES(description),status=1;
-- 仅调整权限配置树的展示归属；权限编码及后端所属领域保持不变。
UPDATE wms_permission SET parent_id=@quality_root,name='供应商入场操作' WHERE code='admission.confirm';
UPDATE wms_permission SET parent_id=@quality_root,name='下单补货' WHERE code='restock.submit';

INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
VALUES(0,'dataCenter.view','数据中心','data-center',1,'数据中心分类与卡片权限','','',200,1)
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),status=1;
SET @dc=(SELECT id FROM wms_permission WHERE code='dataCenter.view');
INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status) VALUES
(@dc,'dataCenter.category.core','核心','data-center',3,'核心分类','','',201,1),
(@dc,'dataCenter.category.quality','质检','data-center',3,'质检分类','','',202,1),
(@dc,'dataCenter.category.distribution','配货','data-center',3,'配货分类','','',203,1),
(@dc,'dataCenter.category.arrival','到场货','data-center',3,'到场货分类','','',204,1),
(@dc,'dataCenter.category.centralProcurement','集采','data-center',3,'集采分类','','',205,1),
(@dc,'dataCenter.category.packing','打包','data-center',3,'打包分类','','',206,1),
(@dc,'dataCenter.category.logistics','物流','data-center',3,'物流分类','','',207,1),
(@dc,'dataCenter.category.supplier','供应商','data-center',3,'供应商分类','','',208,1),
(@dc,'dataCenter.category.agri','农资','data-center',3,'农资分类','','',209,1)
ON DUPLICATE KEY UPDATE parent_id=VALUES(parent_id),name=VALUES(name),sort_order=VALUES(sort_order),status=1;
SET @core=(SELECT id FROM wms_permission WHERE code='dataCenter.category.core');
SET @quality=(SELECT id FROM wms_permission WHERE code='dataCenter.category.quality');
SET @distribution=(SELECT id FROM wms_permission WHERE code='dataCenter.category.distribution');
SET @arrival=(SELECT id FROM wms_permission WHERE code='dataCenter.category.arrival');
INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status) VALUES
(@core,'dataCenter.card.session-size-statistics','场次大小件统计','data-center',4,'当前场次大小件数量','','',220,1),
(@core,'dataCenter.card.quality-overview','质检完成情况','data-center',4,'当前场次质检完成情况','','',221,1),
(@core,'dataCenter.card.inventory-progress','入库完成进度','data-center',4,'当前库存入库进度','','',222,1),
(@quality,'dataCenter.card.quality-supplier-admission','供应商入场','data-center',4,'应入场、已入场和未入场','','',230,1),
(@quality,'dataCenter.card.quality-business-statistics','质检统计','data-center',4,'质检业务处理统计','','',231,1),
(@quality,'dataCenter.card.quality-task','质检任务','data-center',4,'质检任务概览','','',232,1),
(@quality,'dataCenter.card.quality-result','质检结果','data-center',4,'质检结果统计','','',233,1),
(@quality,'dataCenter.card.quality-issues','待处理问题','data-center',4,'待处理质检问题','','',234,1),
(@quality,'dataCenter.card.quality-trend','质检趋势','data-center',4,'质检趋势','','',235,1),
(@quality,'dataCenter.card.quality-staff','当前在岗质检人员','data-center',4,'在岗质检人数','','',236,1),
(@distribution,'dataCenter.card.distribution-progress','配货进度','data-center',4,'整体配货完成进度','','',240,1),
(@distribution,'dataCenter.card.agency-distribution','代配货统计','data-center',4,'代配供应商和货量','','',241,1),
(@distribution,'dataCenter.card.contractor-distribution','配货统计（外包负责人）','data-center',4,'外包负责人配货统计','','',242,1),
(@distribution,'dataCenter.card.shelf-progress','货架进度','data-center',4,'已完成配货货架数','','',243,1),
(@distribution,'dataCenter.card.restock-units','待补货量','data-center',4,'当前待补货数量','','',244,1),
(@arrival,'dataCenter.card.arrival-volume','到场货统计','data-center',4,'销售、收花与晚场构成','','',250,1),
(@arrival,'dataCenter.card.self-pickup','自提统计','data-center',4,'自提货量和人数','','',251,1),
(@arrival,'dataCenter.card.arrival-late','迟到供应商','data-center',4,'迟到供应商记录','','',252,1),
(@arrival,'dataCenter.card.arrival-priority','优先质检','data-center',4,'优先质检供应商','','',253,1)
ON DUPLICATE KEY UPDATE parent_id=VALUES(parent_id),name=VALUES(name),description=VALUES(description),sort_order=VALUES(sort_order),status=1;

INSERT INTO wms_permission_group(code,name,description,status) VALUES
('system_account_admin','系统账户管理员','管理本系统登录账户',1),
('access_control_admin','角色权限管理员','管理角色、权限组及权限关联',1)
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),status=1;
INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p
WHERE (g.code='system_account_admin' AND p.code IN ('systemAccount.view','systemAccount.manage'))
   OR (g.code='access_control_admin' AND p.code IN ('accessControl.view','accessControl.manage'));
INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g
WHERE r.code='siteAdmin' AND g.code IN ('system_account_admin','access_control_admin');
