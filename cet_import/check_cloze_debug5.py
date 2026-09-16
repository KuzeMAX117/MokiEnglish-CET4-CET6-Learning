# -*- coding: utf-8 -*-
"""Check cloze answers in SQL - debug pattern 5"""
import re

with open(r'D:\202401\study\Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Find the first cloze topic
idx = content.find("'cloze'")
if idx >= 0:
    print(f"Found 'cloze' at {idx}")
    # Get the surrounding context
    start = max(0, idx - 500)
    end = min(len(content), idx + 100)
    context = content[start:end]
    print(f"Context:")
    print(context)
else:
    print("'cloze' not found")
