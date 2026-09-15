# -*- coding: utf-8 -*-
"""生成修复版 SQL：将 topic_name 超过 1990 字符的行截断，保证可执行"""
SQL_FILE = r"D:\202401\study\Hao-Topic\cet_import\cet_all_import.sql"
OUT_FILE = r"D:\202401\study\Hao-Topic\cet_import\cet_all_import_fixed.sql"

with open(SQL_FILE, "r", encoding="utf-8") as f:
    content = f.read()

# 只处理 VALUES ( 之后的第一个字符串（topic_name），截断其内容到1990字符
import re

def truncate_long_string(full):
    # 提取行内字符串: 以 ' 开头 ' 结尾（该行只有一个完整字符串时）
    if full.startswith("'") and full.endswith("',"):
        inner = full[1:-2]  # 去掉首尾 ' 和 ,
        if len(inner) > 1990:
            inner = inner[:1990]
            return "'" + inner + "',"
    return full

lines = content.split("\n")
new_lines = []
changed = []
for idx, line in enumerate(lines):
    stripped = line.strip()
    # 定位 topic INSERT 的 VALUES 后第一行（topic_name 行）：行首为 ' 且长度超长
    if len(stripped) > 2005 and stripped.startswith("'"):
        # 行内含一个完整字符串 + 逗号
        new_line = truncate_long_string(stripped)
        if new_line != stripped:
            changed.append(idx + 1)
            new_lines.append(new_line)
            continue
    new_lines.append(line)

out = "\n".join(new_lines)
with open(OUT_FILE, "w", encoding="utf-8", newline="") as f:
    f.write(out)

print("截断行数:", len(changed), "->", changed)
print("输出:", OUT_FILE)
