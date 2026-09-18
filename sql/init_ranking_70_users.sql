SET NAMES utf8mb4;

-- ============================================
-- 初始化排行榜数据：70个用户 + 打卡记录
-- 用户ID: 101-170
-- ============================================

-- 1. 创建70个测试用户（如已存在则跳过）
INSERT IGNORE INTO sys_user (id, account, password, nickname, avatar, status, email, create_time, is_deleted, update_time)
VALUES
(101, 'user_101', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '张伟', '', 0, 'test101@test.com', NOW(), 0, NOW()),
(102, 'user_102', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '王芳', '', 0, 'test102@test.com', NOW(), 0, NOW()),
(103, 'user_103', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '李娜', '', 0, 'test103@test.com', NOW(), 0, NOW()),
(104, 'user_104', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '刘洋', '', 0, 'test104@test.com', NOW(), 0, NOW()),
(105, 'user_105', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '陈静', '', 0, 'test105@test.com', NOW(), 0, NOW()),
(106, 'user_106', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '杨磊', '', 0, 'test106@test.com', NOW(), 0, NOW()),
(107, 'user_107', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '赵敏', '', 0, 'test107@test.com', NOW(), 0, NOW()),
(108, 'user_108', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '黄强', '', 0, 'test108@test.com', NOW(), 0, NOW()),
(109, 'user_109', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '周婷', '', 0, 'test109@test.com', NOW(), 0, NOW()),
(110, 'user_110', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '吴刚', '', 0, 'test110@test.com', NOW(), 0, NOW()),
(111, 'user_111', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '郑丽', '', 0, 'test111@test.com', NOW(), 0, NOW()),
(112, 'user_112', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '孙超', '', 0, 'test112@test.com', NOW(), 0, NOW()),
(113, 'user_113', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '朱军', '', 0, 'test113@test.com', NOW(), 0, NOW()),
(114, 'user_114', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '马琳', '', 0, 'test114@test.com', NOW(), 0, NOW()),
(115, 'user_115', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '胡亮', '', 0, 'test115@test.com', NOW(), 0, NOW()),
(116, 'user_116', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '林峰', '', 0, 'test116@test.com', NOW(), 0, NOW()),
(117, 'user_117', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '何雪', '', 0, 'test117@test.com', NOW(), 0, NOW()),
(118, 'user_118', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '高翔', '', 0, 'test118@test.com', NOW(), 0, NOW()),
(119, 'user_119', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '罗晨', '', 0, 'test119@test.com', NOW(), 0, NOW()),
(120, 'user_120', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '梁宇', '', 0, 'test120@test.com', NOW(), 0, NOW()),
(121, 'user_121', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '宋佳', '', 0, 'test121@test.com', NOW(), 0, NOW()),
(122, 'user_122', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '唐鑫', '', 0, 'test122@test.com', NOW(), 0, NOW()),
(123, 'user_123', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '韩梅', '', 0, 'test123@test.com', NOW(), 0, NOW()),
(124, 'user_124', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '冯博', '', 0, 'test124@test.com', NOW(), 0, NOW()),
(125, 'user_125', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '董悦', '', 0, 'test125@test.com', NOW(), 0, NOW()),
(126, 'user_126', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '程鹏', '', 0, 'test126@test.com', NOW(), 0, NOW()),
(127, 'user_127', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '曹颖', '', 0, 'test127@test.com', NOW(), 0, NOW()),
(128, 'user_128', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '袁浩', '', 0, 'test128@test.com', NOW(), 0, NOW()),
(129, 'user_129', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '邓莎', '', 0, 'test129@test.com', NOW(), 0, NOW()),
(130, 'user_130', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '许涛', '', 0, 'test130@test.com', NOW(), 0, NOW()),
(131, 'user_131', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '傅琳', '', 0, 'test131@test.com', NOW(), 0, NOW()),
(132, 'user_132', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '沈鑫', '', 0, 'test132@test.com', NOW(), 0, NOW()),
(133, 'user_133', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '曾昊', '', 0, 'test133@test.com', NOW(), 0, NOW()),
(134, 'user_134', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '彭丹', '', 0, 'test134@test.com', NOW(), 0, NOW()),
(135, 'user_135', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '吕翔', '', 0, 'test135@test.com', NOW(), 0, NOW()),
(136, 'user_136', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '苏瑶', '', 0, 'test136@test.com', NOW(), 0, NOW()),
(137, 'user_137', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '卢威', '', 0, 'test137@test.com', NOW(), 0, NOW()),
(138, 'user_138', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '蒋倩', '', 0, 'test138@test.com', NOW(), 0, NOW()),
(139, 'user_139', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '蔡磊', '', 0, 'test139@test.com', NOW(), 0, NOW()),
(140, 'user_140', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '贾蓉', '', 0, 'test140@test.com', NOW(), 0, NOW()),
(141, 'user_141', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '丁辉', '', 0, 'test141@test.com', NOW(), 0, NOW()),
(142, 'user_142', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '魏蕾', '', 0, 'test142@test.com', NOW(), 0, NOW()),
(143, 'user_143', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '薛凯', '', 0, 'test143@test.com', NOW(), 0, NOW()),
(144, 'user_144', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '叶璇', '', 0, 'test144@test.com', NOW(), 0, NOW()),
(145, 'user_145', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '阎飞', '', 0, 'test145@test.com', NOW(), 0, NOW()),
(146, 'user_146', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '余佳', '', 0, 'test146@test.com', NOW(), 0, NOW()),
(147, 'user_147', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '潘睿', '', 0, 'test147@test.com', NOW(), 0, NOW()),
(148, 'user_148', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '杜蕾', '', 0, 'test148@test.com', NOW(), 0, NOW()),
(149, 'user_149', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '戴鹏', '', 0, 'test149@test.com', NOW(), 0, NOW()),
(150, 'user_150', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '夏颖', '', 0, 'test150@test.com', NOW(), 0, NOW()),
(151, 'user_151', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '钟华', '', 0, 'test151@test.com', NOW(), 0, NOW()),
(152, 'user_152', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '汪洋', '', 0, 'test152@test.com', NOW(), 0, NOW()),
(153, 'user_153', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '田丽', '', 0, 'test153@test.com', NOW(), 0, NOW()),
(154, 'user_154', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '任杰', '', 0, 'test154@test.com', NOW(), 0, NOW()),
(155, 'user_155', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '姜娜', '', 0, 'test155@test.com', NOW(), 0, NOW()),
(156, 'user_156', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '范明', '', 0, 'test156@test.com', NOW(), 0, NOW()),
(157, 'user_157', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '石悦', '', 0, 'test157@test.com', NOW(), 0, NOW()),
(158, 'user_158', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '姚明', '', 0, 'test158@test.com', NOW(), 0, NOW()),
(159, 'user_159', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '谭晶', '', 0, 'test159@test.com', NOW(), 0, NOW()),
(160, 'user_160', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '廖斌', '', 0, 'test160@test.com', NOW(), 0, NOW()),
(161, 'user_161', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '邹玲', '', 0, 'test161@test.com', NOW(), 0, NOW()),
(162, 'user_162', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '熊伟', '', 0, 'test162@test.com', NOW(), 0, NOW()),
(163, 'user_163', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '金鑫', '', 0, 'test163@test.com', NOW(), 0, NOW()),
(164, 'user_164', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '陆瑶', '', 0, 'test164@test.com', NOW(), 0, NOW()),
(165, 'user_165', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '孔飞', '', 0, 'test165@test.com', NOW(), 0, NOW()),
(166, 'user_166', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '白洁', '', 0, 'test166@test.com', NOW(), 0, NOW()),
(167, 'user_167', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '崔浩', '', 0, 'test167@test.com', NOW(), 0, NOW()),
(168, 'user_168', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '康宁', '', 0, 'test168@test.com', NOW(), 0, NOW()),
(169, 'user_169', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '秦爽', '', 0, 'test169@test.com', NOW(), 0, NOW()),
(170, 'user_170', '$2a$10$Ni32jdkBfwkc6a.WMgEiaOKVfuduf1ZAfPa6NmqG8JO7hSYnQAtPq', '江涛', '', 0, 'test170@test.com', NOW(), 0, NOW());

