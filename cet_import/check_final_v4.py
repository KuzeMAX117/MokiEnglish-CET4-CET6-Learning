# -*- coding: utf-8 -*-
"""Final quality check"""
import re

with open(r'D:\202401\study\Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Count papers
papers = len(re.findall(r"INSERT INTO `paper`", content))
print(f"Papers: {papers}")

# Count topics
topics = len(re.findall(r"INSERT INTO `topic`", content))
print(f"Topics: {topics}")

# Count paper_topics
paper_topics = len(re.findall(r"INSERT INTO `paper_topic`", content))
print(f"Paper-topics: {paper_topics}")

# Count non-NULL answers
ans_vals = re.findall(r"VALUES \(\n\s+'[^']*',\n\s+'([A-Z])'", content)
ans_null = len(re.findall(r"VALUES \(\n\s+'[^']*',\n\s+NULL", content))
print(f"Topics with letter answers: {len(ans_vals)}")
print(f"Topics with NULL answer: {ans_null}")

# Show distribution
from collections import Counter
if ans_vals:
    print(f"Answer distribution: {Counter(ans_vals)}")

# Paper question counts
print("\nPapers with question counts:")
for m in re.finditer(r"-- \[(\d+)\].*?-- 题目数: (\d+)", content):
    num = m.group(1)
    count = int(m.group(2))
    status = "good" if count >= 40 else "bad" if count < 10 else "partial"
    print(f"  [{num:>2}] {count:>3} questions ({status})")
