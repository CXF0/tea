-- 数据中心：质检团队分区任务统计卡片。
UPDATE wms_permission
   SET name = '质检任务统计',
       description = '按负责的质检团队分区汇总辖区内所有质检人员任务完成情况'
 WHERE code = 'dataCenter.card.quality-task';

-- 仅给管理与质检负责角色增加默认卡片；普通质检员仍使用个人任务统计。
UPDATE wms_role
   SET data_cards_json = JSON_ARRAY_APPEND(
         COALESCE(data_cards_json, JSON_ARRAY()),
         '$',
         'quality-task'
       )
 WHERE code IN ('superAdmin', 'siteAdmin', 'regionalManager', 'qualityLeader')
   AND NOT JSON_CONTAINS(COALESCE(data_cards_json, JSON_ARRAY()), JSON_QUOTE('quality-task'));
