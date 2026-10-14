-- 供应商所属基地简称，沿用旧配货页面 supplier_tag 字段。
INSERT INTO xm_bulky_supplier (id,supplier_name,supplier_tag,login_tel,create_time,update_time,data_status)
SELECT entry.supplier_id,entry.supplier_name,
       CASE entry.supplier_id WHEN 401 THEN '晋宁' WHEN 402 THEN '呈贡' WHEN 403 THEN '斗南'
         WHEN 404 THEN '嵩明' WHEN 405 THEN '安宁' WHEN 406 THEN '宜良' WHEN 407 THEN '石林' ELSE '斗南' END,
       entry.login_tel,NOW(),NOW(),0
FROM xm_bulky_supplier_enter entry
WHERE entry.date='2026-09-18'
ON DUPLICATE KEY UPDATE supplier_name=VALUES(supplier_name),supplier_tag=VALUES(supplier_tag),login_tel=VALUES(login_tel),update_time=NOW(),data_status=0;
