

ALTER TABLE `topic`
    ADD COLUMN `options` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '选择题选项JSON [{label:"A",content:"..."}]' AFTER `ai_answer`,
    ADD COLUMN `correct_option` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '选择题正确选项 如A/B/C/D',
    ADD COLUMN `question_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '题目类型 writing/listening/reading/cloze/translation/vocabulary',
    ADD COLUMN `analysis` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '题目解析';

ALTER TABLE `topic_record`
    ADD COLUMN `paper_id` bigint DEFAULT NULL COMMENT '试卷id（真题卷作答时记录）',
    ADD COLUMN `selected` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '用户选择的选项',
    ADD COLUMN `correct` tinyint DEFAULT NULL COMMENT '是否答对 0错 1对';

CREATE TABLE `paper` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '试卷id',
  `level` tinyint NOT NULL COMMENT '级别 4四级 6六级',
  `exam_year` int NOT NULL COMMENT '考试年份',
  `exam_half` tinyint NOT NULL DEFAULT '1' COMMENT '1上半年 2下半年',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '试卷名称',
  `total_score` bigint DEFAULT '710' COMMENT '总分',
  `status` tinyint DEFAULT '0' COMMENT '0正常 1停用',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_level_year_half` (`level`,`exam_year`,`exam_half`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='真题试卷';

CREATE TABLE `paper_topic` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `paper_id` bigint NOT NULL COMMENT '试卷id',
  `topic_id` bigint NOT NULL COMMENT '题目id',
  `section` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '部分 writing/listening/reading/translation',
  `sorted` bigint DEFAULT '0' COMMENT '卷内题序',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_paper_id` (`paper_id`,`sorted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='试卷题目关联';

INSERT INTO `topic` (`topic_name`, `answer`, `options`, `correct_option`, `question_type`, `analysis`, `status`, `create_by`) VALUES
('【听力】What does the woman suggest the man do?', 'A. Take the presentation seriously. B. Prepare it with his teammates. C. Ask his professor for advice. D. Postpone it to next week.',
 '[{"label":"A","content":"Take the presentation seriously."},{"label":"B","content":"Prepare it with his teammates."},{"label":"C","content":"Ask his professor for advice."},{"label":"D","content":"Postpone it to next week."}]',
 'B', 'listening', '对话中女士建议男士和组员一起准备，故选B。', '0', 'admin'),
('【听力】What do we learn about the new library?', 'A. It will open ahead of schedule. B. It is the largest on campus. C. It costs far more than planned. D. It has run short of reading rooms.',
 '[{"label":"A","content":"It will open ahead of schedule."},{"label":"B","content":"It is the largest on campus."},{"label":"C","content":"It costs far more than planned."},{"label":"D","content":"It has run short of reading rooms."}]',
 'A', 'listening', '新闻提到新图书馆将提前开放，故选A。', '0', 'admin'),
('【阅读】The word "undermine" in Paragraph 2 is closest in meaning to ______.', 'A. strengthen B. weaken C. ignore D. support',
 '[{"label":"A","content":"strengthen"},{"label":"B","content":"weaken"},{"label":"C","content":"ignore"},{"label":"D","content":"support"}]',
 'B', 'reading', 'undermine 意为"削弱"，与 weaken 同义，故选B。', '0', 'admin'),
('【阅读】According to the passage, remote work may ______.', 'A. reduce employees'' loyalty B. blur the boundary of work and life C. increase office expenses D. improve face-to-face communication',
 '[{"label":"A","content":"reduce employees'' loyalty"},{"label":"B","content":"blur the boundary of work and life"},{"label":"C","content":"increase office expenses"},{"label":"D","content":"improve face-to-face communication"}]',
 'B', 'reading', '文章指出远程办公模糊了工作与生活的界限，故选B。', '0', 'admin'),
('【词汇】The committee reached a ______ decision after hours of debate.', 'A. unanimous B. anonymous C. enormous D. generous',
 '[{"label":"A","content":"unanimous"},{"label":"B","content":"anonymous"},{"label":"C","content":"enormous"},{"label":"D","content":"generous"}]',
 'A', 'vocabulary', 'unanimous decision 意为"一致的决定"，故选A。', '0', 'admin');

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (4, 2025, 2, '2025年下半年大学英语四级真题（第一套）', 710);

INSERT INTO topic (topic_name, answer, options, correct_option, question_type, analysis, status, create_by) VALUES
('【听力】What does the woman suggest the man do?', 'A. Take the presentation seriously. B. Prepare it with his teammates. C. Ask his professor for advice. D. Postpone it to next week.',
 '[{"label":"A","content":"Take the presentation seriously."},{"label":"B","content":"Prepare it with his teammates."},{"label":"C","content":"Ask his professor for advice."},{"label":"D","content":"Postpone it to next week."}]',
 'B', 'listening', '对话中女士建议男士和组员一起准备，故选B。', '0', 'admin');

INSERT INTO topic (topic_name, answer, options, correct_option, question_type, analysis, status, create_by) VALUES
('【听力】What do we learn about the new library?', 'A. It will open ahead of schedule. B. It is the largest on campus. C. It costs far more than planned. D. It has run short of reading rooms.',
 '[{"label":"A","content":"It will open ahead of schedule."},{"label":"B","content":"It is the largest on campus."},{"label":"C","content":"It costs far more than planned."},{"label":"D","content":"It has run short of reading rooms."}]',
 'A', 'listening', '新闻提到新图书馆将提前开放，故选A。', '0', 'admin');

INSERT INTO topic (topic_name, answer, options, correct_option, question_type, analysis, status, create_by) VALUES
('【阅读】"Undermine" means to ______.', 'A. strengthen B. weaken C. ignore D. support',
 '[{"label":"A","content":"strengthen"},{"label":"B","content":"weaken"},{"label":"C","content":"ignore"},{"label":"D","content":"support"}]',
 'B', 'reading', 'undermine 意为"削弱"，与 weaken 同义，故选B。', '0', 'admin');

INSERT INTO topic (topic_name, answer, options, correct_option, question_type, analysis, status, create_by) VALUES
('【阅读】Remote work may ______.', 'A. reduce employees'' loyalty B. blur the boundary of work and life C. increase office expenses D. improve face-to-face communication',
 '[{"label":"A","content":"reduce employees'' loyalty"},{"label":"B","content":"blur the boundary of work and life"},{"label":"C","content":"increase office expenses"},{"label":"D","content":"improve face-to-face communication"}]',
 'B', 'reading', '文章指出远程办公模糊了工作与生活的界限，故选B。', '0', 'admin');

INSERT INTO topic (topic_name, answer, options, correct_option, question_type, analysis, status, create_by) VALUES
('【词汇】The committee reached a ______ decision.', 'A. unanimous B. anonymous C. enormous D. generous',
 '[{"label":"A","content":"unanimous"},{"label":"B","content":"anonymous"},{"label":"C","content":"enormous"},{"label":"D","content":"generous"}]',
 'A', 'vocabulary', 'unanimous decision 意为"一致的决定"，故选A。', '0', 'admin');

INSERT INTO paper (level, exam_year, exam_half, title, total_score) VALUES (4, 2025, 2, '2025年下半年大学英语四级真题（第一套）', 710);

INSERT INTO paper_topic (paper_id, topic_id, section, sorted)
SELECT 1, t.id, t.question_type, t.id
FROM topic t WHERE t.create_by = 'admin' AND t.question_type IS NOT NULL;
