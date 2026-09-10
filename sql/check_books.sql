SET NAMES utf8mb4;
SELECT id, name, type, total_count FROM word_book;
SELECT book_id, COUNT(*) as cnt FROM word_item GROUP BY book_id;
