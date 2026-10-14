CREATE TABLE IF NOT EXISTS wms_permission (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, code VARCHAR(64) NOT NULL, name VARCHAR(50) NOT NULL,
  domain_code VARCHAR(32) NOT NULL, description VARCHAR(255) NOT NULL DEFAULT '', status TINYINT NOT NULL DEFAULT 1,
  create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY(id), UNIQUE KEY uk_permission_code(code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='仓管端能力权限';
CREATE TABLE IF NOT EXISTS wms_permission_group (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, code VARCHAR(50) NOT NULL, name VARCHAR(50) NOT NULL,
  description VARCHAR(255) NOT NULL DEFAULT '', status TINYINT NOT NULL DEFAULT 1, create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id), UNIQUE KEY uk_group_code(code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='仓管端权限组';
CREATE TABLE IF NOT EXISTS wms_permission_group_item (
  group_id BIGINT UNSIGNED NOT NULL, permission_id BIGINT UNSIGNED NOT NULL, PRIMARY KEY(group_id,permission_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限组权限关系';
CREATE TABLE IF NOT EXISTS wms_role (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, code VARCHAR(50) NOT NULL, name VARCHAR(50) NOT NULL,
  description VARCHAR(255) NOT NULL DEFAULT '', status TINYINT NOT NULL DEFAULT 1,
  workbench_cards_json VARCHAR(1000) NOT NULL DEFAULT '[]',
  todo_ids_json VARCHAR(1000) NOT NULL DEFAULT '[]', scan_operations_json VARCHAR(1000) NOT NULL DEFAULT '[]', data_cards_json VARCHAR(1000) NOT NULL DEFAULT '[]',
  create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY(id), UNIQUE KEY uk_role_code(code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='仓管端角色';
CREATE TABLE IF NOT EXISTS wms_role_permission_group (
  role_id BIGINT UNSIGNED NOT NULL, group_id BIGINT UNSIGNED NOT NULL, PRIMARY KEY(role_id,group_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色权限组关系';
CREATE TABLE IF NOT EXISTS wms_account (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, login_name VARCHAR(50) NOT NULL, phone VARCHAR(20) NOT NULL DEFAULT '',
  display_name VARCHAR(50) NOT NULL, password_salt VARCHAR(32) NOT NULL, password_hash CHAR(64) NOT NULL,
  role_id BIGINT UNSIGNED NOT NULL, warehouse_id BIGINT UNSIGNED NOT NULL DEFAULT 1, warehouse_name VARCHAR(100) NOT NULL DEFAULT '梦花仓管',
  status TINYINT NOT NULL DEFAULT 1, last_login_time DATETIME NULL, create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY(id), UNIQUE KEY uk_account_login(login_name), UNIQUE KEY uk_account_phone(phone), KEY idx_account_role(role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='仓管端账户（一个账户一个角色）';

INSERT INTO wms_permission(code,name,domain_code) VALUES
('quality.view','查看质检','quality'),('quality.scan','扫码质检','quality'),('quality.submit','提交质检','quality'),('quality.itemControl','质检业务标记','quality'),('quality.returnConfirm','退货确认','quality'),('quality.statistics','质检统计','quality'),
('admission.view','查看入场','admission'),('admission.confirm','确认入场','admission'),('admission.scan','扫码入场','admission'),('admission.history','入场历史','admission'),('admission.statistics','入场统计','admission'),('admission.exception','入场异常','admission'),
('distribution.view','查看配货','distribution'),('distribution.operate','执行配货','distribution'),('restock.view','查看补货','restock'),('restock.submit','提交补货','restock'),
('inventory.view','查看库存','inventory'),('inventory.inbound','库存入库','inventory'),('inventory.outbound','库存出库','inventory'),('nfc.use','使用NFC','inventory'),('staff.manage','人员权限管理','management')
ON DUPLICATE KEY UPDATE name=VALUES(name),domain_code=VALUES(domain_code);
INSERT INTO wms_permission_group(code,name,description) VALUES
('quality_operator','花材质检作业','质检查看、扫码、标记与提交'),('quality_management','质检管理','质检统计与人员管理'),('admission_operator','入场作业','供应商及基地入场能力'),('distribution_operator','配货作业','配货查看与操作'),('restock_operator','补货作业','补货查看与提交'),('inventory_operator','库存作业','库存入出库与NFC')
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description);
INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p ON
(g.code='quality_operator' AND p.code IN ('quality.view','quality.scan','quality.submit','quality.itemControl','quality.returnConfirm')) OR
(g.code='quality_management' AND p.code IN ('quality.statistics','staff.manage')) OR
(g.code='admission_operator' AND p.domain_code='admission') OR
(g.code='distribution_operator' AND p.domain_code='distribution') OR
(g.code='restock_operator' AND p.domain_code='restock') OR
(g.code='inventory_operator' AND p.domain_code='inventory');
INSERT INTO wms_role(code,name,description,workbench_cards_json,todo_ids_json,scan_operations_json,data_cards_json) VALUES
('qualityInspector','质检员','执行花材质检及关联作业','["quality-session"]','["quality-pending"]','["admission-checkin","quality-inspection"]','["quality-overview","quality-result"]'),
('qualityLeader','质检负责人','质检作业、统计及人员管理','["quality-session"]','["quality-pending"]','["quality-inspection"]','["quality-overview","quality-result"]'),
('baseAdmissionOfficer','基地入场员','负责基地入场作业','["admission-session"]','["admission-pending"]','["admission-checkin"]','["admission-overview"]'),
('warehouseManager','仓库管理员','负责库存入出库','["inventory-session"]','["inventory-inbound"]','["inventory-inbound"]','["inventory-overview","inventory-progress"]')
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description);
INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g ON
(r.code='qualityInspector' AND g.code IN ('quality_operator','admission_operator','distribution_operator','restock_operator')) OR
(r.code='qualityLeader' AND g.code IN ('quality_operator','quality_management','admission_operator','distribution_operator','restock_operator')) OR
(r.code='baseAdmissionOfficer' AND g.code='admission_operator') OR
(r.code='warehouseManager' AND g.code='inventory_operator');
INSERT INTO wms_account(login_name,phone,display_name,password_salt,password_hash,role_id,warehouse_name)
SELECT 'quality','13800001001','李师傅','mh_quality_2026',SHA2(CONCAT('mh_quality_2026','123456'),256),id,'梦花仓管' FROM wms_role WHERE code='qualityInspector'
ON DUPLICATE KEY UPDATE display_name=VALUES(display_name),role_id=VALUES(role_id);
INSERT INTO wms_account(login_name,phone,display_name,password_salt,password_hash,role_id,warehouse_name)
SELECT 'quality_leader','13800001002','王主管','mh_leader_2026',SHA2(CONCAT('mh_leader_2026','123456'),256),id,'梦花仓管' FROM wms_role WHERE code='qualityLeader'
ON DUPLICATE KEY UPDATE display_name=VALUES(display_name),role_id=VALUES(role_id);
INSERT INTO wms_account(login_name,phone,display_name,password_salt,password_hash,role_id,warehouse_name)
SELECT 'admission','13800001003','张师傅','mh_admit_2026',SHA2(CONCAT('mh_admit_2026','123456'),256),id,'梦花仓管' FROM wms_role WHERE code='baseAdmissionOfficer'
ON DUPLICATE KEY UPDATE display_name=VALUES(display_name),role_id=VALUES(role_id);
INSERT INTO wms_account(login_name,phone,display_name,password_salt,password_hash,role_id,warehouse_name)
SELECT 'warehouse','13800001004','赵师傅','mh_warehouse_2026',SHA2(CONCAT('mh_warehouse_2026','123456'),256),id,'梦花仓管' FROM wms_role WHERE code='warehouseManager'
ON DUPLICATE KEY UPDATE display_name=VALUES(display_name),role_id=VALUES(role_id);
