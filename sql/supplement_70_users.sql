-- ============================================
-- 批量补充70个用户的刷题记录数据
-- ============================================

-- 为测试用户101-170补充今天的刷题记录（70个用户）
INSERT INTO topic_record (user_id, nickname, topic_id, subject_id, count, topic_time, update_time)
VALUES 
-- 用户101-110 (活跃用户，刷题多)
(101, '小明', 61, 38, 50, CURDATE(), NOW()),
(102, '小红', 61, 38, 45, CURDATE(), NOW()),
(103, '小刚', 61, 38, 42, CURDATE(), NOW()),
(104, '小丽', 61, 38, 38, CURDATE(), NOW()),
(105, '小华', 61, 38, 35, CURDATE(), NOW()),
(106, '小强', 61, 38, 32, CURDATE(), NOW()),
(107, '小芳', 61, 38, 28, CURDATE(), NOW()),
(108, '小伟', 61, 38, 25, CURDATE(), NOW()),
(109, '小娜', 61, 38, 22, CURDATE(), NOW()),
(110, '小磊', 61, 38, 20, CURDATE(), NOW()),

-- 用户111-120 (中等活跃)
(111, '小雪', 61, 38, 18, CURDATE(), NOW()),
(112, '小龙', 61, 38, 16, CURDATE(), NOW()),
(113, '小凤', 61, 38, 15, CURDATE(), NOW()),
(114, '小虎', 61, 38, 14, CURDATE(), NOW()),
(115, '小燕', 61, 38, 13, CURDATE(), NOW()),
(116, '小鹏', 61, 38, 12, CURDATE(), NOW()),
(117, '小静', 61, 38, 11, CURDATE(), NOW()),
(118, '小军', 61, 38, 10, CURDATE(), NOW()),
(119, '小琳', 61, 38, 9, CURDATE(), NOW()),
(120, '小峰', 61, 38, 8, CURDATE(), NOW()),

-- 用户121-130 (一般活跃)
(121, '小云', 61, 38, 7, CURDATE(), NOW()),
(122, '小波', 61, 38, 7, CURDATE(), NOW()),
(123, '小晶', 61, 38, 6, CURDATE(), NOW()),
(124, '小杰', 61, 38, 6, CURDATE(), NOW()),
(125, '小洁', 61, 38, 5, CURDATE(), NOW()),
(126, '小斌', 61, 38, 5, CURDATE(), NOW()),
(127, '小慧', 61, 38, 4, CURDATE(), NOW()),
(128, '小亮', 61, 38, 4, CURDATE(), NOW()),
(129, '小超', 61, 38, 3, CURDATE(), NOW()),
(130, '小蕾', 61, 38, 3, CURDATE(), NOW()),

-- 用户131-140
(131, '小翔', 61, 38, 3, CURDATE(), NOW()),
(132, '小菲', 61, 38, 2, CURDATE(), NOW()),
(133, '小睿', 61, 38, 2, CURDATE(), NOW()),
(134, '小瑶', 61, 38, 2, CURDATE(), NOW()),
(135, '小豪', 61, 38, 2, CURDATE(), NOW()),
(136, '小欣', 61, 38, 1, CURDATE(), NOW()),
(137, '小毅', 61, 38, 1, CURDATE(), NOW()),
(138, '小婷', 61, 38, 1, CURDATE(), NOW()),
(139, '小楠', 61, 38, 1, CURDATE(), NOW()),
(140, '小威', 61, 38, 1, CURDATE(), NOW()),

-- 用户141-150
(141, '小妮', 61, 38, 1, CURDATE(), NOW()),
(142, '小博', 61, 38, 1, CURDATE(), NOW()),
(143, '小雅', 61, 38, 1, CURDATE(), NOW()),
(144, '小森', 61, 38, 1, CURDATE(), NOW()),
(145, '小柠', 61, 38, 1, CURDATE(), NOW()),
(146, '小泽', 61, 38, 1, CURDATE(), NOW()),
(147, '小茜', 61, 38, 1, CURDATE(), NOW()),
(148, '小枫', 61, 38, 1, CURDATE(), NOW()),
(149, '小滢', 61, 38, 1, CURDATE(), NOW()),
(150, '小楷', 61, 38, 1, CURDATE(), NOW()),

-- 用户151-160
(151, '小依', 61, 38, 1, CURDATE(), NOW()),
(152, '小骏', 61, 38, 1, CURDATE(), NOW()),
(153, '小湘', 61, 38, 1, CURDATE(), NOW()),
(154, '小雨', 61, 38, 1, CURDATE(), NOW()),
(155, '小霓', 61, 38, 1, CURDATE(), NOW()),
(156, '小霏', 61, 38, 1, CURDATE(), NOW()),
(157, '小霖', 61, 38, 1, CURDATE(), NOW()),
(158, '小霁', 61, 38, 1, CURDATE(), NOW()),
(159, '小靓', 61, 38, 1, CURDATE(), NOW()),
(160, '小颢', 61, 38, 1, CURDATE(), NOW()),

-- 用户161-170
(161, '小颜', 61, 38, 1, CURDATE(), NOW()),
(162, '小晨', 61, 38, 1, CURDATE(), NOW()),
(163, '小铄', 61, 38, 1, CURDATE(), NOW()),
(164, '小曦', 61, 38, 1, CURDATE(), NOW()),
(165, '小rock', 61, 38, 1, CURDATE(), NOW()),
(166, '小fang', 61, 38, 1, CURDATE(), NOW()),
(167, '小lin', 61, 38, 1, CURDATE(), NOW()),
(168, '小jun', 61, 38, 1, CURDATE(), NOW()),
(169, '小hao', 61, 38, 1, CURDATE(), NOW()),
(170, '小hua', 61, 38, 1, CURDATE(), NOW());

-- 同时给这些用户创建角色（普通用户role_id=2）
INSERT IGNORE INTO sys_user_role (user_id, role_id, create_time, update_time, is_deleted)
SELECT id, 2, NOW(), NOW(), 0
FROM sys_user
WHERE id BETWEEN 101 AND 170;

-- 完成！
SELECT '70个用户刷题记录补充完成！' AS message;
SELECT COUNT(DISTINCT user_id) AS total_users FROM topic_record WHERE topic_time = CURDATE();
