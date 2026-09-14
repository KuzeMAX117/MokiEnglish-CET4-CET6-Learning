import re

file_path = r'D:\202401\study\Hao-Topic\word'
output_path = r'D:\202401\study\Hao-Topic\sql\update_cet4_syllable.sql'


def split_syllable(word):
    """
    基于规则的英语音节拆分�?    规则�?    1. 找出元音位置，按元音分组拆分
    2. 两个元音之间的辅音通常归后一个音�?    3. 结尾�?e 不单独成音节
    4. 双写辅音拆开
    """
    w = word.lower()
    if len(w) <= 2:
        return w

    vowels = 'aeiouy'

    # 找到元音位置
    vowel_positions = [i for i, c in enumerate(w) if c in vowels]

    if len(vowel_positions) <= 1:
        return w

    # 处理 silent e：如果最后一个元音是 e，且前面有元音，则忽略尾 e 作为单独音节
    last_is_silent_e = w.endswith('e') and len(vowel_positions) >= 2 and w[vowel_positions[-1]] == 'e'
    if last_is_silent_e:
        # 检查是�?e 前面是辅音，且整体不�?'le' 等情�?        if len(w) - vowel_positions[-1] == 1:
            vowel_positions = vowel_positions[:-1]

    if len(vowel_positions) == 0:
        return w

    # 根据元音位置划分音节
    syllables = []
    start = 0
    for i in range(len(vowel_positions) - 1):
        vp_current = vowel_positions[i]
        vp_next = vowel_positions[i + 1]

        # 两个元音之间的辅�?        consonants_between = w[vp_current + 1:vp_next]

        # 决定切分�?        # 如果有多个辅音，通常前几个归前音节，后几个归后音�?        # 简单处理：如果中间�?2 个及以上辅音，前一个元音带�?1 个辅�?        if len(consonants_between) >= 2:
            split_point = vp_current + 1 + 1
        elif len(consonants_between) == 1:
            # 单个辅音通常归后一个音�?            split_point = vp_current + 1
        else:
            split_point = vp_current + 1

        # 确保切分点在合理范围�?        if split_point <= start:
            split_point = vp_current + 1

        syllable = w[start:split_point]
        if syllable:
            syllables.append(syllable)
        start = split_point

    # 添加最后一个音�?    last_syllable = w[start:]
    if last_syllable:
        syllables.append(last_syllable)

    # 清理空音�?    syllables = [s for s in syllables if s]

    if len(syllables) <= 1:
        return w

    return '·'.join(syllables)


with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

updates = []
seen = set()
for line in lines:
    line = line.strip()
    if not line or line.startswith('##'):
        continue
    m = re.match(r'^\d+\.\s+([a-zA-Z]+)\s+((?:[a-zA-Z]+\.)+)\s*(.+)$', line)
    if not m:
        continue
    w = m.group(1)
    if w in seen:
        continue
    seen.add(w)
    syllable = split_syllable(w)
    word_safe = w.replace("'", "\\'")
    syllable_safe = syllable.replace("'", "\\'")
    updates.append(
        f"UPDATE `word_item` SET `syllable_word` = '{syllable_safe}' WHERE `word` = '{word_safe}' AND `book_id` = 1;"
    )

with open(output_path, 'w', encoding='utf-8') as f:
    f.write("SET NAMES utf8mb4;\n")
    f.write("\n".join(updates))

print(f'共生�?{len(updates)} �?UPDATE 语句，SQL 已生成：{output_path}')
