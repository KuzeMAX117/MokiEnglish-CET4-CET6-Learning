# -*- coding: utf-8 -*-
"""Check answer parsing in docx files"""
from docx import Document
import re
import os

cache_dir = r"D:\202401\study\Hao-Topic\cet_import\docx_cache"

for fname in sorted(os.listdir(cache_dir))[:5]:
    fpath = os.path.join(cache_dir, fname)
    print(f"\n{'='*60}")
    print(f"FILE: {fname}")
    print(f"{'='*60}")
    doc = Document(fpath)
    text = "\n".join([p.text for p in doc.paragraphs])
    
    # Search for answer section
    for marker in ["参考答案", "答案", "Answer", "ANSWER", "参考答案：", "参考答案："]:
        idx = text.rfind(marker)
        if idx > len(text) * 0.3:
            print(f"Found '{marker}' at index {idx}")
            snippet = text[idx:idx+500]
            print(f"Content:\n{snippet}")
            break
    else:
        # Show last 300 chars
        print("No answer marker found. Last 300 chars:")
        print(text[-300:])
