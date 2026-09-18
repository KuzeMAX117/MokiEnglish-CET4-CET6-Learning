-- 试卷管理模块菜单脚本（幂等，可重复执行）
-- 用法：mysql --default-character-set=utf8mb4 -e "source D:/202401/study/Hao-Topic/sql/paper_manage_menu.sql"
USE brushtopic;

-- 1. 新增"试卷管理"菜单（挂到"题库管理"id=12 下，sorted=5）
INSERT INTO sys_menu (menu_name, parent_id, sorted, route, create_time, update_time, is_deleted, icon)
SELECT '试卷管理', 12, 5, '/topic/paper', NOW(), NOW(), 0, 'FileDoneOutlined'
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE route = '/topic/paper');

-- 2. 关联到管理员角色（role_id=1），供后台菜单渲染
INSERT INTO sys_role_menu (role_id, menu_id, create_time, update_time, is_deleted)
SELECT 1, m.id, NOW(), NOW(), 0
FROM sys_menu m
WHERE m.route = '/topic/paper'
  AND NOT EXISTS (SELECT 1 FROM sys_role_menu rm WHERE rm.role_id = 1 AND rm.menu_id = m.id);

-- 3. 验证结果
SELECT m.id, m.menu_name, m.parent_id, m.sorted, m.route, m.icon,
       (SELECT COUNT(*) FROM sys_role_menu rm WHERE rm.menu_id = m.id AND rm.role_id = 1) AS admin_linked
FROM sys_menu m
WHERE m.route = '/topic/paper';
