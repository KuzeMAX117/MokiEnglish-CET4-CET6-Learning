# -*- coding: utf-8 -*-
"""Check cloze questions in SQL - debug"""
import re

with open(r'D:\202401\study\Hao-Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Find lines with cloze
for i, line in enumerate(lines):
    if 'cloze' in line.lower():
        # Print surrounding lines
        for j in range(max(0, i-10), min(len(lines), i+3)):
            print(f"Line {j+1}: {lines[j].rstrip()}")
        print("---")
        break
