ALTER TABLE `xm_bulky_supplier_enter_item`
  ADD COLUMN `duty_media_json` text NULL COMMENT '商家全责图片/视频URL列表(JSON)' AFTER `duty_remark`;
