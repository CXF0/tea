-- 数据中心质检分类：移除质检任务、质检结果和待处理问题三张旧卡片。
UPDATE wms_role
   SET data_cards_json = JSON_REMOVE(data_cards_json, JSON_UNQUOTE(JSON_SEARCH(data_cards_json, 'one', 'quality-task')))
 WHERE JSON_SEARCH(data_cards_json, 'one', 'quality-task') IS NOT NULL;

UPDATE wms_role
   SET data_cards_json = JSON_REMOVE(data_cards_json, JSON_UNQUOTE(JSON_SEARCH(data_cards_json, 'one', 'quality-result')))
 WHERE JSON_SEARCH(data_cards_json, 'one', 'quality-result') IS NOT NULL;

UPDATE wms_role
   SET data_cards_json = JSON_REMOVE(data_cards_json, JSON_UNQUOTE(JSON_SEARCH(data_cards_json, 'one', 'quality-issues')))
 WHERE JSON_SEARCH(data_cards_json, 'one', 'quality-issues') IS NOT NULL;

UPDATE wms_permission
   SET name = '质检问题统计',
       description = '降级、退货、缺货、换货及后续处理数量'
 WHERE code = 'dataCenter.card.quality-business-statistics';

UPDATE wms_permission
   SET status = 0
 WHERE code IN (
   'dataCenter.card.quality-task',
   'dataCenter.card.quality-result',
   'dataCenter.card.quality-issues'
 );
