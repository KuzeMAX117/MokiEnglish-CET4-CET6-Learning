# -*- coding: utf-8 -*-
"""Debug regex matching - check actual format"""
import re

with open(r'D:\202401\study\Hao-Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# The format is:
# INSERT INTO `topic` (...) VALUES (
#   'topic_name',
#   'answer_value',
#   ...

# So we need to find the pattern after VALUES (
ans_pattern = re.compile(r"VALUES \(\n\s+'[^']*',\n\s+'([A-D])'")
ans_vals = ans_pattern.findall(content)

ans_null_pattern = re.compile(r"VALUES \(\n\s+'[^']*',\n\s+NULL")
ans_null = len(ans_null_pattern.findall(content))

ans_word_pattern = re.compile(r"VALUES \(\n\s+'[^']*',\n\s+'([^']{2,})'")
ans_word = len(ans_word_pattern.findall(content))

print(f"Topics with ABCD answers: {len(ans_vals)}")
print(f"Topics with NULL answer: {ans_null}")
print(f"Topics with word answers: {ans_word}")
print(f"Total: {len(ans_vals) + ans_null + ans_word}")

# Show distribution
from collections import Counter
if ans_vals:
    print(f"\nAnswer distribution: {Counter(ans_vals)}")
