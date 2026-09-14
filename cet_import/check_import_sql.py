# -*- coding: utf-8 -*-
"""cet_all_import.sql 静态校验脚�?""
import re
import json
import sys

SQL_FILE = r"D:\202401\study\Hao-Topic\cet_import\cet_all_import.sql"

with open(SQL_FILE, "r", encoding="utf-8") as f:
    content = f.read()

lines = content.split("\n")
print(f"总行�? {len(lines)}")

# 1. 检查非 INSERT/SET 语句（DDL 等）
bad_stmts = []
for i, line in enumerate(lines, 1):
    s = line.strip().rstrip(";")
    if not s or s.startswith("--"):
        continue
    up = s.upper()
    if not (up.startswith("INSERT INTO") or up.startswith("SET NAMES") or up.startswith("SET FOREIGN_KEY_CHECKS")):
        bad_stmts.append((i, s[:120]))
print(f"\n[1] 非INSERT/SET语句�? {len(bad_stmts)}")
for i, s in bad_stmts[:20]:
    print(f"  行{i}: {s}")

# 2. 统计 INSERT 类型
insert_counts = {}
for m in re.finditer(r"INSERT INTO\s+`?(\w+)`?", content, re.IGNORECASE):
    tbl = m.group(1).lower()
    insert_counts[tbl] = insert_counts.get(tbl, 0) + 1
print(f"\n[2] INSERT 语句分布: {insert_counts}")

# 3. 试卷元数据（标题、题号）——提�?paper INSERT �?VALUES
paper_pat = re.compile(
    r"INSERT INTO `paper` .*?VALUES \((\d+), (\d+), (\d+), '([^']*)', (\d+)\);", re.DOTALL)
papers = []
for m in paper_pat.finditer(content):
    papers.append({"line": content[:m.start()].count("\n") + 1, "level": int(m.group(1)),
                   "year": int(m.group(2)), "half": int(m.group(3)),
                   "title": m.group(4), "score": m.group(5)})
print(f"\n[3] paper 数量: {len(papers)}")
seen = {}
for p in papers:
    key = (p["level"], p["year"], p["half"], p["title"])
    seen[key] = seen.get(key, 0) + 1
    if seen[key] > 1:
        print(f"  ⚠️ 重复试卷: 行{p['line']} {p['title']}")
lv4 = [p for p in papers if p["level"] == 4]
lv6 = [p for p in papers if p["level"] == 6]
print(f"  四级 {len(lv4)} �? 六级 {len(lv6)} �?)

# 4. 检查每�?paper INSERT 之后是否�?SET @pid �?topic/paper_topic 配对
sets = list(re.finditer(r"SET @pid = LAST_INSERT_ID\(\);", content))
print(f"[4] SET @pid 数量: {len(sets)} (应与 paper 数一�?")

# 5. 提取 topic 插入：将 SQL �?';\n' 拆分后逐句解析
statements = re.split(r";\s*\n", content)
topic_stmts = []
pt_stmts = []
for st in statements:
    s = st.strip()
    if s.upper().startswith("INSERT INTO `topic`"):
        topic_stmts.append(s)
    elif s.upper().startswith("INSERT INTO `paper_topic`"):
        pt_stmts.append(s)
print(f"[5] topic INSERT: {len(topic_stmts)}, paper_topic INSERT: {len(pt_stmts)}")

# 6. 解析每个 topic 语句的值（用正则手工解析：按列顺序取字符串/数字/NULL�?# topic �? topic_name, answer, options, correct_option, question_type, analysis, article, status, create_by
col_pat = re.compile(r"VALUES \(\s*(.*?)\s*\)\s*$", re.DOTALL)


def parse_sql_string(s):
    """解析SQL字符串字面量（处�?'' 转义），返回 (�? 剩余)"""
    if s.startswith("NULL"):
        return None, s[4:]
    if s.startswith("'"):
        i = 1
        out = []
        while i < len(s):
            if s[i] == "'":
                if i + 1 < len(s) and s[i + 1] == "'":
                    out.append("'")
                    i += 2
                    continue
                return "".join(out), s[i + 1:]
            out.append(s[i])
            i += 1
        return "".join(out), ""  # 未闭�?    m = re.match(r"-?\d+", s)
    if m:
        return m.group(0), s[m.end():]
    raise ValueError(f"无法解析�? {s[:60]}")


def split_values(vals_str):
    """按逗号切分（忽略引号内逗号�?""
    result = []
    i = 0
    cur = ""
    in_str = False
    while i < len(vals_str):
        c = vals_str[i]
        if in_str:
            cur += c
            if c == "'":
                if i + 1 < len(vals_str) and vals_str[i + 1] == "'":
                    cur += vals_str[i + 1]
                    i += 1
                else:
                    in_str = False
        else:
            if c == "'":
                in_str = True
                cur += c
            elif c == ",":
                result.append(cur.strip())
                cur = ""
            else:
                cur += c
        i += 1
    if cur.strip():
        result.append(cur.strip())
    return result


