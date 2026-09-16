SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- 文章表
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `title` varchar(255) NOT NULL COMMENT '文章标题',
  `content` longtext COMMENT '文章内容',
  `summary` varchar(500) DEFAULT NULL COMMENT '摘要',
  `cover_image` varchar(500) DEFAULT NULL COMMENT '封面图',
  `category` varchar(100) DEFAULT NULL COMMENT '分类',
  `source` varchar(255) DEFAULT NULL COMMENT '来源',
  `view_count` bigint DEFAULT 0 COMMENT '浏览量',
  `is_member` tinyint DEFAULT 0 COMMENT '是否会员专属 0-否 1-是',
  `status` tinyint DEFAULT 0 COMMENT '状态 0-正常 1-停用',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT 0 COMMENT '是否删除 0-否 1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章表';

-- ----------------------------
-- 作文表
-- ----------------------------
DROP TABLE IF EXISTS `essay`;
CREATE TABLE `essay` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '作文ID',
  `title` varchar(255) NOT NULL COMMENT '作文题目',
  `content` longtext COMMENT '题目要求/描述',
  `reference_answer` longtext COMMENT '参考范文',
  `analysis` longtext COMMENT '解析/点评',
  `category` varchar(100) DEFAULT NULL COMMENT '分类(如: 议论文, 说明文, 记叙文)',
  `difficulty` tinyint DEFAULT 1 COMMENT '难度 1-简单 2-中等 3-困难',
  `time_limit` int DEFAULT NULL COMMENT '建议用时(分钟)',
  `word_count` varchar(50) DEFAULT NULL COMMENT '字数要求',
  `view_count` bigint DEFAULT 0 COMMENT '浏览量',
  `is_member` tinyint DEFAULT 0 COMMENT '是否会员专属 0-否 1-是',
  `status` tinyint DEFAULT 0 COMMENT '状态 0-正常 1-停用',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT 0 COMMENT '是否删除 0-否 1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='作文表';

-- ----------------------------
-- 翻译表
-- ----------------------------
DROP TABLE IF EXISTS `translation`;
CREATE TABLE `translation` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '翻译ID',
  `title` varchar(255) NOT NULL COMMENT '翻译题目标题',
  `source_lang` varchar(50) DEFAULT 'en' COMMENT '原文语言',
  `target_lang` varchar(50) DEFAULT 'zh' COMMENT '目标语言',
  `source_text` longtext NOT NULL COMMENT '原文',
  `reference_answer` longtext COMMENT '参考译文',
  `analysis` longtext COMMENT '翻译技巧/解析',
  `difficulty` tinyint DEFAULT 1 COMMENT '难度 1-简单 2-中等 3-困难',
  `category` varchar(100) DEFAULT NULL COMMENT '分类(如: 日常, 商务, 文学)',
  `view_count` bigint DEFAULT 0 COMMENT '浏览量',
  `is_member` tinyint DEFAULT 0 COMMENT '是否会员专属 0-否 1-是',
  `status` tinyint DEFAULT 0 COMMENT '状态 0-正常 1-停用',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT 0 COMMENT '是否删除 0-否 1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='翻译表';

-- ----------------------------
-- 管理后台菜单 - 内容管理
-- 先插入父菜单，再插入子菜单（子菜单的 parent_id 需要根据实际父菜单ID填写）
-- ----------------------------
INSERT INTO `sys_menu` (`menu_name`, `sorted`, `route`, `icon`, `parent_id`) VALUES
('内容管理', 5, '/content', 'BookOutlined', 0);

-- 请将下面的 0 替换为上面插入的「内容管理」菜单的实际 ID
-- 例如：INSERT INTO `sys_menu` ... VALUES ('文章管理', 1, '/content/article', 'FileTextOutlined', <内容管理ID>);
INSERT INTO `sys_menu` (`menu_name`, `sorted`, `route`, `icon`, `parent_id`) VALUES
('文章管理', 1, '/content/article', 'FileTextOutlined', 0),
('作文管理', 2, '/content/essay', 'EditOutlined', 0),
('翻译管理', 3, '/content/translation', 'TranslationOutlined', 0),
('词书管理', 4, '/content/wordbook', 'BookOutlined', 0);
