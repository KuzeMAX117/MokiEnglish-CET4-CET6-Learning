# -*- coding: utf-8 -*-
"""Debug cloze answer parsing"""
import re

# The cloze answers format is: ã€?6-45ã€‘JGOKB
# Let's check if this is being parsed correctly

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
    print(f"  {m.group()}")

# Parse word answers for cloze
word_range_pattern = re.compile(r"[ã€\[]?\s*(\d+)[-â€“](\d+)\s*[ã€‘\]]?\s*[ï¼?]?\s*(.+?)(?=[ã€\[]?\s*\d+[-â€“]\d+|$)")
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
