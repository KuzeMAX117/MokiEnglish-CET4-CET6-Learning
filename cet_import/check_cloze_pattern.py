# -*- coding: utf-8 -*-
"""Check cloze answers in SQL - debug pattern 6"""
import re

with open(r'D:\202401\study\Topic\cet_import\cet_all_import.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Test the pattern
test_text = """INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. tho words in the bank more than once.\\n\\nQuestions 36 to 45 are based on the following passage. \\nIt seem',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');"""

# Try different patterns
patterns = [
    r"'answer',\n\s+'([^']+)'",
    r"'answer',\r?\n\s+'([^']+)'",
    r"'answer',\n\s+'([A-Z])'",
]

for i, pattern in enumerate(patterns):
    matches = re.findall(pattern, test_text)
    print(f"Pattern {i}: {pattern}")
    print(f"  Matches: {matches}")
