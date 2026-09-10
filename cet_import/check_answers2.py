# -*- coding: utf-8 -*-
"""Check answer section format"""
from docx import Document
import re
import os

cache_dir = r"D:\202401\study\Hao-Topic\cet_import\docx_cache"

for fname in sorted(os.listdir(cache_dir))[:5]:
    fpath = os.path.join(cache_dir, fname)
    print(f"\n{'='*60}")
    print(f"FILE: {fname[:50]}...")
    doc = Document(fpath)
    text = "\n".join([p.text for p in doc.paragraphs])
    
    # Search for answer patterns
    patterns_to_find = [
        (r"\d+[-–]\d+\s*[：:]\s*[A-D]+", "range answers"),
        (r"参考答案", "参考答案"),
        (r"答案[：:]", "答案："),
    ]
    
    for pat, desc in patterns_to_find:
        matches = list(re.finditer(pat, text))
        if matches:
            last = matches[-1]
            print(f"Found '{desc}' (count={len(matches)}), last at pos {last.start()}")
            print(f"  Context: ...{text[max(0,last.start()-20):last.start()+100]}...")
    
    # Also show last 200 chars
    print(f"\nLast 200 chars:")
    print(text[-200:])
