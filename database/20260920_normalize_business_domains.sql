CREATE TABLE IF NOT EXISTS wms_business_domain (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  code VARCHAR(32) NOT NULL,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(255) NOT NULL DEFAULT '',
  view_permission_code VARCHAR(64) NOT NULL DEFAULT '',
  icon VARCHAR(255) NOT NULL DEFAULT '',
  entry_path VARCHAR(255) NOT NULL DEFAULT '',
  sort_order INT NOT NULL DEFAULT 0,
  status TINYINT NOT NULL DEFAULT 1,
  create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY(id), UNIQUE KEY uk_business_domain_code(code), KEY idx_domain_view_permission(view_permission_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='仓管端业务领域定义';

INSERT INTO wms_business_domain(code,name,description,view_permission_code,icon,entry_path,sort_order) VALUES
('admission','入场管理','基地入场、签到与到场状态','admission.view','fwms-checkin-outline','/features/admission/pages/home/index',10),
('collection','集货','集货任务、数量确认与异常','collection.view','fwms-collection-outline','',20),
('transport','运输','车辆、司机、线路与在途状态','transport.view','fwms-truck-outline','',30),
('quality','花材质检','供应商花材逐扎质检','quality.flower.view','fwms-inspection-outline','/features/quality/pages/suppliers/index',40),
('qualityTask','质检任务','派发任务、自行检查与好花视频','quality.task.view','fwms-task-outline','/features/quality/pages/tasks/index',50),
('distribution','配货作业','分区配货、货架操作与换货','distribution.view','fwms-picking-outline','/features/distribution/pages/home/index',60),
('restock','补货管理','补货需求、提交与历史','restock.view','fwms-replenishment-outline','/features/restock/pages/home/index',70),
('packing','打包','打包任务、复核与包材','packing.view','fwms-packing-outline','',80),
('inventory','库存','入库、出库、库存与物资','inventory.view','fwms-warehouse-outline','/pages/home/index',90),
('coldStorage','冷库暂存','冷库暂存、出库与库存','coldStorage.view','fwms-cold-storage-outline','/features/cold-storage/pages/home/index',100),
('logistics','物流发货','揽收、拍照、分配与发货','logistics.view','fwms-outbound-outline','',110),
('consignment','代卖','收购、定级、上架与订单','','fwms-flower-bunch-outline','',120),
('agriMaterial','农资','农资商品、订单与供应商','','fwms-parcel-outline','',130),
('management','管理','人员、权限、统计与日志','staff.manage','fwms-account-outline','/features/management/pages/staff/index',140)
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),view_permission_code=VALUES(view_permission_code),icon=VALUES(icon),entry_path=VALUES(entry_path),sort_order=VALUES(sort_order),status=1;
