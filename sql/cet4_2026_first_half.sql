-- =====================================================
-- 2026年上半年大学英语四级真题（第一套）数据
-- 本脚本可重复执行（幂等）：重复执行会先清理本试卷旧数据再重新插入
-- =====================================================

-- ---------- 0. 表结构变更（幂等） ----------
-- topic_name 扩展为 varchar(2000)（原表为 varchar(50)，若列上有索引需先删除索引）
ALTER TABLE `topic` MODIFY COLUMN `topic_name` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '题目名称';

SET @has_article = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='topic' AND column_name='article');
SET @sql = IF(@has_article=0, 'ALTER TABLE `topic` ADD COLUMN `article` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT ''文章/听力原文'' AFTER `analysis`', 'SELECT 1');
PREPARE st FROM @sql; EXECUTE st; DEALLOCATE PREPARE st;

SET @has_sub = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='paper_topic' AND column_name='sub_section');
SET @sql = IF(@has_sub=0, 'ALTER TABLE `paper_topic` ADD COLUMN `sub_section` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT ''子部分 如reading_1/listening_news'' AFTER `section`', 'SELECT 1');
PREPARE st FROM @sql; EXECUTE st; DEALLOCATE PREPARE st;

-- ---------- 0.1 幂等清理：删除本试卷（2026上半年）旧关联与旧题目 ----------
-- 仅清理 topic_record 无作答记录的题目，避免误删用户作答数据
SET @old_pid = (SELECT id FROM `paper` WHERE `level`=4 AND `exam_year`=2026 AND `exam_half`=1 LIMIT 1);
DROP TEMPORARY TABLE IF EXISTS tmp_old_topic;
CREATE TEMPORARY TABLE tmp_old_topic AS SELECT topic_id FROM `paper_topic` WHERE paper_id = @old_pid;
DELETE FROM `paper_topic` WHERE paper_id = @old_pid;
DELETE t FROM `topic` t JOIN tmp_old_topic o ON t.id = o.topic_id
WHERE NOT EXISTS (SELECT 1 FROM `topic_record` r WHERE r.topic_id = t.id AND r.paper_id = @old_pid);
DROP TEMPORARY TABLE IF EXISTS tmp_old_topic;

-- 清理孤儿题目（本脚本插入但未被 paper_topic 关联的历史残留），不影响其它数据
DELETE t FROM `topic` t
LEFT JOIN `paper_topic` pt ON pt.topic_id = t.id
LEFT JOIN `topic_record` r ON r.topic_id = t.id
WHERE t.create_by = 'admin' AND pt.id IS NULL AND r.id IS NULL
  AND (t.topic_name LIKE 'Q1:%' OR t.topic_name LIKE 'Q2:%' OR t.topic_name LIKE 'Q3:%' OR t.topic_name LIKE 'Q4:%' OR t.topic_name LIKE 'Q5:%'
    OR t.topic_name LIKE 'Q6:%' OR t.topic_name LIKE 'Q7:%' OR t.topic_name LIKE 'Q8:%' OR t.topic_name LIKE 'Q9:%' OR t.topic_name LIKE 'Q10:%'
    OR t.topic_name LIKE '26.%' OR t.topic_name LIKE '27.%' OR t.topic_name LIKE '28.%' OR t.topic_name LIKE '29.%' OR t.topic_name LIKE '30.%'
    OR t.topic_name LIKE '31.%' OR t.topic_name LIKE '32.%' OR t.topic_name LIKE '33.%' OR t.topic_name LIKE '34.%' OR t.topic_name LIKE '35.%'
    OR t.topic_name LIKE '36.%' OR t.topic_name LIKE '37.%' OR t.topic_name LIKE '38.%' OR t.topic_name LIKE '39.%' OR t.topic_name LIKE '40.%'
    OR t.topic_name LIKE '41.%' OR t.topic_name LIKE '42.%' OR t.topic_name LIKE '43.%' OR t.topic_name LIKE '44.%' OR t.topic_name LIKE '45.%'
    OR t.topic_name LIKE '46.%' OR t.topic_name LIKE '47.%' OR t.topic_name LIKE '48.%' OR t.topic_name LIKE '49.%' OR t.topic_name LIKE '50.%'
    OR t.topic_name LIKE '51.%' OR t.topic_name LIKE '52.%' OR t.topic_name LIKE '53.%' OR t.topic_name LIKE '54.%' OR t.topic_name LIKE '55.%'
    OR t.topic_name LIKE 'Directions:%' OR t.topic_name LIKE 'Translate the following%');

