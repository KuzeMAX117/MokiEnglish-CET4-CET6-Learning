# -*- coding: utf-8 -*-
"""Debug cloze answer format - check actual answers"""
import re

# The cloze answers are: JGOKB, IFMHA, GDAFK, HCIBJ, CADBA, ABCDB
# These are NOT ABCD answers - they're word bank letters

# Let's check what the actual answers should be
# From the earlier output:
# ã€?6-40ã€‘JGOKB
# ã€?1-45ã€‘IFMHA
# ã€?6-50ã€‘GDAFK
# ã€?1-55ã€‘HCIBJ
# ã€?6-60ã€‘CADBA
# ã€?1-65ã€‘ABCDB

# These are the answer keys for the cloze section
# Each letter corresponds to a word in the word bank

# Let's check if the answer parser is correctly identifying these
text = """
ã€?6-40ã€‘JGOKB   ã€?1-45ã€‘IFMHA 
  
ã€?6-50ã€‘GDAFK   ã€?1-55ã€‘HCIBJ

ã€?6-60ã€‘CADBA   ã€?1-65ã€‘ABCDB   
"""

# Parse range answers
range_pattern = re.compile(r"[ã€\[]?\s*(\d+)[-â€“](\d+)\s*[ã€‘\]]?\s*[ï¼?]?\s*([A-D]{1,20})")
matches = list(range_pattern.finditer(text))
print(f"Range answer matches: {len(matches)}")
for m in matches:
    start, end, ans_str = int(m.group(1)), int(m.group(2)), m.group(3)
    print(f"  {m.group(1)}-{m.group(2)}: {ans_str}")
    
    # Check if this is ABCD or word bank letters
    if re.match(r"^[A-D]+$", ans_str):
        print(f"    -> ABCD answers")
    else:
        print(f"    -> Word bank letters")
