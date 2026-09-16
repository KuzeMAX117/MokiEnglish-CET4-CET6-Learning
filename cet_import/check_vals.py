# -*- coding: utf-8 -*-
"""Check answer values"""
with open(r'D:\202401\study\Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Find lines with answer values
for i, line in enumerate(lines):
    if i > 100:
        break
    stripped = line.strip()
    if stripped in ['NULL', "'C'", "'B'", "'A'", "'D'"]:
        print(f"Line {i+1}: {repr(stripped)}")