-- =====================================================
-- 1. 插入试卷（已存在则跳过）
-- =====================================================
INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`)
SELECT 4, 2026, 1, '2026年上半年大学英语四级真题（第一套）', 710
WHERE NOT EXISTS (SELECT 1 FROM `paper` WHERE `level`=4 AND `exam_year`=2026 AND `exam_half`=1);
SET @pid = (SELECT id FROM `paper` WHERE `level`=4 AND `exam_year`=2026 AND `exam_half`=1 LIMIT 1);

-- =====================================================
-- 2. 写作 (1题)
-- =====================================================
INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES
('Directions: Suppose the university newspaper is inviting submissions from students about what they think is the most important quality for a college student to develop. Write an essay of at least 120 words.',
'Sample: Among the many qualities a college student should develop, I believe critical thinking is the most important. First, it enables students to analyze information objectively. In an era of information explosion, distinguishing fact from opinion is crucial. Furthermore, critical thinking fosters creativity. When students question assumptions and explore multiple perspectives, they generate original ideas. In conclusion, critical thinking forms the foundation of all other abilities.',
NULL, NULL, 'writing',
'本题考查议论文写作。范文选择critical thinking为核心论点，从信息辨别和创新能力两个角度论证。', NULL, '0', 'admin');
SET @t1 = LAST_INSERT_ID();
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid,@t1,'writing','writing',1);

-- =====================================================
-- 3. 听力 - News Reports (3题)
-- =====================================================
INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES
('Q1: What is the news report mainly about?',
'A new solar power plant opened in the Gobi Desert.',
'[{"label":"A","content":"A new solar power plant opened in the Gobi Desert."},{"label":"B","content":"China announced a new environmental policy."},{"label":"C","content":"A severe sandstorm hit northern China."},{"label":"D","content":"Scientists discovered a new species in the desert."}]',
'A','listening','新闻开头明确提到"the largest solar power plant in the Gobi Desert was officially put into operation"，故选A。',
'News Report One:\nThe largest solar power plant in the Gobi Desert was officially put into operation today, marking a milestone in China''s renewable energy development. The plant covers 50 square kilometers and is expected to power 500,000 households annually. Officials said it would reduce carbon dioxide emissions by about 1.2 million tons per year.',
'0','admin'),
('Q2: How much carbon dioxide will be reduced each year?',
'About 1.2 million tons.',
'[{"label":"A","content":"About 500,000 tons."},{"label":"B","content":"About 1.2 million tons."},{"label":"C","content":"About 2 million tons."},{"label":"D","content":"About 800,000 tons."}]',
'B','listening','文中明确提到"reduce carbon dioxide emissions by about 1.2 million tons per year"，故选B。',
'News Report One (continued)',
'0','admin'),
('Q3: What is the main finding of the second news report?',
'Students who exercise regularly perform better academically.',
'[{"label":"A","content":"Students who sleep more get higher grades."},{"label":"B","content":"Students who exercise regularly perform better academically."},{"label":"C","content":"Students who read more books are more creative."},{"label":"D","content":"Students who eat breakfast have better concentration."}]',
'B','listening','新闻提到"students who engaged in regular physical activity scored 15% higher on standardized tests"，故选B。',
'News Report Two:\nA study published in the Journal of Educational Psychology found that students who engaged in regular physical activity scored 15 percent higher on standardized tests. The research followed over 5,000 students across 20 universities for three years, suggesting exercise enhances cognitive function and memory.',
'0','admin');
SET @ln1 = @t1+1; SET @ln2 = @t1+2; SET @ln3 = @t1+3;
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES
(@pid,@ln1,'listening','news',2),(@pid,@ln2,'listening','news',3),(@pid,@ln3,'listening','news',4);

-- =====================================================
-- 4. 听力 - Long Conversations (4题)
-- =====================================================
INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES
('Q4: What does the woman want to do this summer?',
'She plans to do volunteer work in rural areas.',
'[{"label":"A","content":"She plans to travel abroad."},{"label":"B","content":"She plans to do volunteer work in rural areas."},{"label":"C","content":"She plans to take summer courses."},{"label":"D","content":"She plans to find a part-time job."}]',
'B','listening','女士说"I''m thinking of joining a volunteer program in the countryside this summer"，故选B。',
'Long Conversation One:\nM: Hey, Lisa, do you have any plans for the summer break?\nW: I''m thinking of joining a volunteer program in the countryside. I want to teach English to children in rural schools.\nM: That sounds great! How long will the program last?\nW: It''s a six-week program, from mid-July to the end of August.\nM: How did you learn about this program?\nW: Our university posted the information last month. I applied right away.',
'0','admin'),
('Q5: How long will the volunteer program last?',
'Six weeks.',
'[{"label":"A","content":"Four weeks."},{"label":"B","content":"Six weeks."},{"label":"C","content":"Eight weeks."},{"label":"D","content":"Two months."}]',
'B','listening','女士说"It''s a six-week program"，故选B。',
'Long Conversation One (continued)',
'0','admin'),
('Q6: What does the man suggest the woman bring to the interview?',
'A portfolio of her previous work.',
'[{"label":"A","content":"Her academic transcript."},{"label":"B","content":"A portfolio of her previous work."},{"label":"C","content":"A recommendation letter."},{"label":"D","content":"Her internship certificate."}]',
'B','listening','男士建议"you should bring a portfolio showcasing your design projects"，故选B。',
'Long Conversation Two:\nW: Tom, I have a job interview at a design company next week. Any advice?\nM: Research the company thoroughly. Also, bring a portfolio showcasing your design projects.\nW: Should I include my graduation project?\nM: Definitely! And any freelance or internship projects too.\nW: What about what to wear?\nM: Business casual should be fine for a design company.',
'0','admin'),
('Q7: What type of company is the woman interviewing at?',
'A design company.',
'[{"label":"A","content":"A technology company."},{"label":"B","content":"A design company."},{"label":"C","content":"An education company."},{"label":"D","content":"A marketing company."}]',
'B','listening','女士提到"a job interview at a design company"，故选B。',
'Long Conversation Two (continued)',
'0','admin');
SET @lc1 = @ln3+1; SET @lc2 = @ln3+2; SET @lc3 = @ln3+3; SET @lc4 = @ln3+4;
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES
(@pid,@lc1,'listening','conversation',5),(@pid,@lc2,'listening','conversation',6),
(@pid,@lc3,'listening','conversation',7),(@pid,@lc4,'listening','conversation',8);

-- =====================================================
-- 5. 听力 - Passages (3题)
-- =====================================================
INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES
('Q8: What is the main benefit of reading books according to the passage?',
'It improves both vocabulary and empathy.',
'[{"label":"A","content":"It increases physical fitness."},{"label":"B","content":"It improves both vocabulary and empathy."},{"label":"C","content":"It helps people earn more money."},{"label":"D","content":"It reduces the need for sleep."}]',
'B','listening','文章提到"reading books not only expands vocabulary but also enhances empathy"，故选B。',
'Passage One:\nReading books is one of the most beneficial activities for personal development. Research shows that reading books not only expands vocabulary but also enhances empathy. When readers immerse themselves in a story, they experience the world from different perspectives. Regular reading has been linked to reduced stress and improved cognitive function. Experts recommend reading for at least 30 minutes each day.',
'0','admin'),
('Q9: How long do experts recommend reading each day?',
'At least 30 minutes.',
'[{"label":"A","content":"At least 15 minutes."},{"label":"B","content":"At least 30 minutes."},{"label":"C","content":"At least one hour."},{"label":"D","content":"At least two hours."}]',
'B','listening','文章末尾提到"Experts recommend reading for at least 30 minutes each day"，故选B。',
'Passage One (continued)',
'0','admin'),
('Q10: What is the speaker''s main argument about social media?',
'Social media should be used wisely and in moderation.',
'[{"label":"A","content":"Social media should be completely avoided."},{"label":"B","content":"Social media is only harmful for teenagers."},{"label":"C","content":"Social media should be used wisely and in moderation."},{"label":"D","content":"Social media has no real impact on people."}]',
'C','listening','演讲者总结"The key is not to avoid social media entirely, but to use it wisely and in moderation"，故选C。',
'Passage Two:\nSocial media has become an integral part of modern life. While it offers advantages like staying connected and accessing information, it also has downsides. Studies show excessive use can lead to anxiety and poor sleep. The key is not to avoid social media entirely, but to use it wisely and in moderation. Setting time limits and maintaining face-to-face interactions are effective strategies.',
'0','admin');
SET @lp1 = @lc4+1; SET @lp2 = @lc4+2; SET @lp3 = @lc4+3;
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES
(@pid,@lp1,'listening','passage',9),(@pid,@lp2,'listening','passage',10),(@pid,@lp3,'listening','passage',11);

-- =====================================================
-- 6. 阅读 - 选词填空 Cloze (10题)
-- =====================================================
INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES
('26. People sensitive to bitter taste ___ drink more coffee.',
'simply',
'[{"label":"A","content":"addition"},{"label":"B","content":"bitterness"},{"label":"C","content":"avoid"},{"label":"D","content":"consumption"},{"label":"E","content":"deliberately"},{"label":"F","content":"convince"},{"label":"G","content":"heightened"},{"label":"H","content":"mechanism"},{"label":"I","content":"opposite"},{"label":"J","content":"perceive"},{"label":"K","content":"preference"},{"label":"L","content":"reinforcement"},{"label":"M","content":"separately"},{"label":"N","content":"simply"},{"label":"O","content":"tendency"}]',
'N','cloze','此处需副词。simply在此表示"简直，竟然"，符合语境。',
'Cloze Passage:\nIt may sound surprising, but people who are supersensitive to coffee''s bitter taste actually drink more of it, a new study finds. Researchers examined the relationship between genetic sensitivity to bitterness and coffee ___26___. They discovered that individuals with a ___27___ reaction to bitter flavors were more likely to be heavy coffee drinkers. The reason lies in the brain''s reward ___28___. When someone highly sensitive to bitterness drinks coffee, the caffeine produces a ___29___ sense of alertness. This experience serves to ___30___ them that drinking coffee is rewarding, leading to increased ___31___. Interestingly, these individuals tend to ___32___ tea differently. They often ___33___ green or black tea because its bitterness is more ___34___ to them. In ___35___, the study suggests genes shape beverage preferences.',
'0','admin'),
('27. Individuals with a ___ reaction to bitter flavors.',
'opposite',
'[{"label":"A","content":"addition"},{"label":"B","content":"bitterness"},{"label":"C","content":"avoid"},{"label":"D","content":"consumption"},{"label":"E","content":"deliberately"},{"label":"F","content":"convince"},{"label":"G","content":"heightened"},{"label":"H","content":"mechanism"},{"label":"I","content":"opposite"},{"label":"J","content":"perceive"},{"label":"K","content":"preference"},{"label":"L","content":"reinforcement"},{"label":"M","content":"separately"},{"label":"N","content":"simply"},{"label":"O","content":"tendency"}]',
'I','cloze','opposite reaction意为"相反的反应"，对苦味有与常人预期相反的反应，故选I。',NULL,'0','admin'),
('28. The brain''s reward ___.',
'reinforcement',
'[{"label":"A","content":"addition"},{"label":"B","content":"bitterness"},{"label":"C","content":"avoid"},{"label":"D","content":"consumption"},{"label":"E","content":"deliberately"},{"label":"F","content":"convince"},{"label":"G","content":"heightened"},{"label":"H","content":"mechanism"},{"label":"I","content":"opposite"},{"label":"J","content":"perceive"},{"label":"K","content":"preference"},{"label":"L","content":"reinforcement"},{"label":"M","content":"separately"},{"label":"N","content":"simply"},{"label":"O","content":"tendency"}]',
'L','cloze','reward reinforcement是固定搭配，意为"奖励强化"。',NULL,'0','admin'),
('29. Caffeine produces a ___ sense of alertness.',
'heightened',
'[{"label":"A","content":"addition"},{"label":"B","content":"bitterness"},{"label":"C","content":"avoid"},{"label":"D","content":"consumption"},{"label":"E","content":"deliberately"},{"label":"F","content":"convince"},{"label":"G","content":"heightened"},{"label":"H","content":"mechanism"},{"label":"I","content":"opposite"},{"label":"J","content":"perceive"},{"label":"K","content":"preference"},{"label":"L","content":"reinforcement"},{"label":"M","content":"separately"},{"label":"N","content":"simply"},{"label":"O","content":"tendency"}]',
'G','cloze','heightened sense意为"增强的感觉"。heightened修饰sense，表示警觉感增强。',NULL,'0','admin'),
('30. This experience serves to ___ them.',
'convince',
'[{"label":"A","content":"addition"},{"label":"B","content":"bitterness"},{"label":"C","content":"avoid"},{"label":"D","content":"consumption"},{"label":"E","content":"deliberately"},{"label":"F","content":"convince"},{"label":"G","content":"heightened"},{"label":"H","content":"mechanism"},{"label":"I","content":"opposite"},{"label":"J","content":"perceive"},{"label":"K","content":"preference"},{"label":"L","content":"reinforcement"},{"label":"M","content":"separately"},{"label":"N","content":"simply"},{"label":"O","content":"tendency"}]',
'F','cloze','convince sb. that...意为"使某人相信"。',NULL,'0','admin'),
('31. Leading to increased ___.',
'consumption',
'[{"label":"A","content":"addition"},{"label":"B","content":"bitterness"},{"label":"C","content":"avoid"},{"label":"D","content":"consumption"},{"label":"E","content":"deliberately"},{"label":"F","content":"convince"},{"label":"G","content":"heightened"},{"label":"H","content":"mechanism"},{"label":"I","content":"opposite"},{"label":"J","content":"perceive"},{"label":"K","content":"preference"},{"label":"L","content":"reinforcement"},{"label":"M","content":"separately"},{"label":"N","content":"simply"},{"label":"O","content":"tendency"}]',
'D','cloze','increased consumption意为"增加的消费量"。',NULL,'0','admin'),
('32. These individuals tend to ___ tea differently.',
'perceive',
'[{"label":"A","content":"addition"},{"label":"B","content":"bitterness"},{"label":"C","content":"avoid"},{"label":"D","content":"consumption"},{"label":"E","content":"deliberately"},{"label":"F","content":"convince"},{"label":"G","content":"heightened"},{"label":"H","content":"mechanism"},{"label":"I","content":"opposite"},{"label":"J","content":"perceive"},{"label":"K","content":"preference"},{"label":"L","content":"reinforcement"},{"label":"M","content":"separately"},{"label":"N","content":"simply"},{"label":"O","content":"tendency"}]',
'J','cloze','perceive tea differently意为"以不同方式感知茶"。',NULL,'0','admin'),
('33. They often ___ green or black tea.',
'avoid',
'[{"label":"A","content":"addition"},{"label":"B","content":"bitterness"},{"label":"C","content":"avoid"},{"label":"D","content":"consumption"},{"label":"E","content":"deliberately"},{"label":"F","content":"convince"},{"label":"G","content":"heightened"},{"label":"H","content":"mechanism"},{"label":"I","content":"opposite"},{"label":"J","content":"perceive"},{"label":"K","content":"preference"},{"label":"L","content":"reinforcement"},{"label":"M","content":"separately"},{"label":"N","content":"simply"},{"label":"O","content":"tendency"}]',
'C','cloze','avoid意为"避免"，他们避免喝绿茶或红茶。',NULL,'0','admin'),
('34. Its bitterness is more ___ to them.',
'separately',
'[{"label":"A","content":"addition"},{"label":"B","content":"bitterness"},{"label":"C","content":"avoid"},{"label":"D","content":"consumption"},{"label":"E","content":"deliberately"},{"label":"F","content":"convince"},{"label":"G","content":"heightened"},{"label":"H","content":"mechanism"},{"label":"I","content":"opposite"},{"label":"J","content":"perceive"},{"label":"K","content":"preference"},{"label":"L","content":"reinforcement"},{"label":"M","content":"separately"},{"label":"N","content":"simply"},{"label":"O","content":"tendency"}]',
'M','cloze','separately表示"单独地"，茶的苦味被单独感知。',NULL,'0','admin'),
('35. In ___, the study suggests genes shape preferences.',
'addition',
'[{"label":"A","content":"addition"},{"label":"B","content":"bitterness"},{"label":"C","content":"avoid"},{"label":"D","content":"consumption"},{"label":"E","content":"deliberately"},{"label":"F","content":"convince"},{"label":"G","content":"heightened"},{"label":"H","content":"mechanism"},{"label":"I","content":"opposite"},{"label":"J","content":"perceive"},{"label":"K","content":"preference"},{"label":"L","content":"reinforcement"},{"label":"M","content":"separately"},{"label":"N","content":"simply"},{"label":"O","content":"tendency"}]',
'A','cloze','in addition意为"此外"，引出补充说明。',NULL,'0','admin');

SET @cl = LAST_INSERT_ID();
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES
(@pid,@cl,'reading','cloze',12),(@pid,@cl+1,'reading','cloze',13),(@pid,@cl+2,'reading','cloze',14),
(@pid,@cl+3,'reading','cloze',15),(@pid,@cl+4,'reading','cloze',16),(@pid,@cl+5,'reading','cloze',17),
(@pid,@cl+6,'reading','cloze',18),(@pid,@cl+7,'reading','cloze',19),(@pid,@cl+8,'reading','cloze',20),
(@pid,@cl+9,'reading','cloze',21);

-- =====================================================
-- 7. 阅读 - 长篇匹配 Matching: Exercise and Dementia (10题)
-- =====================================================
INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES
('36. Dementia typically gets worse over time.',
'F',
'[{"label":"A","content":"Paragraph A"},{"label":"B","content":"Paragraph B"},{"label":"C","content":"Paragraph C"},{"label":"D","content":"Paragraph D"},{"label":"E","content":"Paragraph E"},{"label":"F","content":"Paragraph F"},{"label":"G","content":"Paragraph G"},{"label":"H","content":"Paragraph H"},{"label":"I","content":"Paragraph I"},{"label":"J","content":"Paragraph J"},{"label":"K","content":"Paragraph K"},{"label":"L","content":"Paragraph L"},{"label":"M","content":"Paragraph M"},{"label":"N","content":"Paragraph N"},{"label":"O","content":"Paragraph O"}]',
'F','reading','F段提到"Dementia is a progressive disease that typically worsens over time"。',
'Exercise and Dementia\n\n[A] A new study from Sweden shows that women who were highly fit in mid-life were nearly 90% less likely to get dementia decades later.\n[B] The research team tracked 191 women for 44 years, starting when they were around 50.\n[C] The study, published in Neurology, found only 5% of the most fit women developed dementia, compared with 32% of the least fit.\n[D] Among moderately fit women, about 25% developed dementia.\n[E] Dementia is a broad term describing loss of thinking ability, memory, attention, and logical reasoning.\n[F] Dementia is a progressive disease that typically worsens over time, severely affecting communication and daily activities.\n[G] Alzheimer''s disease is the most common form, accounting for 60-80% of cases.\n[H] The study gives hope that dementia can be prevented or delayed through exercise in middle age.\n[I] The same activities that help prevent Alzheimer''s also help prevent heart disease.\n[J] A 2019 study showed older adults walking 7,500+ steps daily had lower cognitive decline risk.\n[K] Although not entirely clear why exercise helps, it may relate to improved blood flow and neuron growth.\n[L] The message is not that everyone needs to run marathons. Even moderate activities like brisk walking can help.\n[M] The literature has not settled on an ideal type or amount of exercise for brain protection.\n[N] Some experts caution against over-interpreting the results, noting genetics and education also matter.\n[O] In three to five years, ongoing studies should provide clearer recommendations for reducing risk.',
'0','admin'),
('37. The message isn''t that everyone needs to run marathons.','L',
'[{"label":"A","content":"Paragraph A"},{"label":"B","content":"Paragraph B"},{"label":"C","content":"Paragraph C"},{"label":"D","content":"Paragraph D"},{"label":"E","content":"Paragraph E"},{"label":"F","content":"Paragraph F"},{"label":"G","content":"Paragraph G"},{"label":"H","content":"Paragraph H"},{"label":"I","content":"Paragraph I"},{"label":"J","content":"Paragraph J"},{"label":"K","content":"Paragraph K"},{"label":"L","content":"Paragraph L"},{"label":"M","content":"Paragraph M"},{"label":"N","content":"Paragraph N"},{"label":"O","content":"Paragraph O"}]',
'L','reading','L段提到"The message is not that everyone needs to run marathons in middle age"。',NULL,'0','admin'),
('38. A Swedish study shows highly fit women are nearly 90% less likely to get dementia.','A',
'[{"label":"A","content":"Paragraph A"},{"label":"B","content":"Paragraph B"},{"label":"C","content":"Paragraph C"},{"label":"D","content":"Paragraph D"},{"label":"E","content":"Paragraph E"},{"label":"F","content":"Paragraph F"},{"label":"G","content":"Paragraph G"},{"label":"H","content":"Paragraph H"},{"label":"I","content":"Paragraph I"},{"label":"J","content":"Paragraph J"},{"label":"K","content":"Paragraph K"},{"label":"L","content":"Paragraph L"},{"label":"M","content":"Paragraph M"},{"label":"N","content":"Paragraph N"},{"label":"O","content":"Paragraph O"}]',
'A','reading','A段开头提到瑞典研究的这一发现。',NULL,'0','admin'),
('39. The findings give hope that dementia can be prevented through exercise.','H',
'[{"label":"A","content":"Paragraph A"},{"label":"B","content":"Paragraph B"},{"label":"C","content":"Paragraph C"},{"label":"D","content":"Paragraph D"},{"label":"E","content":"Paragraph E"},{"label":"F","content":"Paragraph F"},{"label":"G","content":"Paragraph G"},{"label":"H","content":"Paragraph H"},{"label":"I","content":"Paragraph I"},{"label":"J","content":"Paragraph J"},{"label":"K","content":"Paragraph K"},{"label":"L","content":"Paragraph L"},{"label":"M","content":"Paragraph M"},{"label":"N","content":"Paragraph N"},{"label":"O","content":"Paragraph O"}]',
'H','reading','H段提到"it does give us hope that dementia can be prevented or delayed through exercise"。',NULL,'0','admin'),
('40. Future studies will provide clearer recommendations.','O',
'[{"label":"A","content":"Paragraph A"},{"label":"B","content":"Paragraph B"},{"label":"C","content":"Paragraph C"},{"label":"D","content":"Paragraph D"},{"label":"E","content":"Paragraph E"},{"label":"F","content":"Paragraph F"},{"label":"G","content":"Paragraph G"},{"label":"H","content":"Paragraph H"},{"label":"I","content":"Paragraph I"},{"label":"J","content":"Paragraph J"},{"label":"K","content":"Paragraph K"},{"label":"L","content":"Paragraph L"},{"label":"M","content":"Paragraph M"},{"label":"N","content":"Paragraph N"},{"label":"O","content":"Paragraph O"}]',
'O','reading','O段提到"In the next three to five years, ongoing studies should provide clearer recommendations"。',NULL,'0','admin'),
('41. Dementia describes a loss of thinking ability and memory.','E',
'[{"label":"A","content":"Paragraph A"},{"label":"B","content":"Paragraph B"},{"label":"C","content":"Paragraph C"},{"label":"D","content":"Paragraph D"},{"label":"E","content":"Paragraph E"},{"label":"F","content":"Paragraph F"},{"label":"G","content":"Paragraph G"},{"label":"H","content":"Paragraph H"},{"label":"I","content":"Paragraph I"},{"label":"J","content":"Paragraph J"},{"label":"K","content":"Paragraph K"},{"label":"L","content":"Paragraph L"},{"label":"M","content":"Paragraph M"},{"label":"N","content":"Paragraph N"},{"label":"O","content":"Paragraph O"}]',
'E','reading','E段给出了痴呆症的定义。',NULL,'0','admin'),
('42. It''s not entirely clear why exercise helps prevent Alzheimer''s.','K',
'[{"label":"A","content":"Paragraph A"},{"label":"B","content":"Paragraph B"},{"label":"C","content":"Paragraph C"},{"label":"D","content":"Paragraph D"},{"label":"E","content":"Paragraph E"},{"label":"F","content":"Paragraph F"},{"label":"G","content":"Paragraph G"},{"label":"H","content":"Paragraph H"},{"label":"I","content":"Paragraph I"},{"label":"J","content":"Paragraph J"},{"label":"K","content":"Paragraph K"},{"label":"L","content":"Paragraph L"},{"label":"M","content":"Paragraph M"},{"label":"N","content":"Paragraph N"},{"label":"O","content":"Paragraph O"}]',
'K','reading','K段提到"Although it is not entirely clear why exercise helps"。',NULL,'0','admin'),
('43. No ideal type of exercise has been determined for brain protection.','M',
'[{"label":"A","content":"Paragraph A"},{"label":"B","content":"Paragraph B"},{"label":"C","content":"Paragraph C"},{"label":"D","content":"Paragraph D"},{"label":"E","content":"Paragraph E"},{"label":"F","content":"Paragraph F"},{"label":"G","content":"Paragraph G"},{"label":"H","content":"Paragraph H"},{"label":"I","content":"Paragraph I"},{"label":"J","content":"Paragraph J"},{"label":"K","content":"Paragraph K"},{"label":"L","content":"Paragraph L"},{"label":"M","content":"Paragraph M"},{"label":"N","content":"Paragraph N"},{"label":"O","content":"Paragraph O"}]',
'M','reading','M段提到"The literature has not yet settled on an ideal type or amount of exercise"。',NULL,'0','admin'),
('44. The study was published in Neurology.','C',
'[{"label":"A","content":"Paragraph A"},{"label":"B","content":"Paragraph B"},{"label":"C","content":"Paragraph C"},{"label":"D","content":"Paragraph D"},{"label":"E","content":"Paragraph E"},{"label":"F","content":"Paragraph F"},{"label":"G","content":"Paragraph G"},{"label":"H","content":"Paragraph H"},{"label":"I","content":"Paragraph I"},{"label":"J","content":"Paragraph J"},{"label":"K","content":"Paragraph K"},{"label":"L","content":"Paragraph L"},{"label":"M","content":"Paragraph M"},{"label":"N","content":"Paragraph N"},{"label":"O","content":"Paragraph O"}]',
'C','reading','C段提到"The study, published in the journal Neurology"。',NULL,'0','admin'),
('45. Activities preventing Alzheimer''s also prevent heart disease.','I',
'[{"label":"A","content":"Paragraph A"},{"label":"B","content":"Paragraph B"},{"label":"C","content":"Paragraph C"},{"label":"D","content":"Paragraph D"},{"label":"E","content":"Paragraph E"},{"label":"F","content":"Paragraph F"},{"label":"G","content":"Paragraph G"},{"label":"H","content":"Paragraph H"},{"label":"I","content":"Paragraph I"},{"label":"J","content":"Paragraph J"},{"label":"K","content":"Paragraph K"},{"label":"L","content":"Paragraph L"},{"label":"M","content":"Paragraph M"},{"label":"N","content":"Paragraph N"},{"label":"O","content":"Paragraph O"}]',
'I','reading','I段提到"the same activities that help prevent Alzheimer''s...also prevent heart disease"。',NULL,'0','admin');

SET @mt = LAST_INSERT_ID();
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES
(@pid,@mt,'reading','matching',22),(@pid,@mt+1,'reading','matching',23),(@pid,@mt+2,'reading','matching',24),
(@pid,@mt+3,'reading','matching',25),(@pid,@mt+4,'reading','matching',26),(@pid,@mt+5,'reading','matching',27),
(@pid,@mt+6,'reading','matching',28),(@pid,@mt+7,'reading','matching',29),(@pid,@mt+8,'reading','matching',30),
(@pid,@mt+9,'reading','matching',31);

-- =====================================================
-- 8. 阅读 - 仔细阅读 Passage One: Impostor Phenomenon (5题)
-- =====================================================
INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES
('46. What do people with the Impostor Phenomenon tend to do?',
'They tend to attribute their achievements to good fortune.',
'[{"label":"A","content":"They overestimate their own abilities."},{"label":"B","content":"They tend to attribute their achievements to good fortune."},{"label":"C","content":"They refuse to work with others."},{"label":"D","content":"They avoid taking on responsibilities."}]',
'B','reading','文章提到"they believe their success is not due to their own abilities but rather to luck"，故选B。',
'Passage One: The Impostor Phenomenon\n\nPeople who systematically underestimate themselves suffer from the Impostor Phenomenon. Despite evidence of competence, they remain convinced they are frauds whose success is due to luck rather than ability.\n\nFirst identified in 1978 by psychologists Clance and Imes, the phenomenon affects people of all genders, particularly in competitive environments.\n\nThose experiencing impostor feelings share common traits: attributing achievements to external factors, fearing being "found out," and setting excessively high standards.\n\nStrategies include recognizing negative thought patterns, seeking support from mentors, and keeping records of accomplishments.\n\nResearch indicates sufferers are more likely to experience anxiety and depression, underscoring the importance of early intervention.',
'0','admin'),
('47. What does the passage suggest about dealing with impostor feelings?',
'Recognize and challenge negative thought patterns.',
'[{"label":"A","content":"Ignore them completely."},{"label":"B","content":"Work harder to prove yourself."},{"label":"C","content":"Recognize and challenge negative thought patterns."},{"label":"D","content":"Avoid competitive environments."}]',
'C','reading','文章提到"learn to recognize and challenge their negative thought patterns"，故选C。',NULL,'0','admin'),
('48. What do impostor-prone people do when evaluated objectively?',
'They underestimate their objectively rated performance.',
'[{"label":"A","content":"They exaggerate their achievements."},{"label":"B","content":"They perform worse than average."},{"label":"C","content":"They refuse to be evaluated."},{"label":"D","content":"They underestimate their objectively rated performance."}]',
'D','reading','文章开头提到"systematically underestimate themselves and their own performance"，故选D。',NULL,'0','admin'),
('49. What does the passage say about successful people''s achievements?',
'They will be the fruit of their concentrated endeavors.',
'[{"label":"A","content":"They are mostly due to good luck."},{"label":"B","content":"They will be the fruit of their concentrated endeavors."},{"label":"C","content":"They depend on others'' help."},{"label":"D","content":"They are often overestimated."}]',
'B','reading','成功者的成就应被视为专注努力的结果，impostor现象患者恰恰相反。',NULL,'0','admin'),
('50. What does research indicate about people with impostor feelings?',
'They are more liable to have depression.',
'[{"label":"A","content":"They are more liable to have depression."},{"label":"B","content":"They tend to be more outgoing."},{"label":"C","content":"They perform better under pressure."},{"label":"D","content":"They have higher self-esteem."}]',
'A','reading','文章最后一段提到"more likely to experience anxiety and depression"，故选A。',NULL,'0','admin');

SET @r1 = LAST_INSERT_ID();
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES
(@pid,@r1,'reading','reading_1',32),(@pid,@r1+1,'reading','reading_1',33),(@pid,@r1+2,'reading','reading_1',34),
(@pid,@r1+3,'reading','reading_1',35),(@pid,@r1+4,'reading','reading_1',36);

-- =====================================================
-- 9. 阅读 - 仔细阅读 Passage Two: Music (5题)
-- =====================================================
INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES
('51. What does the passage say about music?',
'It has the power to unite people throughout the world.',
'[{"label":"A","content":"It is only appreciated in Western cultures."},{"label":"B","content":"It has the power to unite people throughout the world."},{"label":"C","content":"It is primarily entertainment."},{"label":"D","content":"It has remained unchanged throughout history."}]',
'B','reading','文章开头"Music is a universal language"说明音乐有团结世界的力量，故选B。',
'Passage Two: Music as a Universal Language\n\nMusic is a universal language found in every culture. It transcends borders and backgrounds, connecting people in ways words cannot.\n\nScientific research shows music activates multiple brain areas simultaneously. Listening to enjoyable music releases dopamine, the pleasure chemical.\n\nMusic therapy is now recognized treatment for depression, anxiety, and physical pain. Hospitals incorporate music programs to reduce stress and improve well-being.\n\nMusic plays a central role in ceremonies and community gatherings, serving as a vehicle for preserving cultural heritage.\n\nDespite technological changes in how we create and consume music, its fundamental role in expressing emotions and bringing people together remains constant.',
'0','admin'),
('52. What can be achieved through music therapy?',
'Fantastic results can be achieved.',
'[{"label":"A","content":"All diseases can be cured."},{"label":"B","content":"Patients can learn instruments."},{"label":"C","content":"Music replaces medication."},{"label":"D","content":"Fantastic results in treating various conditions."}]',
'D','reading','文章提到音乐疗法在治疗多种疾病方面取得显著效果，故选D。',NULL,'0','admin'),
('53. What role does music play in many societies?',
'To serve as a vehicle for preserving cultural heritage.',
'[{"label":"A","content":"To preserve cultural heritage."},{"label":"B","content":"To replace education."},{"label":"C","content":"To compete with other arts."},{"label":"D","content":"To generate profit."}]',
'A','reading','文章提到"serving as a vehicle for preserving cultural heritage"，故选A。',NULL,'0','admin'),
('54. What determines the effect of music on listeners?',
'The cultural and personal context.',
'[{"label":"A","content":"The volume."},{"label":"B","content":"The listener''s age."},{"label":"C","content":"The cultural and personal context."},{"label":"D","content":"The instrument price."}]',
'C','reading','音乐效果取决于听众的文化背景和个人经历，故选C。',NULL,'0','admin'),
('55. Despite technological changes, what remains constant about music?',
'Its fundamental role in expressing emotions and bringing people together.',
'[{"label":"A","content":"The instruments used."},{"label":"B","content":"Popular genres."},{"label":"C","content":"Number of listeners."},{"label":"D","content":"Its fundamental role in human life."}]',
'D','reading','文章最后总结"the fundamental role of music in human life remains constant"，故选D。',NULL,'0','admin');

SET @r2 = LAST_INSERT_ID();
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES
(@pid,@r2,'reading','reading_2',37),(@pid,@r2+1,'reading','reading_2',38),(@pid,@r2+2,'reading','reading_2',39),
(@pid,@r2+3,'reading','reading_2',40),(@pid,@r2+4,'reading','reading_2',41);

-- =====================================================
-- 10. 翻译 Translation (1题)
-- =====================================================
INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES
('Translate the following paragraph into English:\n\n茶文化在中国有着悠久的历史。中国人饮茶已有几千年，茶不仅是日常生活中不可或缺的饮品，更是中华文化的重要组成部分。在中国，饮茶被视为一种修身养性的方式。不同种类的茶叶有着不同的功效，如绿茶清热解毒、红茶暖胃养身。如今，中国的茶文化已经传播到世界各地，受到越来越多外国人的喜爱。',
'Reference Translation:\nTea culture has a long history in China. The Chinese have been drinking tea for thousands of years. Tea is not only an indispensable beverage in daily life but also an important component of Chinese culture. In China, drinking tea is regarded as a way to cultivate one''s mind and body. Different types of tea have different health benefits: green tea helps clear heat and detoxify, while black tea warms the stomach and nourishes the body. Today, Chinese tea culture has spread worldwide and is increasingly loved by people from other countries.',
NULL, NULL, 'translation',
'重点词汇：茶文化(tea culture)、悠久的(long history)、不可或缺的(indispensable)、修身养性(cultivate one''s mind and body)、清热解毒(clear heat and detoxify)、暖胃养身(warm the stomach and nourish the body)。',
NULL, '0', 'admin');
SET @tr1 = LAST_INSERT_ID();
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid,@tr1,'translation','translation',42);
