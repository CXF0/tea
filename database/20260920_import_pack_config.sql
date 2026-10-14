USE `menghuacangguan_v1_local`;

SET @has_wms_bind_flag := (
  SELECT COUNT(*) FROM information_schema.columns
  WHERE table_schema=DATABASE() AND table_name='xm_bulky_pack_config' AND column_name='wms_bind_flag'
);
SET @add_wms_bind_flag := IF(@has_wms_bind_flag=0,
  'ALTER TABLE xm_bulky_pack_config ADD COLUMN wms_bind_flag tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT ''是否绑定WMS 0否 1是'' AFTER sort',
  'SELECT 1');
PREPARE pack_config_stmt FROM @add_wms_bind_flag;
EXECUTE pack_config_stmt;
DEALLOCATE PREPARE pack_config_stmt;

INSERT INTO xm_bulky_pack_config
  (id,pack_name,pack_weight,flower_weight,pack_price,labor_price,logistics_price,pic_url,remark,sort,wms_bind_flag)
VALUES
  (7,'天地盖小号（40*20）',15.00,10.00,8.00,5.00,0.30,'https://img-bulky.xunmengvip.com/xmbulky/refund/2024/12/5/17333951998158901.png','110*40*20 箱',0,1),
  (28,'小件70*20箱',1.70,1.00,1.70,3.00,0.15,'','70*20箱',0,1),
  (29,'小件90*17箱',3.50,2.50,2.00,3.00,0.15,'','小件90*17箱',0,1),
  (13,'天地盖中号（40*25）',20.00,15.00,9.00,5.00,0.30,'https://img-bulky.xunmengvip.com/xmbulky/refund/2024/12/5/17333952051731929.png','110*40*25 箱',1,1),
  (14,'天地盖大号（40*30）',30.00,22.00,11.00,5.00,0.30,'https://img-bulky.xunmengvip.com/xmbulky/refund/2024/12/5/17333952115619885.png','110*40*30 箱',2,1),
  (15,'天地盖超大号（45*38）',38.00,30.00,12.00,7.00,0.30,'https://img-bulky.xunmengvip.com/xmbulky/refund/2024/12/5/17333952162481329.png','110*45*38 箱',3,1),
  (16,'天地盖最大号（45*45）',45.00,39.10,13.00,10.00,0.30,'https://img-bulky.xunmengvip.com/xmbulky/refund/2026/7/2/17829772583777750.png','110*45*45 箱',3,1),
  (10,'110*45*45箱',50.00,0.00,11.50,14.00,0.30,'https://img-bulky.xunmengvip.com/xmbulky/refund/2024/12/5/17333952305229183.png','110*45*45 箱',4,1),
  (11,'110*50*50箱',60.00,52.20,12.80,14.00,0.50,'https://img-bulky.xunmengvip.com/xmbulky/refund/2024/12/5/1733395248095165.png','110*50*50 箱',5,1),
  (17,'110*50*60箱',65.00,56.50,15.00,21.00,0.50,'https://img-bulky.xunmengvip.com/xmbulky/refund/2024/12/5/17333952551442073.png','110*50*60',6,1),
  (12,'110*60*60箱',80.00,69.60,24.00,21.00,0.50,'https://img-bulky.xunmengvip.com/xmbulky/refund/2024/12/5/17333952612902764.png','110*60*60 箱',7,1),
  (26,'100*25箱',10.00,7.00,4.40,3.00,0.15,'','100*25',8,1),
  (25,'90*20箱',6.00,4.00,3.00,3.00,0.15,'','90*20',10,1),
  (20,'蝴蝶兰',4.00,1.00,0.00,0.00,0.00,'https://img-bulky.xunmengvip.com/xmbulky/refund/2024/12/5/17333950687505534.png','100*30*15',11,1),
  (19,'蓝妖',2.00,1.00,0.00,0.00,0.00,'https://img-bulky.xunmengvip.com/xmbulky/refund/2024/12/5/17333950504103692.png','100*10*15',12,1),
  (24,'框子',39.00,0.00,0.00,0.00,0.30,'','其他',13,1),
  (21,'其他',7.00,0.00,0.00,0.00,0.00,'https://img-bulky.xunmengvip.com/xmbulky/refund/2024/12/6/17334669460003153.png','其他',14,0)
ON DUPLICATE KEY UPDATE
  pack_name=VALUES(pack_name),pack_weight=VALUES(pack_weight),flower_weight=VALUES(flower_weight),
  pack_price=VALUES(pack_price),labor_price=VALUES(labor_price),logistics_price=VALUES(logistics_price),
  pic_url=VALUES(pic_url),remark=VALUES(remark),sort=VALUES(sort),wms_bind_flag=VALUES(wms_bind_flag);
