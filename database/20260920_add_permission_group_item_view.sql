-- 权限组与权限的可读查询视图；真实关系仍由 wms_permission_group_item 保存。
CREATE OR REPLACE VIEW wms_permission_group_item_view AS
SELECT
  gi.group_id,
  g.code AS group_code,
  g.name AS group_name,
  gi.permission_id,
  p.code AS permission_code,
  p.name AS permission_name,
  p.domain_code,
  p.description AS permission_description,
  g.status AS group_status,
  p.status AS permission_status
FROM wms_permission_group_item gi
JOIN wms_permission_group g ON g.id = gi.group_id
JOIN wms_permission p ON p.id = gi.permission_id;
