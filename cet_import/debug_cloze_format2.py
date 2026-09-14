# -*- coding: utf-8 -*-
"""Debug cloze answer format - check actual format"""
import re

text = """
ã€?6-40ã€‘JGOKB   ã€?1-45ã€‘IFMHA 
  
ã€?6-50ã€‘GDAFK   ã€?1-55ã€‘HCIBJ

ã€?6-60ã€‘CADBA   ã€?1-65ã€‘ABCDB   
"""

# Check the actual format
print("Text around JGOKB:")
idx = text.find("JGOKB")
if idx >= 0:
    print(repr(text[max(0,idx-20):idx+20]))

# Check the pattern
pattern = re.compile(r"[ã€\[]?\s*(\d+)[-â€“](\d+)\s*[ã€‘\]]?\s*[ï¼?]?\s*([A-D]{1,20})")
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
