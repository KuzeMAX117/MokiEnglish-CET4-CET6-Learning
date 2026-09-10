# -*- coding: utf-8 -*-
import re

with open(r'D:\202401\study\Hao-Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    content = f.read()

papers = len(re.findall(r"INSERT INTO `paper`", content))
topics = len(re.findall(r"INSERT INTO `topic`", content))
paper_topics = len(re.findall(r"INSERT INTO `paper_topic`", content))

print(f"Papers: {papers}")
print(f"Topics: {topics}")
print(f"Paper-topics: {paper_topics}")

# Count answers
ans_not_null = len(re.findall(r"'answer',\n\s+NULL", content))
ans_null = topics - ans_not_null
print(f"Topics with answers: {ans_not_null}")
print(f"Topics without answers: {ans_null}")

# Papers with > 40 questions
for m in re.finditer(r"-- \[(\d+)\].*?-- 题目数: (\d+)", content):
    if int(m.group(2)) >= 40:
        print(f"  Good paper [{m.group(1)}]: {m.group(2)} questions")
