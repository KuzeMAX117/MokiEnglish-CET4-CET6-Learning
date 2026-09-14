# -*- coding: utf-8 -*-
"""Debug answer format"""
from docx import Document
import re
import os

cache_dir = r"D:\202401\study\Hao-Topic\cet_import\docx_cache"

# Check file index 3 (CET4 set 1 2015)
fname = sorted(os.listdir(cache_dir))[3]
fpath = os.path.join(cache_dir, fname)
doc = Document(fpath)

all_text = "\n".join([p.text for p in doc.paragraphs])

# Find the answer section
idx = all_text.rfind("1-5")
if idx >= 0:
    print(f"Found '1-5' at {idx}")
    # Show the context
    context = all_text[idx:idx+200]
    print(f"Context: {context}")
    print(f"\nCharacter codes:")
    for i, c in enumerate(context[:50]):
        print(f"  {i}: {c} (U+{ord(c):04X})")
else:
    print("'1-5' not found")
    # Search for patterns
    for pattern in [r"1[-â€“]5", r"1-5", r"1ï¼?", r"1:5"]:
        matches = list(re.finditer(pattern, all_text))
        print(f"Pattern '{pattern}': {len(matches)} matches")
