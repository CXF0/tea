CREATE TABLE IF NOT EXISTS wms_account_inspection_area (
  account_id BIGINT UNSIGNED NOT NULL,
  zone_code VARCHAR(32) NOT NULL,
  operator_id BIGINT UNSIGNED NOT NULL DEFAULT 0,
  create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (account_id, zone_code),
  KEY idx_inspection_area_zone (zone_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='质检员负责分区';

INSERT INTO wms_account(login_name,phone,display_name,password_salt,password_hash,role_id,warehouse_name,status)
SELECT seed.login_name,seed.phone,seed.display_name,seed.salt,SHA2(CONCAT(seed.salt,'123456'),256),r.id,'梦花仓管',1
FROM (
  SELECT 'quality_zhaochu' login_name,'13810003001' phone,'赵初' display_name,'quality_zhaochu_2026' salt UNION ALL
  SELECT 'quality_guoyan','13810003002','郭燕','quality_guoyan_2026' UNION ALL
  SELECT 'quality_ningxia','13810003003','宁潇欣','quality_ningxia_2026' UNION ALL
  SELECT 'quality_wuzong','13810003004','吴宗兴','quality_wuzong_2026' UNION ALL
  SELECT 'quality_ninglang','13810003005','宁朗琼','quality_ninglang_2026' UNION ALL
  SELECT 'quality_ninayuan','13810003006','宁园','quality_ninayuan_2026' UNION ALL
  SELECT 'quality_sunyi','13810003007','孙一丽','quality_sunyi_2026' UNION ALL
  SELECT 'quality_zhangjie','13810003008','张洁','quality_zhangjie_2026' UNION ALL
  SELECT 'quality_shaoming','13810003009','邵明康','quality_shaoming_2026' UNION ALL
  SELECT 'quality_linxi','13810003010','林芯玉','quality_linxi_2026'
) seed JOIN wms_role r ON r.code='qualityInspector'
ON DUPLICATE KEY UPDATE display_name=VALUES(display_name),role_id=VALUES(role_id),warehouse_name=VALUES(warehouse_name),status=1;

INSERT INTO xm_bulky_inspection_assign_user(user_id,user_name,status,attendance_status,attendance_update_time)
SELECT a.id,a.display_name,1,IF(MOD(a.id,5)=0,0,1),NOW()
FROM wms_account a JOIN wms_role r ON r.id=a.role_id
WHERE a.status=1 AND r.code='qualityInspector'
ON DUPLICATE KEY UPDATE user_name=VALUES(user_name),status=1;

INSERT IGNORE INTO wms_account_inspection_area(account_id,zone_code)
SELECT a.id,z.zone_code FROM wms_account a JOIN (
  SELECT 'quality_zhaochu' login_name,'7' zone_code UNION ALL SELECT 'quality_zhaochu','8' UNION ALL
  SELECT 'quality_guoyan','1' UNION ALL SELECT 'quality_guoyan','2' UNION ALL
  SELECT 'quality_ningxia','10' UNION ALL SELECT 'quality_ningxia','12' UNION ALL
  SELECT 'quality_wuzong','3' UNION ALL
  SELECT 'quality_ninglang','20' UNION ALL SELECT 'quality_ninglang','24' UNION ALL
  SELECT 'quality_ninayuan','17' UNION ALL SELECT 'quality_ninayuan','18' UNION ALL
  SELECT 'quality_sunyi','3' UNION ALL SELECT 'quality_sunyi','4' UNION ALL
  SELECT 'quality_zhangjie','9' UNION ALL
  SELECT 'quality_shaoming','15' UNION ALL SELECT 'quality_shaoming','16' UNION ALL
  SELECT 'quality_linxi','6' UNION ALL SELECT 'quality_linxi','11'
) z ON z.login_name=a.login_name;
