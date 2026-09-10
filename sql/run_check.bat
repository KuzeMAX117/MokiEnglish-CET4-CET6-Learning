@echo off
chcp 65001 >nul
mysql -uroot -pMIMA132455. --default-character-set=utf8mb4 brushtopic < D:\202401\study\Hao-Topic\sql\check_books.sql
