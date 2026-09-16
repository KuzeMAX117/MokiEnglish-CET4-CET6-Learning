-- PK用户等级表
CREATE TABLE `pk_user_level` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `level` int NOT NULL DEFAULT 1 COMMENT '等级 1-4: 1=初学者 2=进阶者 3=挑战者 4=大师',
  `score` int NOT NULL DEFAULT 0 COMMENT '累计积分',
  `total_games` int NOT NULL DEFAULT 0 COMMENT '总场次',
  `wins` int NOT NULL DEFAULT 0 COMMENT '胜场',
  `win_streak` int NOT NULL DEFAULT 0 COMMENT '当前连胜',
  `max_win_streak` int NOT NULL DEFAULT 0 COMMENT '最大连胜',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_id` (`user_id`),
  KEY `idx_level` (`level`),
  KEY `idx_score` (`score`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='PK用户等级表';

-- 等级说明:
-- Lv1 初学者 (score 0-99):    四级基础词汇 (book_id=3, 随机简单词)
-- Lv2 进阶者 (score 100-299): 四级核心词汇 (book_id=3, 高频词)
-- Lv3 挑战者 (score 300-599): 六级词汇     (book_id=4)
-- Lv4 大师   (score 600+):    六级+考研词汇 (book_id=4/5 混合)
