-- AI模块使用记录表
-- 用于统计每个模块（背单词、作文、翻译）的使用次数

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `ai_module_record`;
CREATE TABLE `ai_module_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `nickname` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '用户昵称',
  `module_type` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '模块类型：word-背单词，essay-作文，translation-翻译',
  `count` bigint DEFAULT 1 COMMENT '使用次数',
  `record_date` date DEFAULT (curdate()) COMMENT '记录日期',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_module_date` (`user_id`, `module_type`, `record_date`),
  KEY `idx_module_type` (`module_type`),
  KEY `idx_record_date` (`record_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='AI模块使用记录表';

SET FOREIGN_KEY_CHECKS = 1;