errors = []
warnings = []

for idx, st in enumerate(topic_stmts):
    m = col_pat.search(st)
    if not m:
        errors.append(f"topic[{idx}]: 无法定位VALUES")
        continue
    vals = split_values(m.group(1))
    if len(vals) != 9:
        errors.append(f"topic[{idx}]: 列数={len(vals)} != 9")
        continue
    vals = [v.strip() for v in vals]

    def unquote(v):
        if v == "NULL":
            return None
        if v.startswith("'") and v.endswith("'"):
            return v[1:-1].replace("''", "'")
        return v

    topic_name = unquote(vals[0])
    answer = unquote(vals[1])
    options = unquote(vals[2])
    correct = unquote(vals[3])
    qtype = unquote(vals[4])
    analysis = unquote(vals[5])
    article = unquote(vals[6])
    status = vals[7]

    # 6.1 topic_name 过短（可能是解析失败只剩题号�?    if topic_name and len(topic_name) <= 3 and not topic_name.startswith("Directions"):
        warnings.append(f"topic[{idx}]: topic_name过短={topic_name!r} answer={answer!r} qtype={qtype}")

    # 6.2 options JSON 校验
    if options:
        try:
            opt_list = json.loads(options)
            if not isinstance(opt_list, list):
                errors.append(f"topic[{idx}]: options不是数组")
            else:
                labels = [o.get("label") for o in opt_list]
                if correct and correct not in labels:
                    errors.append(f"topic[{idx}]: correct_option={correct} 不在options labels={labels}")
        except json.JSONDecodeError as e:
            errors.append(f"topic[{idx}]: options JSON解析失败 -> {e}")

    # 6.3 correct_option �?answer 一致性（选择�?answer 应为纯字母；�?answer �?NULL �?options 非空 -> 警告�?    if options and correct:
        if answer is None:
            warnings.append(f"topic[{idx}]: 有options但answer为NULL")
        elif re.fullmatch(r"[A-O]", answer or "") is None:
            warnings.append(f"topic[{idx}]: answer={answer!r} 与correct_option={correct} 不一�?非纯字母)")

    # 6.4 qtype 合法�?    if qtype not in ("writing", "listening", "reading", "cloze", "translation", "vocabulary", None):
        errors.append(f"topic[{idx}]: question_type非法={qtype}")

    # 6.5 status 应为 0
    if status not in ("0", "NULL"):
        errors.append(f"topic[{idx}]: status={status} �?")

# 7. paper_topic 检�?pt_sections = set()
pt_subsections = set()
pt_sorted_ok = True
paper_boundary = []  # (paper标题, sorted列表)
for idx, st in enumerate(pt_stmts):
    m = col_pat.search(st)
    if not m:
        errors.append(f"pt[{idx}]: 无法定位VALUES")
        continue
    # 形式: (@pid, LAST_INSERT_ID(), 'section', 'sub', 排序)
    body = m.group(1)
    pm = re.match(r"@pid,\s*LAST_INSERT_ID\(\),\s*'([^']*)',\s*(?:'([^']*)'|NULL),\s*(\d+)", body)
    if not pm:
        # 可能是多�?values (listening, NULL)
        pm = re.match(r"@pid,\s*LAST_INSERT_ID\(\),\s*'([^']*)',\s*'([^']*)',\s*(\d+)", body)
    if not pm:
        errors.append(f"pt[{idx}]: 无法解析内容 {body[:100]}")
        continue
    sec = pm.group(1)
    sub = pm.group(2) if pm.lastindex >= 2 else None
    pt_sections.add(sec)
    if sub:
        pt_subsections.add(sub)

print(f"\n[6] topic 检�? 错误={len(errors)}, 警告={len(warnings)}")
for e in errors[:30]:
    print("  �?, e)
for w in warnings[:30]:
    print("  ⚠️", w)
if len(errors) > 30:
    print(f"  ... 其余 {len(errors)-30} 条错误省�?)
if len(warnings) > 30:
    print(f"  ... 其余 {len(warnings)-30} 条警告省�?)

print(f"\n[7] paper_topic 使用�?section: {sorted(pt_sections)}")
print(f"    paper_topic 使用�?sub_section: {sorted(pt_subsections)}")

print("\n==== 校验结束 ====")
