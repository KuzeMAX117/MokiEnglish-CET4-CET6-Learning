"""深度搜索：在源文件中查找 ai, been, x-ray"""
import os

DATA_DIR = r"D:\202401\study\Hao-Topic\word_data"
files = [
    "1_初中_乱序.txt", "2_高中_乱序.txt", "3_四级_乱序.txt",
    "4_六级_乱序.txt", "5_考研_乱序.txt", "6_托福_乱序.txt", "7_SAT_乱序.txt"
]

# 搜索目标单词（精确匹配，忽略大小写）
targets = ["ai", "been", "x-ray", "be", "is", "am"]

for target in targets:
    print(f"\n=== 搜索: '{target}' ===")
    found = False
    for fname in files:
        fpath = os.path.join(DATA_DIR, fname)
        if not os.path.exists(fpath):
            continue
        with open(fpath, "r", encoding="utf-8") as f:
            for i, line in enumerate(f, 1):
                line = line.strip()
                if not line:
                    continue
                parts = line.split("\t", 1)
                word = parts[0].strip().lower()
                if word == target.lower():
                    meaning = parts[1] if len(parts) > 1 else "(无释�?"
                    print(f"  [{fname}] 行{i}: {parts[0].strip()} -> {meaning[:100]}")
                    found = True
    if not found:
        print(f"  未找到！")

# 额外：统计每个文件中包含 'been' 作为子串的行
print("\n\n=== 模糊搜索 'been' (包含在释义中) ===")
for fname in files:
    fpath = os.path.join(DATA_DIR, fname)
    if not os.path.exists(fpath):
        continue
    count = 0
    with open(fpath, "r", encoding="utf-8") as f:
        for i, line in enumerate(f, 1):
            parts = line.strip().split("\t", 1)
            if parts and parts[0].strip().lower() == "been":
                count += 1
                print(f"  [{fname}] 行{i}: {line.strip()[:120]}")
    if count == 0:
        # 搜索 be 开头的单词
        pass

# 搜索所有以 "be" 开头的单词
print("\n\n=== �?'be' 开头的单词（四级文件） ===")
fpath = os.path.join(DATA_DIR, "3_四级_乱序.txt")
with open(fpath, "r", encoding="utf-8") as f:
    for i, line in enumerate(f, 1):
        parts = line.strip().split("\t", 1)
        if parts and parts[0].strip().lower().startswith("be"):
            print(f"  行{i}: {parts[0].strip()} -> {parts[1][:80] if len(parts) > 1 else ''}")
