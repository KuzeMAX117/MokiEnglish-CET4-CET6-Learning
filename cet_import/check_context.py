# -*- coding: utf-8 -*-
"""查看 6146 行超长记录上下文 + 统计每套卷题数与残缺题分布"""
SQL_FILE = r"D:\202401\study\Hao-Topic\cet_import\cet_all_import.sql"

with open(SQL_FILE, "r", encoding="utf-8") as f:
    lines = f.readlines()

print("== 6138-6165 行 ==")
for ln in range(6137, 6165):
    if ln < len(lines):
        print(f"{ln+1}: {lines[ln].rstrip()[:160]}")

# 统计每个 paper 块：标题 + 注释题数 + 实际 topic/paper_topic 语句数
import re
print("\n== 每套卷声明的题目数 ==")
for i, line in enumerate(lines):
    m = re.search(r"-- \[(\d+)\] (\S+)", line)
    if m:
        print(f"行{i+1}: 卷[{m.group(1)}] {m.group(2)}")
    m2 = re.match(r"-- \u9898\u76ee\u6570: (\d+)", line.strip())
    if m2:
        print(f"   -> 声明题目数: {m2.group(1)}")
