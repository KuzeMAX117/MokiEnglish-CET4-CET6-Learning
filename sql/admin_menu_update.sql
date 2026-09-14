-- 后台菜单更新SQL
-- 列名：menu_name, route, icon, parent_id, sorted, create_time, update_time, is_deleted

-- 1. 修复角色/菜单名互换
UPDATE sys_menu SET menu_name = '角色管理' WHERE route = '/system/role';
UPDATE sys_menu SET menu_name = '菜单管理' WHERE route = '/system/menu';

-- 2. 新增内容管理菜单组
INSERT INTO sys_menu (menu_name, route, icon, parent_id, sorted, create_time, update_time, is_deleted)
VALUES ('内容管理', '/content', 'FileTextOutlined', 0, 3, NOW(), NOW(), 0);

SET @content_menu_id = LAST_INSERT_ID();

INSERT INTO sys_menu (menu_name, route, icon, parent_id, sorted, create_time, update_time, is_deleted) VALUES
('试卷管理', '/content/paper', 'FileOutlined', @content_menu_id, 1, NOW(), NOW(), 0),
('词书管理', '/content/wordbook', 'BookOutlined', @content_menu_id, 2, NOW(), NOW(), 0),
('文章管理', '/content/article', 'ReadOutlined', @content_menu_id, 3, NOW(), NOW(), 0),
('作文记录', '/content/writing', 'EditOutlined', @content_menu_id, 4, NOW(), NOW(), 0),
('翻译记录', '/content/translation', 'TranslationOutlined', @content_menu_id, 5, NOW(), NOW(), 0);

-- 3. 新增PK管理菜单组
INSERT INTO sys_menu (menu_name, route, icon, parent_id, sorted, create_time, update_time, is_deleted)
VALUES ('PK管理', '/pk', 'TrophyOutlined', 0, 4, NOW(), NOW(), 0);

SET @pk_menu_id = LAST_INSERT_ID();

INSERT INTO sys_menu (menu_name, route, icon, parent_id, sorted, create_time, update_time, is_deleted) VALUES
('排行榜', '/pk/rank', 'RankedListOutlined', @pk_menu_id, 1, NOW(), NOW(), 0),
('对战记录', '/pk/record', 'HistoryOutlined', @pk_menu_id, 2, NOW(), NOW(), 0);
