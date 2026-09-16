# -*- coding: utf-8 -*-
"""Check answer distribution and paper quality"""
import re

with open(r'D:\202401\study\Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Count answers
ans_not_null = len(re.findall(r"'answer',\n\s+NULL", content))
total_topics = len(re.findall(r"INSERT INTO `topic`", content))

print(f"Total topics: {total_topics}")
print(f"Topics with NULL answer: {ans_not_null}")
print(f"Topics with non-NULL answer: {total_topics - ans_not_null}")

# Papers with question counts
print("\nPapers with question counts:")
for m in re.finditer(r"-- \[(\d+)\].*?-- 题目数: (\d+)", content):
    num = m.group(1)
    count = int(m.group(2))
    status = "✓" if count >= 40 else "✗" if count < 5 else "~"
    print(f"  [{num:>2}] {count:>3} questions {status}")
