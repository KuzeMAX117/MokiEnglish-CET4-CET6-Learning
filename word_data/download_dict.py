"""通过 git clone 下载词典�?""
import subprocess
import os

repo_dir = r"D:\202401\study\Topic\word_data\103976"

if os.path.exists(repo_dir):
    print("目录已存在，跳过 clone")
else:
    print("正在 git clone...")
    result = subprocess.run(
        ["git", "clone", "--depth", "1", "https://github.com/1eez/103976.git", repo_dir],
        capture_output=True, text=True, timeout=120
    )
    print("STDOUT:", result.stdout[:500] if result.stdout else "")
    print("STDERR:", result.stderr[:500] if result.stderr else "")
    print("Return code:", result.returncode)

# 检查文�?sql_path = os.path.join(repo_dir, "EnWords.sql")
csv_path = os.path.join(repo_dir, "EnWords.csv")
for p in [sql_path, csv_path]:
    if os.path.exists(p):
        size = os.path.getsize(p)
        print(f"存在: {os.path.basename(p)} ({size/1024/1024:.1f} MB)")
    else:
        print(f"不存�? {os.path.basename(p)}")
