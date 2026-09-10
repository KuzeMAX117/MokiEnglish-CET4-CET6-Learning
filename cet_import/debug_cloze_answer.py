# -*- coding: utf-8 -*-
"""Debug cloze answer parsing"""
import re

# The cloze answers format is: 【36-45】JGOKB
# Let's check if this is being parsed correctly

text = """
【36-40】JGOKB   【41-45】IFMHA 
  
【46-50】GDAFK   【51-55】HCIBJ

【56-60】CADBA   【61-65】ABCDB   
"""

# Parse range answers
range_pattern = re.compile(r"[【\[]?\s*(\d+)[-–](\d+)\s*[】\]]?\s*[：:]?\s*([A-D]{1,20})")
matches = list(range_pattern.finditer(text))
print(f"Range answer matches: {len(matches)}")
for m in matches:
    print(f"  {m.group()}")

# Parse word answers for cloze
word_range_pattern = re.compile(r"[【\[]?\s*(\d+)[-–](\d+)\s*[】\]]?\s*[：:]?\s*(.+?)(?=[【\[]?\s*\d+[-–]\d+|$)")
word_matches = list(word_range_pattern.finditer(text))
print(f"\nWord range matches: {len(word_matches)}")
for m in word_matches:
    start, end = int(m.group(1)), int(m.group(2))
    words_text = m.group(3).strip()
    print(f"  {m.group(1)}-{m.group(2)}: {words_text[:50]}")
    
    # Skip if it's just letters (already parsed as ABCD)
    if re.match(r"^[A-D]+$", words_text):
        print(f"    -> Skipped (ABCD letters)")
        continue
    
    word_list = re.split(r"\s{2,}|\t", words_text)
    word_list = [w.strip() for w in word_list if w.strip()]
    print(f"    -> Words: {word_list}")
