DROP TABLE IF EXISTS brushtopic_precheck.paper_topic;
DROP TABLE IF EXISTS brushtopic_precheck.topic;
DROP TABLE IF EXISTS brushtopic_precheck.paper;
CREATE TABLE brushtopic_precheck.paper LIKE brushtopic.paper;
CREATE TABLE brushtopic_precheck.topic LIKE brushtopic.topic;
CREATE TABLE brushtopic_precheck.paper_topic LIKE brushtopic.paper_topic;
SELECT 'setup ok' AS info;
