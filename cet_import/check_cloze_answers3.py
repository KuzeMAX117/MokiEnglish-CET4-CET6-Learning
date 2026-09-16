# -*- coding: utf-8 -*-
"""Check cloze answers in SQL - debug"""
import re

with open(r'D:\202401\study\Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Find all topic inserts
topic_pattern = re.compile(r"INSERT INTO `topic`.*?VALUES \((.*?)\);", re.DOTALL)
matches = topic_pattern.findall(content)

print(f"Total topic inserts: {len(matches)}")

# Check for cloze answers
cloze_answers = []
for m in matches:
    # Check if this is a cloze question (in cloze sub_section)
    if "'cloze'" in m:
        # Extract the answer
        ans_match = re.search(r"'answer',\n\s+'([^']+)'", m)
        if ans_match:
            cloze_answers.append(ans_match.group(1))

print(f"Cloze answers found: {len(cloze_answers)}")
print(f"Sample cloze answers: {cloze_answers[:10]}")
