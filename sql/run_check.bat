@echo off
chcp 65001 >nul
mysql -uroot -pyour_password --default-character-set=utf8mb4 brushtopic < D:\202401\study\Hao-Topic\sql\check_books.sql
