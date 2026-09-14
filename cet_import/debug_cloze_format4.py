# -*- coding: utf-8 -*-
"""Debug cloze answer format - check actual text"""
import re

text = """
ã€?6-40ã€‘JGOKB   ã€?1-45ã€‘IFMHA 
  
ã€?6-50ã€‘GDAFK   ã€?1-55ã€‘HCIBJ

ã€?6-60ã€‘CADBA   ã€?1-65ã€‘ABCDB   
"""

print(f"Text length: {len(text)}")
print(f"Text: {repr(text)}")

# Find all occurrences of 36-40
for m in re.finditer(r"36-40", text):
    print(f"\nFound 36-40 at {m.start()}")
    start = max(0, m.start() - 10)
    end = min(len(text), m.end() + 10)
    print(f"Context: {repr(text[start:end])}")
