# -*- coding: utf-8 -*-
"""Debug cloze answer format - check pattern matching"""
import re

text = """
ã€?6-40ã€‘JGOKB   ã€?1-45ã€‘IFMHA 
  
ã€?6-50ã€‘GDAFK   ã€?1-55ã€‘HCIBJ

ã€?6-60ã€‘CADBA   ã€?1-65ã€‘ABCDB   
"""

# Check the pattern
pattern = re.compile(r"[ã€\[]?\s*(\d+)[-â€“](\d+)\s*[ã€‘\]]?\s*[ï¼?]?\s*([A-D]{1,20})")
matches = list(pattern.finditer(text))
print(f"Pattern matches: {len(matches)}")
for m in matches:
    print(f"  {m.group()}")

# Try a more specific pattern for full-width brackets
fullwidth_pattern = re.compile(r"ã€?\d+)-(\d+)ã€?[A-Z]{5})")
fullwidth_matches = list(fullwidth_pattern.finditer(text))
print(f"\nFull-width pattern matches: {len(fullwidth_matches)}")
for m in fullwidth_matches:
    print(f"  {m.group()}")
