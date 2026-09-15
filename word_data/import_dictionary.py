"""
�?EnWords.sql 提取数据，创建独立的 word_dictionary 词典表并导入
"""
import subprocess
import os
import re

SOURCE_SQL = r"D:\202401\study\Hao-Topic\word_data\103976\EnWords.sql"
OUTPUT_SQL = r"D:\202401\study\Hao-Topic\sql\import_dictionary.sql"

def parse_and_convert():
    """读取原始 SQL，转换为 word_dictionary 表的导入 SQL"""
    print("读取原始 SQL 文件...")
    
    with open(OUTPUT_SQL, "w", encoding="utf-8") as out:
        out.write("-- 独立词典库（兜底查询用，不参与背诵模块）\n")
        out.write("-- 数据来源: https://github.com/1eez/103976 (103,976 个英语单�?\n\n")
        out.write("SET NAMES utf8mb4;\n\n")
        
        # 创建独立的词典表
        out.write("DROP TABLE IF EXISTS `word_dictionary`;\n")
        out.write("""CREATE TABLE `word_dictionary` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '词典ID',
  `word` varchar(64) NOT NULL COMMENT '单词',
  `translation` varchar(512) DEFAULT NULL COMMENT '释义',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_word` (`word`),
  KEY `idx_word` (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='英语词典（兜底查询用�?;\n\n""")
        
        # 逐行解析原始 SQL 中的 INSERT 数据
        count = 0
        batch = []
        batch_size = 500
        
        with open(SOURCE_SQL, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if not line.startswith("('"):
                    continue
                
                # 解析 ('word', 'translation') 格式
                # 可能一行有多条: ('w1','t1'),\n('w2','t2'),
                # 用正则提取每�?(word, translation) �?                # 匹配 ('...', '...') 模式
                matches = re.findall(r"\('([^']*)',\s*'([^']*)'\)", line)
                for word, translation in matches:
                    # 转义单引号（原始数据中可能有�?                    w = word.replace("\\", "\\\\").replace("'", "\\'").lower().strip()
                    t = translation.replace("\\", "\\\\").replace("'", "\\'").strip()
                    
                    if not w:
                        continue
                    
                    batch.append(f"('{w}', '{t}')")
                    count += 1
                    
                    if len(batch) >= batch_size:
                        out.write("INSERT INTO `word_dictionary` (`word`, `translation`) VALUES\n")
                        out.write(",\n".join(batch))
                        out.write(";\n")
                        batch = []
        
        # 写入剩余
        if batch:
            out.write("INSERT INTO `word_dictionary` (`word`, `translation`) VALUES\n")
            out.write(",\n".join(batch))
            out.write(";\n")
    
    print(f"转换完成: {OUTPUT_SQL}")
    print(f"�?{count} 条词典记�?)
    return count

def execute_import():
    """执行 SQL 导入"""
    bat_content = f"""@echo off
mysql -uroot -pMIMA132455. --default-character-set=utf8mb4 brushtopic < "{OUTPUT_SQL}"
echo Import exit code: %ERRORLEVEL%
mysql -uroot -pMIMA132455. --default-character-set=utf8mb4 brushtopic -e "SELECT COUNT(*) as dict_total FROM word_dictionary;"
"""
    bat_path = r"D:\202401\study\Hao-Topic\sql\tmp_run.bat"
    with open(bat_path, "w", encoding="gbk") as f:
        f.write(bat_content)
    
    result = subprocess.run(["cmd", "/c", bat_path], capture_output=True, timeout=300)
    for enc in ["utf-8", "gbk", "cp936"]:
        try:
            print(result.stdout.decode(enc))
            break
        except:
            continue
    os.remove(bat_path)

if __name__ == "__main__":
    count = parse_and_convert()
    print("\n开始导入数据库...")
    execute_import()
