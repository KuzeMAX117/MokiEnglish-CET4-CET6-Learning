# -*- coding: utf-8 -*-
"""Debug answer parsing"""
from docx import Document
import re
import os

cache_dir = r"D:\202401\study\Topic\cet_import\docx_cache"

# Check file index 3 (CET4 set 1 2015)
fname = sorted(os.listdir(cache_dir))[3]
fpath = os.path.join(cache_dir, fname)
doc = Document(fpath)

all_text = "\n".join([p.text for p in doc.paragraphs])

# Find answer section
ans_start = None
for marker in ["参考答案", "参考答案：", "参考答案："]:
    idx = all_text.rfind(marker)
    if idx >= len(all_text) * 0.5:
        ans_start = idx
        print(f"Found marker '{marker}' at {idx}")
        break

if ans_start is None:
    for m in re.finditer(r"(?:^|\n)\s*(\d+)[-–](\d+)\s*[：:]\s*[A-D]", all_text):
        if m.start() > len(all_text) * 0.5:
            ans_start = m.start()
            print(f"Found answer pattern at {m.start()}")
            break

if ans_start is not None:
    answer_section = all_text[ans_start:]
    print(f"Answer section length: {len(answer_section)}")
    print(f"Answer section preview:\n{answer_section[:500]}")
    
    # Parse range answers
    range_pattern = re.compile(r"(\d+)[-–](\d+)\s*[：:]\s*([A-D]{1,20})")
    matches = list(range_pattern.finditer(answer_section))
    print(f"\nRange answer matches: {len(matches)}")
    for m in matches:
        print(f"  {m.group()}")
else:
    print("No answer section found")
    # Show last 1000 chars
    print(f"Last 1000 chars:\n{all_text[-1000:]}")
