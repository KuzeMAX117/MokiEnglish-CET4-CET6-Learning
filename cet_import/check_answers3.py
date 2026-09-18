# -*- coding: utf-8 -*-
"""Deep check of answer format in docx"""
from docx import Document
import re
import os

cache_dir = r"D:\202401\study\Topic\cet_import\docx_cache"

# Check the 2015 CET4 set 1 file (index 03)
fname = sorted(os.listdir(cache_dir))[3]
fpath = os.path.join(cache_dir, fname)
doc = Document(fpath)
text = "\n".join([p.text for p in doc.paragraphs])

# Find all lines with number patterns
lines = text.split("\n")
for i, line in enumerate(lines):
    stripped = line.strip()
    if re.match(r"^\d+[-–]\d+", stripped):
        print(f"Line {i}: {stripped[:150]}")
    if re.match(r"^\d+\s*[.)\]）】]\s*[A-D]", stripped):
        print(f"Line {i}: {stripped[:150]}")

print("\n--- Last 1000 chars ---")
print(text[-1000:])
