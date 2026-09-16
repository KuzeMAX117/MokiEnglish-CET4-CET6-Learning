# -*- coding: utf-8 -*-
"""严格模拟 MySQL 字符串解析，找出未闭合字符串 / 语法问题的语句位置"""
SQL_FILE = r"D:\202401\study\Topic\cet_import\cet_all_import.sql"

with open(SQL_FILE, "r", encoding="utf-8") as f:
    content = f.read()

lines = content.split("\n")

# 逐字符扫描：状态机
# state: 0=代码 1=单引号字符串 2=双引号字符串 3=行注释(--) 4=块注释(/* */)
state = 0
unclosed = []
line = 1
col = 0
stmt_start_line = 1
i = 0
n = len(content)
quote_style = None
escaped = False

while i < n:
    c = content[i]
    if c == "\n":
        line += 1
        col = 0
        i += 1
        continue
    col += 1

    if state == 3:  # 行注释
        if c == "\n":
            state = 0
        i += 1
        continue

    if state == 4:  # 块注释
        if c == "*" and i + 1 < n and content[i + 1] == "/":
            state = 0
            i += 2
            continue
        i += 1
        continue

    if state == 0:
        # 检测注释
        if c == "-" and i + 1 < n and content[i + 1] == "-":
            state = 3
            i += 2
            continue
        if c == "/" and i + 1 < n and content[i + 1] == "*":
            state = 4
            i += 2
            continue
        if c == "'":
            state = 1
            i += 1
            continue
        if c == '"':
            state = 2
            i += 1
            continue
        if c == ";":
            stmt_start_line = line
        i += 1
        continue

    if state in (1, 2):  # 字符串内
        if escaped:  # 上一个字符是反斜杠
            escaped = False
            i += 1
            continue
        if c == "\\":
            escaped = True
            i += 1
            continue
        if (state == 1 and c == "'") or (state == 2 and c == '"'):
            # 检查 '' 双写转义
            if i + 1 < n and content[i + 1] == c:
                i += 2
                continue
            state = 0
            i += 1
            continue
        i += 1
        continue

if state == 1:
    print(f"❌ 文件结束仍处于单引号字符串未闭合！开始于行{stmt_start_line}")
elif state == 2:
    print(f"❌ 文件结束仍处于双引号字符串未闭合！开始于行{stmt_start_line}")
else:
    print("✅ 扫描到文件末尾：所有字符串均已闭合")

# 提取第 480-500 行原文，逐字符检查 488 行
print("\n=== 第 480-500 行原文 ===")
for ln in range(479, 500):
    if ln < len(lines):
        print(f"{ln+1}: {lines[ln].rstrip()[:300]}")

# 专门检查 488 行（翻译题字符串）是否含 ASCII 单引号或反斜杠
if len(lines) > 487:
    target = lines[487]
    print(f"\n=== 第 488 行 ASCII 单引号位置 ===")
    for idx, ch in enumerate(target):
        if ch == "'":
            print(f"  位置{idx}: {target[max(0,idx-30):idx+30]!r}")
    print(f"=== 第 488 行反斜杠位置 ===")
    for idx, ch in enumerate(target):
        if ch == "\\":
            print(f"  位置{idx}: {target[max(0,idx-30):idx+30]!r}")
