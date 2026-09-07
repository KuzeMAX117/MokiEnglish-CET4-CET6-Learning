#!/bin/bash
# Hao-Topic 虚拟机后端修复脚本 - 在虚拟机内执行
# 已在宿主机完成 Nacos 配置发布，此脚本修复本地 bootstrap 并启动服务

set -e
PROJECT_ROOT="/opt/springcloud-brushtopic-api"
if [ ! -d "$PROJECT_ROOT" ]; then
  PROJECT_ROOT="$(pwd)/springcloud-brushtopic-api"
fi
if [ ! -d "$PROJECT_ROOT" ]; then
  PROJECT_ROOT="/home/$(whoami)/Hao-Topic/springcloud-brushtopic-api"
fi
echo "项目路径: $PROJECT_ROOT"

# 1. 修复 bootstrap.properties 缺失的 shared-configs
echo "=== 修复 bootstrap.properties ==="
for f in "$PROJECT_ROOT/topic-api/topic-api-topic/src/main/resources/bootstrap.properties" "$PROJECT_ROOT/topic-api/topic-api-system/src/main/resources/bootstrap.properties"; do
  if [ -f "$f" ]; then
    echo "修复 $f"
    # 如果已包含 [1].group 则跳过，否则追加
    if ! grep -q "shared-configs\[1\].group" "$f"; then
      echo "spring.cloud.nacos.config.shared-configs[1].group=DEFAULT_GROUP" >> "$f"
      echo "spring.cloud.nacos.config.shared-configs[1].refresh=true" >> "$f"
    fi
    cat "$f"
  else
    echo "未找到 $f，请检查路径"
  fi
done

# 2. 检查 Nacos 是否已包含修复后的配置
echo "=== 检查 Nacos ==="
curl -s "http://192.168.68.132:8848/nacos/v1/cs/configs?dataId=common-config.yaml&group=DEFAULT_GROUP" | head -20

# 3. 检查 MySQL
echo "=== 检查 MySQL ==="
mysql -uroot -p123456 -e "SHOW DATABASES;" 2>&1 | head -20 || echo "MySQL 连接失败，请检查密码是否为 123456，库是否存在 brushtopic"
mysql -uroot -p123456 brushtopic -e "SHOW TABLES;" 2>&1 | head -20 || echo "请导入 sql/topic.sql: mysql -uroot -p123456 < sql/topic.sql"

# 4. 检查 Redis
echo "=== 检查 Redis ==="
redis-cli ping || echo "Redis 未启动: systemctl start redis 或 docker start redis"

# 5. 检查 MinIO 桶
echo "=== 检查 MinIO ==="
curl -s http://localhost:9000/minio/health/live && echo "MinIO 运行中" || echo "MinIO 未启动"

# 6. 启动提示
echo ""
echo "=== 启动顺序 ==="
echo "1. 终端1: cd $PROJECT_ROOT/topic-security && mvn spring-boot:run -Dspring-boot.run.profiles=dev"
echo "   等待日志出现 'topic-security 启动成功' 再执行下一步"
echo "2. 终端2: cd $PROJECT_ROOT/topic-api/topic-api-topic && mvn spring-boot:run"
echo "3. 终端3: cd $PROJECT_ROOT/topic-api/topic-api-system && mvn spring-boot:run"
echo "4. 终端4: cd $PROJECT_ROOT/topic-api/topic-api-ai && mvn spring-boot:run"
echo "5. 终端5: cd $PROJECT_ROOT/topic-gateway/web-gateway && mvn spring-boot:run  # 9993"
echo "6. 终端6: cd $PROJECT_ROOT/topic-gateway/admin-gateway && mvn spring-boot:run  # 9992"
echo ""
echo "或设置环境变量后启动（若密码不同）："
echo "export MYSQL_PASSWORD=你的密码 REDIS_PASSWORD=你的密码 MINIO_ACCESS_KEY=minioadmin MINIO_SECRET_KEY=minioadmin"
