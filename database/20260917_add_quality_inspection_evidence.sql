ALTER TABLE `xm_inspection_reason_record`
  ADD COLUMN `evidence_media_json` text NULL COMMENT '质检凭证图片/视频(JSON)' AFTER `user_name`,
  ADD COLUMN `allow_downgrade_restock` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '是否允许降一级补货：0否 1是' AFTER `evidence_media_json`;
