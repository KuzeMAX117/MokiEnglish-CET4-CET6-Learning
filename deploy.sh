#!/bin/bash

# ==================== 配置区 ====================
PROJECT_DIR="/opt/Hao-Topic"  # 项目部署目录，根据实际情况修改

# ==================== 颜色定义 ====================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ==================== 工具函数 ====================
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# ==================== 检查函数 ====================
check_docker() {
    if ! command -v docker &> /dev/null; then
        log_error "Docker未安装，请先安装Docker"
        exit 1
    fi
    if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
        log_error "Docker Compose未安装，请先安装Docker Compose"
        exit 1
    fi
    log_info "Docker环境检查通过"
}

# ==================== 构建后端 ====================
build_backend() {
    log_info "正在构建后端服务..."
    cd $PROJECT_DIR/springcloud-brushtopic-api || exit

    # 构建公共模块
    mvn clean install -DskipTests -Dmaven.test.skip=true -pl topic-common,topic-model,topic-client

    # 构建各服务模块
    mvn clean package -DskipTests -Dmaven.test.skip=true -pl topic-security
    mvn clean package -DskipTests -Dmaven.test.skip=true -pl topic-gateway/admin-gateway
    mvn clean package -DskipTests -Dmaven.test.skip=true -pl topic-gateway/web-gateway
    mvn clean package -DskipTests -Dmaven.test.skip=true -pl topic-api/topic-api-system
    mvn clean package -DskipTests -Dmaven.test.skip=true -pl topic-api/topic-api-topic
    mvn clean package -DskipTests -Dmaven.test.skip=true -pl topic-api/topic-api-ai

    cd $PROJECT_DIR
}

# ==================== 构建前端 ====================
build_frontend() {
    log_info "正在构建管理后台前端..."
    cd $PROJECT_DIR/vue3-ts-brushtopic-admin
    npm install
    npm run build
    cd ..

    log_info "正在构建前台前端..."
    cd $PROJECT_DIR/vue3-ts-brushtopic-web
    npm install
    npm run build
    cd $PROJECT_DIR
}

# ==================== 主流程 ====================
main() {
    echo "=========================================="
    echo "       Hao-Topic 一键部署脚本"
    echo "=========================================="
    echo ""

    # 检查Docker环境
    check_docker

    # 进入项目目录
    cd $PROJECT_DIR || exit

    # 拉取最新代码
    log_info "正在拉取最新代码..."
    git pull origin main  # 改成你的分支名

    # 构建后端
    build_backend

    # 构建前端
    build_frontend

    # 停止旧容器
    log_info "正在停止旧容器..."
    docker-compose down

    # 重新构建镜像并启动
    log_info "正在构建镜像并启动服务..."
    docker-compose up -d --build

    # 等待服务启动
    log_info "等待服务启动（30秒）..."
    sleep 30

    # 检查服务状态
    log_info "服务状态："
    docker-compose ps

    echo ""
    echo "=========================================="
    echo -e "${GREEN}部署完成！${NC}"
    echo "=========================================="
    echo ""
    echo "访问地址："
    echo "  管理后台: http://你的服务器IP/admin"
    echo "  前台:     http://你的服务器IP/web"
    echo "  Nacos:    http://你的服务器IP:8848/nacos"
    echo "  MinIO:    http://你的服务器IP:9001"
    echo "  RabbitMQ: http://你的服务器IP:15672"
    echo ""
}

# ==================== 执行 ====================
main "$@"
