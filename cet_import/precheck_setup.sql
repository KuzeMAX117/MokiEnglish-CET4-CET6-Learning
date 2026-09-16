-- 影子库：复制表结构用于试执行（不影响主库）
DROP DATABASE IF EXISTS brushtopic_precheck;
CREATE DATABASE brushtopic_precheck DEFAULT CHARACTER SET utf8mb4;
USE brushtopic_precheck;
CREATE TABLE paper LIKE brushtopic.paper;
CREATE TABLE topic LIKE brushtopic.topic;
CREATE TABLE paper_topic LIKE brushtopic.paper_topic;
