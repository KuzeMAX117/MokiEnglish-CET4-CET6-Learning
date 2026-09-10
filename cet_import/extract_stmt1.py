# -*- coding: utf-8 -*-
"""提取第487-491行完整语句单独测试；同时检查 2043 行附近"""
SQL_FILE = r"D:\202401\study\Hao-Topic\cet_import\cet_all_import.sql"

with open(SQL_FILE, "r", encoding="utf-8") as f:
    lines = f.readlines()

# 语句1: 487-491
seg1 = lines[486:491]
with open(r"D:\202401\study\Hao-Topic\cet_import\_test_stmt1.sql", "w", encoding="utf-8", newline="") as f:
    f.writelines(seg1)
print("== 语句1(487-491) ==")
print("".join(seg1))

# 2043 行附近
print("\n== 2043行附近 ==")
for ln in range(2035, 2055):
    if ln < len(lines):
        print(f"{ln+1}: {lines[ln].rstrip()[:200]}")
