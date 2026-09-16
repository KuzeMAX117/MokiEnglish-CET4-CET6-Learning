SELECT 'paper' AS tbl, COUNT(*) AS cnt FROM brushtopic.paper
UNION ALL SELECT 'topic', COUNT(*) FROM brushtopic.topic
UNION ALL SELECT 'paper_topic', COUNT(*) FROM brushtopic.paper_topic
UNION ALL SELECT 'orphan_pt', COUNT(*) FROM brushtopic.paper_topic pt LEFT JOIN brushtopic.topic t ON t.id=pt.topic_id LEFT JOIN brushtopic.paper p ON p.id=pt.paper_id WHERE t.id IS NULL OR p.id IS NULL;

-- 模拟后端 paperList(level) 过滤: status=0 AND is_deleted=0
SELECT level, COUNT(*) AS visible_papers
FROM brushtopic.paper
WHERE status = 0 AND is_deleted = 0
GROUP BY level ORDER BY level;

-- 新导入卷列表
SELECT p.id, p.level, p.exam_year, p.exam_half, p.title, COUNT(pt.topic_id) AS topics
FROM brushtopic.paper p
LEFT JOIN brushtopic.paper_topic pt ON pt.paper_id = p.id
WHERE p.id > 2
GROUP BY p.id, p.level, p.exam_year, p.exam_half, p.title
ORDER BY p.id;
