# -*- coding: utf-8 -*-
"""Check answer distribution after v4"""
import re

with open(r'D:\202401\study\Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Count topics with answers
# Pattern: 'answer',\n  'X' or 'answer',\n  NULL
ans_pattern = re.compile(r"'answer',\n\s+('[^']*'|NULL)")
matches = ans_pattern.findall(content)

null_count = sum(1 for v in matches if v == 'NULL')
non_null = sum(1 for v in matches if v != 'NULL')
print(f"Total topics: {len(matches)}")
print(f"NULL answers: {null_count}")
print(f"Non-NULL answers: {non_null}")

# Show sample non-NULL answers
non_null_vals = [v for v in matches if v != 'NULL']
print(f"Sample answers: {non_null_vals[:30]}")
