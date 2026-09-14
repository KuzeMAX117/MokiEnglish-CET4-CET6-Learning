# -*- coding: utf-8 -*-
"""查看 2059 行附�?+ 统计所有超�?topic_name"""
SQL_FILE = r"D:\202401\study\Hao-Topic\cet_import\cet_all_import.sql"

with open(SQL_FILE, "r", encoding="utf-8") as f:
    lines = f.readlines()

print("== 2055-2070 �?==")
for ln in range(2054, 2070):
    if ln < len(lines):
        print(f"{ln+1}: {lines[ln].rstrip()[:250]}")

# 统计超长 topic_name（启发式：找所�?INSERT topic 的下一行字符串长度>2000�?print("\n== 超长 topic_name 统计 ==")
overlong = 0
for i, line in enumerate(lines):
    if "INSERT INTO `topic`" in line:
        # topic_name 在下一行或下下�?        j = i + 1
        while j < len(lines) and not lines[j].strip().startswith("'"):
            j += 1
        if j < len(lines):
            content = lines[j].strip()
            # 去掉首尾引号（粗略）
            inner = content[1:-1] if content.startswith("'") else content
            if len(inner) > 2000:
                overlong += 1
                if overlong <= 10:
                    print(f"行{j+1}: 长度={len(inner)} 内容�?00�? {inner[:100]!r}")
print(f"�?{overlong} 处可能超�?)
