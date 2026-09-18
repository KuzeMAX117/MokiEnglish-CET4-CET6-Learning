#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
背单词排行榜 Redis 同步脚本
从MySQL读取打卡记录，计算连续打卡天数，写入Redis ZSET (word:rank:streak)
"""

import pymysql
import redis
from datetime import datetime

# ==================== 配置区 ====================
MYSQL_CONFIG = {
    'host': '127.0.0.1',
    'port': 3306,
    'user': 'root',
    'password': 'MIMA132455.',
    'database': 'brushtopic',
    'charset': 'utf8mb4'
}

REDIS_CONFIG = {
    'host': '192.168.68.132',
    'port': 6379,
    'db': 1,
    'password': 'redis123456'
}

# Redis Key（与Java代码 WordRankRedisService 一致）
RANK_KEY = "word:rank:streak"


def main():
    print("=" * 50)
    print("背单词排行榜 Redis 同步脚本")
    print("=" * 50)

    # 1. 连接MySQL
    print("\n[1/4] 连接MySQL...")
    mysql_conn = pymysql.connect(**MYSQL_CONFIG)
    cursor = mysql_conn.cursor(pymysql.cursors.DictCursor)

    # 2. 连接Redis
    print("[2/4] 连接Redis...")
    r = redis.Redis(**REDIS_CONFIG)
    r.ping()
    print("  Redis连接成功！")

    # 3. 从MySQL查询每个用户的连续打卡天数
    print("[3/4] 查询打卡数据...")
    query = """
        SELECT user_id, COUNT(DISTINCT DATE(last_study_time)) AS streak
        FROM user_word_record
        WHERE is_deleted = 0 AND status != 0 AND last_study_time IS NOT NULL
        GROUP BY user_id
        ORDER BY streak DESC
    """
    cursor.execute(query)
    rows = cursor.fetchall()
    print(f"  查询到 {len(rows)} 个用户的打卡数据")

    if not rows:
        print("  MySQL中无打卡数据，跳过同步")
        cursor.close()
        mysql_conn.close()
        return

    # 查询用户信息
    user_ids = [row['user_id'] for row in rows]
    placeholders = ','.join(['%s'] * len(user_ids))
    info_query = f"""
        SELECT u.id, COALESCE(NULLIF(u.nickname, ''), u.account) AS nickname,
               u.avatar, r.role_key AS role
        FROM sys_user u
        JOIN (SELECT user_id, MIN(role_id) AS role_id FROM sys_user_role GROUP BY user_id) AS ur ON u.id = ur.user_id
        JOIN sys_role AS r ON ur.role_id = r.id
        WHERE u.id IN ({placeholders})
    """
    cursor.execute(info_query, user_ids)
    user_info_map = {u['id']: u for u in cursor.fetchall()}
    print(f"  查询到 {len(user_info_map)} 个用户信息")

    # 4. 写入Redis
    print("[4/4] 写入Redis...")

    # 清空旧数据
    r.delete(RANK_KEY)

    # 写入ZSET
    score_map = {}
    for row in rows:
        uid = str(row['user_id'])
        score = float(row['streak'])
        score_map[uid] = score

    if score_map:
        for uid, score in score_map.items():
            r.zadd(RANK_KEY, {uid: score})

    print(f"  写入排行榜: {len(score_map)} 条记录")

    # ==================== 验证 ====================
    print("\n" + "=" * 50)
    print("验证结果")
    print("=" * 50)

    total = r.zcard(RANK_KEY)
    print(f"  Redis排行榜总人数: {total}")

    print("\n  排行榜 Top 20:")
    top20 = r.zrevrange(RANK_KEY, 0, 19, withscores=True)
    for i, (uid_bytes, score) in enumerate(top20, 1):
        uid = int(uid_bytes)
        info = user_info_map.get(uid, {})
        nickname = info.get('nickname', f'用户{uid}')
        print(f"    {i:>2}. {nickname:<8} - 连续打卡 {int(score)} 天")

    # 关闭连接
    cursor.close()
    mysql_conn.close()
    r.close()

    print("\n" + "=" * 50)
    print("同步完成！排行榜数据已写入Redis")
    print("=" * 50)


if __name__ == '__main__':
    main()
