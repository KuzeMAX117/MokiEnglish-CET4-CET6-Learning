-- per-paper usability summary
SELECT p.id AS pid, p.title,
       COUNT(*) AS total,
       SUM(CASE WHEN t.options IS NOT NULL AND t.options <> '' THEN 1 ELSE 0 END) AS with_opts,
       SUM(CASE WHEN t.options IS NOT NULL AND t.options <> '' AND t.answer IS NOT NULL AND t.answer <> '' THEN 1 ELSE 0 END) AS answerable,
       SUM(CASE WHEN pt.section = 'listening' THEN 1 ELSE 0 END) AS listen,
       SUM(CASE WHEN pt.section = 'reading' AND pt.sub_section IN ('reading_1','reading_2') THEN 1 ELSE 0 END) AS careful_reading,
       SUM(CASE WHEN pt.section = 'writing' THEN 1 ELSE 0 END) AS writing,
       SUM(CASE WHEN pt.section = 'translation' THEN 1 ELSE 0 END) AS translation
FROM paper p
JOIN paper_topic pt ON pt.paper_id = p.id
JOIN topic t ON t.id = pt.topic_id
GROUP BY p.id, p.title
ORDER BY p.id;
