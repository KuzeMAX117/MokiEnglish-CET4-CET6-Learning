# -*- coding: utf-8 -*-
"""Debug cloze answer format"""
import re

text = """
【36-40】JGOKB   【41-45】IFMHA 
  
【46-50】GDAFK   【51-55】HCIBJ

【56-60】CADBA   【61-65】ABCDB   
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
