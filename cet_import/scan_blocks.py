# -*- coding: utf-8 -*-
"""定位 fixed SQL 中每套卷的 paper INSERT 位置，打印块边界（用于按卷提取）"""
SQL_FILE = r"D:\202401\study\Hao-Topic\cet_import\cet_all_import_fixed.sql"

with open(SQL_FILE, encoding="utf-8") as f:
    lines = f.readlines()

print("total lines:", len(lines))
for i, line in enumerate(lines):
    s = line.strip()
    if s.startswith("INSERT INTO paper"):
        # 回溯最近 8 行的注释头
        ctx = []
        for j in range(max(0, i - 8), i):
            t = lines[j].strip()
            if t.startswith("--") and t not in ctx:
                ctx.append(t[:110])
        print("paper@L%d :: %s" % (i + 1, " || ".join(ctx[-3:])[:200]))
