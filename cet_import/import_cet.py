# -*- coding: utf-8 -*-
"""
四六级真题完整导入脚�?v4
修复答案解析 - 处理【】括号格�?"""
import os
import re
import json
import time
import base64
import urllib3
import requests
from docx import Document
from datetime import datetime

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

REPO_API = "https://api.github.com/repos/DieDiDi/CET4-6-past-exam-paper/git/trees/main?recursive=1"
OUTPUT_DIR = os.path.dirname(os.path.abspath(__file__))
SQL_OUTPUT = os.path.join(OUTPUT_DIR, "cet_all_import.sql")
CACHE_DIR = os.path.join(OUTPUT_DIR, "docx_cache")

os.makedirs(CACHE_DIR, exist_ok=True)


def get_docx_file_list():
    print("正在获取GitHub文件列表...")
    r = requests.get(REPO_API, verify=False, timeout=30)
    r.raise_for_status()
    data = r.json()
    files = []
    for item in data["tree"]:
        if item["path"].endswith(".docx") and item["type"] == "blob":
            files.append({"path": item["path"], "sha": item["sha"], "url": item["url"]})
    print(f"  找到 {len(files)} 个docx文件")
    return files


def download_docx(file_info, index):
    safe_name = re.sub(r'[^\w]', '_', file_info["path"])[:80]
    cache_path = os.path.join(CACHE_DIR, f"{index:02d}_{safe_name}.docx")
    if os.path.exists(cache_path) and os.path.getsize(cache_path) > 1000:
        return cache_path
    print(f"  下载: {os.path.basename(file_info['path'])}")
    r = requests.get(file_info["url"], verify=False, timeout=30)
    r.raise_for_status()
    content = base64.b64decode(r.json()["content"])
    with open(cache_path, "wb") as f:
        f.write(content)
    return cache_path


