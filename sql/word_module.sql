SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- 词书表
-- ----------------------------
DROP TABLE IF EXISTS `word_book`;
CREATE TABLE `word_book` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '词书ID',
  `name` varchar(50) NOT NULL COMMENT '词书名称',
  `type` tinyint NOT NULL COMMENT '1-四级单词 2-六级单词 3-四级词组 4-六级词组',
  `total_count` int DEFAULT 0 COMMENT '单词总数',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT 0 COMMENT '是否删除 0-否 1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='词书表';

-- ----------------------------
-- 单词表
-- ----------------------------
DROP TABLE IF EXISTS `word_item`;
CREATE TABLE `word_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '单词ID',
  `book_id` bigint NOT NULL COMMENT '词书ID',
  `word` varchar(100) NOT NULL COMMENT '单词/词组',
  `phonetic` varchar(100) DEFAULT NULL COMMENT '音标',
  `meaning` text COMMENT '释义',
  `example` text COMMENT '例句',
  `example_translate` text COMMENT '例句翻译',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT 0 COMMENT '是否删除 0-否 1-是',
  PRIMARY KEY (`id`),
  KEY `idx_book_id` (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='单词表';

-- ----------------------------
-- 用户词书配置表
-- ----------------------------
DROP TABLE IF EXISTS `user_word_setting`;
CREATE TABLE `user_word_setting` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `book_id` bigint NOT NULL COMMENT '当前选择的词书ID',
  `daily_count` int DEFAULT 20 COMMENT '每日背诵数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT 0 COMMENT '是否删除 0-否 1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户词书配置表';

-- ----------------------------
-- 用户背单词记录表
-- ----------------------------
DROP TABLE IF EXISTS `user_word_record`;
CREATE TABLE `user_word_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `word_id` bigint NOT NULL COMMENT '单词ID',
  `book_id` bigint NOT NULL COMMENT '词书ID',
  `status` tinyint DEFAULT 0 COMMENT '0-未学 1-学习中 2-已掌握 3-需复习',
  `proficiency` tinyint DEFAULT 0 COMMENT '熟练度 0-5',
  `next_review_time` datetime DEFAULT NULL COMMENT '下次复习时间',
  `review_count` int DEFAULT 0 COMMENT '复习次数',
  `last_study_time` datetime DEFAULT NULL COMMENT '最后学习时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT 0 COMMENT '是否删除 0-否 1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_word` (`user_id`,`word_id`),
  KEY `idx_user_book_status` (`user_id`,`book_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户背单词记录表';

-- ----------------------------
-- 初始化词书数据
-- ----------------------------
INSERT INTO `word_book` (`name`, `type`, `total_count`) VALUES
('四级单词', 1, 0),
('六级单词', 2, 0),
('四级词组', 3, 0),
('六级词组', 4, 0);
