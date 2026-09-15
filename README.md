<div align="center">

<!-- 标题 Logo 预留位置 -->
<img src="logo.png" alt="Logo" width="200" height="200">

<!-- 标题 -->
<h1>Hao-Topic</h1>

<!-- 动态文字效果 -->
<p>
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&pause=1000&color=336791&center=true&vCenter=true&width=435&lines=AI智能刷题平台;Spring+Cloud+Vue3+uni-app;支持多端访问&size=24" alt="Typing SVG" />
</p>

<!-- 徽章区域 -->
<p>
  <img src="https://img.shields.io/badge/Java-17-blue?style=flat&logo=openjdk&logoColor=white" alt="Java">
  <img src="https://img.shields.io/badge/Spring%20Cloud-2023-green?style=flat&logo=springcloud&logoColor=white" alt="Spring Cloud">
  <img src="https://img.shields.io/badge/Vue-3-brightgreen?style=flat&logo=vuedotjs&logoColor=white" alt="Vue3">
  <img src="https://img.shields.io/badge/uni--app-Easy-2B9939?style=flat&logo=app&logoColor=white" alt="uni-app">
  <img src="https://img.shields.io/badge/MySQL-8.0-4479A1?style=flat&logo=mysql&logoColor=white" alt="MySQL">
  <img src="https://img.shields.io/badge/Redis-7.0-DC382D?style=flat&logo=redis&logoColor=white" alt="Redis">
  <img src="https://img.shields.io/badge/RabbitMQ-3.0-FF6600?style=flat&logo=rabbitmq&logoColor=white" alt="RabbitMQ">
</p>

<!-- 简介 -->
<p>
  一款基于 Spring Cloud 微服务 + Vue3 + uni-app 构建的 AI 智能刷题平台，面向求职者与在校学生，提供题库刷题、每日专属推荐、AI 陪背/问答、实时排行榜等核心学习能力。
</p>

<!-- 动态按钮 -->
<p>
  <a href="#功能特性">功能特性</a> •
  <a href="#技术架构">技术架构</a> •
  <a href="#快速开始">快速开始</a> •
  <a href="#演示">演示</a> •
  <a href="#贡献">参与贡献</a>
</p>

</div>

---

## 演示

<!-- 动态 GIF 预留位置 -->
<p align="center">
  <img src="demo.gif" alt="Demo" width="700">
</p>

## 功能特性

- 🚀 **多端支持** - PC网页端、移动端H5/小程序、管理后台、数据大屏
- 🤖 **AI智能刷题** - AI陪背、AI问答、TTS语音朗读
- 📊 **实时排行榜** - 基于Redis高性能实现的实时排名系统
- 🎯 **每日专属推荐** - 定时任务为用户生成个性化刷题内容
- 🔐 **三级权限管理** - 普通用户、会员用户、管理员三类角色
- 📱 **移动优先** - uni-app构建，一套代码多端运行
- 📈 **数据可视化** - ECharts实现的管理后台数据大屏

<!-- 进度条效果 -->
<p align="center">
  <img src="https://progress-bar.vercel.app/?style=flat-square&width=600&title=项目完成度&percentage=85" alt="Progress Bar">
</p>

## 技术架构

```
┌────────────────────────────────────────────────────────────────────┐
│                            前端三端                                 │
│   PC 网页端(vue3-ts-brushtopic-web)   移动端 H5/小程序(uni-app)      │
│   管理后台(vue3-ts-brushtopic-admin)  数据大屏(Echarts)             │
└──────────────┬──────────────────────────────┬──────────────────────┘
               │ /api                         │ /api
      ┌────────▼─────────┐           ┌────────▼─────────┐
      │  web-gateway :9993│          │ admin-gateway:9992│
      │  (用户端网关)      │          │  (后台网关)        │
      └────────┬─────────┘           └────────┬─────────┘
               │ OpenFeign                     │ OpenFeign
┌──────────────▼──────────────────────────────▼──────────────────────┐
│                       注册中心 / 配置中心 Nacos                      │
│                      ╔═══════════════════════╗                      │
│                      ║ topic-security :认证  ║  JWT + Security      │
│                      ╠═══════════════════════╣                      │
│                      ║ service-system :系统  ║  用户/角色/菜单/公告  │
│                      ║ service-topic  :题库  ║  题目/专题/刷题/排行  │
│                      ║ service-ai     :AI   ║  对话/审核/TTS       │
│                      ╚═══════════════════════╝                      │
└──────────────┬──────────────────────────────┬───────────────┬───────┘
               │                      │               │
        ┌──────▼──────┐       ┌───────▼──────┐ ┌──────▼──────┐
        │  MySQL 8    │       │    Redis     │ │  RabbitMQ   │
        │  25 张表    │       │ 缓存/排行/锁  │ │ AI异步/审核  │
        └─────────────┘       └──────────────┘ └─────────────┘
                                ┌──────▼──────┐   ┌──────▼──────┐
                                │    MinIO    │   │ 阿里云百炼AI │
                                │  专题图片存储 │   │ 对话/TTS语音 │
                                └─────────────┘   └─────────────┘
```

