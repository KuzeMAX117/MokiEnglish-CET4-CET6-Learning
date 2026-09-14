@echo off
mysql -uroot -pyour_password --default-character-set=utf8mb4 brushtopic < D:\202401\study\Hao-Topic\sql\import_vocabulary.sql
echo Import done with errorlevel: %ERRORLEVEL%
mysql -uroot -pyour_password --default-character-set=utf8mb4 brushtopic -e "SELECT id, name, type, total_count FROM word_book; SELECT book_id, COUNT(*) as cnt FROM word_item GROUP BY book_id;"
