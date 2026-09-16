# -*- coding: utf-8 -*-
import re

with open(r'D:\202401\study\Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Count all NULL vs non-NULL answers
ans_vals = re.findall(r"'answer',\n\s+([^,]+)", content)
null_count = sum(1 for v in ans_vals if v.strip() == 'NULL')
non_null = sum(1 for v in ans_vals if v.strip() != 'NULL')
print(f"Answer values: {len(ans_vals)}")
print(f"NULL: {null_count}")
print(f"Non-NULL: {non_null}")
print(f"Sample answers: {ans_vals[:10]}")

# Show paper question counts
print("\nPapers:")
for m in re.finditer(r"-- \[(\d+)\].*?-- 题目数: (\d+)", content):
    num = m.group(1)
    count = int(m.group(2))
    status = "good" if count >= 40 else "bad" if count < 5 else "partial"
    print(f"  [{num:>2}] {count:>3} questions ({status})")
