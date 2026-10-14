INSERT INTO logistics_message
  (msg_type,target_type,carrier_id,provider_id,biz_type,biz_id,title,content,creator_account_type,creator_account_id,creator_name,create_time,update_time,data_status)
VALUES
  (21,0,0,0,21,2026100901,'处罚通知','巡线发现 三区 015 货架存在配货错误，已生成处罚记录，请相关责任人及时查看并处理。',1,0,'系统',NOW() - INTERVAL 12 MINUTE,NOW() - INTERVAL 12 MINUTE,0),
  (22,0,0,0,22,2026100902,'处罚撤销','处罚单 P20261009002 已由巡察员撤销，原处罚金额不再计入结算。',1,0,'系统',NOW() - INTERVAL 8 MINUTE,NOW() - INTERVAL 8 MINUTE,0),
  (23,0,0,0,23,2026100903,'处罚申诉通过','你提交的处罚申诉已审核通过，相关处罚记录已解除，请关注后续结算结果。',1,0,'系统',NOW() - INTERVAL 3 MINUTE,NOW() - INTERVAL 3 MINUTE,0);
