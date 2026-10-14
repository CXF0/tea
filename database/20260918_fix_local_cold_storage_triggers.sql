-- 原库导出的触发器硬编码了生产 schema 名，而且本地开发账号没有 CREATE TRIGGER 权限。
-- 移除这两个旧触发器，剩余数量由 cold-storage repository 的事务统一维护。
DROP TRIGGER IF EXISTS trg_cold_task_remaining_bunch_insert;
DROP TRIGGER IF EXISTS trg_cold_task_remaining_bunch_update;
