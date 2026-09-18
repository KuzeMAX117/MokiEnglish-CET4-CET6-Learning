import re
import pymysql

file_path = r'D:\202401\study\Topic\word'

with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

word_meanings = {}
for line in lines:
    line = line.strip()
    if not line or line.startswith('##'):
        continue
    m = re.match(r'^\d+\.\s+([a-zA-Z]+)\s+((?:[a-zA-Z]+\.)+)\s*(.+)$', line)
    if not m:
        continue
    w, pos, meaning = m.group(1), m.group(2).strip(), m.group(3).strip()
    if w not in word_meanings:
        word_meanings[w] = f"{pos} {meaning}"

conn = pymysql.connect(
    host='localhost',
    port=3306,
    user='root',
    password='MIMA132455.',
    database='brushtopic',
    charset='utf8mb4'
)

try:
    with conn.cursor() as cursor:
        cursor.execute("SELECT id, word FROM word_item WHERE book_id = 1")
        rows = cursor.fetchall()
        updated = 0
        for row in rows:
            word_id, word = row
            if word in word_meanings:
                meaning = word_meanings[word]
                cursor.execute(
                    "UPDATE word_item SET meaning = %s WHERE id = %s",
                    (meaning, word_id)
                )
                updated += 1
        conn.commit()
        print(f'共更�?{updated} 个单词的释义')
finally:
    conn.close()
