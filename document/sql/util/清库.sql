-- 1: truncate所有表
CALL truncate_all_tables("daigou_dev");
-- 2:设置自增初始值
CALL set_auto_increment("daigou_dev");
-- 3:执行init_db.sql 初始化所有数据


