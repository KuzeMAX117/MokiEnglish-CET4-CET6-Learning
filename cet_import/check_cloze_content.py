# -*- coding: utf-8 -*-
"""Check reading section content"""
from docx import Document
import re
import os

cache_dir = r"D:\202401\study\Hao-Topic\cet_import\docx_cache"

# Check file index 3 (CET4 set 1 2015)
fname = sorted(os.listdir(cache_dir))[3]
fpath = os.path.join(cache_dir, fname)
doc = Document(fpath)

all_text = "\n".join([p.text for p in doc.paragraphs])

# Find the reading section
reading_start = re.search(r"Part\s+III\s+Reading|Part III\s+Reading|Reading Comprehension|阅读", all_text, re.IGNORECASE)
translation_start = re.search(r"Part\s+IV\s+Translation|Part IV\s+Translation|翻译", all_text, re.IGNORECASE)

if reading_start and translation_start:
    reading_text = all_text[reading_start.start():translation_start.start()]
    
    # Show the content around the cloze section
    lines = reading_text.split("\n")
    for i, line in enumerate(lines):
        if "36" in line or "Questions 36" in line:
            print(f"Line {i}: {line[:100]}")
            # Show next 20 lines
            for j in range(i+1, min(len(lines), i+21)):
                print(f"  {j}: {lines[j][:100]}")
            break
