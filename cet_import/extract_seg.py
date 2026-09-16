# -*- coding: utf-8 -*-
"""提取SQL片段：行480-491（含报错的第487行语句）"""
SQL_FILE = r"D:\202401\study\Topic\cet_import\cet_all_import.sql"
OUT_FILE = r"D:\202401\study\Topic\cet_import\_test_seg.sql"

with open(SQL_FILE, "r", encoding="utf-8") as f:
    lines = f.readlines()

seg = lines[479:491]  # 行480-491
with open(OUT_FILE, "w", encoding="utf-8", newline="") as f:
    f.writelines(seg)
print("已提取行480-491，共", len(seg), "行")

# 同时 hexdump 第488行的关键部分，检查是否有非UTF8字节或特殊引号
target = lines[487]
print("第488行长度:", len(target))
# 找出所有非 ASCII 可打印字符分类
import collections
cnt = collections.Counter(c for c in target if ord(c) > 127)
print("非ASCII字符种类数:", len(cnt))
for ch, c in list(cnt.items()):
    if 0x2000 <= ord(ch) <= 0x206F or ch in "'\"`\\":
        print(f"  特殊字符 U+{ord(ch):04X} {ch!r} 出现{c}次")
# 检查是否有 U+FFFD
print("U+FFFD数量:", target.count("\ufffd"))
