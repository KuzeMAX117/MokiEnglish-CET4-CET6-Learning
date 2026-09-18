"""验证 walls/wall 在词典中的情�?""
import subprocess

bat_content = r"""@echo off
mysql -uroot -pMIMA132455. --default-character-set=utf8mb4 brushtopic -e "SELECT word, LEFT(translation, 80) as translation FROM word_dictionary WHERE word IN ('wall', 'walls');"
mysql -uroot -pMIMA132455. --default-character-set=utf8mb4 brushtopic -e "SELECT word, LEFT(meaning, 80) as meaning FROM word_item WHERE word IN ('wall', 'walls');"
"""

bat_path = r"D:\202401\study\Topic\sql\tmp_check.bat"
with open(bat_path, "w", encoding="gbk") as f:
    f.write(bat_content)

result = subprocess.run(["cmd", "/c", bat_path], capture_output=True, timeout=30)
for enc in ["utf-8", "gbk", "cp936"]:
    try:
        print(result.stdout.decode(enc))
        break
    except:
        continue
import os; os.remove(bat_path)
