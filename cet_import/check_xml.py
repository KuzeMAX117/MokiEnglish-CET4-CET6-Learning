# -*- coding: utf-8 -*-
"""Check docx XML for answer content"""
from docx import Document
import re
import os
import zipfile

cache_dir = r"D:\202401\study\Topic\cet_import\docx_cache"

# Check the first file
fname = sorted(os.listdir(cache_dir))[0]
fpath = os.path.join(cache_dir, fname)

print(f"File: {fname}")

# Read the XML directly
with zipfile.ZipFile(fpath, 'r') as z:
    # List all files in the docx
    print("\nFiles in docx:")
    for name in z.namelist():
        print(f"  {name}")
    
    # Read the main document
    with z.open('word/document.xml') as f:
        content = f.read().decode('utf-8')
    
    # Search for answer patterns in XML
    print("\n--- Searching XML for answers ---")
    range_matches = re.findall(r"(\d+)[-–](\d+)\s*[：:]\s*([A-D]{1,20})", content)
    print(f"Range answer matches: {range_matches}")
    
    # Search for 参考答案
    idx = content.rfind("参考答案")
    if idx >= 0:
        print(f"\nFound 参考答案 in XML")
        print(f"  Context: {content[idx:idx+300]}")
    
    # Check for answer section
    for marker in ["1-5:", "6-10:", "11-15:", "16-20:", "21-25:"]:
        idx = content.find(marker)
        if idx >= 0:
            print(f"\nFound '{marker}' at {idx}")
            print(f"  Context: ...{content[max(0,idx-50):idx+100]}...")
