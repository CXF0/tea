CREATE TABLE IF NOT EXISTS wms_account_distribution_area (
  account_id BIGINT UNSIGNED NOT NULL,
  zone_code VARCHAR(32) NOT NULL,
  operator_id BIGINT UNSIGNED NOT NULL DEFAULT 0,
  create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (account_id, zone_code),
  KEY idx_distribution_area_zone (zone_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='配货人员可配货分区权限';

INSERT INTO wms_role(code,name,description,workbench_cards_json,todo_ids_json,scan_operations_json,data_cards_json,status) VALUES
('partTimePicker','兼职配货员','按授权分区执行临时配货作业','[]','[]','[]','[]',1)
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),status=1;

INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g
WHERE r.code='partTimePicker' AND g.code='distribution_operator';

INSERT INTO wms_account(login_name,phone,display_name,password_salt,password_hash,role_id,warehouse_name,status)
SELECT seed.login_name,seed.phone,seed.display_name,seed.salt,SHA2(CONCAT(seed.salt,'123456'),256),r.id,'梦花仓管',1
FROM (
  SELECT 'picker_chenyu' login_name,'13810002001' phone,'陈宇' display_name,'picker_chenyu_2026' salt,'picker' role_code UNION ALL
  SELECT 'picker_liujie','13810002002','刘杰','picker_liujie_2026','picker' UNION ALL
  SELECT 'picker_zhangqiang','13810002003','张强','picker_zhangqiang_2026','picker' UNION ALL
  SELECT 'picker_wanghao','13810002004','王浩','picker_wanghao_2026','picker' UNION ALL
  SELECT 'picker_lina','13810002005','李娜','picker_lina_2026','picker' UNION ALL
  SELECT 'part_picker_zhouyang','13810002101','周洋','part_picker_zhouyang_2026','partTimePicker' UNION ALL
  SELECT 'part_picker_sunlei','13810002102','孙磊','part_picker_sunlei_2026','partTimePicker' UNION ALL
  SELECT 'part_picker_wuqian','13810002103','吴倩','part_picker_wuqian_2026','partTimePicker' UNION ALL
  SELECT 'part_picker_heming','13810002104','何明','part_picker_heming_2026','partTimePicker' UNION ALL
  SELECT 'part_picker_zhengjie','13810002105','郑洁','part_picker_zhengjie_2026','partTimePicker' UNION ALL
  SELECT 'part_picker_gaofeng','13810002106','高峰','part_picker_gaofeng_2026','partTimePicker' UNION ALL
  SELECT 'part_picker_xuting','13810002107','徐婷','part_picker_xuting_2026','partTimePicker' UNION ALL
  SELECT 'part_picker_luocheng','13810002108','罗成','part_picker_luocheng_2026','partTimePicker'
) seed JOIN wms_role r ON r.code=seed.role_code
ON DUPLICATE KEY UPDATE display_name=VALUES(display_name),role_id=VALUES(role_id),warehouse_name=VALUES(warehouse_name),status=1;

INSERT IGNORE INTO wms_account_distribution_area(account_id,zone_code)
SELECT a.id,z.zone_code FROM wms_account a JOIN (
  SELECT 'picker_chenyu' login_name,'1' zone_code UNION ALL SELECT 'picker_chenyu','2' UNION ALL SELECT 'picker_chenyu','3' UNION ALL
  SELECT 'picker_liujie','4' UNION ALL SELECT 'picker_liujie','5' UNION ALL SELECT 'picker_liujie','6' UNION ALL
  SELECT 'picker_zhangqiang','7' UNION ALL SELECT 'picker_zhangqiang','8' UNION ALL SELECT 'picker_zhangqiang','9' UNION ALL
  SELECT 'picker_wanghao','10' UNION ALL SELECT 'picker_wanghao','11' UNION ALL SELECT 'picker_wanghao','12' UNION ALL
  SELECT 'picker_lina','13' UNION ALL SELECT 'picker_lina','14' UNION ALL SELECT 'picker_lina','15' UNION ALL
  SELECT 'part_picker_zhouyang','1' UNION ALL SELECT 'part_picker_zhouyang','6' UNION ALL SELECT 'part_picker_sunlei','2' UNION ALL SELECT 'part_picker_sunlei','7' UNION ALL
  SELECT 'part_picker_wuqian','3' UNION ALL SELECT 'part_picker_wuqian','8' UNION ALL SELECT 'part_picker_heming','4' UNION ALL SELECT 'part_picker_heming','9' UNION ALL
  SELECT 'part_picker_zhengjie','5' UNION ALL SELECT 'part_picker_zhengjie','10' UNION ALL SELECT 'part_picker_gaofeng','11' UNION ALL SELECT 'part_picker_gaofeng','12' UNION ALL
  SELECT 'part_picker_xuting','13' UNION ALL SELECT 'part_picker_xuting','14' UNION ALL SELECT 'part_picker_luocheng','15' UNION ALL SELECT 'part_picker_luocheng','16'
) z ON z.login_name=a.login_name;
