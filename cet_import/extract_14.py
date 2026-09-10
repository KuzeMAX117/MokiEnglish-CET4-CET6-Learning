# -*- coding: utf-8 -*-
"""从修复版 SQL 中按卷号提取 14 套优质卷，生成部分导入 SQL"""
import re

SQL_FILE = r"D:\202401\study\Hao-Topic\cet_import\cet_all_import_fixed.sql"
OUT_FILE = r"D:\202401\study\Hao-Topic\cet_import\cet_import_14papers.sql"

# 目标卷号（按 SQL 中 paper 出现顺序 1..32）
TARGETS = [1, 3, 6, 9, 11, 13, 15, 17, 18, 20, 21, 23, 24, 26]

with open(SQL_FILE, encoding="utf-8") as f:
    lines = f.readlines()

# 定位每个卷块起点（INSERT INTO `paper`）
starts = []
for i, line in enumerate(lines):
    if line.strip().startswith("INSERT INTO `paper`"):
        starts.append(i)

print("paper blocks found:", len(starts))
assert len(starts) == 32, "expect 32 paper blocks"

# 每个块的标题注释（块起点前最近的 -- [N] 行）
titles = {}
for idx, s in enumerate(starts):
    m = None
    for j in range(max(0, s - 10), s):
        t = lines[j].strip()
        if t.startswith("-- [%d]" % (idx + 1)):
            m = t
            break
    titles[idx + 1] = m if m else "(no header)"
    print("vol %2d: L%-6d %s" % (idx + 1, s + 1, titles[idx + 1][:100]))

# 提取目标块
header_end = 0
for i, line in enumerate(lines[: starts[0]]):
    if line.strip().startswith("SET FOREIGN_KEY_CHECKS=0"):
        header_end = i + 1
        break

out = lines[:header_end]  # 头部 SET NAMES / FOREIGN_KEY_CHECKS
out.append("\n")
total_topic = 0
for vol in TARGETS:
    s = starts[vol - 1]
    e = starts[vol] if vol < 32 else len(lines)
    block = lines[s:e]
    # 块内 topic / paper_topic 计数
    n_topic = sum(1 for l in block if l.strip().startswith("INSERT INTO `topic`"))
    n_pt = sum(1 for l in block if l.strip().startswith("INSERT INTO `paper_topic`"))
    assert n_topic == n_pt, "vol %d topic/pt mismatch %d/%d" % (vol, n_topic, n_pt)
    total_topic += n_topic
    # 卷注释头（含标题）一并带上：回找 -- [N] 及上方注释行到 -- ==== 边界
    hdr = []
    for j in range(s - 1, max(0, s - 12), -1):
        t = lines[j].strip()
        if t.startswith("-- ===="):
            break
        hdr.append(lines[j])
    out.append("-- " + "=" * 60 + "\n")
    out.extend(reversed(hdr))
    out.extend(block)
    out.append("\n")

with open(OUT_FILE, "w", encoding="utf-8", newline="") as f:
    f.writelines(out)

print("target vols:", TARGETS)
print("total topic/pt pairs:", total_topic)
print("output:", OUT_FILE)
