# -*- coding: utf-8 -*-
"""Check answer distribution after v3"""
import re

with open(r'D:\202401\study\Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Count all NULL vs non-NULL answers
ans_vals = re.findall(r"'answer',\n\s+([^,]+)", content)
null_count = sum(1 for v in ans_vals if v.strip() == 'NULL')
non_null = sum(1 for v in ans_vals if v.strip() != 'NULL')
print(f"Answer values: {len(ans_vals)}")
print(f"NULL: {null_count}")
print(f"Non-NULL: {non_null}")

# Show some sample non-NULL answers
non_null_vals = [v.strip() for v in ans_vals if v.strip() != 'NULL']
print(f"Sample non-NULL answers: {non_null_vals[:20]}")
