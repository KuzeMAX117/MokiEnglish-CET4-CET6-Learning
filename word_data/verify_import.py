"""验证导入结果"""
import subprocess

bat_content = r"""@echo off
mysql -uroot -pMIMA132455. --default-character-set=utf8mb4 brushtopic -e "SELECT id, name, type, total_count FROM word_book;"
mysql -uroot -pMIMA132455. --default-character-set=utf8mb4 brushtopic -e "SELECT book_id, COUNT(*) as cnt FROM word_item GROUP BY book_id;"
"""

bat_path = r"D:\202401\study\Topic\sql\verify_import.bat"
with open(bat_path, "w", encoding="gbk") as f:
    f.write(bat_content)

result = subprocess.run(["cmd", "/c", bat_path], capture_output=True, timeout=30)
# Try multiple encodings
for enc in ["utf-8", "gbk", "cp936"]:
    try:
        print(result.stdout.decode(enc))
        break
    except:
        continue
