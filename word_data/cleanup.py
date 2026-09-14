"""执行 ALTER TABLE 更新注释 + 清理临时文件"""
import subprocess
import os

# 1. 执行 ALTER TABLE
bat_content = r"""@echo off
mysql -uroot -pyour_password --default-character-set=utf8mb4 brushtopic < D:\202401\study\Hao-Topic\sql\update_word_book_type.sql
"""
bat_path = r"D:\202401\study\Hao-Topic\sql\run_alter.bat"
with open(bat_path, "w", encoding="gbk") as f:
    f.write(bat_content)

result = subprocess.run(["cmd", "/c", bat_path], capture_output=True, timeout=30)
print("ALTER TABLE result:", result.returncode)

# 2. 清理临时 bat 文件
for f in ["check_books.sql", "run_check.bat", "run_import.bat", "verify_import.bat", "run_alter.bat", "update_word_book_type.sql"]:
    path = os.path.join(r"D:\202401\study\Hao-Topic\sql", f)
    if os.path.exists(path):
        os.remove(path)
        print(f"Deleted: {f}")

print("Done!")

