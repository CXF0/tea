CREATE TABLE IF NOT EXISTS `xm_quality_punish_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `operation` tinyint unsigned NOT NULL COMMENT '处置方式',
  `operation_name` varchar(32) NOT NULL DEFAULT '' COMMENT '处置方式名称',
  `punish_percent` decimal(8,2) NOT NULL DEFAULT 0 COMMENT '处罚比例(%)',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '处罚规则说明',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `data_status` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_operation` (`operation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='质检处置处罚比例配置';

INSERT INTO `xm_quality_punish_config` (`operation`,`operation_name`,`punish_percent`,`description`) VALUES
  (1,'降一级',30,'降一级处罚：本金 × 30%'),
  (2,'降两级',50,'降两级处罚：本金 × 50%'),
  (3,'退货不补',15,'退货不补处罚：本金 × 15%'),
  (5,'退货补货',15,'退货补货处罚：本金 × 15%'),
  (6,'缺货补货',300,'缺货补货处罚：本金 × 300%'),
  (7,'缺货不补',300,'缺货不补处罚：本金 × 300%'),
  (12,'换货',0,'换货不产生处罚金额')
ON DUPLICATE KEY UPDATE `operation_name`=VALUES(`operation_name`),`punish_percent`=VALUES(`punish_percent`),`description`=VALUES(`description`),`data_status`=0;
