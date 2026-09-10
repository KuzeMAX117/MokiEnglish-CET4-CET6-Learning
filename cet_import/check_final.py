# -*- coding: utf-8 -*-
"""Count answers properly"""
import re

with open(r'D:\202401\study\Hao-Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Count topics with non-NULL answers
# Pattern: answer column value is on the line after 'answer',
ans_vals = re.findall(r"'answer',\n\s+'([A-D])'", content)
ans_null = len(re.findall(r"'answer',\n\s+NULL", content))
ans_word = len(re.findall(r"'answer',\n\s+'([^']{2,})'", content))

print(f"Topics with ABCD answers: {len(ans_vals)}")
print(f"Topics with NULL answer: {ans_null}")
print(f"Topics with word answers: {ans_word}")
print(f"Total: {len(ans_vals) + ans_null + ans_word}")

# Show distribution
from collections import Counter
if ans_vals:
    print(f"\nAnswer distribution: {Counter(ans_vals)}")
