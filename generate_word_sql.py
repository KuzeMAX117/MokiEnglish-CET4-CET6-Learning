import re

file_path = r'D:\202401\study\Hao-Topic\word'
output_path = r'D:\202401\study\Hao-Topic\sql\import_cet4_words.sql'

with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

words = []
seen = set()
for line in lines:
    line = line.strip()
    if not line or line.startswith('##'):
        continue
    m = re.match(r'^\d+\.\s+([a-zA-Z]+)\s+((?:[a-zA-Z]+\.)+)\s*(.+)$', line)
    if not m:
        continue
    w, pos, meaning = m.group(1), m.group(2).strip(), m.group(3).strip()
    if w in seen:
        continue
    seen.add(w)
    meaning_full = f"{pos} {meaning}".replace("'", "\\'")
    word_safe = w.replace("'", "\\'")
    example = f"We need to understand the meaning of <u>{word_safe}</u> in this sentence.".replace("'", "\\'")
    words.append((word_safe, meaning_full, example))

with open(output_path, 'w', encoding='utf-8') as f:
    f.write("SET NAMES utf8mb4;\n")
    f.write("DELETE FROM `word_item` WHERE `book_id` = 1;\n")
    for w, m, e in words:
        f.write(
            f"INSERT INTO `word_item` (`book_id`, `word`, `phonetic`, `meaning`, `syllable_word`, `example`, `example_translate`) "
            f"VALUES (1, '{w}', '', '{m}', NULL, '{e}', '我们需要理解本句中 <u>{w}</u> 的含义�?);\n"
        )

print(f'共导�?{len(words)} 个单词，SQL 已生成：{output_path}')
