# -*- coding: utf-8 -*-
"""Debug cloze answer format - check actual format"""
import re

text = """
【36-40】JGOKB   【41-45】IFMHA 
  
【46-50】GDAFK   【51-55】HCIBJ

【56-60】CADBA   【61-65】ABCDB   
"""

# Check the actual format
print("Text around JGOKB:")
idx = text.find("JGOKB")
if idx >= 0:
    print(repr(text[max(0,idx-20):idx+20]))

# Check the pattern
pattern = re.compile(r"[【\[]?\s*(\d+)[-–](\d+)\s*[】\]]?\s*[：:]?\s*([A-D]{1,20})")
matches = list(pattern.finditer(text))
print(f"\nPattern matches: {len(matches)}")
for m in matches:
    print(f"  {m.group()}")

# Try a simpler pattern
simple_pattern = re.compile(r"(\d+)-(\d+)\s*([A-Z]{5})")
simple_matches = list(simple_pattern.finditer(text))
print(f"\nSimple pattern matches: {len(simple_matches)}")
for m in simple_matches:
    print(f"  {m.group()}")