def parse_exam_meta(filepath):
    meta = {"level": 4, "year": 2015, "half": 2, "set_num": 1}
    ym = re.search(r"(\d{4})�?\d{1,2})�?, filepath)
    if ym:
        meta["year"] = int(ym.group(1))
        meta["half"] = 1 if int(ym.group(2)) <= 6 else 2
    if "四级" in filepath or "CET4" in filepath:
        meta["level"] = 4
    else:
        meta["level"] = 6
    sm = re.search(r"[卷第]([一二三123])", filepath)
    if sm:
        c = sm.group(1)
        meta["set_num"] = {"一": 1, "�?: 2, "�?: 3, "1": 1, "2": 2, "3": 3}.get(c, 1)
    elif "�?�? in filepath or "�?1 �? in filepath:
        meta["set_num"] = 1
    elif "�?�? in filepath or "�?2 �? in filepath:
        meta["set_num"] = 2
    elif "�?�? in filepath or "�?3 �? in filepath:
        meta["set_num"] = 3
    half_text = "上半�? if meta["half"] == 1 else "下半�?
    level_text = "四级" if meta["level"] == 4 else "六级"
    meta["title"] = f"{meta['year']}年{half_text}大学英语{level_text}真题（第{meta['set_num']}套）"
    return meta


def read_docx(docx_path):
    doc = Document(docx_path)
    return "\n".join([p.text for p in doc.paragraphs])


def parse_answers_v4(text):
    """Improved answer parser - handles 【�?brackets and word bank letters"""
    answers = {}
    
    # Find answer section - look for the actual answer key patterns
    # The answers are typically at the very end of the text
    # Format: �?-5】CBDAA    �?-10】DBDAC    �?1-15】BACCD    �?6-20】ADCCB
    # Or: 1-5:CBDAA    6-10:DBDAC
    # Cloze answers: �?6-40】JGOKB (word bank letters, not ABCD)
    
    # First, try to find the answer section by looking for patterns like "�?-5�? or "1-5:"
    ans_start = None
    
    # Try to find "参考答�? marker
    for marker in ["参考答�?, "参考答案：", "参考答案："]:
        idx = text.rfind(marker)
        if idx >= len(text) * 0.5:  # Must be in the second half
            ans_start = idx
            break
    
    # If no marker found, look for the first answer pattern
    if ans_start is None:
        # Look for patterns like "�?-5�? or "1-5�? at the start of a line
        for m in re.finditer(r"(?:^|\n)\s*[【\[]?\s*(\d+)[-–](\d+)\s*[】\]]?\s*[�?]?\s*[A-D]", text):
            if m.start() > len(text) * 0.5:  # Must be in the second half
                ans_start = m.start()
                break
    
    if ans_start is not None:
        answer_section = text[ans_start:]
    else:
        # Use the entire text as a fallback
        answer_section = text
    
    # Parse range answers: �?-5】CBDAA or 1-5:CBDAA
    # Handle 【�? [], and colons
    # Also handle word bank letters like �?6-40】JGOKB
    range_pattern = re.compile(r"[【\[]?\s*(\d+)[-–](\d+)\s*[】\]]?\s*[�?]?\s*([A-Za-z]{1,20})")
    for rm in range_pattern.finditer(answer_section):
        start, end, ans_str = int(rm.group(1)), int(rm.group(2)), rm.group(3).upper()
        if end - start + 1 == len(ans_str):
            for i, ch in enumerate(ans_str):
                answers[start + i] = ch
    
    # Parse word answers for cloze: �?6-30】word1  word2  word3  word4  word5
    word_range_pattern = re.compile(r"[【\[]?\s*(\d+)[-–](\d+)\s*[】\]]?\s*[�?]?\s*(.+?)(?=[【\[]?\s*\d+[-–]\d+|$)")
    for wm in word_range_pattern.finditer(answer_section):
        start, end = int(wm.group(1)), int(wm.group(2))
        words_text = wm.group(3).strip()
        # Skip if it's just letters (already parsed as ABCD or word bank)
        if re.match(r"^[A-Za-z]+$", words_text):
            continue
        word_list = re.split(r"\s{2,}|\t", words_text)
        word_list = [w.strip() for w in word_list if w.strip()]
        if len(word_list) == end - start + 1:
            for i, w in enumerate(word_list):
                answers[start + i] = w
    
    # Also try single-line answers: 1. A  2. B  etc.
    single_pattern = re.compile(r"(\d+)\s*[.)\]）】]\s*([A-D])\s")
    for sm in single_pattern.finditer(answer_section):
        q_num = int(sm.group(1))
        if q_num not in answers:
            answers[q_num] = sm.group(2)
    
    return answers


def extract_writing_directions(text):
    """Extract writing directions"""
    m = re.search(r"Directions:\s*(.*?)(?=Part\s+II|Part\s+III|听力|Listening|$)", text, re.DOTALL | re.IGNORECASE)
    if m:
        return re.sub(r"\s+", " ", m.group(1).strip())
    return None


def parse_listening_questions_v2(text, level, year):
    """Parse listening questions with improved detection"""
    questions = []
    lines = text.split("\n")
    
    q_pattern = re.compile(r"^\s*(\d+)\s*[.)\]）】]\s*(.+)")
    current_q = None
    current_text = ""
    q_texts = {}
    
    for line in lines:
        stripped = line.strip()
        qm = q_pattern.match(stripped)
        if qm:
            q_num = int(qm.group(1))
            if 1 <= q_num <= 25:
                if current_q is not None:
                    q_texts[current_q] = current_text.strip()
                current_q = q_num
                current_text = qm.group(2)
        elif current_q is not None:
            if re.match(r"^\s*[A-D]\s*[.)\]）�?：]", stripped):
                current_text += " " + stripped
            elif re.match(r"Questions?\s+\d+|Section\s+[ABC]|Part\s+[III]+|Passage\s+[OneTwo]|Directions", stripped, re.IGNORECASE):
                q_texts[current_q] = current_text.strip()
                current_q = None
                current_text = ""
            else:
                current_text += " " + stripped
    
    if current_q is not None:
        q_texts[current_q] = current_text.strip()
    
    for q_num in sorted(q_texts.keys()):
        q_text = q_texts[q_num]
        options = []
        option_matches = re.findall(r"([A-D])\s*[.)\]）�?：]\s*(.*?)(?=\s*[A-D]\s*[.)\]）�?：]|$)", q_text, re.DOTALL)
        for label, content in option_matches:
            content = re.sub(r"\s+", " ", content).strip()
            if content:
                options.append({"label": label, "content": content})
        
        clean = re.sub(r"[A-D]\s*[.)\]）�?：]\s*.*", "", q_text).strip()
        clean = re.sub(r"^\d+\s*[.)\]）】]\s*", "", clean).strip()
        
        questions.append({
            "num": q_num,
            "question": f"Q{q_num}: {clean}" if clean else f"Q{q_num}",
            "options": options,
        })
    
    return questions


def parse_cloze_questions_v2(text):
    """Parse cloze questions - handles embedded numbers in passage"""
    questions = []
    
    # First try the old format (numbered items)
    lines = text.split("\n")
    q_pattern = re.compile(r"^\s*(\d+)\s*[.)\]）】：:]\s*(.*)")
    
    for line in lines:
        stripped = line.strip()
        qm = q_pattern.match(stripped)
        if qm:
            q_num = int(qm.group(1))
            if 26 <= q_num <= 35 or 36 <= q_num <= 45:
                questions.append({
                    "num": q_num,
                    "question": f"{q_num}. {qm.group(2).strip()}" if qm.group(2).strip() else f"{q_num}. (选词填空)",
                })
    
    # If no questions found, try to find embedded numbers in passage
    if not questions:
        # Look for patterns like "is 36 different" or "society 37 the"
        embedded_pattern = re.compile(r"(\d{2})\s+(?=[a-z])")
        found_nums = set()
        for m in embedded_pattern.finditer(text):
            q_num = int(m.group(1))
            if 36 <= q_num <= 45 and q_num not in found_nums:
                found_nums.add(q_num)
                # Get the context
                start = max(0, m.start() - 50)
                end = min(len(text), m.end() + 50)
                context = text[start:end].strip()
                questions.append({
                    "num": q_num,
                    "question": f"{q_num}. {context}",
                })
    
    return sorted(questions, key=lambda x: x["num"])


def parse_matching_questions_v2(text):
    """Parse matching questions"""
    questions = []
    lines = text.split("\n")
    
    q_pattern = re.compile(r"^\s*(\d+)\s*[.)\]）】：:]\s*(.*)")
    
    for line in lines:
        stripped = line.strip()
        qm = q_pattern.match(stripped)
        if qm:
            q_num = int(qm.group(1))
            if 36 <= q_num <= 55:
                questions.append({
                    "num": q_num,
                    "question": f"{q_num}. {qm.group(2).strip()}",
                })
    
    return questions


def parse_reading_questions_v2(text, level, year):
    """Parse careful reading questions"""
    questions = []
    lines = text.split("\n")
    
    q_pattern = re.compile(r"^\s*(\d+)\s*[.)\]）】：:]\s*(.+)")
    current_q = None
    current_text = ""
    q_texts = {}
    
    for line in lines:
        stripped = line.strip()
        qm = q_pattern.match(stripped)
        if qm:
            q_num = int(qm.group(1))
            if 46 <= q_num <= 65:
                if current_q is not None:
                    q_texts[current_q] = current_text.strip()
                current_q = q_num
                current_text = qm.group(2)
        elif current_q is not None:
            if re.match(r"^\s*[A-D]\s*[.)\]）�?：]", stripped):
                current_text += " " + stripped
            elif re.match(r"Questions?\s+\d+|Passage\s+[OneTwo]|Part\s+IV|翻译|Translation", stripped, re.IGNORECASE):
                q_texts[current_q] = current_text.strip()
                current_q = None
                current_text = ""
            else:
                current_text += " " + stripped
    
    if current_q is not None:
        q_texts[current_q] = current_text.strip()
    
    for q_num in sorted(q_texts.keys()):
        q_text = q_texts[q_num]
        options = []
        option_matches = re.findall(r"([A-D])\s*[.)\]）�?：]\s*(.*?)(?=\s*[A-D]\s*[.)\]）�?：]|$)", q_text, re.DOTALL)
        for label, content in option_matches:
            content = re.sub(r"\s+", " ", content).strip()
            if content:
                options.append({"label": label, "content": content})
        
        clean = re.sub(r"[A-D]\s*[.)\]）�?：]\s*.*", "", q_text).strip()
        clean = re.sub(r"^\d+\s*[.)\]）】]\s*", "", clean).strip()
        
        questions.append({
            "num": q_num,
            "question": clean,
            "options": options,
        })
    
    return questions


def parse_translation_v2(text):
    """Parse translation question"""
    lines = text.split("\n")
    trans_lines = []
    in_trans = False
    for line in lines:
        stripped = line.strip()
        if re.match(r"Part\s+IV\s+Translation|Part IV\s+Translation|翻译", stripped, re.IGNORECASE):
            in_trans = True
            continue
        if in_trans:
            if re.match(r"(参考|答案|Answer|参考答案|{$|\d+[-–]\d+)", stripped, re.IGNORECASE):
                break
            if stripped and any("\u4e00" <= c <= "\u9fff" for c in stripped):
                trans_lines.append(stripped)
    return " ".join(trans_lines) if trans_lines else None


def classify_listening(q_num, level, year):
    """Classify listening sub-section"""
    if level == 4 and year >= 2017:
        if q_num <= 7:
            return "news"
        elif q_num <= 15:
            return "conversation"
        else:
            return "passage"
    elif level == 6 and year >= 2017:
        if q_num <= 7:
            return "news"
        elif q_num <= 15:
            return "conversation"
        else:
            return "passage"
    else:
        if q_num <= 8:
            return "conversation"
        else:
            return "passage"


def classify_reading(q_num, level, year):
    """Classify reading sub-section"""
    if level == 4 and year >= 2017:
        if q_num <= 35:
            return "cloze"
        elif q_num <= 45:
            return "matching"
        elif q_num <= 55:
            return "reading_1"
        else:
            return "reading_2"
    elif level == 6 and year >= 2017:
        if q_num <= 35:
            return "cloze"
        elif q_num <= 45:
            return "matching"
        elif q_num <= 55:
            return "reading_1"
        else:
            return "reading_2"
    else:
        if q_num <= 45:
            return "cloze"
        elif q_num <= 55:
            return "matching"
        elif q_num <= 60:
            return "reading_1"
        else:
            return "reading_2"


def sql_escape(s):
    if s is None:
        return "NULL"
    s = str(s).replace("\\", "\\\\").replace("'", "\\'")
    s = s.replace("\n", "\\n").replace("\r", "").replace("\t", " ")
    s = re.sub(r"[\x00-\x1f]", "", s)
    return f"'{s}'"


def build_sql(meta, writing_text, listening_qs, cloze_qs, matching_qs,
              reading_qs, translation_text, answers):
    lines = []
    level = meta["level"]
    
    lines.append(f"INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) "
                 f"VALUES ({level}, {meta['year']}, {meta['half']}, {sql_escape(meta['title'])}, 710);")
    lines.append("SET @pid = LAST_INSERT_ID();")
    lines.append("")
    
    sorted_num = 1
    topic_count = 0
    
    # Writing
    if writing_text:
        w_answer = answers.get("writing", None)
        lines.append(f"INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,"
                     f"`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (")
        lines.append(f"  {sql_escape(writing_text)},")
        lines.append(f"  {sql_escape(w_answer)},")
        lines.append(f"  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');")
        lines.append(f"INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) "
                     f"VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', {sorted_num});")
        lines.append("")
        sorted_num += 1
        topic_count += 1
    
    # Listening
    for q in listening_qs:
        q_num = q["num"]
        options_json = json.dumps(q["options"], ensure_ascii=False) if q["options"] else None
        answer = answers.get(q_num, None)
        sub = classify_listening(q_num, level, meta["year"])
        correct = sql_escape(answer) if answer and len(answer) == 1 and answer in "ABCD" else "NULL"
        
        lines.append(f"INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,"
                     f"`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (")
        lines.append(f"  {sql_escape(q['question'])},")
        lines.append(f"  {sql_escape(answer)},")
        lines.append(f"  {sql_escape(options_json)},")
        lines.append(f"  {correct},")
        lines.append(f"  'listening', NULL, NULL, 0, 'admin');")
        lines.append(f"INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) "
                     f"VALUES (@pid, LAST_INSERT_ID(), 'listening', {sql_escape(sub)}, {sorted_num});")
        lines.append("")
        sorted_num += 1
        topic_count += 1
    
    # Cloze
    for q in cloze_qs:
        q_num = q["num"]
        answer = answers.get(q_num, None)
        lines.append(f"INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,"
                     f"`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (")
        lines.append(f"  {sql_escape(q['question'])},")
        lines.append(f"  {sql_escape(answer)},")
        lines.append(f"  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');")
        lines.append(f"INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) "
                     f"VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', {sorted_num});")
        lines.append("")
        sorted_num += 1
        topic_count += 1
    
    # Matching
    for q in matching_qs:
        q_num = q["num"]
        answer = answers.get(q_num, None)
        lines.append(f"INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,"
                     f"`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (")
        lines.append(f"  {sql_escape(q['question'])},")
        lines.append(f"  {sql_escape(answer)},")
        lines.append(f"  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');")
        lines.append(f"INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) "
                     f"VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', {sorted_num});")
        lines.append("")
        sorted_num += 1
        topic_count += 1
    
    # Careful Reading
    for q in reading_qs:
        q_num = q["num"]
        options_json = json.dumps(q["options"], ensure_ascii=False) if q["options"] else None
        answer = answers.get(q_num, None)
        sub = classify_reading(q_num, level, meta["year"])
        correct = sql_escape(answer) if answer and len(answer) == 1 and answer in "ABCD" else "NULL"
        
        lines.append(f"INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,"
                     f"`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (")
        lines.append(f"  {sql_escape(q['question'])},")
        lines.append(f"  {sql_escape(answer)},")
        lines.append(f"  {sql_escape(options_json)},")
        lines.append(f"  {correct},")
        lines.append(f"  'reading', NULL, NULL, 0, 'admin');")
        lines.append(f"INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) "
                     f"VALUES (@pid, LAST_INSERT_ID(), 'reading', {sql_escape(sub)}, {sorted_num});")
        lines.append("")
        sorted_num += 1
        topic_count += 1
    
    # Translation
    if translation_text:
        t_answer = answers.get("translation", None)
        lines.append(f"INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,"
                     f"`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (")
        lines.append(f"  {sql_escape(translation_text)},")
        lines.append(f"  {sql_escape(t_answer)},")
        lines.append(f"  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');")
        lines.append(f"INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) "
                     f"VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', {sorted_num});")
        lines.append("")
        sorted_num += 1
        topic_count += 1
    
    return "\n".join(lines), topic_count


def process_one_file(file_info, index):
    docx_path = download_docx(file_info, index)
    meta = parse_exam_meta(file_info["path"])
    full_text = read_docx(docx_path)
    
    answers = parse_answers_v4(full_text)
    writing_text = extract_writing_directions(full_text)
    
    # Split text into listening and reading sections
    listening_start = re.search(r"Part\s+II\s+Listening|Part II\s+Listening|听力", full_text, re.IGNORECASE)
    reading_start = re.search(r"Part\s+III\s+Reading|Part III\s+Reading|Reading Comprehension|阅读", full_text, re.IGNORECASE)
    translation_start = re.search(r"Part\s+IV\s+Translation|Part IV\s+Translation|翻译", full_text, re.IGNORECASE)
    
    listening_text = full_text[listening_start.start():reading_start.start()] if listening_start and reading_start else ""
    reading_text = full_text[reading_start.start():translation_start.start() if translation_start else len(full_text)] if reading_start else ""
    
    listening_qs = parse_listening_questions_v2(listening_text, meta["level"], meta["year"])
    cloze_qs = parse_cloze_questions_v2(reading_text)
    matching_qs = parse_matching_questions_v2(reading_text)
    reading_qs = parse_reading_questions_v2(reading_text, meta["level"], meta["year"])
    translation_text = parse_translation_v2(full_text)
    
    sql, q_count = build_sql(
        meta, writing_text, listening_qs, cloze_qs, matching_qs,
        reading_qs, translation_text, answers
    )
    
    return sql, q_count, meta


def main():
    print("=" * 70)
    print("  四六级真题数据库导入工具 v4")
    print("=" * 70)
    
    files = get_docx_file_list()
    
    with open(SQL_OUTPUT, "w", encoding="utf-8") as f:
        f.write("-- =====================================================\n")
        f.write("-- 四六级历年真题完整导入SQL\n")
        f.write(f"-- 生成时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"-- �?{len(files)} 套试卷\n")
        f.write("-- =====================================================\n\n")
        f.write("SET NAMES utf8mb4;\n")
        f.write("SET FOREIGN_KEY_CHECKS=0;\n\n")
        
        success = 0
        fail = 0
        total_q = 0
        
        for i, finfo in enumerate(files):
            fname = os.path.basename(finfo["path"])
            print(f"\n[{i+1}/{len(files)}] {fname}")
            try:
                sql, q_count, meta = process_one_file(finfo, i)
                f.write(f"-- {'='*60}\n")
                f.write(f"-- [{i+1}] {meta['title']}\n")
                f.write(f"-- 题目�? {q_count}\n")
                f.write(f"-- 源文�? {finfo['path']}\n")
                f.write(f"-- {'='*60}\n\n")
                f.write(sql)
                f.write("\n\n")
                success += 1
                total_q += q_count
                print(f"  -> {meta['title']} ({q_count}�?")
            except Exception as e:
                fail += 1
                print(f"  -> 失败: {e}")
                import traceback
                traceback.print_exc()
        
        f.write("SET FOREIGN_KEY_CHECKS=1;\n")
    
    print("\n" + "=" * 70)
    print(f"  完成!")
    print(f"  成功: {success} �?)
    print(f"  失败: {fail} �?)
    print(f"  总题目数: {total_q}")
    print(f"  SQL文件: {SQL_OUTPUT}")
    print("=" * 70)


if __name__ == "__main__":
    main()
