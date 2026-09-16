SELECT 'paper' AS tbl, COUNT(*) AS cnt FROM brushtopic.paper
UNION ALL SELECT 'topic', COUNT(*) FROM brushtopic.topic
UNION ALL SELECT 'paper_topic', COUNT(*) FROM brushtopic.paper_topic;
SELECT id, level, exam_year, exam_half, title FROM brushtopic.paper ORDER BY id;
SELECT MAX(id) AS max_topic_id FROM brushtopic.topic;
