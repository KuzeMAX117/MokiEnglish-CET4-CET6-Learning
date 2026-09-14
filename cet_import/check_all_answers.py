# -*- coding: utf-8 -*-
"""Check if answers are in any docx files"""
import zipfile
import re
import os

cache_dir = r"D:\202401\study\Hao-Topic\cet_import\docx_cache"

for fname in sorted(os.listdir(cache_dir)):
    fpath = os.path.join(cache_dir, fname)
    try:
        with zipfile.ZipFile(fpath, 'r') as z:
            with z.open('word/document.xml') as f:
                content = f.read().decode('utf-8')
            
            # Search for answer patterns
            range_matches = re.findall(r"(\d+)[-â€“](\d+)\s*[ï¼?]\s*([A-D]{1,20})", content)
            if range_matches:
                print(f"FOUND ANSWERS in {fname[:50]}...")
                print(f"  Matches: {range_matches[:5]}")
    except Exception as e:
        pass

print("\nDone checking all files")
