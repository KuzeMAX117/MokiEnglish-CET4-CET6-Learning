# -*- coding: utf-8 -*-
"""Debug cloze answer format"""
import re

text = """
ã€?6-40ã€‘JGOKB   ã€?1-45ã€‘IFMHA 
  
ã€?6-50ã€‘GDAFK   ã€?1-55ã€‘HCIBJ

ã€?6-60ã€‘CADBA   ã€?1-65ã€‘ABCDB   
"""

# Check the character codes
idx = text.find("JGOKB")
if idx >= 0:
    print(f"Found JGOKB at {idx}")
    context = text[idx:idx+10]
    print(f"Context: {context}")
    print(f"Character codes:")
    for i, c in enumerate(context):
        print(f"  {i}: {c} (U+{ord(c):04X})")
