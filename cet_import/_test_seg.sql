  'What does the author seem to suggest?',
  'D',
  '[{"label": "A", "content": "It is important to increase the size of the middle class."}, {"label": "B", "content": "It is highly important to expand the metropolitan areas."}, {"label": "C", "content": "It is most imperative to focus our efforts on the elimination of income inequality."}, {"label": "D", "content": "It is better to start from the community to help poor children move up the social ladder."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_2', 63);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '在中国，父母总是竭力帮助孩子，甚至为孩子做重要决定，而不管孩子想要什么，因为他们相信这样做是为孩子好。结果，孩子的成长和教育往往屈从于父母的意愿如果父母决定为孩子报名参加一个课外班，以增加其被重点学校录取的机会，他们会坚持自己的决定。即使孩子根本不感兴趣。 然而在美国，父母很可能会尊重孩子的意见，并在决策时更注重他们的意见。中国父母十分重视教育或许值得称赞。然而，他们应向美国父母学习在涉及教育时如何平衡父母与子女间的关系。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 64);
