CREATE TABLE IF NOT EXISTS xm_bulky_part_logistics (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  date VARCHAR(10) NOT NULL DEFAULT '' COMMENT '场次',
  user_id BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '兼职物流员id',
  user_name VARCHAR(20) NOT NULL COMMENT '兼职物流员姓名',
  manage_id BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理组长id',
  manage_name VARCHAR(20) NOT NULL DEFAULT '' COMMENT '管理组长姓名',
  start_manage_id BIGINT UNSIGNED NOT NULL DEFAULT 0,
  start_manage_name VARCHAR(20) NOT NULL DEFAULT '',
  end_manage_id BIGINT UNSIGNED NOT NULL DEFAULT 0,
  end_manage_name VARCHAR(20) NOT NULL DEFAULT '',
  start_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  end_time DATETIME NULL,
  price DECIMAL(10,2) NOT NULL DEFAULT 0,
  total_price DECIMAL(10,2) NOT NULL DEFAULT 0,
  duration DECIMAL(10,2) NOT NULL DEFAULT 0,
  settle_flag TINYINT UNSIGNED NOT NULL DEFAULT 0,
  user_type TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (id), INDEX idx_date(date), INDEX idx_start_time(start_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='兼职物流员工资结算';

INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
VALUES(0,'partLogistics.view','兼职物流员管理','part-logistics',1,'查看兼职物流员场次工作记录','/features/part-logistics/pages/home/index','fwms-account-outline',120,1)
ON DUPLICATE KEY UPDATE name=VALUES(name),domain_code=VALUES(domain_code),permission_type=1,description=VALUES(description),route_path=VALUES(route_path),icon=VALUES(icon),sort_order=VALUES(sort_order),status=1;

INSERT INTO wms_permission(parent_id,code,name,domain_code,permission_type,description,route_path,icon,sort_order,status)
SELECT id,'partLogistics.assign','分配兼职物流组长','part-logistics',2,'批量分配兼职物流员的管理组长','','',10,1
FROM wms_permission WHERE code='partLogistics.view'
ON DUPLICATE KEY UPDATE name=VALUES(name),parent_id=VALUES(parent_id),domain_code=VALUES(domain_code),permission_type=2,description=VALUES(description),status=1;

INSERT INTO wms_permission_group(code,name,description,status)
VALUES('part_logistics_management','兼职物流员管理','查看兼职物流员工作记录并分配管理组长',1)
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),status=1;

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g,wms_permission p
WHERE g.code='part_logistics_management' AND p.code IN ('partLogistics.view','partLogistics.assign');

INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r,wms_permission_group g
WHERE r.code IN ('siteAdmin','logisticsLeader','logisticsSpecialist') AND g.code='part_logistics_management';
