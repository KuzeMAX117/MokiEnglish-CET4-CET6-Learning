-- 清理菜单重复数据（不用变量，兼容性更好）
-- 在Navicat中执行

-- 第一步：清空
DELETE FROM sys_role_menu;
DELETE FROM sys_menu;

-- 第二步：插入顶级菜单
INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted) VALUES ('首页', 0, 0, '/home', 'HomeOutlined', NOW(), NOW(), 0);
INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted) VALUES ('系统管理', 0, 1, '/system', 'SettingOutlined', NOW(), NOW(), 0);
INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted) VALUES ('题库管理', 0, 2, '/topic', 'DatabaseOutlined', NOW(), NOW(), 0);
INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted) VALUES ('内容管理', 0, 3, '/content', 'FileTextOutlined', NOW(), NOW(), 0);
INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted) VALUES ('PK管理', 0, 4, '/pk', 'TrophyOutlined', NOW(), NOW(), 0);
INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted) VALUES ('模型管理', 0, 5, '/ai', 'RobotOutlined', NOW(), NOW(), 0);
INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted) VALUES ('个人中心', 0, 6, '/profile', 'UserOutlined', NOW(), NOW(), 0);

-- 第三步：插入子菜单（用子查询获取父菜单ID）

-- 系统管理的子菜单
INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT '用户管理', id, 1, '/system/user', 'UserOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/system' AND parent_id = 0 LIMIT 1;

INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT '菜单管理', id, 2, '/system/menu', 'MenuOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/system' AND parent_id = 0 LIMIT 1;

INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT '角色管理', id, 3, '/system/role', 'TeamOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/system' AND parent_id = 0 LIMIT 1;

INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT '反馈管理', id, 4, '/system/feedback', 'FeedbackOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/system' AND parent_id = 0 LIMIT 1;

-- 题库管理的子菜单
INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT '题目管理', id, 1, '/topic/topic', 'FileOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/topic' AND parent_id = 0 LIMIT 1;

INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT '分类管理', id, 2, '/topic/category', 'AppstoreOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/topic' AND parent_id = 0 LIMIT 1;

INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT '标签管理', id, 3, '/topic/label', 'TagOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/topic' AND parent_id = 0 LIMIT 1;

INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT '专题管理', id, 4, '/topic/subject', 'FolderOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/topic' AND parent_id = 0 LIMIT 1;

INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT '试卷管理', id, 5, '/topic/paper', 'FileDoneOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/topic' AND parent_id = 0 LIMIT 1;

-- 内容管理的子菜单
INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT '试卷记录', id, 1, '/content/paper', 'FileOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/content' AND parent_id = 0 LIMIT 1;

INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT '文章管理', id, 2, '/content/article', 'ReadOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/content' AND parent_id = 0 LIMIT 1;

INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT '翻译记录', id, 3, '/content/translation', 'TranslationOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/content' AND parent_id = 0 LIMIT 1;

INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT '词书管理', id, 4, '/content/wordbook', 'BookOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/content' AND parent_id = 0 LIMIT 1;

INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT '作文记录', id, 5, '/content/writing', 'EditOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/content' AND parent_id = 0 LIMIT 1;

-- PK管理的子菜单
INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT 'PK排行榜', id, 1, '/pk/rank', 'RankedListOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/pk' AND parent_id = 0 LIMIT 1;

INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT '对战记录', id, 2, '/pk/record', 'HistoryOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/pk' AND parent_id = 0 LIMIT 1;

-- 模型管理的子菜单
INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT 'AI管理', id, 1, '/ai/manage', 'RobotOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/ai' AND parent_id = 0 LIMIT 1;

INSERT INTO sys_menu (menu_name, parent_id, sorted, route, icon, create_time, update_time, is_deleted)
SELECT 'AI模型', id, 2, '/ai/model', 'SettingOutlined', NOW(), NOW(), 0 FROM sys_menu WHERE route = '/ai' AND parent_id = 0 LIMIT 1;

-- 第四步：关联管理员角色
INSERT INTO sys_role_menu (role_id, menu_id, create_time, update_time, is_deleted)
SELECT 1, id, NOW(), NOW(), 0 FROM sys_menu WHERE is_deleted = 0;

-- 验证
SELECT route, menu_name, parent_id FROM sys_menu WHERE is_deleted = 0 ORDER BY parent_id, sorted;
