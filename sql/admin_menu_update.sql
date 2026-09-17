-- 后台菜单更新SQL（幂等，可安全重复执行）
-- 列名：menu_name, route, icon, parent_id, sorted, create_time, update_time, is_deleted

-- 1. 修复角色/菜单名互换
UPDATE sys_menu SET menu_name = '角色管理' WHERE route = '/system/role';
UPDATE sys_menu SET menu_name = '菜单管理' WHERE route = '/system/menu';

-- 2. 新增内容管理菜单组（幂等：先检查是否已存在）
INSERT INTO sys_menu (menu_name, route, icon, parent_id, sorted, create_time, update_time, is_deleted)
SELECT '内容管理', '/content', 'FileTextOutlined', 0, 3, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE route = '/content' AND parent_id = 0 AND is_deleted = 0);

SET @content_menu_id = (SELECT id FROM sys_menu WHERE route = '/content' AND parent_id = 0 AND is_deleted = 0 LIMIT 1);

INSERT INTO sys_menu (menu_name, route, icon, parent_id, sorted, create_time, update_time, is_deleted)
SELECT '试卷管理', '/content/paper', 'FileOutlined', @content_menu_id, 1, NOW(), NOW(), 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE route = '/content/paper' AND is_deleted = 0);

INSERT INTO sys_menu (menu_name, route, icon, parent_id, sorted, create_time, update_time, is_deleted)
SELECT '词书管理', '/content/wordbook', 'BookOutlined', @content_menu_id, 2, NOW(), NOW(), 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE route = '/content/wordbook' AND is_deleted = 0);

INSERT INTO sys_menu (menu_name, route, icon, parent_id, sorted, create_time, update_time, is_deleted)
SELECT '文章管理', '/content/article', 'ReadOutlined', @content_menu_id, 3, NOW(), NOW(), 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE route = '/content/article' AND is_deleted = 0);

INSERT INTO sys_menu (menu_name, route, icon, parent_id, sorted, create_time, update_time, is_deleted)
SELECT '作文管理', '/content/essay', 'EditOutlined', @content_menu_id, 4, NOW(), NOW(), 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE route = '/content/essay' AND is_deleted = 0);

INSERT INTO sys_menu (menu_name, route, icon, parent_id, sorted, create_time, update_time, is_deleted)
SELECT '翻译管理', '/content/translation', 'TranslationOutlined', @content_menu_id, 5, NOW(), NOW(), 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE route = '/content/translation' AND is_deleted = 0);

INSERT INTO sys_menu (menu_name, route, icon, parent_id, sorted, create_time, update_time, is_deleted)
SELECT '作文记录', '/content/writing', 'AuditOutlined', @content_menu_id, 6, NOW(), NOW(), 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE route = '/content/writing' AND is_deleted = 0);

-- 3. 新增PK管理菜单组（幂等：先检查是否已存在）
INSERT INTO sys_menu (menu_name, route, icon, parent_id, sorted, create_time, update_time, is_deleted)
SELECT 'PK管理', '/pk', 'TrophyOutlined', 0, 4, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE route = '/pk' AND parent_id = 0 AND is_deleted = 0);

SET @pk_menu_id = (SELECT id FROM sys_menu WHERE route = '/pk' AND parent_id = 0 AND is_deleted = 0 LIMIT 1);

INSERT INTO sys_menu (menu_name, route, icon, parent_id, sorted, create_time, update_time, is_deleted)
SELECT '排行榜', '/pk/rank', 'RankedListOutlined', @pk_menu_id, 1, NOW(), NOW(), 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE route = '/pk/rank' AND is_deleted = 0);

INSERT INTO sys_menu (menu_name, route, icon, parent_id, sorted, create_time, update_time, is_deleted)
SELECT '对战记录', '/pk/record', 'HistoryOutlined', @pk_menu_id, 2, NOW(), NOW(), 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE route = '/pk/record' AND is_deleted = 0);

-- 4. 关联到管理员角色（role_id=1），供后台菜单渲染
INSERT INTO sys_role_menu (role_id, menu_id, create_time, update_time, is_deleted)
SELECT 1, m.id, NOW(), NOW(), 0
FROM sys_menu m
WHERE m.route IN ('/content', '/content/paper', '/content/wordbook', '/content/article', '/content/essay', '/content/writing', '/content/translation', '/pk', '/pk/rank', '/pk/record')
  AND NOT EXISTS (SELECT 1 FROM sys_role_menu rm WHERE rm.role_id = 1 AND rm.menu_id = m.id);
