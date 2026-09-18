# -*- coding: utf-8 -*-
"""扫描SQL中可疑字符（未转义单引号/反斜杠/控制字符），用于定位语法错误"""
import re

SQL_FILE = r"D:\202401\study\Topic\cet_import\cet_all_import.sql"
with open(SQL_FILE, "r", encoding="utf-8") as f:
    lines = f.readlines()

# 1. 检查每行是否含奇数个未配对单引号（粗略启发：统计行内单引号个数）
print("== 单引号数量为奇数的行（启发式，多行字符串会误报）==")
for i, line in enumerate(lines, 1):
    cnt = line.count("'")
    if cnt % 2 == 1:
        # 跳过注释行
        stripped = line.strip()
        if stripped.startswith("--"):
            continue
        # 只打印包含明显问题迹象的（先全部列出，限前80）
        print(f"行{i} (引号数={cnt}): {stripped[:150]}")

print("\n== 检查反斜杠 \\ 使用（SQL默认 \\ 为转义符）==")
backslash_lines = []
for i, line in enumerate(lines, 1):
    if "\\" in line:
        backslash_lines.append((i, line.strip()[:150]))
print(f"含反斜杠的行数: {len(backslash_lines)}")
for ln, txt in backslash_lines[:40]:
    print(f"行{ln}: {txt}")
