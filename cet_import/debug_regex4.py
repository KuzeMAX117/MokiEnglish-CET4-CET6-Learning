# -*- coding: utf-8 -*-
"""Debug regex matching - check actual format"""
import re

with open(r'D:\202401\study\Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Find all occurrences of `answer`
matches = list(re.finditer(r"`answer`", content))
print(f"Found {len(matches)} occurrences of `answer`")

# Show the context around each occurrence
for m in matches[:5]:
    start = max(0, m.start() - 50)
    end = min(len(content), m.end() + 100)
    context = content[start:end]
    print(f"\n--- Context at {m.start()} ---")
    print(repr(context))
