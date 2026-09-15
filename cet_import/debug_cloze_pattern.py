# -*- coding: utf-8 -*-
"""Debug cloze answer format - check pattern matching"""
import re

text = """
【36-40】JGOKB   【41-45】IFMHA 
  
【46-50】GDAFK   【51-55】HCIBJ

【56-60】CADBA   【61-65】ABCDB   
"""

# Check the pattern
pattern = re.compile(r"[【\[]?\s*(\d+)[-–](\d+)\s*[】\]]?\s*[：:]?\s*([A-D]{1,20})")
matches = list(pattern.finditer(text))
print(f"Pattern matches: {len(matches)}")
for m in matches:
    print(f"  {m.group()}")

# Try a more specific pattern for full-width brackets
fullwidth_pattern = re.compile(r"【(\d+)-(\d+)】([A-Z]{5})")
fullwidth_matches = list(fullwidth_pattern.finditer(text))
print(f"\nFull-width pattern matches: {len(fullwidth_matches)}")
for m in fullwidth_matches:
    print(f"  {m.group()}")
