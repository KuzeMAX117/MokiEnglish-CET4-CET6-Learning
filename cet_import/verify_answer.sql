-- answer coverage by section
SELECT pt.section, pt.sub_section,
       COUNT(*) AS total,
       SUM(CASE WHEN t.answer IS NOT NULL AND t.answer <> '' THEN 1 ELSE 0 END) AS with_ans,
       SUM(CASE WHEN t.answer IS NULL OR t.answer = '' THEN 1 ELSE 0 END) AS no_ans
FROM topic t JOIN paper_topic pt ON pt.topic_id = t.id
GROUP BY pt.section, pt.sub_section
ORDER BY pt.section, pt.sub_section;

-- answer sample for listening / reading_1 / matching
SELECT pt.sub_section, t.id, LEFT(t.answer, 40) AS ans
FROM topic t JOIN paper_topic pt ON pt.topic_id = t.id
WHERE pt.sub_section IN ('conversation','reading_1','matching','news','passage')
  AND t.answer IS NOT NULL AND t.answer <> ''
LIMIT 12;

-- does correct_option get filled?
SELECT pt.section,
       SUM(CASE WHEN t.correct_option IS NOT NULL AND t.correct_option <> '' THEN 1 ELSE 0 END) AS with_correct,
       COUNT(*) AS total
FROM topic t JOIN paper_topic pt ON pt.topic_id = t.id
GROUP BY pt.section;

-- question_type mapping
SELECT question_type, COUNT(*) AS cnt FROM topic GROUP BY question_type;

-- sample full topic of a reading_1 question (has options)
SELECT t.id, LEFT(t.topic_name, 80) AS name, LEFT(t.options, 120) AS opts,
       LEFT(t.answer, 20) AS ans, t.correct_option
FROM topic t JOIN paper_topic pt ON pt.topic_id = t.id
WHERE pt.sub_section = 'reading_1'
LIMIT 3;
