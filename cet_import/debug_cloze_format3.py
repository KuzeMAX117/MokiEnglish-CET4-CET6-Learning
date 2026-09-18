# -*- coding: utf-8 -*-
"""Debug cloze answer format - check character codes"""
import re

text = """
【36-40】JGOKB   【41-45】IFMHA 
  
【46-50】GDAFK   【51-55】HCIBJ

【56-60】CADBA   【61-65】ABCDB   
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
