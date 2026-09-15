# -*- coding: utf-8 -*-
"""Deep check of answer format in all docx files"""
from docx import Document
import re
import os

cache_dir = r"D:\202401\study\Hao-Topic\cet_import\docx_cache"

for fname in sorted(os.listdir(cache_dir))[:8]:
    fpath = os.path.join(cache_dir, fname)
    print(f"\n{'='*60}")
    print(f"FILE: {fname[:60]}...")
    doc = Document(fpath)
    text = "\n".join([p.text for p in doc.paragraphs])
    
    # Find answer patterns - look for the LAST occurrence
    # Pattern 1: 1-5:CBCAA
    range_matches = list(re.finditer(r"(\d+)[-–](\d+)\s*[：:]\s*([A-D]{1,20})", text))
    if range_matches:
        print(f"  Range answers found: {len(range_matches)}")
        # Show the last group
        last = range_matches[-1]
        start = max(0, last.start() - 100)
        print(f"  Context: ...{text[start:last.start()+150]}...")
    
    # Pattern 2: 1. A  2. B
    single_matches = list(re.finditer(r"(\d+)\s*[.)\]）】]\s*([A-D])\s", text))
    if single_matches:
        print(f"  Single answers found: {len(single_matches)}")
    
    # Show last 300 chars
    print(f"  Last 300 chars: ...{text[-300:]}")
