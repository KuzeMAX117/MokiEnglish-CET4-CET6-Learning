-- 补充高频常用词（动词变形、名词复数、缩写等）
-- 这些词在考试词库中未收录，但阅读时会频繁遇到

SET NAMES utf8mb4;

DELETE FROM `word_item` WHERE `word` IN ('was', 'were', 'been', 'does', 'did', 'done', 'doing', 'has', 'had', 'having', 'goes', 'went', 'gone', 'going', 'comes', 'came', 'coming', 'gets', 'got', 'gotten', 'getting', 'makes', 'made', 'making', 'takes', 'took', 'taken', 'taking', 'sees', 'saw', 'seen', 'seeing', 'knows', 'knew', 'known', 'knowing', 'thinks', 'thought', 'thinking', 'gives', 'gave', 'giving', 'tells', 'told', 'telling', 'says', 'said', 'finds', 'puts', 'putting', 'runs', 'ran', 'men', 'women', 'children', 'eyes', 'hands', 'ai', 'mr', 'mrs', 'ms', 'using', 'lets');

INSERT INTO `word_item` (`book_id`, `word`, `phonetic`, `meaning`, `syllable_word`, `example`, `example_translate`) VALUES
(3, 'was', '', 'v. 是；在（be 的过去式，用于 I/he/she/it）', NULL, NULL, NULL),
(3, 'were', '', 'v. 是；在（be 的过去式，用于 you/we/they）', NULL, NULL, NULL),
(3, 'been', '', 'v. 是；在；已经（be 的过去分词）', NULL, NULL, NULL),
(3, 'does', '', 'v. 做；干（do 的第三人称单数）', NULL, NULL, NULL),
(3, 'did', '', 'v. 做；干（do 的过去式）', NULL, NULL, NULL),
(3, 'done', '', 'v. 做；干（do 的过去分词） adj. 完成的', NULL, NULL, NULL),
(3, 'doing', '', 'v. 做；干（do 的现在分词）', NULL, NULL, NULL),
(3, 'has', '', 'v. 有；已经（have 的第三人称单数）', NULL, NULL, NULL),
(3, 'had', '', 'v. 有；已经（have 的过去式和过去分词）', NULL, NULL, NULL),
(3, 'having', '', 'v. 有；拥有（have 的现在分词）', NULL, NULL, NULL),
(3, 'goes', '', 'v. 去；走（go 的第三人称单数）', NULL, NULL, NULL),
(3, 'went', '', 'v. 去；走（go 的过去式）', NULL, NULL, NULL),
(3, 'gone', '', 'v. 去；走（go 的过去分词） adj. 离去的', NULL, NULL, NULL),
(3, 'going', '', 'v. 去；走（go 的现在分词） n. 行为；进展', NULL, NULL, NULL),
(3, 'comes', '', 'v. 来；来到（come 的第三人称单数）', NULL, NULL, NULL),
(3, 'came', '', 'v. 来；来到（come 的过去式）', NULL, NULL, NULL),
(3, 'coming', '', 'v. 来；来到（come 的现在分词） adj. 即将到来的', NULL, NULL, NULL),
(3, 'gets', '', 'v. 得到；变得（get 的第三人称单数）', NULL, NULL, NULL),
(3, 'got', '', 'v. 得到；变得（get 的过去式和过去分词）', NULL, NULL, NULL),
(3, 'gotten', '', 'v. 得到；变得（get 的过去分词，美式）', NULL, NULL, NULL);
INSERT INTO `word_item` (`book_id`, `word`, `phonetic`, `meaning`, `syllable_word`, `example`, `example_translate`) VALUES
(3, 'getting', '', 'v. 得到；变得（get 的现在分词）', NULL, NULL, NULL),
(3, 'makes', '', 'v. 做；制造（make 的第三人称单数）', NULL, NULL, NULL),
(3, 'made', '', 'v. 做；制造（make 的过去式和过去分词）', NULL, NULL, NULL),
(3, 'making', '', 'v. 做；制造（make 的现在分词）', NULL, NULL, NULL),
(3, 'takes', '', 'v. 拿；取；花费（take 的第三人称单数）', NULL, NULL, NULL),
(3, 'took', '', 'v. 拿；取；花费（take 的过去式）', NULL, NULL, NULL),
(3, 'taken', '', 'v. 拿；取；花费（take 的过去分词）', NULL, NULL, NULL),
(3, 'taking', '', 'v. 拿；取；花费（take 的现在分词）', NULL, NULL, NULL),
(3, 'sees', '', 'v. 看见；理解（see 的第三人称单数）', NULL, NULL, NULL),
(3, 'saw', '', 'v. 看见；理解（see 的过去式）', NULL, NULL, NULL),
(3, 'seen', '', 'v. 看见；理解（see 的过去分词）', NULL, NULL, NULL),
(3, 'seeing', '', 'v. 看见；理解（see 的现在分词）', NULL, NULL, NULL),
(3, 'knows', '', 'v. 知道；了解（know 的第三人称单数）', NULL, NULL, NULL),
(3, 'knew', '', 'v. 知道；了解（know 的过去式）', NULL, NULL, NULL),
(3, 'known', '', 'v. 知道；了解（know 的过去分词） adj. 已知的', NULL, NULL, NULL),
(3, 'knowing', '', 'v. 知道；了解（know 的现在分词） adj. 有知识的', NULL, NULL, NULL),
(3, 'thinks', '', 'v. 想；认为（think 的第三人称单数）', NULL, NULL, NULL),
(3, 'thought', '', 'v. 想；认为（think 的过去式和过去分词） n. 想法；思想', NULL, NULL, NULL),
(3, 'thinking', '', 'v. 想；认为（think 的现在分词） n. 思考；想法', NULL, NULL, NULL),
(3, 'gives', '', 'v. 给；提供（give 的第三人称单数）', NULL, NULL, NULL);
INSERT INTO `word_item` (`book_id`, `word`, `phonetic`, `meaning`, `syllable_word`, `example`, `example_translate`) VALUES
(3, 'gave', '', 'v. 给；提供（give 的过去式）', NULL, NULL, NULL),
(3, 'giving', '', 'v. 给；提供（give 的现在分词）', NULL, NULL, NULL),
(3, 'tells', '', 'v. 告诉；讲述（tell 的第三人称单数）', NULL, NULL, NULL),
(3, 'told', '', 'v. 告诉；讲述（tell 的过去式和过去分词）', NULL, NULL, NULL),
(3, 'telling', '', 'v. 告诉；讲述（tell 的现在分词）', NULL, NULL, NULL),
(3, 'says', '', 'v. 说；讲（say 的第三人称单数）', NULL, NULL, NULL),
(3, 'said', '', 'v. 说；讲（say 的过去式和过去分词）', NULL, NULL, NULL),
(3, 'finds', '', 'v. 发现；找到（find 的第三人称单数）', NULL, NULL, NULL),
(3, 'puts', '', 'v. 放；放置（put 的第三人称单数）', NULL, NULL, NULL),
(3, 'putting', '', 'v. 放；放置（put 的现在分词）', NULL, NULL, NULL),
(3, 'runs', '', 'v. 跑；运行（run 的第三人称单数）', NULL, NULL, NULL),
(3, 'ran', '', 'v. 跑；运行（run 的过去式）', NULL, NULL, NULL),
(3, 'men', '', 'n. 男人（man 的复数）', NULL, NULL, NULL),
(3, 'women', '', 'n. 女人（woman 的复数）', NULL, NULL, NULL),
(3, 'children', '', 'n. 孩子们（child 的复数）', NULL, NULL, NULL),
(3, 'eyes', '', 'n. 眼睛（eye 的复数）', NULL, NULL, NULL),
(3, 'hands', '', 'n. 手（hand 的复数） v. 递交（hand 的第三人称单数）', NULL, NULL, NULL),
(3, 'ai', '', 'n. 人工智能（Artificial Intelligence 的缩写）', NULL, NULL, NULL),
(3, 'mr', '', 'n. 先生（Mister 的缩写）', NULL, NULL, NULL),
(3, 'mrs', '', 'n. 夫人；太太（Mistress 的缩写）', NULL, NULL, NULL);
INSERT INTO `word_item` (`book_id`, `word`, `phonetic`, `meaning`, `syllable_word`, `example`, `example_translate`) VALUES
(3, 'ms', '', 'n. 女士（Ms. 的写法）', NULL, NULL, NULL),
(3, 'using', '', 'v. 使用（use 的现在分词）', NULL, NULL, NULL),
(3, 'lets', '', 'v. 让；允许（let 的第三人称单数）', NULL, NULL, NULL);

-- 更新四级词书单词总数
UPDATE `word_book` SET `total_count` = (SELECT COUNT(*) FROM `word_item` WHERE `book_id` = 3) WHERE `id` = 3;
