# -*- coding: utf-8 -*-
"""Check why no cloze questions"""
from docx import Document
import re
import os

cache_dir = r"D:\202401\study\Topic\cet_import\docx_cache"

# Check file index 3 (CET4 set 1 2015)
fname = sorted(os.listdir(cache_dir))[3]
fpath = os.path.join(cache_dir, fname)
doc = Document(fpath)

all_text = "\n".join([p.text for p in doc.paragraphs])

# Find the reading section
reading_start = re.search(r"Part\s+III\s+Reading|Part III\s+Reading|阅读", all_text, re.IGNORECASE)
translation_start = re.search(r"Part\s+IV\s+Translation|Part IV\s+Translation|翻译", all_text, re.IGNORECASE)

if reading_start and translation_start:
    reading_text = all_text[reading_start.start():translation_start.start()]
    print(f"Reading section length: {len(reading_text)}")
    
    # Look for cloze questions (26-35)
    lines = reading_text.split("\n")
    for i, line in enumerate(lines):
        stripped = line.strip()
        if re.match(r"^\s*2[6-9]\s*[.)\]）】：:]", stripped) or re.match(r"^\s*3[0-5]\s*[.)\]）】：:]", stripped):
            print(f"Line {i}: {stripped[:80]}")
    
    # Also check for question patterns
    q_pattern = re.compile(r"^\s*(\d+)\s*[.)\]）】：:]\s*(.*)")
    for line in lines:
        stripped = line.strip()
        qm = q_pattern.match(stripped)
        if qm:
            q_num = int(qm.group(1))
            if 26 <= q_num <= 35:
                print(f"Found cloze Q{q_num}: {stripped[:80]}")
