# -*- coding: utf-8 -*-
"""Debug cloze answer format - check actual text"""
import re

text = """
【36-40】JGOKB   【41-45】IFMHA 
  
【46-50】GDAFK   【51-55】HCIBJ

【56-60】CADBA   【61-65】ABCDB   
"""

print(f"Text length: {len(text)}")
print(f"Text: {repr(text)}")

# Find all occurrences of 36-40
for m in re.finditer(r"36-40", text):
    print(f"\nFound 36-40 at {m.start()}")
    start = max(0, m.start() - 10)
    end = min(len(text), m.end() + 10)
    print(f"Context: {repr(text[start:end])}")
