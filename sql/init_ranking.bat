@echo off
chcp 65001 >nul
echo ============================================
echo   排行榜数据初始化脚本
echo   步骤1: 执行SQL插入70用户数据
echo   步骤2: 同步数据到Redis
echo ============================================
echo.

set MYSQL_BIN="C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
set MYSQL_USER=root
set MYSQL_PASS=MIMA132455.
set MYSQL_DB=brushtopic
set SQL_FILE=%~dp0init_ranking_70_users.sql
set PYTHON_SCRIPT=%~dp0sync_word_rank_redis.py

echo [1/2] 执行SQL: %SQL_FILE%
echo.
%MYSQL_BIN% -u%MYSQL_USER% -p%MYSQL_PASS% %MYSQL_DB% < "%SQL_FILE%"
if %ERRORLEVEL% NEQ 0 (
    echo SQL执行失败！请检查MySQL连接和密码配置
    pause
    exit /b 1
)
echo.
echo SQL执行完成！
echo.

echo [2/2] 同步数据到Redis...
echo.
python "%PYTHON_SCRIPT%"
if %ERRORLEVEL% NEQ 0 (
    echo Redis同步失败！请检查Redis连接和Python环境
    pause
    exit /b 1
)

echo.
echo ============================================
echo   全部完成！排行榜已有数据
echo   请刷新页面查看排行榜
echo ============================================
pause
