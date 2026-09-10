# -*- coding: utf-8 -*-
"""Check cloze question numbering"""
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
    
    # Look for all numbered questions
    q_pattern = re.compile(r"^\s*(\d+)\s*[.)\]）】：:]\s*(.*)")
    for line in reading_text.split("\n"):
        stripped = line.strip()
        qm = q_pattern.match(stripped)
        if qm:
            q_num = int(qm.group(1))
            if 36 <= q_num <= 55:
                print(f"Q{q_num}: {stripped[:80]}")
