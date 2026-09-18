# -*- coding: utf-8 -*-
"""Check cloze answers in SQL - debug pattern 8"""
import re

with open(r'D:\202401\study\Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Find the first cloze topic
idx = content.find("'cloze'")
if idx >= 0:
    print(f"Found 'cloze' at {idx}")
    # Get the surrounding context
    start = max(0, idx - 1000)
    end = min(len(content), idx + 100)
    context = content[start:end]
    
    # Check the character codes around 'answer'
    answer_idx = context.find("answer")
    if answer_idx >= 0:
        print(f"Found 'answer' at {answer_idx}")
        snippet = context[answer_idx:answer_idx+50]
        print(f"Snippet: {repr(snippet)}")
        print(f"Character codes:")
        for i, c in enumerate(snippet):
            print(f"  {i}: {c} (U+{ord(c):04X})")
    else:
        print("'answer' not found in context")
        print(f"Context:\n{context}")
