# -*- coding: utf-8 -*-
"""Debug cloze answer format - check character codes"""
import re

text = """
ã€?6-40ã€‘JGOKB   ã€?1-45ã€‘IFMHA 
  
ã€?6-50ã€‘GDAFK   ã€?1-55ã€‘HCIBJ

ã€?6-60ã€‘CADBA   ã€?1-65ã€‘ABCDB   
"""

# Check the character codes for the brackets
idx = text.find("36-40")
if idx >= 0:
    print(f"Found 36-40 at {idx}")
    context = text[idx-5:idx+15]
    print(f"Context: {context}")
    print(f"Character codes:")
    for i, c in enumerate(context):
        print(f"  {i}: {c} (U+{ord(c):04X})")
