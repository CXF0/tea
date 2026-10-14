-- 将花材质检与质检任务拆成独立业务能力，由权限组负责组合。
INSERT INTO wms_permission(code,name,domain_code,description) VALUES
('quality.flower.view','查看花材质检','quality','查看供应商花材和逐扎质检数据'),
('quality.task.view','查看质检任务','quality-task','查看派发任务、自行货位检查和视频任务'),
('quality.task.submit','提交质检任务','quality-task','提交派发质检任务的处理结果'),
('quality.task.video.submit','提交好花视频','quality-task','扫码、上传并提交好花视频任务')
ON DUPLICATE KEY UPDATE name=VALUES(name),domain_code=VALUES(domain_code),description=VALUES(description),status=1;

INSERT INTO wms_permission_group(code,name,description) VALUES
('quality_operator','花材质检作业','花材质检查看、扫码、问题标记、业务控制、提交与撤销'),
('quality_task_operator','质检任务作业','质检任务查看、任务提交和好花视频提交')
ON DUPLICATE KEY UPDATE name=VALUES(name),description=VALUES(description),status=1;

INSERT IGNORE INTO wms_permission_group_item(group_id,permission_id)
SELECT g.id,p.id FROM wms_permission_group g JOIN wms_permission p ON
(g.code='quality_operator' AND p.code='quality.flower.view') OR
(g.code='quality_task_operator' AND p.code IN ('quality.task.view','quality.task.submit','quality.task.video.submit'));

-- 保持现有角色升级后行为不变；以后可独立删除其中一个角色-权限组关系。
INSERT IGNORE INTO wms_role_permission_group(role_id,group_id)
SELECT r.id,g.id FROM wms_role r JOIN wms_permission_group g
WHERE r.code IN ('siteAdmin','regionalManager','zoneSupervisor','qualityInspector','qualityLeader','patrolInspector')
  AND g.code='quality_task_operator';

-- 清理上一版错误建立的“一项入口能力一个权限组”。
DELETE rpg FROM wms_role_permission_group rpg JOIN wms_permission_group g ON g.id=rpg.group_id
WHERE g.code IN ('quality_flower_entry','quality_task_entry');
DELETE pgi FROM wms_permission_group_item pgi JOIN wms_permission_group g ON g.id=pgi.group_id
WHERE g.code IN ('quality_flower_entry','quality_task_entry');
DELETE FROM wms_permission_group WHERE code IN ('quality_flower_entry','quality_task_entry');
