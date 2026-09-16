# -*- coding: utf-8 -*-
"""Debug regex matching"""
import re

with open(r'D:\202401\study\Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Search for 'answer' in the content
matches = list(re.finditer(r"'answer'", content))
print(f"Found {len(matches)} occurrences of 'answer'")
if matches:
    for m in matches[:3]:
        start = max(0, m.start() - 20)
        end = min(len(content), m.end() + 50)
        print(f"  {repr(content[start:end])}")

# Check the actual format around line 27
lines = content.split("\n")
for i in range(24, 32):
    print(f"Line {i+1}: {repr(lines[i])}")
