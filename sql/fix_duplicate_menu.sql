-- ============================================
-- 修复菜单重复数据（兼容MySQL 5.7/8.0）
-- ============================================

-- ========== 第一步：诊断 ==========
SELECT '=== 当前顶级菜单 ===' AS info;
SELECT id, menu_name, route, parent_id, sorted FROM sys_menu
WHERE is_deleted = 0 AND parent_id = 0 ORDER BY sorted, id;

SELECT '=== 重复检查 ===' AS info;
SELECT menu_name, route, COUNT(*) as cnt FROM sys_menu
WHERE is_deleted = 0 GROUP BY menu_name, route HAVING cnt > 1;

-- ========== 第二步：找保留的父菜单ID ==========
SET @keep_content_id = (SELECT min_id FROM (SELECT MIN(id) AS min_id FROM sys_menu WHERE route = '/content' AND parent_id = 0 AND is_deleted = 0) AS t);
SET @keep_pk_id = (SELECT min_id FROM (SELECT MIN(id) AS min_id FROM sys_menu WHERE route = '/pk' AND parent_id = 0 AND is_deleted = 0) AS t);

SELECT @keep_content_id AS content_id, @keep_pk_id AS pk_id;

-- ========== 第三步：修复子菜单parent_id ==========
-- 内容管理子菜单：指向保留的父菜单
UPDATE sys_menu SET parent_id = @keep_content_id
WHERE route IN ('/content/paper', '/content/wordbook', '/content/article', '/content/writing', '/content/translation')
  AND is_deleted = 0
  AND parent_id != @keep_content_id
  AND parent_id IN (
    SELECT id FROM (SELECT id FROM sys_menu WHERE route = '/content' AND parent_id = 0 AND is_deleted = 0) AS tmp
  );

-- PK管理子菜单：指向保留的父菜单
UPDATE sys_menu SET parent_id = @keep_pk_id
WHERE route IN ('/pk/rank', '/pk/record')
  AND is_deleted = 0
  AND parent_id != @keep_pk_id
  AND parent_id IN (
    SELECT id FROM (SELECT id FROM sys_menu WHERE route = '/pk' AND parent_id = 0 AND is_deleted = 0) AS tmp
  );

-- ========== 第四步：删除重复父菜单 ==========
DELETE FROM sys_menu WHERE id IN (
  SELECT del_id FROM (
    SELECT MAX(id) AS del_id FROM sys_menu
    WHERE route IN ('/content', '/pk') AND parent_id = 0 AND is_deleted = 0
    GROUP BY route HAVING COUNT(*) > 1
  ) AS tmp
);

-- ========== 第五步：删除孤儿子菜单 ==========
DELETE FROM sys_menu WHERE id IN (
  SELECT orphan_id FROM (
    SELECT m.id AS orphan_id FROM sys_menu m
    WHERE m.is_deleted = 0 AND m.parent_id != 0
      AND NOT EXISTS (SELECT 1 FROM sys_menu p WHERE p.id = m.parent_id AND p.is_deleted = 0)
  ) AS tmp
);

-- ========== 第六步：清理sys_role_menu无效关联 ==========
DELETE FROM sys_role_menu WHERE id IN (
  SELECT del_id FROM (
    SELECT rm.id AS del_id FROM sys_role_menu rm
    WHERE rm.is_deleted = 0
      AND NOT EXISTS (SELECT 1 FROM sys_menu m WHERE m.id = rm.menu_id AND m.is_deleted = 0)
  ) AS tmp
);

-- ========== 第七步：确保管理员角色关联完整 ==========
INSERT INTO sys_role_menu (role_id, menu_id, create_time, update_time, is_deleted)
SELECT 1, m.id, NOW(), NOW(), 0
FROM sys_menu m
WHERE m.route IN ('/content', '/content/paper', '/content/wordbook', '/content/article', '/content/writing', '/content/translation')
  AND m.is_deleted = 0
  AND NOT EXISTS (
    SELECT 1 FROM (SELECT menu_id FROM sys_role_menu WHERE role_id = 1 AND is_deleted = 0) AS tmp
    WHERE tmp.menu_id = m.id
  );

INSERT INTO sys_role_menu (role_id, menu_id, create_time, update_time, is_deleted)
SELECT 1, m.id, NOW(), NOW(), 0
FROM sys_menu m
WHERE m.route IN ('/pk', '/pk/rank', '/pk/record')
  AND m.is_deleted = 0
  AND NOT EXISTS (
    SELECT 1 FROM (SELECT menu_id FROM sys_role_menu WHERE role_id = 1 AND is_deleted = 0) AS tmp
    WHERE tmp.menu_id = m.id
  );

-- ========== 第八步：验证 ==========
SELECT '=== 修复后顶级菜单 ===' AS info;
SELECT id, menu_name, route, parent_id, sorted FROM sys_menu
WHERE is_deleted = 0 AND parent_id = 0 ORDER BY sorted, id;

SELECT '=== 修复后内容管理子菜单 ===' AS info;
SELECT id, menu_name, route, parent_id, sorted FROM sys_menu
WHERE is_deleted = 0 AND parent_id = @keep_content_id ORDER BY sorted;

SELECT '=== 修复后PK管理子菜单 ===' AS info;
SELECT id, menu_name, route, parent_id, sorted FROM sys_menu
WHERE is_deleted = 0 AND parent_id = @keep_pk_id ORDER BY sorted;

SELECT '=== 重复检查（应为空） ===' AS info;
SELECT menu_name, route, COUNT(*) as cnt FROM sys_menu
WHERE is_deleted = 0 GROUP BY menu_name, route HAVING cnt > 1;
