-- 更新 word_book 表 type 字段注释，反映新的分类映射
ALTER TABLE `word_book` MODIFY COLUMN `type` tinyint NOT NULL COMMENT '1-初中 2-高中 3-四级 4-六级 5-考研 6-托福 7-SAT';