## 项目结构

```
Hao-Topic/
├── springcloud-brushtopic-api/     # 后端微服务（Maven 多模块）
├── vue3-ts-brushtopic-admin/       # 管理后台前端
├── vue3-ts-brushtopic-web/         # PC 网页端前端
├── uni-app-vue3-brushtopic/        # 移动端 H5/小程序前端
├── sql/topic.sql                   # 数据库初始化脚本（25 张表）
└── docker-compose.yml              # Docker 部署配置
```

## 快速开始

### 环境要求

- JDK 17+
- Maven 3.6+
- Node.js 18+
- MySQL 8.0+
- Redis 7.0+
- RabbitMQ 3.0+
- Nacos 2.2.3+
- MinIO

### 启动步骤

```bash
# 1. 克隆仓库
git clone https://github.com/用户名/Hao-Topic.git
cd Hao-Topic

# 2. 启动中间件（使用 Docker Compose）
docker-compose up -d mysql redis rabbitmq nacos minio

# 3. 导入数据库
mysql -u root -p topic < sql/topic.sql

# 4. 启动后端微服务（按顺序）
cd springcloud-brushtopic-api
mvn clean package -DskipTests

# 启动认证服务
java -jar topic-security/target/topic-security.jar

# 启动业务服务
java -jar topic-api/topic-api-system/target/topic-api-system.jar
java -jar topic-api/topic-api-topic/target/topic-api-topic.jar
java -jar topic-api/topic-api-ai/target/topic-api-ai.jar

# 启动网关
java -jar topic-gateway/admin-gateway/target/admin-gateway.jar
java -jar topic-gateway/web-gateway/target/web-gateway.jar

# 5. 启动前端
# PC 网页端
cd vue3-ts-brushtopic-web
npm install
npm run dev

# 管理后台
cd vue3-ts-brushtopic-admin
npm install
npm run dev

# 移动端 H5
cd uni-app-vue3-brushtopic
npm install
npm run dev:h5
```

### 访问地址

| 端 | 地址 | 说明 |
|---|---|---|
| PC 网页端 | http://localhost:9990 | 用户刷题主界面 |
| 管理后台 | http://localhost:9991 | 系统管理界面 |
| 移动端 H5 | http://localhost:9090 | 移动端访问 |
| Nacos 控制台 | http://localhost:8848 | 服务注册与配置中心 |
| MinIO 控制台 | http://localhost:9001 | 对象存储管理 |

## 技术栈

### 后端

- **框架**: Spring Boot 3.2 + Spring Cloud 2023
- **认证**: Spring Security + JWT
- **数据库**: MySQL 8.0 + MyBatis-Plus
- **缓存**: Redis 7.0
- **消息队列**: RabbitMQ 3.0
- **配置中心**: Nacos 2.2.3
- **对象存储**: MinIO
- **AI服务**: 阿里云百炼 (Spring AI)

### 前端

- **PC网页端**: Vue3 + Vite6 + TypeScript + Ant Design Vue 4
- **移动端**: Vue3 + uni-app + Uv-ui
- **管理后台**: Vue3 + Ant Design Vue + ECharts
- **样式**: 暗色科技风 + 玻璃拟态设计

### 数据库设计

包含 25 张表，涵盖：
- 系统权限 (RBAC)
- 题库核心 (分类/专题/题目)
- 刷题行为 (记录/收藏/每日推荐)
- AI 模块 (对话/记录/审核)

## 核心功能

### 1. 智能刷题系统
- 三层浏览结构：分类 → 专题 → 题目
- 每日专属推荐算法
- 实时排行榜 (Redis ZSET)
- 题目收藏与刷题记录

### 2. AI 智能助手
- AI 陪背功能
- AI 答疑解惑
- TTS 语音朗读
- 异步审核会员提交题目

### 3. 多端数据同步
- 统一的 RESTful API
- JWT 无状态鉴权
- 网关统一路由

### 4. 管理后台
- 数据大屏可视化
- 用户/角色/菜单管理
- 题库批量导入导出 (EasyExcel)
- AI 记录管理

## 贡献

<!-- 动态贡献者头像 -->
<p align="center">
  <a href="https://github.com/用户名/Hao-Topic/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=用户名/Hao-Topic" />
  </a>
</p>

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

## 致谢

- 感谢所有贡献者
- 感谢开源社区的支持
- 感谢阿里云百炼提供的 AI 能力

---

<!-- 动态页脚 -->
<div align="center">

**如果这个项目对你有帮助，请给一个 ⭐ Star 支持一下！**

<p>
  <img src="https://komarev.com/ghpvc/?username=用户名&label=Profile%20Views&color=0e75b6&style=flat" alt="Profile Views">
</p>

<p>
  <i>用 ❤️ 构建</i>
</p>

</div>