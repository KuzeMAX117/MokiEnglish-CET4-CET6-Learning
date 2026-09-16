SET NAMES utf8mb4;

-- ============================================
-- 为70个用户添加打卡记录
-- 模拟不同的连续打卡天数（1-20天）
-- ============================================

-- 先清理旧数据
DELETE FROM user_word_record WHERE is_deleted = 0;

-- 用户1: 连续打卡20天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 1, (232 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19) d;

-- 用户16: 连续打卡18天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 16, (432 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17) d;

-- 用户17: 连续打卡16天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 17, (632 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15) d;

-- 用户18: 连续打卡15天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 18, (832 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14) d;

-- 用户101-110: 连续打卡14-5天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 101, (1032 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 102, (1232 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 103, (1432 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 104, (1632 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 105, (1832 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 106, (2032 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 107, (2232 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 108, (2432 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 109, (2632 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 110, (2832 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) d;

-- 用户111-120: 连续打卡4-1天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 111, (3032 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 112, (3232 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 113, (3432 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 114, (3632 + w.rn), 1, 2, 3, 2, NOW(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 115, (3642 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 116, (3842 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 117, (4042 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 118, (4242 + w.rn), 1, 2, 3, 2, NOW(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 119, (4252 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 120, (4452 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2) d;

-- 用户121-130: 连续打卡8-1天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 121, (4652 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 122, (4852 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 123, (5052 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 124, (5252 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 125, (5452 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 126, (5652 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 127, (5852 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 128, (6052 + w.rn), 1, 2, 3, 2, NOW(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 129, (6062 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 130, (6262 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6) d;

-- 用户131-140: 连续打卡12-3天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 131, (6462 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 132, (6662 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 133, (6862 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 134, (7062 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 135, (7262 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 136, (7462 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 137, (7662 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 138, (7862 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 139, (8062 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 140, (8262 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2) d;

-- 用户141-150: 连续打卡10-1天
INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 141, (8462 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 142, (8662 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 143, (8862 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 144, (9062 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 145, (9262 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 146, (9462 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 147, (9662 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2 UNION SELECT 3) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 148, (9862 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1 UNION SELECT 2) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 149, (10062 + d.day * 10 + w.rn), 1, 2, 3, 2, DATE_SUB(NOW(), INTERVAL d.day DAY), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w
CROSS JOIN (SELECT 0 AS day UNION SELECT 1) d;

INSERT IGNORE INTO user_word_record (user_id, word_id, book_id, status, proficiency, review_count, last_study_time, create_time, update_time)
SELECT 150, (10262 + w.rn), 1, 2, 3, 2, NOW(), NOW(), NOW()
FROM (SELECT 1 AS rn UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) w;

-- 验证
SELECT '===== 70个用户打卡数据插入完成 =====' AS message;
SELECT COUNT(DISTINCT user_id) AS total_users FROM user_word_record WHERE is_deleted = 0 AND status != 0;
SELECT user_id, nickname, COUNT(DISTINCT DATE(last_study_time)) AS streak_days
FROM user_word_record r
JOIN sys_user u ON r.user_id = u.id
WHERE r.is_deleted = 0 AND r.status != 0
GROUP BY user_id, nickname
ORDER BY streak_days DESC
LIMIT 20;
