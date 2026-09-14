#!/bin/bash
# Hao-Topic 虚拟机后端修复脚�?- 在虚拟机内执�?# 已在宿主机完�?Nacos 配置发布，此脚本修复本地 bootstrap 并启动服�?
set -e
PROJECT_ROOT="/opt/springcloud-brushtopic-api"
if [ ! -d "$PROJECT_ROOT" ]; then
  PROJECT_ROOT="$(pwd)/springcloud-brushtopic-api"
fi
if [ ! -d "$PROJECT_ROOT" ]; then
  PROJECT_ROOT="/home/$(whoami)/Hao-Topic/springcloud-brushtopic-api"
fi
echo "项目路径: $PROJECT_ROOT"

# 1. 修复 bootstrap.properties 缺失�?shared-configs
echo "=== 修复 bootstrap.properties ==="
for f in "$PROJECT_ROOT/topic-api/topic-api-topic/src/main/resources/bootstrap.properties" "$PROJECT_ROOT/topic-api/topic-api-system/src/main/resources/bootstrap.properties"; do
  if [ -f "$f" ]; then
    echo "修复 $f"
    # 如果已包�?[1].group 则跳过，否则追加
    if ! grep -q "shared-configs\[1\].group" "$f"; then
      echo "spring.cloud.nacos.config.shared-configs[1].group=DEFAULT_GROUP" >> "$f"
      echo "spring.cloud.nacos.config.shared-configs[1].refresh=true" >> "$f"
    fi
    cat "$f"
  else
    echo "未找�?$f，请检查路�?
  fi
done

# 2. 检�?Nacos 是否已包含修复后的配�?echo "=== 检�?Nacos ==="
curl -s "http://127.0.0.1:8848/nacos/v1/cs/configs?dataId=common-config.yaml&group=DEFAULT_GROUP" | head -20

# 3. 检�?MySQL
echo "=== 检�?MySQL ==="
mysql -uroot -p$MYSQL_PASSWORD -e "SHOW DATABASES;" 2>&1 | head -20 || echo "MySQL 连接失败，请检查密码是否为 123456，库是否存在 brushtopic"
mysql -uroot -p$MYSQL_PASSWORD brushtopic -e "SHOW TABLES;" 2>&1 | head -20 || echo "请导�?sql/topic.sql: mysql -uroot -p$MYSQL_PASSWORD < sql/topic.sql"

# 4. 检�?Redis
echo "=== 检�?Redis ==="
redis-cli ping || echo "Redis 未启�? systemctl start redis �?docker start redis"

# 5. 检�?MinIO �?echo "=== 检�?MinIO ==="
curl -s http://localhost:9000/minio/health/live && echo "MinIO 运行�? || echo "MinIO 未启�?

# 6. 启动提示
echo ""
echo "=== 启动顺序 ==="
echo "1. 终端1: cd $PROJECT_ROOT/topic-security && mvn spring-boot:run -Dspring-boot.run.profiles=dev"
echo "   等待日志出现 'topic-security 启动成功' 再执行下一�?
echo "2. 终端2: cd $PROJECT_ROOT/topic-api/topic-api-topic && mvn spring-boot:run"
echo "3. 终端3: cd $PROJECT_ROOT/topic-api/topic-api-system && mvn spring-boot:run"
echo "4. 终端4: cd $PROJECT_ROOT/topic-api/topic-api-ai && mvn spring-boot:run"
echo "5. 终端5: cd $PROJECT_ROOT/topic-gateway/web-gateway && mvn spring-boot:run  # 9993"
echo "6. 终端6: cd $PROJECT_ROOT/topic-gateway/admin-gateway && mvn spring-boot:run  # 9992"
echo ""
echo "或设置环境变量后启动（若密码不同）："
echo "export MYSQL_PASSWORD=你的密码 REDIS_PASSWORD=你的密码 MINIO_ACCESS_KEY=minioadmin MINIO_SECRET_KEY=minioadmin"
