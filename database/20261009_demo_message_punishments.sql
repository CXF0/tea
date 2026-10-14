-- 消息中心处罚通知联动「我的处罚」演示数据
-- 依赖已存在 admin 账号：login_name=admin

INSERT INTO wms_punish (
  type,punish_source,duty_user_id,duty_user_role,duty_user_name,punish_role_type,
  order_sn,date,zone,shelf,zone_shelf,sub_shelf_sn,shelf_detail,
  punish_reason,punish_remark,punish_price,punish_status,
  appeal_status,appeal_count,appeal_content,
  operator_id,operator_name,last_operator_id,last_operator_name,
  create_time,update_time,data_status
)
SELECT 2,2,a.id,0,a.display_name,1,
  'MSG-PUNISH-2026100901','2026-10-09','三区','015','三区-015','三区-015-1','三区 015 货架',
  '巡线发现三区 015 货架存在配货错误，已生成处罚记录。','消息中心处罚通知联动生成',30.00,0,
  0,0,'',
  a.id,'系统',a.id,'系统',
  '2026-10-09 09:15:00','2026-10-09 09:15:00',0
FROM wms_account a
WHERE a.login_name='admin'
  AND NOT EXISTS (SELECT 1 FROM wms_punish p WHERE p.order_sn='MSG-PUNISH-2026100901');

INSERT INTO wms_punish (
  type,punish_source,duty_user_id,duty_user_role,duty_user_name,punish_role_type,
  order_sn,date,zone,shelf,zone_shelf,sub_shelf_sn,shelf_detail,
  punish_reason,punish_remark,punish_price,punish_status,
  appeal_status,appeal_count,appeal_content,
  operator_id,operator_name,last_operator_id,last_operator_name,
  create_time,update_time,data_status
)
SELECT 2,2,a.id,0,a.display_name,1,
  'MSG-PUNISH-2026100902','2026-10-09','四区','028','四区-028','四区-028-2','四区 028 货架',
  '处罚单已由巡察员撤销，原处罚金额不再计入结算。','消息中心处罚撤销联动生成',20.00,2,
  0,0,'',
  a.id,'系统',a.id,'系统',
  '2026-10-09 10:20:00','2026-10-09 10:20:00',0
FROM wms_account a
WHERE a.login_name='admin'
  AND NOT EXISTS (SELECT 1 FROM wms_punish p WHERE p.order_sn='MSG-PUNISH-2026100902');

INSERT INTO wms_punish (
  type,punish_source,duty_user_id,duty_user_role,duty_user_name,punish_role_type,
  order_sn,date,zone,shelf,zone_shelf,sub_shelf_sn,shelf_detail,
  punish_reason,punish_remark,punish_price,punish_status,
  appeal_status,appeal_count,appeal_content,
  operator_id,operator_name,last_operator_id,last_operator_name,
  create_time,update_time,data_status
)
SELECT 1,2,a.id,0,a.display_name,1,
  'MSG-PUNISH-2026100903','2026-10-09','五区','006','五区-006','五区-006-1','五区 006 货架',
  '提交的处罚申诉已审核通过，相关处罚记录已解除。','消息中心申诉通过联动生成',15.00,2,
  2,1,'已提交申诉并审核通过',
  a.id,'系统',a.id,'系统',
  '2026-10-09 11:05:00','2026-10-09 11:05:00',0
FROM wms_account a
WHERE a.login_name='admin'
  AND NOT EXISTS (SELECT 1 FROM wms_punish p WHERE p.order_sn='MSG-PUNISH-2026100903');

UPDATE logistics_message
SET biz_type=21,biz_id=(SELECT id FROM wms_punish WHERE order_sn='MSG-PUNISH-2026100901' LIMIT 1)
WHERE id=111;

UPDATE logistics_message
SET biz_type=21,biz_id=(SELECT id FROM wms_punish WHERE order_sn='MSG-PUNISH-2026100902' LIMIT 1)
WHERE id=112;

UPDATE logistics_message
SET biz_type=21,biz_id=(SELECT id FROM wms_punish WHERE order_sn='MSG-PUNISH-2026100903' LIMIT 1)
WHERE id=113;
