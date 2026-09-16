ALTER TABLE `word_item`
  ADD COLUMN `syllable_word` varchar(128) DEFAULT NULL COMMENT '带间隔点音节，例如 ap·ple',
  MODIFY COLUMN `example` longtext COMMENT '例句，对背诵单词进行下划线标注';
