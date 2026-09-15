# -*- coding: utf-8 -*-
"""Check full XML content for answers"""
import zipfile
import re
import os

cache_dir = r"D:\202401\study\Hao-Topic\cet_import\docx_cache"

# Check the first file (CET6 set 1 2015)
fname = sorted(os.listdir(cache_dir))[0]
fpath = os.path.join(cache_dir, fname)

print(f"File: {fname}")

with zipfile.ZipFile(fpath, 'r') as z:
    with z.open('word/document.xml') as f:
        content = f.read().decode('utf-8')
    
    # Search for answer patterns
    print("\n--- Searching for answers in XML ---")
    
    # Pattern 1: 1-5:CBCAA
    matches = re.findall(r"(\d+)[-–](\d+)\s*[：:]\s*([A-D]{1,20})", content)
    print(f"Range answers (1-5:CBCAA): {matches}")
    
    # Pattern 2: look for 参考答案
    idx = content.find("参考答案")
    if idx >= 0:
        print(f"\nFound 参考答案 at {idx}")
        # Extract surrounding text
        start = max(0, idx - 100)
        print(f"Context: {content[start:idx+500]}")
    
    # Check for answer section markers
    for marker in ["1-5", "6-10", "11-15", "16-20", "21-25"]:
        idx = content.find(marker)
        if idx >= 0:
            print(f"\nFound '{marker}' at {idx}")
            print(f"Context: ...{content[max(0,idx-50):idx+100]}...")
    
    # Show last 1000 chars of the XML
    print("\n--- Last 1000 chars of XML ---")
    print(content[-1000:])
