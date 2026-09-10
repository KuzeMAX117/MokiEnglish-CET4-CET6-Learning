-- detail quality checks on brushtopic_precheck (fixed import result)
-- 1) short topic_name (<=3 chars) by section
SELECT pt.section, COUNT(*) AS short_cnt
FROM topic t JOIN paper_topic pt ON pt.topic_id = t.id
WHERE CHAR_LENGTH(t.topic_name) <= 3
GROUP BY pt.section;

-- 2) topics without options by section
SELECT pt.section, pt.sub_section, COUNT(*) AS no_options_cnt
FROM topic t JOIN paper_topic pt ON pt.topic_id = t.id
WHERE t.options IS NULL OR t.options = ''
GROUP BY pt.section, pt.sub_section;

-- 3) topics WITH options by section
SELECT pt.section, COUNT(*) AS with_options_cnt
FROM topic t JOIN paper_topic pt ON pt.topic_id = t.id
WHERE t.options IS NOT NULL AND t.options <> ''
GROUP BY pt.section;

-- 4) cloze options sample (first 3)
SELECT t.id, LEFT(t.topic_name, 60) AS name, LEFT(t.options, 80) AS opts
FROM topic t JOIN paper_topic pt ON pt.topic_id = t.id
WHERE pt.sub_section = 'cloze'
LIMIT 3;

-- 5) writing topics content check (paper 11 = 2016shang 6ji 1, paper 21 = 2017shang 6ji 1)
SELECT p.id AS pid, p.title, LEFT(t.topic_name, 90) AS writing_topic
FROM topic t
JOIN paper_topic pt ON pt.topic_id = t.id
JOIN paper p ON p.id = pt.paper_id
WHERE pt.section = 'writing'
ORDER BY p.id;

-- 6) listening sub_section + sample topic_name
SELECT pt.sub_section, LEFT(t.topic_name, 50) AS sample_name, COUNT(*) AS cnt
FROM topic t JOIN paper_topic pt ON pt.topic_id = t.id
WHERE pt.section = 'listening'
GROUP BY pt.sub_section, sample_name
ORDER BY cnt DESC
LIMIT 10;

-- 7) translation answer content sample
SELECT p.id AS pid, LEFT(t.answer, 60) AS ans, CHAR_LENGTH(COALESCE(t.article,'')) AS art_len
FROM topic t
JOIN paper_topic pt ON pt.topic_id = t.id
JOIN paper p ON p.id = pt.paper_id
WHERE pt.section = 'translation'
ORDER BY p.id
LIMIT 8;
