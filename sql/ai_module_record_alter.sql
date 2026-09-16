SET NAMES utf8mb4;

-- ai_module_record 表增加业务关联字段
ALTER TABLE `ai_module_record`
  ADD COLUMN `business_id` bigint DEFAULT NULL COMMENT '关联业务ID（作文ID/翻译ID等）' AFTER `module_type`,
  ADD COLUMN `business_type` varchar(50) DEFAULT NULL COMMENT '业务类型（essay/translation/word/article）' AFTER `business_id`;
