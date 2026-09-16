SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- 用户生词本（阅读收藏）表
-- 用户级全局生词本，独立于具体文章；收藏时快照单词释义，
-- 保证即使词典未收录（如 AI 短文生僻词）也能稳定展示。
-- ----------------------------
DROP TABLE IF EXISTS `user_word_collection`;
CREATE TABLE `user_word_collection` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `word` varchar(100) NOT NULL COMMENT '单词（小写）',
  `phonetic` varchar(100) DEFAULT NULL COMMENT '音标快照',
  `meaning` text COMMENT '释义快照',
  `example` text COMMENT '例句快照',
  `example_translate` text COMMENT '例句翻译快照',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT 0 COMMENT '是否删除 0-否 1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_word` (`user_id`,`word`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户生词本（阅读收藏）表';

SET FOREIGN_KEY_CHECKS=1;
