-- ============================================
-- 补充排行榜刷题记录数据
-- 为现有用户创建今天的刷题记录，让排行榜有数据
-- ============================================

-- 1. 为admin用户(1)补充今天的刷题记录
INSERT INTO topic_record (user_id, nickname, topic_id, subject_id, count, topic_time, update_time)
VALUES 
(1, 'Admin', 61, 38, 15, CURDATE(), NOW()),
(1, 'Admin', 62, 38, 12, CURDATE(), NOW()),
(1, 'Admin', 63, 38, 10, CURDATE(), NOW()),
(1, 'Admin', 72, 39, 8, CURDATE(), NOW()),
(1, 'Admin', 73, 39, 6, CURDATE(), NOW());

-- 2. 为Member用户(16)补充今天的刷题记录
INSERT INTO topic_record (user_id, nickname, topic_id, subject_id, count, topic_time, update_time)
VALUES 
(16, 'Member', 61, 38, 20, CURDATE(), NOW()),
(16, 'Member', 62, 38, 18, CURDATE(), NOW()),
(16, 'Member', 63, 38, 14, CURDATE(), NOW()),
(16, 'Member', 72, 39, 12, CURDATE(), NOW()),
(16, 'Member', 73, 39, 10, CURDATE(), NOW());

-- 3. 为Y用户(17)补充今天的刷题记录
INSERT INTO topic_record (user_id, nickname, topic_id, subject_id, count, topic_time, update_time)
VALUES 
(17, 'Y', 61, 38, 8, CURDATE(), NOW()),
(17, 'Y', 62, 38, 6, CURDATE(), NOW()),
(17, 'Y', 63, 38, 5, CURDATE(), NOW());

-- 4. 为测试用户101-110补充今天的刷题记录（模拟活跃用户）
INSERT INTO topic_record (user_id, nickname, topic_id, subject_id, count, topic_time, update_time)
VALUES 
(101, '小明', 61, 38, 25, CURDATE(), NOW()),
(101, '小明', 62, 38, 22, CURDATE(), NOW()),
(102, '小红', 61, 38, 30, CURDATE(), NOW()),
(102, '小红', 63, 38, 28, CURDATE(), NOW()),
(103, '小刚', 61, 38, 18, CURDATE(), NOW()),
(103, '小刚', 72, 39, 15, CURDATE(), NOW()),
(104, '小丽', 61, 38, 35, CURDATE(), NOW()),
(104, '小丽', 62, 38, 32, CURDATE(), NOW()),
(105, '小华', 61, 38, 12, CURDATE(), NOW()),
(106, '小强', 61, 38, 40, CURDATE(), NOW()),
(106, '小强', 63, 38, 38, CURDATE(), NOW()),
(107, '小芳', 61, 38, 8, CURDATE(), NOW()),
(108, '小伟', 61, 38, 28, CURDATE(), NOW()),
(108, '小伟', 72, 39, 25, CURDATE(), NOW()),
(109, '小娜', 61, 38, 15, CURDATE(), NOW()),
(110, '小磊', 61, 38, 45, CURDATE(), NOW()),
(110, '小磊', 62, 38, 42, CURDATE(), NOW());

-- 5. 为测试用户111-120补充今天的刷题记录（模拟中等活跃用户）
INSERT INTO topic_record (user_id, nickname, topic_id, subject_id, count, topic_time, update_time)
VALUES 
(111, '小雪', 61, 38, 10, CURDATE(), NOW()),
(112, '小龙', 61, 38, 22, CURDATE(), NOW()),
(113, '小凤', 61, 38, 5, CURDATE(), NOW()),
(114, '小虎', 61, 38, 32, CURDATE(), NOW()),
(115, '小燕', 61, 38, 18, CURDATE(), NOW()),
(116, '小鹏', 61, 38, 28, CURDATE(), NOW()),
(117, '小静', 61, 38, 12, CURDATE(), NOW()),
(118, '小军', 61, 38, 38, CURDATE(), NOW()),
(119, '小琳', 61, 38, 8, CURDATE(), NOW()),
(120, '小峰', 61, 38, 25, CURDATE(), NOW());

-- 6. 为测试用户121-130补充昨天的刷题记录（模拟历史数据）
INSERT INTO topic_record (user_id, nickname, topic_id, subject_id, count, topic_time, update_time)
VALUES 
(121, '小云', 61, 38, 20, DATE_SUB(CURDATE(), INTERVAL 1 DAY), NOW()),
(122, '小波', 61, 38, 15, DATE_SUB(CURDATE(), INTERVAL 1 DAY), NOW()),
(123, '小晶', 61, 38, 25, DATE_SUB(CURDATE(), INTERVAL 1 DAY), NOW()),
(124, '小杰', 61, 38, 30, DATE_SUB(CURDATE(), INTERVAL 1 DAY), NOW()),
(125, '小洁', 61, 38, 18, DATE_SUB(CURDATE(), INTERVAL 1 DAY), NOW()),
(126, '小斌', 61, 38, 35, DATE_SUB(CURDATE(), INTERVAL 1 DAY), NOW()),
(127, '小慧', 61, 38, 12, DATE_SUB(CURDATE(), INTERVAL 1 DAY), NOW()),
(128, '小亮', 61, 38, 40, DATE_SUB(CURDATE(), INTERVAL 1 DAY), NOW()),
(129, '小超', 61, 38, 8, DATE_SUB(CURDATE(), INTERVAL 1 DAY), NOW()),
(130, '小蕾', 61, 38, 28, DATE_SUB(CURDATE(), INTERVAL 1 DAY), NOW());

-- 完成！
SELECT '刷题记录数据补充完成！' AS message;
SELECT COUNT(*) AS total_records_today FROM topic_record WHERE topic_time = CURDATE();
SELECT COUNT(*) AS total_records_yesterday FROM topic_record WHERE topic_time = DATE_SUB(CURDATE(), INTERVAL 1 DAY);
