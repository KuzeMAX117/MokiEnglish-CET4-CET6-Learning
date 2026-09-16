"""
�?GitHub 仓库 KyleBing/english-vocabulary 下载单词 txt 文件并生成导�?SQL
"""
import urllib.request
import os
import ssl

# 忽略 SSL 验证
ssl._create_default_https_context = ssl._create_unverified_context

BASE_URL = "https://raw.githubusercontent.com/KyleBing/english-vocabulary/master/"

# 7 个分类文�?FILES = {
    "1_初中_乱序.txt": "1 初中-乱序.txt",
    "2_高中_乱序.txt": "2 高中-乱序.txt",
    "3_四级_乱序.txt": "3 四级-乱序.txt",
    "4_六级_乱序.txt": "4 六级-乱序.txt",
    "5_考研_乱序.txt": "5 考研-乱序.txt",
    "6_托福_乱序.txt": "6 托福-乱序.txt",
    "7_SAT_乱序.txt":  "7 SAT-乱序.txt",
}

DATA_DIR = os.path.dirname(os.path.abspath(__file__))

def download_files():
    """下载所�?txt 文件"""
    for local_name, remote_name in FILES.items():
        local_path = os.path.join(DATA_DIR, local_name)
        if os.path.exists(local_path):
            print(f"[跳过] {local_name} 已存�?)
            continue
        url = BASE_URL + urllib.parse.quote(remote_name)
        print(f"[下载] {local_name} <- {url}")
        urllib.request.urlretrieve(url, local_path)
        print(f"[完成] {local_name}")

import urllib.parse

def parse_txt(filepath):
    """解析 txt 文件，返�?[(word, meaning), ...]"""
    words = []
    with open(filepath, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            parts = line.split("\t", 1)
            if len(parts) == 2:
                word = parts[0].strip()
                meaning = parts[1].strip()
                if word and meaning:
                    words.append((word, meaning))
    return words

def escape_sql(s):
    """转义 SQL 字符串中的特殊字�?""
    return s.replace("\\", "\\\\").replace("'", "\\'")

def generate_sql():
    """生成导入 SQL 文件"""
    
    # 分类映射：文件名 -> (book_name, type_code)
    # �?type: 1-四级 2-六级 3-四级词组 4-六级词组
    # �?type: 1-初中 2-高中 3-四级 4-六级 5-考研 6-托福 7-SAT
    CATEGORY_MAP = {
        "1_初中_乱序.txt": ("初中词汇", 1),
        "2_高中_乱序.txt": ("高中词汇", 2),
        "3_四级_乱序.txt": ("四级词汇", 3),
        "4_六级_乱序.txt": ("六级词汇", 4),
        "5_考研_乱序.txt": ("考研词汇", 5),
        "6_托福_乱序.txt": ("托福词汇", 6),
        "7_SAT_乱序.txt":  ("SAT词汇", 7),
    }
    
    sql_path = os.path.join(DATA_DIR, "..", "sql", "import_vocabulary.sql")
    sql_path = os.path.abspath(sql_path)
    
    total_words = 0
    
    with open(sql_path, "w", encoding="utf-8") as sql:
        sql.write("-- �?GitHub KyleBing/english-vocabulary 导入单词数据\n")
        sql.write("-- 分类：初中、高中、四级、六级、考研、托福、SAT\n\n")
        sql.write("SET NAMES utf8mb4;\n\n")
        
        # 先插入词�?        sql.write("-- ==================== 词书数据 ====================\n")
        sql.write("-- 先删除旧的词书和单词数据（按 book_id）\n")
        
        # 收集所�?book_id
        book_ids = []
        for local_name, (book_name, type_code) in CATEGORY_MAP.items():
            book_id = type_code  # 使用 type_code 作为 book_id
            book_ids.append(book_id)
        
        ids_str = ", ".join(str(bid) for bid in book_ids)
        sql.write(f"DELETE FROM `word_item` WHERE `book_id` IN ({ids_str});\n")
        sql.write(f"DELETE FROM `word_book` WHERE `id` IN ({ids_str});\n\n")
        
        sql.write("-- 插入新词书\n")
        for local_name, (book_name, type_code) in CATEGORY_MAP.items():
            # 先统计单词数
            filepath = os.path.join(DATA_DIR, local_name)
            words = parse_txt(filepath)
            count = len(words)
            total_words += count
            book_id = type_code
            sql.write(
                f"INSERT INTO `word_book` (`id`, `name`, `type`, `total_count`) "
                f"VALUES ({book_id}, '{escape_sql(book_name)}', {type_code}, {count});\n"
            )
        
        sql.write("\n-- ==================== 单词数据 ====================\n\n")
        
        # 插入单词
        for local_name, (book_name, type_code) in CATEGORY_MAP.items():
            filepath = os.path.join(DATA_DIR, local_name)
            words = parse_txt(filepath)
            book_id = type_code
            
            sql.write(f"-- ---------- {book_name} ({len(words)} �? ----------\n")
            
            # 批量插入，每 100 条一�?            batch_size = 100
            for i in range(0, len(words), batch_size):
                batch = words[i:i+batch_size]
                values = []
                for word, meaning in batch:
                    w = escape_sql(word.lower())
                    m = escape_sql(meaning)
                    values.append(f"({book_id}, '{w}', '', '{m}', NULL, NULL, NULL)")
                
                sql.write(
                    "INSERT INTO `word_item` "
                    "(`book_id`, `word`, `phonetic`, `meaning`, `syllable_word`, `example`, `example_translate`) VALUES\n"
                )
                sql.write(",\n".join(values))
                sql.write(";\n")
            
            sql.write("\n")
    
    print(f"\n[完成] SQL 文件已生�? {sql_path}")
    print(f"[统计] �?{total_words} 个单�?)
    
    # 打印每个分类的统�?    print("\n各分类单词数量：")
    for local_name, (book_name, type_code) in CATEGORY_MAP.items():
        filepath = os.path.join(DATA_DIR, local_name)
        words = parse_txt(filepath)
        print(f"  {book_name}: {len(words)} �?)

if __name__ == "__main__":
    print("=" * 50)
    print("步骤 1: 下载单词 txt 文件")
    print("=" * 50)
    download_files()
    
    print("\n" + "=" * 50)
    print("步骤 2: 生成导入 SQL")
    print("=" * 50)
    generate_sql()
