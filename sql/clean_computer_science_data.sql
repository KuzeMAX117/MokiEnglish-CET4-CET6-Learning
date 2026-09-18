-- 清理计算机刷题相关数据
-- 此脚本将删除所有与计算机刷题相关的数据，保留英语学习相关内容

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

-- 1. 删除AI历史记录中的Java编程面试演示数据
DELETE FROM `ai_history` WHERE `id` IN (220, 221, 222, 223);

-- 2. 删除计算机刷题相关的分类数据
DELETE FROM `topic_category` WHERE `category_name` IN ('数据库', '后端', '前端', '后端框架', '12312311', '成色', '123123', '前端开发', 'Java色色');

-- 3. 删除计算机刷题相关的科目数据
DELETE FROM `topic_subject` WHERE `subject_name` IN (
    'Mysql', 'Java基础', '前端三件套', 'Spring', 'SpringBoot', 
    'Mybatis', 'SpringCloud', 'Java集合', 'Java多线程', 'Java锁机制', 
    'Redis', 'RabbitMQ', 'Java虚拟机'
);

-- 4. 删除计算机刷题相关的题目数据
-- 删除所有题目（因为当前所有题目都是计算机相关的）
DELETE FROM `topic`;

-- 5. 删除计算机刷题相关的标签数据
DELETE FROM `topic_label` WHERE `label_name` IN (
    'mysql', '数据库', 'java', 'Java基础', 'html', 'css', 
    'spring', 'springBoot', 'mybatis', 'mybatisPlus', 'springCloud', 
    '集合', '多线程', '锁', '虚拟机', 'redis', 'rabbitMq'
);

-- 6. 删除分类和科目的关联数据
DELETE FROM `topic_category_subject`;

-- 7. 删除科目和题目的关联数据
DELETE FROM `topic_subject_topic`;

-- 8. 删除标签和题目的关联数据
DELETE FROM `topic_label_topic`;

-- 9. 删除用户收藏的题目数据
DELETE FROM `topic_collection`;

-- 10. 删除每日题目数据
DELETE FROM `topic_daily_brush`;

-- 11. 删除每日暂存题目数据
DELETE FROM `topic_daily_staging`;

-- 12. 删除刷题记录数据
DELETE FROM `topic_record`;

-- 13. 删除题目收藏数据
DELETE FROM `topic_favorite`;

-- 14. 删除计算机刷题相关的菜单项
-- 删除题库管理及其子菜单
DELETE FROM `sys_menu` WHERE `id` IN (12, 13, 14, 15, 16);

-- 15. 删除菜单角色关系中的相关数据
DELETE FROM `sys_role_menu` WHERE `menu_id` IN (12, 13, 14, 15, 16);

-- 16. 重置自增ID（可选，根据需要）
-- ALTER TABLE `topic` AUTO_INCREMENT = 1;
-- ALTER TABLE `topic_category` AUTO_INCREMENT = 1;
-- ALTER TABLE `topic_subject` AUTO_INCREMENT = 1;
-- ALTER TABLE `topic_label` AUTO_INCREMENT = 1;

SET FOREIGN_KEY_CHECKS=1;

-- 完成清理
SELECT '计算机刷题数据清理完成' AS '清理结果';
