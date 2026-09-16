SELECT 'papers' AS chk, COUNT(*) AS cnt FROM paper
UNION ALL SELECT 'topics', COUNT(*) FROM topic
UNION ALL SELECT 'paper_topic', COUNT(*) FROM paper_topic
UNION ALL SELECT 'orphan_pt', COUNT(*) FROM paper_topic pt LEFT JOIN topic t ON t.id=pt.topic_id LEFT JOIN paper p ON p.id=pt.paper_id WHERE t.id IS NULL OR p.id IS NULL
UNION ALL SELECT 'bad_status', COUNT(*) FROM topic WHERE status <> 0;

SELECT p.id, p.level, p.exam_year, p.exam_half, p.title, COUNT(pt.topic_id) AS n
FROM paper p LEFT JOIN paper_topic pt ON pt.paper_id = p.id
GROUP BY p.id, p.level, p.exam_year, p.exam_half, p.title
ORDER BY p.id;

SELECT pt.section, COUNT(*) AS cnt FROM paper_topic pt GROUP BY pt.section ORDER BY pt.section;
