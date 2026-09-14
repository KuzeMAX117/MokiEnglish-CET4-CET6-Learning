"""验证词典兜底查询"""
import subprocess

# 测试几个�?word_item 中不存在但在词典中应该存在的�?targets = ["been", "ai", "abandon", "xylophone", "zzz"]
words_str = ", ".join(f"'{w}'" for w in targets)

bat_content = f"""@echo off
mysql -uroot -pyour_password --default-character-set=utf8mb4 brushtopic -e "SELECT word, LEFT(translation, 80) as translation FROM word_dictionary WHERE word IN ({words_str});"
mysql -uroot -pyour_password --default-character-set=utf8mb4 brushtopic -e "SELECT COUNT(*) as dict_count FROM word_dictionary;"
mysql -uroot -pyour_password --default-character-set=utf8mb4 brushtopic -e "SELECT COUNT(*) as item_count FROM word_item;"
"""

bat_path = r"D:\202401\study\Hao-Topic\sql\tmp_check.bat"
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