-- 2. 为所有用户分配角色（普通用户 role_id=2）
INSERT IGNORE INTO sys_user_role (user_id, role_id, create_time, update_time, is_deleted)
SELECT id, 2, NOW(), NOW(), 0
FROM sys_user
WHERE id BETWEEN 101 AND 170;

-- 3. 插入打卡记录（模拟不同连续打卡天数）
-- 连续打卡天数分布：20天x2人, 18天x2人, 15天x3人, 12天x5人, 10天x5人, 8天x8人, 5天x15人, 3天x15人, 1天x15人

-- 用户101: 连续打卡20天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 101, (10000 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19) d;

-- 用户102: 连续打卡20天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 102, (10200 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19) d;

-- 用户103: 连续打卡18天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 103, (10400 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17) d;

-- 用户104: 连续打卡18天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 104, (10600 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17) d;

-- 用户105: 连续打卡15天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 105, (10800 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14) d;

-- 用户106: 连续打卡15天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 106, (11000 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14) d;

-- 用户107: 连续打卡15天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 107, (11200 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14) d;

-- 用户108-112: 连续打卡12天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 108, (11400 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 109, (11600 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 110, (11800 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 111, (12000 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 112, (12200 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11) d;

-- 用户113-117: 连续打卡10天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 113, (12400 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 114, (12600 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 115, (12800 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 116, (13000 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 117, (13200 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) d;

-- 用户118-125: 连续打卡8天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 118, (13400 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 119, (13600 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 120, (13800 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 121, (14000 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 122, (14200 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 123, (14400 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 124, (14600 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 125, (14800 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) d;

-- 用户126-135: 连续打卡5天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 126, (15000 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 127, (15100 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 128, (15200 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 129, (15300 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 130, (15400 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 131, (15500 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 132, (15600 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 133, (15700 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 134, (15800 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 135, (15900 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) d;

-- 用户136-145: 连续打卡3天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 136, (16000 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 137, (16100 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 138, (16200 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 139, (16300 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 140, (16400 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 141, (16500 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 142, (16600 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 143, (16700 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 144, (16800 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 145, (16900 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2) d;

-- 用户146-155: 连续打卡2天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 146, (17000 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 147, (17100 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 148, (17200 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 149, (17300 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 150, (17400 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 151, (17500 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 152, (17600 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 153, (17700 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 154, (17800 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 155, (17900 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(CURDATE(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1) d;

-- 用户156-165: 连续打卡1天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 156, (18000 + w.rn), 1, 2, 3, 2, CURDATE(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 157, (18100 + w.rn), 1, 2, 3, 2, CURDATE(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 158, (18200 + w.rn), 1, 2, 3, 2, CURDATE(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 159, (18300 + w.rn), 1, 2, 3, 2, CURDATE(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 160, (18400 + w.rn), 1, 2, 3, 2, CURDATE(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 161, (18500 + w.rn), 1, 2, 3, 2, CURDATE(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 162, (18600 + w.rn), 1, 2, 3, 2, CURDATE(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 163, (18700 + w.rn), 1, 2, 3, 2, CURDATE(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 164, (18800 + w.rn), 1, 2, 3, 2, CURDATE(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 165, (18900 + w.rn), 1, 2, 3, 2, CURDATE(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w;

-- 用户166-170: 连续打卡1天（少量）
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 166, (19000 + w.rn), 1, 2, 3, 2, CURDATE(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3) w;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 167, (19100 + w.rn), 1, 2, 3, 2, CURDATE(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3) w;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 168, (19200 + w.rn), 1, 2, 3, 2, CURDATE(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3) w;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 169, (19300 + w.rn), 1, 2, 3, 2, CURDATE(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3) w;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 170, (19400 + w.rn), 1, 2, 3, 2, CURDATE(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3) w;

-- ============================================
-- 验证结果
-- ============================================
SELECT '===== 70个用户排行榜数据初始化完成 =====' AS message;
SELECT COUNT(DISTINCT user_id) AS total_users FROM user_word_record WHERE is_deleted = 0 AND status != 0;
SELECT user_id, nickname, COUNT(DISTINCT DATE(last_study_time)) AS streak_days
FROM user_word_record r
JOIN sys_user u ON r.user_id = u.id
WHERE r.is_deleted = 0 AND r.status != 0
GROUP BY user_id, nickname
ORDER BY streak_days DESC
LIMIT 20;
