@echo off
mysql -uroot -pMIMA132455. --default-character-set=utf8mb4 brushtopic < D:\202401\study\Topic\sql\import_vocabulary.sql
echo Import done with errorlevel: %ERRORLEVEL%
mysql -uroot -pMIMA132455. --default-character-set=utf8mb4 brushtopic -e "SELECT id, name, type, total_count FROM word_book; SELECT book_id, COUNT(*) as cnt FROM word_item GROUP BY book_id;"
