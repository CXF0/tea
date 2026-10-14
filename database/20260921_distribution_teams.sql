-- 新版本地库配货团队基础数据；不连接、不修改源数据库。
INSERT INTO wms_account_source_identity(account_id,source_system,source_user_id)
SELECT a.id,'bulkyGoods',991000000+a.id FROM wms_account a
JOIN wms_role r ON r.id=a.role_id
WHERE a.status=1 AND r.code IN('picker','partTimePicker')
ON DUPLICATE KEY UPDATE source_user_id=source_user_id;

INSERT INTO xm_bulky_team(type,name,role_id,perm_config,people_num,leader_id,leader_name,charge_base,remark,active_flag,data_status)
SELECT 2,'寻梦1-10区配货组',0,JSON_OBJECT('zones',JSON_ARRAY('01','02','03','04','05','06','07','08','09','10')),5,990000009,'陈志强','[]','新版仓管测试配货团队',1,0
WHERE NOT EXISTS(SELECT 1 FROM xm_bulky_team WHERE type=2 AND name='寻梦1-10区配货组' AND data_status=0);
INSERT INTO xm_bulky_team(type,name,role_id,perm_config,people_num,leader_id,leader_name,charge_base,remark,active_flag,data_status)
SELECT 2,'寻梦11-20区配货组',0,JSON_OBJECT('zones',JSON_ARRAY('11','12','13','14','15','16','17','18','19','20')),5,991000040,'陈宇','[]','新版仓管测试配货团队',1,0
WHERE NOT EXISTS(SELECT 1 FROM xm_bulky_team WHERE type=2 AND name='寻梦11-20区配货组' AND data_status=0);
INSERT INTO xm_bulky_team(type,name,role_id,perm_config,people_num,leader_id,leader_name,charge_base,remark,active_flag,data_status)
SELECT 2,'寻梦21-30区配货组',0,JSON_OBJECT('zones',JSON_ARRAY('21','22','23','24','25','26','27','28','29','30')),4,991000041,'刘杰','[]','新版仓管测试配货团队',1,0
WHERE NOT EXISTS(SELECT 1 FROM xm_bulky_team WHERE type=2 AND name='寻梦21-30区配货组' AND data_status=0);

INSERT IGNORE INTO xm_bulky_team_user(user_id,user_name,is_sub,team_id)
SELECT source.source_user_id,a.display_name,1,t.id FROM wms_account a
JOIN wms_account_source_identity source ON source.account_id=a.id AND source.source_system='bulkyGoods'
JOIN xm_bulky_team t ON t.name='寻梦1-10区配货组' AND t.type=2 AND t.data_status=0
WHERE a.id IN(13,45,46,52);
INSERT IGNORE INTO xm_bulky_team_user(user_id,user_name,is_sub,team_id)
SELECT 990000009,'陈志强',1,t.id FROM xm_bulky_team t
WHERE t.name='寻梦1-10区配货组' AND t.type=2 AND t.data_status=0;

INSERT IGNORE INTO xm_bulky_team_user(user_id,user_name,is_sub,team_id)
SELECT source.source_user_id,a.display_name,1,t.id FROM wms_account a
JOIN wms_account_source_identity source ON source.account_id=a.id AND source.source_system='bulkyGoods'
JOIN xm_bulky_team t ON t.name='寻梦11-20区配货组' AND t.type=2 AND t.data_status=0
WHERE a.id IN(40,42,47,48,49);

INSERT IGNORE INTO xm_bulky_team_user(user_id,user_name,is_sub,team_id)
SELECT source.source_user_id,a.display_name,1,t.id FROM wms_account a
JOIN wms_account_source_identity source ON source.account_id=a.id AND source.source_system='bulkyGoods'
JOIN xm_bulky_team t ON t.name='寻梦21-30区配货组' AND t.type=2 AND t.data_status=0
WHERE a.id IN(41,43,44,50);

INSERT INTO xm_bulky_external_distribution_contractor_account(contractor_user_id,employee_user_id,last_operator_id,data_status)
SELECT 990000009,source.source_user_id,990000009,0 FROM wms_account_source_identity source
WHERE source.source_system='bulkyGoods' AND source.account_id IN(13,45,46,52)
ON DUPLICATE KEY UPDATE data_status=0,last_operator_id=VALUES(last_operator_id),update_time=NOW();

UPDATE xm_bulky_team t SET people_num=(SELECT COUNT(*) FROM xm_bulky_team_user u WHERE u.team_id=t.id)
WHERE t.type=2 AND t.name IN('寻梦1-10区配货组','寻梦11-20区配货组','寻梦21-30区配货组');
