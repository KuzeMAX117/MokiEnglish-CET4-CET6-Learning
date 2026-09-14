# -*- coding: utf-8 -*-
"""Check full text of CET4 file"""
from docx import Document
import re
import os

cache_dir = r"D:\202401\study\Hao-Topic\cet_import\docx_cache"

# Check file index 3 (CET4 set 1 2015)
fname = sorted(os.listdir(cache_dir))[3]
fpath = os.path.join(cache_dir, fname)
doc = Document(fpath)

print(f"File: {fname}")

# Get all text
all_text = "\n".join([p.text for p in doc.paragraphs])
print(f"Total text length: {len(all_text)}")

# Search for answer patterns in the full text
print("\n--- Searching for answers ---")
for pattern in [r"\d+[-–]\d+\s*[�?]\s*[A-D]", r"参考答�?, r"答案", r"1-5:", r"6-10:"]:
    matches = list(re.finditer(pattern, all_text))
    if matches:
        print(f"Pattern '{pattern}': {len(matches)} matches")
        for m in matches[:3]:
            start = max(0, m.start() - 50)
            print(f"  {all_text[start:m.start()+100]}")

# Show the last 2000 chars
print(f"\n--- Last 2000 chars ---")
print(all_text[-2000:])
