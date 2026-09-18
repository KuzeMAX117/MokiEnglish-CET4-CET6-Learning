-- 1) per-paper topic count
SELECT p.id AS paper_id, p.level, p.exam_year, p.exam_half, p.title,
       COUNT(pt.id) AS pt_cnt
FROM brushtopic_precheck.paper p
LEFT JOIN brushtopic_precheck.paper_topic pt ON pt.paper_id = p.id
GROUP BY p.id ORDER BY p.id;

-- 2) orphan paper_topic or duplicated paper+topic
SELECT 'orphan_pt' AS chk, COUNT(*) AS cnt FROM brushtopic_precheck.paper_topic pt
LEFT JOIN brushtopic_precheck.topic t ON t.id = pt.topic_id
WHERE t.id IS NULL;
SELECT 'dup_pt_topic' AS chk, COUNT(*) AS cnt FROM (
  SELECT paper_id, topic_id FROM brushtopic_precheck.paper_topic GROUP BY paper_id, topic_id HAVING COUNT(*) > 1
) x;

-- 3) topic referenced by multiple papers (wrong-link feature)
SELECT 'topic_shared' AS chk, COUNT(*) AS cnt FROM (
  SELECT topic_id FROM brushtopic_precheck.paper_topic GROUP BY topic_id HAVING COUNT(DISTINCT paper_id) > 1
) x;

-- 4) section distribution
SELECT p.id AS pid, p.title, pt.section, IFNULL(pt.sub_section,'') AS sub, COUNT(*) AS cnt
FROM brushtopic_precheck.paper p
JOIN brushtopic_precheck.paper_topic pt ON pt.paper_id = p.id
GROUP BY p.id, pt.section, pt.sub_section
ORDER BY p.id, pt.section, pt.sub_section;

-- 5) sorted continuity
SELECT p.id AS pid, p.title, COUNT(*) AS total,
       MIN(pt.sorted) AS min_s, MAX(pt.sorted) AS max_s,
       COUNT(DISTINCT pt.sorted) AS distinct_s
FROM brushtopic_precheck.paper p
JOIN brushtopic_precheck.paper_topic pt ON pt.paper_id = p.id
GROUP BY p.id ORDER BY p.id;

-- 6) short topic_name (<=3 chars)
SELECT COUNT(*) AS short_name_cnt FROM brushtopic_precheck.topic
WHERE CHAR_LENGTH(IFNULL(topic_name,'')) <= 3 AND status = 0;

-- 7) type/status stats
SELECT question_type, COUNT(*) AS cnt FROM brushtopic_precheck.topic GROUP BY question_type;
SELECT status, COUNT(*) AS cnt FROM brushtopic_precheck.topic GROUP BY status;

-- 8) bad options JSON (charset-safe: any row where JSON_VALID fails on raw)
SELECT COUNT(*) AS total_with_options FROM brushtopic_precheck.topic WHERE options IS NOT NULL AND options <> '';
