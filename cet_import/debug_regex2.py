# -*- coding: utf-8 -*-
"""Debug regex matching - check backticks"""
import re

with open(r'D:\202401\study\Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Search for answer column
matches = list(re.finditer(r"`answer`", content))
print(f"Found {len(matches)} occurrences of `answer`")
if matches:
    for m in matches[:3]:
        start = max(0, m.start() - 20)
        end = min(len(content), m.end() + 50)
        print(f"  {repr(content[start:end])}")

# Count topics with non-NULL answers
# Pattern: `answer`,\n  'X'
ans_vals = re.findall(r"`answer`,\n\s+'([A-D])'", content)
ans_null = len(re.findall(r"`answer`,\n\s+NULL", content))
ans_word = len(re.findall(r"`answer`,\n\s+'([^']{2,})'", content))

print(f"\nTopics with ABCD answers: {len(ans_vals)}")
print(f"Topics with NULL answer: {ans_null}")
print(f"Topics with word answers: {ans_word}")
print(f"Total: {len(ans_vals) + ans_null + ans_word}")

# Show distribution
from collections import Counter
if ans_vals:
    print(f"\nAnswer distribution: {Counter(ans_vals)}")
