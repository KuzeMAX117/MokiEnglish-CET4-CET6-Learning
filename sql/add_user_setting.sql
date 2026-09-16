ALTER TABLE `sys_user` ADD COLUMN `setting` TEXT DEFAULT NULL COMMENT '用户设置(JSON格式，存储主题、暗黑模式等偏好)';
