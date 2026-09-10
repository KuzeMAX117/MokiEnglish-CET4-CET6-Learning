-- =====================================================
-- 修复阅读文章原文：将简化版替换为 celst-4 完整原文
-- 当前问题：Passage Two (Music) 的 article 字段是简化摘要（~120词），
--           需要替换为完整原文（~400词）
-- 执行方式：mysql --default-character-set=utf8mb4 -u root -p brushtopic < fix_articles.sql
-- =====================================================

SET NAMES utf8mb4;

-- 修复 Passage Two: Music as a Universal Language
-- 找到 reading_2 板块中存储了文章的那条记录（article 不为空的第一条）
UPDATE `topic`
SET `article` = 'Music is a universal language. In every culture and country, you will find music. It is vitally important across the globe and has the potential to bring people together in peace and harmony. One of my favorite experiences in music is seeing musicians from different cultures come together and perform as a group. When each culture brings its own unique qualities to the group, an entirely new sound is achieved. This can create extraordinary results. People can communicate with each other using music as the common language.\n\nOne common musical thread between cultures is known as the pentatonic scale. It is astonishing how many cultures share this tool in approaching music. The pentatonic scale consists of five notes; \"penta-\" meaning 5, and \"tonic\" meaning tone or note. This scale can be found in music everywhere including that of Native Americans, Africans, and Asians. It is also found in popular music, blues, jazz, and rock. Using this five-note scale, musicians from around the globe have a medium through which they can relate, communicate, perform, and ultimately understand each other.\n\nMusic is tied to specific perceptual, mental, and emotional faculties, including language (all societies put words to their songs), motor control (people in all societies dance), sound analysis (all musical systems have a distinct pitch and quality), and aesthetics (their tunes and rhythms are balanced between repetitiveness and chaos).\n\nThere is no known society that existed without music. Although each culture has their own specific style and approach to music, you will find that the purposes behind music are very similar across the board. Music essentially serves to express or change emotions. It can cheer you up, sadden you, anger you or excite you. Music is often ceremonial: used in religion, ceremony, and celebration. Music can simply be recreational: entertaining, joyful and fun. Any way you have used music, it is almost certain that every other culture has used music in the very same way. And that is something that bonds all of us. We all share a deep love for music and it has the power to unite us.'
WHERE `topic_name` LIKE '51.%'
  AND `question_type` = 'reading'
  AND `article` IS NOT NULL;

-- 验证修复结果
SELECT id, LEFT(topic_name, 30) AS title, LENGTH(article) AS article_len
FROM `topic`
WHERE `question_type` = 'reading'
  AND `article` IS NOT NULL
ORDER BY id;
