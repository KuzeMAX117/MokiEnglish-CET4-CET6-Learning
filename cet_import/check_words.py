# -*- coding: utf-8 -*-
"""Check word answers for cloze"""
import re

with open(r'D:\202401\study\Hao-Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Find all word answers (not ABCD, not NULL)
word_pattern = re.compile(r"VALUES \(\n\s+'[^']*',\n\s+'([^']+)'")
all_answers = word_pattern.findall(content)

# Filter out ABCD answers
word_answers = [a for a in all_answers if not re.match(r'^[A-D]+$', a) and a != 'NULL']

print(f"Total non-NULL answers: {len(all_answers)}")
print(f"Word answers: {len(word_answers)}")
print(f"Sample word answers: {word_answers[:20]}")
