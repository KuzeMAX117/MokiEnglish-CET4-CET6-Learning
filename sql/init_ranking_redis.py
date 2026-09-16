#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
排行榜数据初始化脚本
从MySQL读取刷题记录，写入Redis排行榜
"""

import pymysql
import redis
from datetime import datetime, date
from collections import defaultdict

# ==================== 配置区 ====================
# MySQL配置（MySQL在Windows本机）
MYSQL_CONFIG = {
    'host': '127.0.0.1',  # Windows本机
    'port': 3306,
    'user': 'root',
    'password': 'MIMA132455.',  # MySQL密码
    'database': 'brushtopic',
    'charset': 'utf8mb4'
}

# Redis配置（Redis在Ubuntu虚拟机192.168.68.132的Docker中）
REDIS_CONFIG = {
    'host': '192.168.68.132',  # Ubuntu虚拟机IP
    'port': 6379,  # Docker映射端口
    'db': 1,  # 项目使用database 1
    'password': 'redis123456'  # Redis密码
}

# Redis Key前缀（与Java代码保持一致）
TOPIC_RANK_PREFIX = "topic:rank"
TOPIC_RANK_TODAY_PREFIX = "topic:rank:today:"
USER_RANK_PREFIX = "user:rank:"

# ==================== 主函数 ====================
def main():
    print("=" * 50)
    print("排行榜数据初始化脚本")
    print("=" * 50)
    
    # 1. 连接MySQL
    print("\n[1/5] 连接MySQL...")
    mysql_conn = pymysql.connect(**MYSQL_CONFIG)
    mysql_cursor = mysql_conn.cursor(pymysql.cursors.DictCursor)
    
    # 2. 连接Redis
    print("[2/5] 连接Redis...")
    redis_client = redis.Redis(**REDIS_CONFIG)
    redis_client.ping()
    print("  Redis连接成功！")
    
    # 3. 从MySQL读取今天的刷题记录
    print("[3/5] 读取刷题记录...")
    today = date.today().isoformat()
    
    # 查询今天每个用户的刷题总数
    query_today = """
        SELECT user_id, nickname, SUM(count) as total_count
        FROM topic_record
        WHERE topic_time = %s
        GROUP BY user_id, nickname
        ORDER BY total_count DESC
    """
    mysql_cursor.execute(query_today, (today,))
    today_rank = mysql_cursor.fetchall()
    print(f"  今日刷题用户数: {len(today_rank)}")
    
    # 查询所有用户的刷题总数（总榜）
    query_all = """
        SELECT user_id, nickname, SUM(count) as total_count
        FROM topic_record
        GROUP BY user_id, nickname
        ORDER BY total_count DESC
    """
    mysql_cursor.execute(query_all)
    all_rank = mysql_cursor.fetchall()
    print(f"  总榜用户数: {len(all_rank)}")
    
    # 4. 查询用户详细信息（头像、角色）
    print("[4/5] 查询用户信息...")
    user_ids = list(set([r['user_id'] for r in all_rank]))
    if user_ids:
        placeholders = ','.join(['%s'] * len(user_ids))
        query_user = f"""
            SELECT u.id, u.nickname, u.avatar, u.is_deleted,
                   GROUP_CONCAT(r.role_key) as roles
            FROM sys_user u
            LEFT JOIN sys_user_role ur ON u.id = ur.user_id
            LEFT JOIN sys_role r ON ur.role_id = r.id
            WHERE u.id IN ({placeholders})
            GROUP BY u.id
        """
        mysql_cursor.execute(query_user, user_ids)
        users_info = {u['id']: u for u in mysql_cursor.fetchall()}
    else:
        users_info = {}
    print(f"  查询到用户信息: {len(users_info)}条")
    
    # 5. 写入Redis
    print("[5/5] 写入Redis...")
    
    # 清空旧的排行榜数据
    print("  清空旧数据...")
    redis_client.delete(TOPIC_RANK_PREFIX)
    today_key = f"{TOPIC_RANK_TODAY_PREFIX}{today}"
    redis_client.delete(today_key)
    
    # 写入今日排行榜
    print("  写入今日排行榜...")
    for rank in today_rank:
        user_id = str(rank['user_id'])
        score = float(rank['total_count'])
        
        # 添加到今日ZSET
        redis_client.zadd(today_key, {user_id: score})
        
        # 写入用户信息Hash
        user_info = users_info.get(rank['user_id'], {})
        user_hash_key = f"{USER_RANK_PREFIX}{user_id}"
        user_data = {
            'nickname': rank['nickname'] or user_info.get('nickname', f'用户{user_id}'),
            'avatar': user_info.get('avatar', '') or '',
            'role': 'user'  # 默认角色
        }
        
        # 根据角色设置
        if user_info.get('roles'):
            if 'admin' in user_info['roles']:
                user_data['role'] = 'admin'
            elif 'member' in user_info['roles']:
                user_data['role'] = 'member'
        
        redis_client.hset(user_hash_key, mapping=user_data)
    
    print(f"  今日排行榜写入: {len(today_rank)}条")
    
    # 写入总排行榜
    print("  写入总排行榜...")
    for rank in all_rank:
        user_id = str(rank['user_id'])
        score = float(rank['total_count'])
        
        # 添加到总榜ZSET
        redis_client.zadd(TOPIC_RANK_PREFIX, {user_id: score})
        
        # 确保用户信息已写入（今日可能没有刷题记录的用户）
        user_hash_key = f"{USER_RANK_PREFIX}{user_id}"
        if not redis_client.exists(user_hash_key):
            user_info = users_info.get(rank['user_id'], {})
            user_data = {
                'nickname': rank['nickname'] or user_info.get('nickname', f'用户{user_id}'),
                'avatar': user_info.get('avatar', '') or '',
                'role': 'user'
            }
            if user_info.get('roles'):
                if 'admin' in user_info['roles']:
                    user_data['role'] = 'admin'
                elif 'member' in user_info['roles']:
                    user_data['role'] = 'member'
            redis_client.hset(user_hash_key, mapping=user_data)
    
    print(f"  总排行榜写入: {len(all_rank)}条")
    
    # 验证结果
    print("\n" + "=" * 50)
    print("验证结果")
    print("=" * 50)
    
    today_count = redis_client.zcard(today_key)
    all_count = redis_client.zcard(TOPIC_RANK_PREFIX)
    print(f"  今日排行榜人数: {today_count}")
    print(f"  总排行榜人数: {all_count}")
    
    # 显示今日Top10
    print("\n  今日排行榜 Top10:")
    today_top10 = redis_client.zrevrange(today_key, 0, 9, withscores=True)
    for i, (user_id, score) in enumerate(today_top10, 1):
        user_hash_key = f"{USER_RANK_PREFIX}{user_id.decode()}"
        user_data = redis_client.hgetall(user_hash_key)
        nickname = user_data.get(b'nickname', user_id).decode() if user_data.get(b'nickname') else user_id.decode()
        print(f"    {i}. {nickname} - {int(score)}题")
    
    # 显示总榜Top10
    print("\n  总排行榜 Top10:")
    all_top10 = redis_client.zrevrange(TOPIC_RANK_PREFIX, 0, 9, withscores=True)
    for i, (user_id, score) in enumerate(all_top10, 1):
        user_hash_key = f"{USER_RANK_PREFIX}{user_id.decode()}"
        user_data = redis_client.hgetall(user_hash_key)
        nickname = user_data.get(b'nickname', user_id).decode() if user_data.get(b'nickname') else user_id.decode()
        print(f"    {i}. {nickname} - {int(score)}题")
    
    # 关闭连接
    mysql_cursor.close()
    mysql_conn.close()
    redis_client.close()
    
    print("\n" + "=" * 50)
    print("排行榜数据初始化完成！")
    print("=" * 50)

if __name__ == '__main__':
    main()
