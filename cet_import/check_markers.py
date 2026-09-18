# -*- coding: utf-8 -*-
"""Check for Part III marker"""
from docx import Document
import re
import os

cache_dir = r"D:\202401\study\Topic\cet_import\docx_cache"

# Check file index 3 (CET4 set 1 2015)
fname = sorted(os.listdir(cache_dir))[3]
fpath = os.path.join(cache_dir, fname)
doc = Document(fpath)

all_text = "\n".join([p.text for p in doc.paragraphs])

# Search for various markers
for marker in ["Part III", "Part\s+III", "Part 3", "阅读", "Reading"]:
    matches = list(re.finditer(marker, all_text, re.IGNORECASE))
    if matches:
        print(f"Found '{marker}': {len(matches)} matches")
        for m in matches[:3]:
            print(f"  At {m.start()}: ...{all_text[max(0,m.start()-20):m.start()+50]}...")

# Show the text around Part IV
idx = all_text.find("Part IV")
if idx >= 0:
    print(f"\nContext around Part IV:")
    print(all_text[max(0,idx-500):idx+200])
