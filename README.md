<div align="center">

# Hao-Topic

### AI 智能刷题平台 | Spring Cloud 微服务全栈项目

**CET 四六级 AI 智能备考平台，涵盖刷题、背单词、真题模拟、PK 对战、AI 辅助学习等一站式英语学习场景**

[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![Java](https://img.shields.io/badge/JDK-17-green.svg)](https://openjdk.org/projects/jdk/17/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![Spring Cloud](https://img.shields.io/badge/Spring%20Cloud-2023-6db33f.svg)](https://spring.io/projects/spring-cloud)
[![Vue](https://img.shields.io/badge/Vue-3-42b883.svg)](https://vuejs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.0-3178c6.svg)](https://www.typescriptlang.org/)

![项目截图](图片/截图1.png)

</div>

---

## 项目简介

Hao-Topic 是一款面向求职者与在校学生的 **CET 四六级 AI 智能备考平台**，采用 **Spring Cloud 微服务架构** + **Vue3 全家桶** 构建，深度整合 AI 能力，提供题库刷题、每日专属推荐、PK 对战、AI 作文/翻译批改等创新学习场景。

### 技术架构总览

```
┌────────────────────────────────────────────────────────────────────┐
│                           前端应用层                                │
│   PC 网页端 (Vue3 + Ant Design)    管理后台 (Vue3 + ECharts)        │
└──────────────┬──────────────────────────────┬──────────────────────┘
               │                              │
      ┌────────▼─────────┐           ┌────────▼─────────┐
      │  web-gateway     │          │  admin-gateway   │
      │  (用户端网关)     │          │  (后台网关)       │
      └────────┬─────────┘           └────────┬─────────┘
               │                              │
┌──────────────▼──────────────────────────────▼──────────────────────┐
│                    Spring Cloud 微服务集群                          │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌───────────┐ │
│  │   认证服务   │  │   系统服务   │  │   题库服务   │  │  AI 服务  │ │
│  │  Security   │  │   System    │  │   Topic     │  │    AI     │ │
│  └─────────────┘  └─────────────┘  └─────────────┘  └───────────┘ │
│                    Nacos (注册中心/配置中心)                         │
└──────────────┬──────────────────────┬──────────────────────────────┘
               │                      │
        ┌──────▼──────┐       ┌───────▼──────┐
        │  MySQL 8    │       │    Redis     │
        │  (25 张表)  │       │  (缓存/排行)  │
        └─────────────┘       └──────────────┘
                ┌──────▼──────┐       ┌──────▼──────┐
                │  RabbitMQ   │       │   MinIO     │
                │  (异步队列)  │       │  (文件存储)  │
                └─────────────┘       └─────────────┘
```

![技术架构图](图片/架构图.png)

---

## 技术栈

### 后端

| 技术 | 版本 | 说明 |
|:---|:---:|:---|
| JDK | 17 | Java 开发环境 |
| Spring Boot | 3.2 | 微服务基础框架 |
| Spring Cloud | 2023 | 微服务治理 |
| Nacos | 2.2+ | 注册中心 & 配置中心 |
| Spring Security + JWT | - | 安全认证 |
| MyBatis-Plus | 3.5+ | ORM 框架 |
| Redis | 7+ | 缓存 & 排行榜 |
| RabbitMQ | 3.12+ | 消息队列 |
| Spring AI | - | AI 能力集成 |
| MySQL | 8.0+ | 关系型数据库 |

### 前端

| 端 | 技术栈 |
|:---|:---|
| PC 网页端 | Vue3.5 + Vite6 + TypeScript 5 + Ant Design Vue 4 + TailwindCSS 4 + Pinia |
| 管理后台 | Vue3 + Ant Design Vue + ECharts + v-scale-screen |

### 部署

| 技术 | 说明 |
|:---|:---|
| Docker Compose | 一键部署 10+ 容器 |
| Nginx | 反向代理 & 静态资源 |
| MinIO | 对象存储 |

---

## 项目结构

```
Hao-Topic/
├── springcloud-brushtopic-api/          # 后端 Spring Cloud 微服务集群
│   ├── topic-gateway/                   # 网关层
│   │   ├── admin-gateway/              #   后台网关 (:9992)
│   │   └── web-gateway/                #   用户端网关 (:9993)
│   ├── topic-security/                 # 认证服务 (JWT + Spring Security)
│   ├── topic-api/                      # 业务服务
│   │   ├── topic-api-system/           #   系统服务 (用户/角色/菜单/公告/反馈/词书)
│   │   ├── topic-api-topic/            #   题库服务 (题目/专题/刷题/PK/试卷/排行榜)
│   │   └── topic-api-ai/               #   AI服务 (TTS/作文批改/翻译批改/短文生成)
│   ├── topic-client/                   # OpenFeign 远程调用客户端
│   ├── topic-common/                   # 公共模块 (工具类/安全/MyBatis配置)
│   └── topic-model/                    # 实体模型层 (Entity/VO/DTO/Excel)
├── vue3-ts-brushtopic-web/             # PC 网页端 (Vue3 + Vite6 + TS + TailwindCSS)
├── vue3-ts-brushtopic-admin/           # 管理后台 (Vue3 + ECharts 数据大屏)
├── sql/                                # 数据库脚本 (25+张表, 含25个SQL文件)
├── nginx/conf.d/                       # Nginx 反向代理配置
├── docker-compose.yml                  # Docker 一键部署
├── 配置文件/                            # Nacos 配置文件 (8个YAML)
└── 图片/                               # 项目截图
```

---

## 核心功能

### 用户端功能

| 模块 | 功能 | 技术实现 |
|:---|:---|:---|
| 首页 | 学习统计、每日必刷推荐、考试倒计时 | SpringTask 定时生成推荐 |
| 真题试卷 | 按难度筛选、逐题答题、进度保存、即时评分 | 数据库事务 + Redis 缓存 |
| 题库浏览 | 分类→专题→题目三层浏览、答案查看、收藏 | MyBatis-Plus 多表查询 |
| 背单词 | 词书选择、艾宾浩斯复习、学习日历、TTS 语音朗读 | Redis 缓存 + 阿里云 TTS |
| PK 对战 | 词汇量匹配/对战/热身赛 | WebSocket 实时通信 |
| 排行榜 | 实时排名、荣誉台 | Redis ZSET 高性能排行 |
| 作文批改 | AI 四六级作文评分、语法/词汇反馈 | Spring AI + 阿里云百炼 |
| 翻译批改 | 中英双向翻译、AI 批改润色 | Spring AI 流式输出 |
| AI 短文 | AI 生成阅读短文 + 词汇卡片 | 多阶段 Pipeline 流式生成 |

![用户端首页](图片/用户端首页.png)
![题库浏览](图片/题库浏览.png)
![PK对战](图片/PK对战.png)

### 管理后台功能

| 模块 | 功能 |
|:---|:---|
| 数据大屏 | 用户分布饼图、刷题量Top10、活跃用户统计、飞线地图、实时动态 |
| 系统管理 | 用户/角色/菜单/反馈管理 |
| 内容管理 | 试卷管理(含AI解析)、词书管理、文章管理、作文/翻译记录 |
| 题库管理 | 分类/标签/专题/题目管理 (Markdown编辑器 + Excel导入导出) |
| PK管理 | 排行榜 + 对战记录 |
| AI管理 | AI记录管理 + AI模型配置 |

![数据大屏](图片/数据大屏.png)
![管理后台](图片/管理后台.png)

---

## 项目亮点

### 1. AI 多场景深度整合

| AI 功能 | 实现方式 | 特点 |
|:---|:---|:---|
| AI 作文批改 | 基于四六级阅卷标准 | 内容/语言/词汇/结构四维度评分 |
| AI 翻译批改 | 中英双向 | 核心信息点核查 + 双版本润色 |
| AI 短文生成 | 多阶段 Pipeline | 大纲→正文→元数据(词汇卡片+评估) |
| TTS 语音朗读 | 阿里云 TTS | 背单词场景语音播报 |
| AI 自动审核 | RabbitMQ 异步消费 | 会员提交题目自动审核 |

### 2. Redis 高性能排行榜

```java
// 使用 Redis ZSET 实现高性能排行榜
redisTemplate.opsForZSet().incrementScore("ranking:daily", userId, score);
Set<String> topUsers = redisTemplate.opsForZSet().reverseRange("ranking:daily", 0, 9);
```

- 每日零点定时刷新
- 分离高频读写到 Redis，大幅降低 MySQL 压力

### 3. WebSocket 实时 PK 对战

- 词汇量 PK 匹配/对战/热身赛全流程
- WebSocket 实时通信，答题结果即时推送
- 用户等级体系 (Lv1初学者 ~ Lv4大师)，ELO 式积分机制

### 4. 每日专属推荐算法

```java
@Scheduled(cron = "0 0 6 * * ?")
public void generateDailyRecommend() {
    // 分析用户历史刷题数据 (专题偏好/薄弱分类)
    // 先暂存 (topic_daily_staging) 再落库 (topic_daily_brush)，两阶段生成
}
```

### 5. 多主题 UI 设计系统

- CSS 变量驱动的三套主题：亮色默认 / 护眼淡黄 / 夜间暗黑
- Quizlet 风格设计语言，8px 间距基数系统
- `data-theme` 属性切换，0.3s 过渡动画

### 6. 数据大屏可视化

- v-scale-screen 自适应缩放到 1920x1080
- ECharts：用户分布饼图 + 刷题量 Top10 柱状图 + 活跃用户柱状图 + 飞线地图 + 实时动态滚动

![数据大屏效果](图片/数据大屏效果.png)

---

## 数据库设计

项目包含 **25+ 张数据表**，核心表结构：

| 模块 | 表数量 | 核心表 |
|:---|:---:|:---|
| 系统权限 (RBAC) | 5 | user、role、menu、user_role、role_menu |
| 题库核心 | 4 | category、topic、subject、tag |
| 关联表 | 3 | topic_subject、subject_tag、topic_tag |
| 刷题行为 | 3 | brush_record、favorite、daily_recommend |
| PK 对战 | 3 | pk_match、pk_record、pk_rank |
| 真题试卷 | 2 | paper、paper_record |
| 背单词 | 3 | vocab_book、vocab_word、vocab_record |
| AI 模块 | 4 | ai_quota、ai_chat_history、ai_audit_log、ai_model_config |
| 系统业务 | 3 | feedback、announcement、config |

---

## 安全设计

### 认证授权流程

```
用户登录 → 密码BCrypt校验 → 生成JWT Token → 存入Redis
    ↓
请求携带Token → Token拦截器校验 → 解析用户信息 → 注入SecurityContext
    ↓
接口访问 → Spring Security 权限校验 (user/member/admin)
```

### 三级权限控制

| 角色 | 权限范围 |
|:---|:---|
| user | 基础刷题、查看排行榜 |
| member | 提交题目(AI审核)、PK对战、AI功能 |
| admin | 全部功能 + 管理后台 |

---

## 快速开始

### 环境要求

- JDK 17+
- Maven 3.8+
- Node.js 18+
- MySQL 8.0+
- Redis 7+
- RabbitMQ 3.12+
- Nacos 2.2+

### 一键启动

```bash
# 1. 克隆项目
git clone https://github.com/your-username/Hao-Topic.git

# 2. 启动中间件（Docker 方式）
docker-compose up -d mysql redis rabbitmq nacos minio

# 3. 导入数据库
mysql -u root -p < sql/topic.sql

# 4. 启动后端服务（按顺序）
cd springcloud-brushtopic-api
mvn clean package -DskipTests

# 启动认证服务
java -jar topic-security/target/*.jar

# 启动业务服务
java -jar topic-api/topic-api-system/target/*.jar
java -jar topic-api/topic-api-topic/target/*.jar
java -jar topic-api/topic-api-ai/target/*.jar

# 启动网关
java -jar topic-gateway/web-gateway/target/*.jar
java -jar topic-gateway/admin-gateway/target/*.jar

# 5. 启动前端
cd vue3-ts-brushtopic-web && npm install && npm run dev    # PC 端 :9990
cd vue3-ts-brushtopic-admin && npm install && npm run dev  # 后台 :9991
```

### 访问地址

| 端 | 地址 | 说明 |
|:---|:---|:---|
| PC 网页端 | http://localhost:9990 | 用户端 |
| 管理后台 | http://localhost:9991 | 管理端 |
| Nacos 控制台 | http://localhost:8848 | 服务治理 |
| RabbitMQ | http://localhost:15672 | 消息队列 |
| MinIO | http://localhost:9001 | 文件存储 |

---

## 工程化亮点

### 1. 统一返回封装

```java
@Data
public class Result<T> {
    private Integer code;
    private String message;
    private T data;
    
    public static <T> Result<T> success(T data) {
        return new Result<>(200, "success", data);
    }
}
```

### 2. 全局异常处理

```java
@RestControllerAdvice
public class GlobalExceptionHandler {
    
    @ExceptionHandler(BusinessException.class)
    public Result<?> handleBusinessException(BusinessException e) {
        return Result.error(e.getCode(), e.getMessage());
    }
}
```

### 3. Axios 请求拦截

```typescript
// 请求拦截器注入 Token
instance.interceptors.request.use(config => {
    const token = useUserStore().token;
    if (token) config.headers.Authorization = `Bearer ${token}`;
    return config;
});

// 响应拦截器统一错误处理
instance.interceptors.response.use(response => {
    if (response.data.code === 401) {
        useRouter().push('/login');
    }
    return response.data;
});
```

### 4. Nacos 配置中心

- 8 个 YAML 配置文件，common + 环境分离
- 动态配置刷新，无需重启服务

---

## 部署架构

```yaml
# docker-compose.yml 核心服务
services:
  mysql:          # 数据库
  redis:          # 缓存
  rabbitmq:       # 消息队列
  nacos:          # 注册/配置中心
  minio:          # 文件存储
  nginx:          # 反向代理
  
  # 微服务
  topic-security:       # 认证服务
  topic-api-system:     # 系统服务
  topic-api-topic:      # 题库服务
  topic-api-ai:         # AI服务
  web-gateway:          # 用户端网关
  admin-gateway:        # 后台网关
```

![Docker部署](图片/Docker部署.png)

---

## 截图预览

### 用户端

| 首页 | 题库 | 刷题 | 排行榜 |
|:---:|:---:|:---:|:---:|
| ![首页](图片/首页.png) | ![题库](图片/题库.png) | ![刷题](图片/刷题.png) | ![排行榜](图片/排行榜.png) |

| PK对战 | 背单词 | 作文批改 | 翻译批改 |
|:---:|:---:|:---:|:---:|
| ![PK对战](图片/PK对战.png) | ![背单词](图片/背单词.png) | ![作文批改](图片/作文批改.png) | ![翻译批改](图片/翻译批改.png) |

### 管理后台

| 数据大屏 | 题库管理 | 用户管理 | AI管理 |
|:---:|:---:|:---:|:---:|
| ![数据大屏](图片/数据大屏.png) | ![题库管理](图片/题库管理.png) | ![用户管理](图片/用户管理.png) | ![AI管理](图片/AI管理.png) |

---

## 面试要点总结

### 技术深度

| 方向 | 关键点 |
|:---|:---|
| 微服务架构 | Spring Cloud + Nacos + OpenFeign + 网关隔离 |
| 安全认证 | Spring Security + JWT + BCrypt + 三级权限 |
| 高并发 | Redis ZSET 排行榜 + RabbitMQ 异步解耦 |
| AI 整合 | Spring AI + 作文/翻译批改 + TTS 语音 + 短文生成 |
| 实时通信 | WebSocket PK 对战 + 等级体系 |
| 前端工程化 | Vue3 + TypeScript + Pinia + TailwindCSS |

### 项目难点

1. **AI 多场景整合**：如何让 AI 在作文批改、翻译批改、短文生成、TTS语音等场景发挥价值
2. **PK 实时对战**：WebSocket 连接管理、断线重连、状态同步
3. **推荐算法**：基于用户画像的每日专属推荐，两阶段生成机制
4. **性能优化**：Redis 缓存策略、数据库索引设计、微服务调用链路优化

### 项目收获

1. **架构设计能力**：从单体到微服务的演进，服务拆分原则
2. **AI 落地经验**：如何将 AI 能力与业务场景深度结合
3. **全栈开发**：前后端分离 + 数据库设计 + 部署运维
4. **工程化实践**：统一规范、异常处理、日志监控

---

## 许可证

本项目采用 [Apache License 2.0](LICENSE) 开源协议。

---

<div align="center">

**如果觉得项目不错，请给个 Star 支持一下！**

Made with ❤️ by Hao

</div>
