"""创建 bat 文件并执�?SQL 导入"""
import subprocess
import os

bat_path = r"D:\202401\study\Hao-Topic\sql\run_import.bat"
sql_path = r"D:\202401\study\Hao-Topic\sql\import_vocabulary.sql"

# �?GBK 编码�?bat 文件（Windows CMD 默认编码�?bat_content = f"""@echo off
mysql -uroot -pyour_password --default-character-set=utf8mb4 brushtopic < "{sql_path}"
echo Import exit code: %ERRORLEVEL%
mysql -uroot -pyour_password --default-character-set=utf8mb4 brushtopic -e "SELECT id, name, type, total_count FROM word_book;"
mysql -uroot -pyour_password --default-character-set=utf8mb4 brushtopic -e "SELECT book_id, COUNT(*) as cnt FROM word_item GROUP BY book_id;"
"""

with open(bat_path, "w", encoding="gbk") as f:
    f.write(bat_content)

print("bat 文件已创建，开始执行导�?..")
result = subprocess.run(["cmd", "/c", bat_path], capture_output=True, text=True, encoding="gbk", timeout=300)
print("STDOUT:", result.stdout)
if result.stderr:
    print("STDERR:", result.stderr)
print("Return code:", result.returncode)
