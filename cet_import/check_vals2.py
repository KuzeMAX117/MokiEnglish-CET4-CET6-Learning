# -*- coding: utf-8 -*-
"""Check answer values - search more lines"""
with open(r'D:\202401\study\Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Find lines with answer values
answer_lines = []
for i, line in enumerate(lines):
    stripped = line.strip()
    if stripped in ['NULL', "'C'", "'B'", "'A'", "'D'"]:
        answer_lines.append((i+1, stripped))

print(f"Found {len(answer_lines)} answer lines")
for line_num, val in answer_lines[:20]:
    print(f"  Line {line_num}: {val}")
