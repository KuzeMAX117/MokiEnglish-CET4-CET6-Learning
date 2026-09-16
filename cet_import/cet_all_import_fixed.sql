-- =====================================================
-- 四六级历年真题完整导入SQL
-- 生成时间: 2026-09-10 00:13:43
-- 共 32 套试卷
-- =====================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

-- ============================================================
-- [1] 2015年下半年大学英语六级真题（第1套）
-- 题目数: 64
-- 源文件: 四六级历年真题汇总/2015年12月英语四六级/2015年12月英语六级真题及答案/卷一 2015年12月英语六级真题及答案/卷一 2015年12月英语六级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2015, 2, '2015年下半年大学英语六级真题（第1套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write a short essay based on the picture below. You should focus on the impact of social networking websites on reading.You are reauired to write at least 150 words but no more than 200 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  'C',
  '[{"label": "A", "content": "The restaurant offers some specials each day."}, {"label": "B", "content": "The restaurant is known for its food varieties."}, {"label": "C", "content": "The dressing makes the mixed salad very inviting."}, {"label": "D", "content": "The woman should mix the ingredients thoroughly."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  'B',
  '[{"label": "A", "content": "He took over the firm from Mary."}, {"label": "B", "content": "He is running a successful business."}, {"label": "C", "content": "He failed to foresee major problems."}, {"label": "D", "content": "He is opening a new consulting firm."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  'C',
  '[{"label": "A", "content": "Someone should be put in charge of office supplies."}, {"label": "B", "content": "The man can leave the discs in the office cabinet."}, {"label": "C", "content": "The man may find the supplies in the cabinet."}, {"label": "D", "content": "The printer in the office has run out of paper."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  'A',
  '[{"label": "A", "content": "He has to use a magnifying glass to see clearly."}, {"label": "B", "content": "The woman can use his glasses to read."}, {"label": "C", "content": "He has the dictionary the woman wants."}, {"label": "D", "content": "The dictionary is not of much help to him."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q5',
  'A',
  '[{"label": "A", "content": "Redecorating her office."}, {"label": "B", "content": "Majoring in interior design."}, {"label": "C", "content": "Seeking professional advice."}, {"label": "D", "content": "Adding some office furniture."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  'D',
  '[{"label": "A", "content": "Problems in port management."}, {"label": "B", "content": "Improvement of port facilities."}, {"label": "C", "content": "Delayed shipment of goods."}, {"label": "D", "content": "Shortage of container ships."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  'B',
  '[{"label": "A", "content": "Their boss."}, {"label": "B", "content": "A colleague."}, {"label": "C", "content": "Their workload."}, {"label": "D", "content": "A coffee machine."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  'C',
  '[{"label": "A", "content": "Call the hotel manager for help."}, {"label": "B", "content": "Postpone the event until a later date."}, {"label": "C", "content": "Hold the banquet at a different place."}, {"label": "D", "content": "Get an expert to correct the error."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  'B',
  '[{"label": "A", "content": "He shares some of the household duties."}, {"label": "B", "content": "He often goes back home late for dinner."}, {"label": "C", "content": "He cooks dinner for the family occasionally."}, {"label": "D", "content": "He dines out from time to time with friends."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  'D',
  '[{"label": "A", "content": "To take him to dinner."}, {"label": "B", "content": "To talk about a budget plan."}, {"label": "C", "content": "To discuss an urgent problem."}, {"label": "D", "content": "To pass on an important message."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  'D',
  '[{"label": "A", "content": "Foreign investors are losing confidence in India\'s economy."}, {"label": "B", "content": "Many multinational enterprises are withdrawing from India."}, {"label": "C", "content": "There are wild fluctuations in the international money market."}, {"label": "D", "content": "There is a sharp increase in India\'s balance of payment deficit."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  'A',
  '[{"label": "A", "content": "They have unrealistic expectations about the other half."}, {"label": "B", "content": "They may not be prepared for a lifelong relationship."}, {"label": "C", "content": "They form a more realistic picture of life."}, {"label": "D", "content": "They try to adapt to their changing roles."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  'D',
  '[{"label": "A", "content": "He is lucky to have visited many exotic places."}, {"label": "B", "content": "He is able to forget all the troubles in his life."}, {"label": "C", "content": "He is able to meet many interesting people."}, {"label": "D", "content": "He is lucky to be able to do what he loves."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  'C',
  '[{"label": "A", "content": "It is stressful."}, {"label": "B", "content": "It is full of time."}, {"label": "C", "content": "It is all glamour."}, {"label": "D", "content": "It is challenging"}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  'B',
  '[{"label": "A", "content": "Bothered."}, {"label": "B", "content": "Amazed."}, {"label": "C", "content": "Puzzled."}, {"label": "D", "content": "Excited."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  'B',
  '[{"label": "A", "content": "Maintain the traditional organizational culture."}, {"label": "B", "content": "Learn new ways of relating and working together."}, {"label": "C", "content": "Follow closely the fast development of technology."}, {"label": "D", "content": "Learn to be respectful in a hierarchical organization."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  'A',
  '[{"label": "A", "content": "How the team integrates with what it is supposed to serve."}, {"label": "B", "content": "How the team is built to keep improving its performance."}, {"label": "C", "content": "What type of personnel the team should be composed of."}, {"label": "D", "content": "What qualifications team members should be equipped with."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  'D',
  '[{"label": "A", "content": "A team manager must set very clear and high objectives."}, {"label": "B", "content": "Teams must consist of members from different cultures."}, {"label": "C", "content": "Team members should be knowledgeable and creative."}, {"label": "D", "content": "A team manager should develop a certain set of skills."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  'D',
  '[{"label": "A", "content": "It is a platform for sharing ideas on teaching at the University of Illinois."}, {"label": "B", "content": "It was mainly used by scientists and technical people to exchange text."}, {"label": "C", "content": "It started off as a successful program but was unable to last long."}, {"label": "D", "content": "It is a program allowing people to share information on the Web."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  'B',
  '[{"label": "A", "content": "He visited a number of famous computer scientists."}, {"label": "B", "content": "He met with an entrepreneur named Jim Clark."}, {"label": "C", "content": "He sold a program developed by his friends."}, {"label": "D", "content": "He invested in a leading computer business."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  'A',
  '[{"label": "A", "content": "They had confidence in his new ideas."}, {"label": "B", "content": "They trusted his computer expertise."}, {"label": "C", "content": "They were very keen on new technology."}, {"label": "D", "content": "They believed in his business connections."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  'C',
  '[{"label": "A", "content": "Prestige advertising."}, {"label": "B", "content": "Institutional advertising."}, {"label": "C", "content": "Word of mouth advertising."}, {"label": "D", "content": "Distributing free trial products."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  'B',
  '[{"label": "A", "content": "To sell a particular product."}, {"label": "B", "content": "To build up their reputation."}, {"label": "C", "content": "To promote a specific service."}, {"label": "D", "content": "To attract high-end consumers."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  'A',
  '[{"label": "A", "content": "By using the services of large advertising agencies."}, {"label": "B", "content": "By hiring their own professional advertising staff."}, {"label": "C", "content": "By buying media space in leading newspapers."}, {"label": "D", "content": "By creating their own ads and commericais."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  'D',
  '[{"label": "A", "content": "Decide on what specific means of communication to employ."}, {"label": "B", "content": "Conduct a large-scale survey on customer needs."}, {"label": "C", "content": "Specify the objectives of the campaign in detail."}, {"label": "D", "content": "Pre-test alternative ads or commercials in certain regions."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. tho words in the bank more than once.\n\nQuestions 36 to 45 are based on the following passage. \nIt seem',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. sales 37 But consumers\' preferences were already 38 toward touch-screen smartphones. With the introduc',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. in the middle of that year, Nokia\'s market share 39 rapidly and revenue plunged. By the end of 2013, N',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Reading Comprehension            (40 minutes)\nSection A\nDirections: In this section, th',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. nology giant, was too fascinated by the company\'s 43 success to recognize the change that was needed to',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. s competitiveness. The company also embarked on a 44 cost-cutting program, which included the 45 elimin',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. ords in the bank more than once.\n\nQuestions 36 to 45 are based on the following passage. \nIt seems to b',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '46. Many first-generation college-goers have doubts about their abilities to get a college degree.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. First-generation college students tend to have much heavier financial burdens than their peers.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. The graduation rate of first-generation students at Nijay\'s university was incredibly low.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. Some top institutions like Yale seem to provide first-generation students with more support than they actually need.',
  'N',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. On entering college, Nijay Williams had no idea how challenging college education was.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '51. Many universities simply refuse to release their exact graduation rates for first-generation students.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '52. According to a marketing executive, many students from low-income families don\'t know they could have a chance of going to an elite university.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. Some elite universities attach great importance to building up the first-generation students\' serf-confidence.',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. I\'m First distributes information to help first-generation college-goers find schools that are most suitable for them.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 42);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. Elite universities tend to graduate first-generation students at a higher rate.',
  'M',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 43);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Many first-generation college-goers have doubts about their abilities to get a college degree.',
  'H',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 44);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'First-generation college students tend to have much heavier financial burdens than their peers.',
  'C',
  NULL,
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 45);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'The graduation rate of first-generation students at Nijay\'s university was incredibly low.',
  'B',
  NULL,
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 46);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Some top institutions like Yale seem to provide first-generation students with more support than they actually need.',
  'N',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 47);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'On entering college, Nijay Williams had no idea how challenging college education was.',
  'A',
  NULL,
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 48);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Many universities simply refuse to release their exact graduation rates for first-generation students.',
  'I',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 49);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'According to a marketing executive, many students from low-income families don\'t know they could have a chance of going to an elite university.',
  'G',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 50);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Some elite universities attach great importance to building up the first-generation students\' serf-confidence.',
  'O',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 51);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'I\'m First distributes information to help first-generation college-goers find schools that are most suitable for them.',
  'D',
  NULL,
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 52);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Elite universities tend to graduate first-generation students at a higher rate.  Section C Directions: There are 2 passages in this section. Each passage is followed by some questions or unfinished statements. For each of them there are four choices marked',
  'M',
  '[{"label": "A", "content": ","}, {"label": "B", "content": ","}, {"label": "C", "content": "and"}, {"label": "D", "content": "You should decide on the best choice and mark the corresponding letter on Answer Sheet 2 with a single line through the centre."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 53);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do some most influential medical groups recommend doctors do?',
  'C',
  '[{"label": "A", "content": "Reflect on the responsibilities they are supposed to take."}, {"label": "B", "content": "Pay more attention to the effectiveness of their treatments."}, {"label": "C", "content": "Take costs into account when making treatment decisions."}, {"label": "D", "content": "Readjust their practice in view of the cuts in health care."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 54);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What were doctors mainly concerned about in the past?',
  'B',
  '[{"label": "A", "content": "Specific medicines to be used."}, {"label": "B", "content": "Effects of medical treatment."}, {"label": "C", "content": "Professional advancement."}, {"label": "D", "content": "Patients\' trust."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 55);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What may the new guidelines being developed lead to?',
  'A',
  '[{"label": "A", "content": "The redefining of doctors\' roles."}, {"label": "B", "content": "Overuse of less effective medicines."}, {"label": "C", "content": "Conflicts between doctors and patients."}, {"label": "D", "content": "The prolonging of patients\' suffering."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 56);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What risk do doctors see in their dual role as patient care providers and financial overseers?',
  'D',
  '[{"label": "A", "content": "They may be involved in a conflict of interest."}, {"label": "B", "content": "They may be forced to divide their attention."}, {"label": "C", "content": "They may have to use less effective drugs."}, {"label": "D", "content": "They may lose the respect of patients."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 57);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do some experts say about doctors\' involvement in medical cost analysis?',
  'C',
  '[{"label": "A", "content": "It may add to doctors\' already heavy workloads."}, {"label": "B", "content": "It will help to save money for society as a whole."}, {"label": "C", "content": "It results from society\'s failure to tackle the problem."}, {"label": "D", "content": "It raises doctors\' awareness of their social responsibilities."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 58);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'How does Obama view economic inequality?',
  'A',
  '[{"label": "A", "content": "It is the biggest obstacle to social mobility."}, {"label": "B", "content": "It is the greatest threat to social stability."}, {"label": "C", "content": "It is the No. 1 enemy of income growth."}, {"label": "D", "content": "It is the most malicious social evil of our time."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_2', 59);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn about the inequality gap from Scott Winship\'s data analysis?',
  'B',
  '[{"label": "A", "content": "It is fast widening across most parts of America."}, {"label": "B", "content": "It is not a reliable indicator of economic mobility."}, {"label": "C", "content": "It is not correctly interpreted."}, {"label": "D", "content": "It is overwhelmingly ignored."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_2', 60);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Compared with Atlanta, metropolitan Salt Lake City is said to',
  'C',
  '[{"label": "A", "content": "have placed religious beliefs above party politics"}, {"label": "B", "content": "have bridged the gap between the rich and the poor"}, {"label": "C", "content": "offer poor children more chances to climb the social ladder"}, {"label": "D", "content": "suffer from higher levels of racial and economic segregation"}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_2', 61);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is strongly correlated with social mobility according to economist Raj Cherty?',
  'A',
  '[{"label": "A", "content": "Family structure."}, {"label": "B", "content": "Racial equality."}, {"label": "C", "content": "School education."}, {"label": "D", "content": "Community density."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_2', 62);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
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


-- ============================================================
-- [2] 2015年下半年大学英语六级真题（第3套）
-- 题目数: 39
-- 源文件: 四六级历年真题汇总/2015年12月英语四六级/2015年12月英语六级真题及答案/卷三 2015年12月英语六级真题及答案/卷三 2015年12月大学英语六级考试真题.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2015, 2, '2015年下半年大学英语六级真题（第3套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write a short essay based on the picture below.You should focus on the harm caused by misleading information online.You are required to write at least 150 words but no more than 200 words. Part Ⅱ',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. the words in the bank more than once.\n\nQuestions 36 to 45 are based on the following passage.\nAs it is',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. t get the 7 to 9 hours of shut-eye every night as 37  by sleep experts.\nWhether or not we can catch up o',
  'M',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. atch up on sleep--on the weekend, say--is a hotly 38   topic among sleep researchers.The latest evidence',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Reading Comprehension            (40 minutes)\nSection A\nDirections: In this section, th',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. they logged about 10 hours per night, they showed 41 in the ability of insulin (胰岛素) to process blood s',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. ay undo some\nbut not all of the damage that sleep 42 causes, which is encouraging, given how many adult',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. t the hours they need each night.Still, Liu isn\'t 43 to endorse the habit of sleeping less and making u',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. .\nSleeping pills, while helpful for some, are not 44 an effective remedy either."A sleeping pill will 4',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. ords in the bank more than once.\n\nQuestions 36 to 45 are based on the following passage.\nAs it is, slee',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '46. When people find they are powerless to change a situation, they tend to live with it.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. To be effective, environmental messages should be carefully framed.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. It is the government\'s responsibility to persuade people into making environment-friendly decisions.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. Politicians are beginning to realise the importance of enlisting psychologists\' help in fighting climate change.',
  'P',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. To find effective solutions to climate change, it is necessary to understand what motivates people to make change.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '51. In their evolution, humans have learned to pay attention to the most urgent issues instead of long-term concerns.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '52. One study shows that our neighbours\' actions are influential in changing our behaviour.',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. Despite clear signs of global warming, it is not easy for most people to believe climate change will affect their own lives.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. We should take our future into consideration in making decisions concerning climate change before it is too late.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. Existing social networks can be more effective in creating change in people\'s behaviour.',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'When people find they are powerless to change a situation, they tend to live with it.',
  'C',
  NULL,
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'To be effective, environmental messages should be carefully framed.',
  'L',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'It is the government\'s responsibility to persuade people into making environment-friendly decisions.',
  'G',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Politicians are beginning to realise the importance of enlisting psychologists\' help in fighting climate change.',
  'P',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'To find effective solutions to climate change, it is necessary to understand what motivates people to make change.',
  'H',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'In their evolution, humans have learned to pay attention to the most urgent issues instead of long-term concerns.',
  'D',
  NULL,
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'One study shows that our neighbours\' actions are influential in changing our behaviour.',
  'J',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Despite clear signs of global warming, it is not easy for most people to believe climate change will affect their own lives.',
  'B',
  NULL,
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'We should take our future into consideration in making decisions concerning climate change before it is too late.',
  'F',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Existing social networks can be more effective in creating change in people\'s behaviour.  Section C Directions: There are 2 passages in this section.Each passage is followed by some questions or unfinished statements.For each of them there are four choices marked',
  'O',
  '[{"label": "A", "content": ","}, {"label": "B", "content": ","}, {"label": "C", "content": "and"}, {"label": "D", "content": ".You should decide on the best choice and mark the corresponding letter on Answer Sheet 2 with a single line through the centre."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'In what way are college students different from children?',
  'A',
  '[{"label": "A", "content": "They have learned to think critically."}, {"label": "B", "content": "They are concerned about social issues."}, {"label": "C", "content": "They are curious about specific features."}, {"label": "D", "content": "They have learned to work independently."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is the benefit of asking questions with no ready answers?',
  'B',
  '[{"label": "A", "content": "It arouses students\' interest in things around them."}, {"label": "B", "content": "It cultivates students\' ability to make scientific inquiries."}, {"label": "C", "content": "It trains students\' ability to design scientific experiments."}, {"label": "D", "content": "It helps students realize not every question has an answer."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is said to be the advantage of informal learning?',
  'A',
  '[{"label": "A", "content": "It allows for failures."}, {"label": "B", "content": "It is entertaining."}, {"label": "C", "content": "It charges no tuition."}, {"label": "D", "content": "It meets practical needs."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author seem to encourage educators to do at the end of the passage?',
  'C',
  '[{"label": "A", "content": "Train students to think about global issues."}, {"label": "B", "content": "Design more interactive classroom activities."}, {"label": "C", "content": "Make full use of informal learning resources."}, {"label": "D", "content": "Include collaborative inquiry in the curriculum."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn about the space-tourism firm Virgin Galactic?',
  'C',
  '[{"label": "A", "content": "It has just built a craft for commercial flights."}, {"label": "B", "content": "It has sent half a dozen passengers into space."}, {"label": "C", "content": "It was about ready to start regular business."}, {"label": "D", "content": "It is the first to launch \\"suborbital\\" flights."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_2', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is the purpose of the 2004 Commercial Space Launch Amendments Act?',
  'D',
  '[{"label": "A", "content": "To ensure space travel safety."}, {"label": "B", "content": "To limit the FAA\'s functions."}, {"label": "C", "content": "To legalize private space explorations."}, {"label": "D", "content": "To promote the space tourism industry."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_2', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What might the FAA do after the recent accident in California?',
  'D',
  '[{"label": "A", "content": "Impose more rigid safety standards."}, {"label": "B", "content": "Stop certifying new space-tourist agencies."}, {"label": "C", "content": "Amend its 2004 Commercial Space Launch Amendments Act."}, {"label": "D", "content": "Suspend Virgin Galactic\'s licence to take passengers into space."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_2', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author think of private space travel?',
  'A',
  '[{"label": "A", "content": "It is worth promoting despite the risks involved."}, {"label": "B", "content": "It should not be confined to the rich only."}, {"label": "C", "content": "It should be strictly regulated."}, {"label": "D", "content": "It is too risky to carry on."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_2', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '在帮助国际社会于2030年前消除极端贫困过程中，中国正扮演着越来越重要的角色。 自20世纪70年代未实施改革开放以来，中国已使多达四亿人摆脱了贫困。在未来五年中，中国将向其他发展中国家在减少贫困、发展教育、农业现代化、环境保护和医疗保健等方面提供援助。 中国在减少贫困方面取得了显著进步，并在促进经济增长方面做出了不懈努力，这将鼓励其他贫困国家应对自身发展中的挑战。在寻求具有自身特色的发展道路时，这些国家可以借鉴中国的经验。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 39);


-- ============================================================
-- [3] 2015年下半年大学英语六级真题（第2套）
-- 题目数: 63
-- 源文件: 四六级历年真题汇总/2015年12月英语四六级/2015年12月英语六级真题及答案/卷二 2015年12月英语六级真题及答案/卷二 2015年12月英语六级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2015, 2, '2015年下半年大学英语六级真题（第2套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write a short essay based on the picture below. You should focus on the difficulty in acquiring useful information in spite of advanced information technology. You are required to write at least 150 words but no more than 200 words．',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  'C',
  '[{"label": "A", "content": "She is impatient to learn computer programming."}, {"label": "B", "content": "She is unaware her operation system is outdated."}, {"label": "C", "content": "She is unable to use the new computer program."}, {"label": "D", "content": "She is amazed at the fast change of technology."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  'B',
  '[{"label": "A", "content": "He has long been fed up with traveling."}, {"label": "B", "content": "He prefers to stay home for the holiday."}, {"label": "C", "content": "He is going out of town for a couple of days."}, {"label": "D", "content": "He is annoyed by the heavy traffic downtown."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  'B',
  '[{"label": "A", "content": "The challenges facing East Asia."}, {"label": "B", "content": "The location for their new office."}, {"label": "C", "content": "Their expansion into the overseas market"}, {"label": "D", "content": "The living expenses in Tokyo and Singapore."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  'A',
  '[{"label": "A", "content": "A number of cell phones were found after the last show."}, {"label": "B", "content": "The woman forgot where she had left her cell phone."}, {"label": "C", "content": "The woman was very pleased to find her cell phone."}, {"label": "D", "content": "Reserved tickets could be picked up at the ticket counter."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q5',
  'C',
  '[{"label": "A", "content": "The building materials will be delivered soon."}, {"label": "B", "content": "The project is being held up by bad weather."}, {"label": "C", "content": "The construction schedule may not be met."}, {"label": "D", "content": "Qualified carpenters are not easy to find."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  'B',
  '[{"label": "A", "content": "She is getting very forgetful these days."}, {"label": "B", "content": "She does not hold on to bitter feelings."}, {"label": "C", "content": "She resents the way she is treated."}, {"label": "D", "content": "She never intends to hurt anyone."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  'D',
  '[{"label": "A", "content": "The man wants to rent a small apartment."}, {"label": "B", "content": "The woman has trouble getting a mortgage."}, {"label": "C", "content": "The woman is moving to a foreign country."}, {"label": "D", "content": "The man is trying to sell the woman a house."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  'C',
  '[{"label": "A", "content": "They are writing a story for the Morning News."}, {"label": "B", "content": "They are facing great challenges to get re-elected."}, {"label": "C", "content": "They are launching a campaign to attract women voters."}, {"label": "D", "content": "They are conducting a survey among the women in town."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  'A',
  '[{"label": "A", "content": "Touch his heart."}, {"label": "B", "content": "Make him cry."}, {"label": "C", "content": "Remind him of his life."}, {"label": "D", "content": "Make him feel young."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  'C',
  '[{"label": "A", "content": "He is good at singing operas."}, {"label": "B", "content": "He enjoys complicated music:"}, {"label": "C", "content": "He can sing any song if he likes it."}, {"label": "D", "content": "He loves country music in particular."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  'D',
  '[{"label": "A", "content": "Go to a bar and drink for hours."}, {"label": "B", "content": "Go to an isolated place to sing blues."}, {"label": "C", "content": "Go to see a performance in a concert hall."}, {"label": "D", "content": "Go to work and wrap himself up in music."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  'D',
  '[{"label": "A", "content": "How he became an announcer."}, {"label": "B", "content": "How he writes news stories."}, {"label": "C", "content": "How he makes his living."}, {"label": "D", "content": "How he does his job."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  'A',
  '[{"label": "A", "content": "They write the first version of news stories."}, {"label": "B", "content": "They gather news stories on the spot."}, {"label": "C", "content": "They polish incoming news stories."}, {"label": "D", "content": "They write comments on major news stories."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  'B',
  '[{"label": "A", "content": "Reading through the news stories in a given period of time."}, {"label": "B", "content": "Having little time to read the news before going on the air."}, {"label": "C", "content": "Having to change the tone of his voice from time to time."}, {"label": "D", "content": "Getting all the words and phrases pronounced correctly."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  'D',
  '[{"label": "A", "content": "It shows where advertisements come in."}, {"label": "B", "content": "It gives a signal for him to slow down."}, {"label": "C", "content": "It alerts him to something important."}, {"label": "D", "content": "It serves as a reminder of sad news."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  'A',
  '[{"label": "A", "content": "It gives pleasure to both adults and children."}, {"label": "B", "content": "It is often carried around by small children."}, {"label": "C", "content": "It can be found in many parts of the world."}, {"label": "D", "content": "It was invented by an American Indian."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  'C',
  '[{"label": "A", "content": "They were made for earning a living."}, {"label": "B", "content": "They were delicate geometric figures."}, {"label": "C", "content": "They were small circus figures made of wire."}, {"label": "D", "content": "They were collected by a number of museums."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  'A',
  '[{"label": "A", "content": "In art."}, {"label": "B", "content": "In geometry."}, {"label": "C", "content": "In engineering."}, {"label": "D", "content": "In circus performance."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  'B',
  '[{"label": "A", "content": "They offer students a wide variety of courses."}, {"label": "B", "content": "They attract students from all over the world."}, {"label": "C", "content": "They admit more students than they can handle."}, {"label": "D", "content": "They have trouble dealing with overseas students."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  'D',
  '[{"label": "A", "content": "Everyone will benefit from education sooner or later."}, {"label": "B", "content": "A good education contributes to the prosperity of a nation."}, {"label": "C", "content": "A good education is necessary for one to climb the social ladder."}, {"label": "D", "content": "Everyone has a right to an education appropriate to his potential."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  'A',
  '[{"label": "A", "content": "He likes students with high motivation."}, {"label": "B", "content": "He enjoys teaching intelligent students."}, {"label": "C", "content": "He tailors his teaching to students\' needs."}, {"label": "D", "content": "He treats all his students in a fair manner."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  'D',
  '[{"label": "A", "content": "It is mostly imported from the Middle East."}, {"label": "B", "content": "It is a sure indicator of its economic activity."}, {"label": "C", "content": "It has a direct impact on the international oil market."}, {"label": "D", "content": "It equals more than 30 million barrels of oil each day."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  'A',
  '[{"label": "A", "content": "It eventually turns into heat."}, {"label": "B", "content": "It is used in a variety of forms."}, {"label": "C", "content": "Its use is chiefly responsible for air pollution."}, {"label": "D", "content": "Part of it is lost in the process of transmission."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  'C',
  '[{"label": "A", "content": "When it is used in rural areas."}, {"label": "B", "content": "When it is environment-friendly."}, {"label": "C", "content": "When it operates at near capacity."}, {"label": "D", "content": "When it operates at regular times."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  'B',
  '[{"label": "A", "content": "Traffic jams in cities."}, {"label": "B", "content": "Inefficient use of energy."}, {"label": "C", "content": "Fuel shortage."}, {"label": "D", "content": "Global warming."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. the words in the bank more than once.\n\nQuestions 36 to 45 are based on the following passage.\nAccordin',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. ever, is still evolving. Health and environmental 38 have long urged U.S. government agencies to 39 the',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. al 38 have long urged U.S. government agencies to 39 the use of some of the 11 chemicals the report cit',
  'N',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Part III Reading Comprehension (40 minutes) \nSection A\nDirections: In this section, t',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. re raised about lead poisoning. The agency is now 42 the toxic effects of some of the chemicals in the',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. them on exposure to specific chemicals with solid 43 evidence, which is what the EPA requires. Even the',
  'M',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. es. Even the Harvard study did not prove a direct 44 but noted strong associations between exposure and',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. ords in the bank more than once.\n\nQuestions 36 to 45 are based on the following passage.\nAccording to a',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '46. Not only moving objects and people but all systems have momentum.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. Changing the current energy system requires the systematic training of professionals and skilled labor.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. Changing a light bulb is easier than changing the fixture housing it.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. Efforts to accelerate the current energy transitions didn\'t succeed as expected.',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. To change the light source is costly because you have to change the whole fixture.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '51. Energy systems, like an aircraft carrier set in motion, have huge momentum.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '52. The problem with lighting, if it arises, often doesn\'t lie in light sources but in their applications.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. The biggest obstacle to energy transition is that the present energy system is too expensive to replace.',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 42);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. The application of a technology can impact areas beyond itself.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 43);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. Physical characteristics of moving objects help explain the dynamics of energy systems.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 44);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Not only moving objects and people but all systems have momentum.',
  'C',
  NULL,
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 45);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Changing the current energy system requires the systematic training of professionals and skilled labor.',
  'I',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 46);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Changing a light bulb is easier than changing the fixture housing it.',
  'E',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 47);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Efforts to accelerate the current energy transitions didn\'t succeed as expected.',
  'K',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 48);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'To change the light source is costly because you have to change the whole fixture.',
  'G',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 49);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Energy systems, like an aircraft carrier set in motion, have huge momentum.',
  'A',
  NULL,
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 50);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'The problem with lighting, if it arises, often doesn\'t lie in light sources but in their applications.',
  'G',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 51);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'The biggest obstacle to energy transition is that the present energy system is too expensive to replace.',
  'J',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 52);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'The application of a technology can impact areas beyond itself.',
  'D',
  NULL,
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 53);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Physical characteristics of moving objects help explain the dynamics of energy systems.  Section C Directions: There are 2 passages in this section. Each passage is followed by some questions or unfinished statements. For each of them there are four choices marked',
  'B',
  '[{"label": "A", "content": ","}, {"label": "B", "content": ","}, {"label": "C", "content": ",and"}, {"label": "D", "content": ". You should decide on the best choice and mark the corresponding letter on Answer Sheet 2 with a single line through the centre."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 54);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author say about the naming of an ethnic group ?',
  'D',
  '[{"label": "A", "content": "It advances with the times."}, {"label": "B", "content": "It is based on racial roots."}, {"label": "C", "content": "It merits intensive study."}, {"label": "D", "content": "It is politically sensitive."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 55);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do Erika Hall\'s findings indicate?',
  'A',
  '[{"label": "A", "content": "Racial biases are widespread in the professional world."}, {"label": "B", "content": "Many applicants don\'t attend to details on their resumes."}, {"label": "C", "content": "Job seekers should all be careful- about their affiliations."}, {"label": "D", "content": "Most recruiters are unable to control their racial biases."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 56);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does Erika Hall find in her experiment about a man with the last name Williams?',
  'C',
  '[{"label": "A", "content": "African Americans fare better than many other ethnic groups."}, {"label": "B", "content": "lack people\'s socioeconomic status in America remains low."}, {"label": "C", "content": "People\'s conception of a person has much to do with the way he or she is labeled."}, {"label": "D", "content": "One\'s professional standing and income are related to their educational background."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 57);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is Dr. Du Bois\'s ideal?',
  'A',
  '[{"label": "A", "content": "All Americans enjoy equal rights."}, {"label": "B", "content": "A person is judged by their worth."}, {"label": "C", "content": "A new term is created to address African Americans."}, {"label": "D", "content": "All ethnic groups share the nation\'s continued progress."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 58);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is responsible for the students\' lack of higher-level skills?',
  'A',
  '[{"label": "A", "content": "The diluted college curriculum."}, {"label": "B", "content": "The boring classroom activities."}, {"label": "C", "content": "The absence of rigorous discipline."}, {"label": "D", "content": "The outdated educational approach."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_2', 59);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does Laura Hamilton say about college administrations?',
  'D',
  '[{"label": "A", "content": "They fail to give adequate help to the needy students."}, {"label": "B", "content": "They tend to offer too many less challenging courses."}, {"label": "C", "content": "They seem to be out of touch with society."}, {"label": "D", "content": "They prioritize non-academic activities."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_2', 60);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What can be learned about the socially and financially privileged students?',
  'B',
  '[{"label": "A", "content": "They tend to have a sense of superiority over their peers."}, {"label": "B", "content": "They can afford to choose easier majors in order to enjoy themselves."}, {"label": "C", "content": "They spend a lot of time building strong connections with businesses."}, {"label": "D", "content": "They can climb the social ladder even without a degree."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_2', 61);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author suggest in the last paragraph?',
  'C',
  '[{"label": "A", "content": "American higher education has lost its global competitiveness."}, {"label": "B", "content": "People should not expect too much from American higher education."}, {"label": "C", "content": "The current situation in American higher education may not last long."}, {"label": "D", "content": "It will take a long time to change the current trend in higher education."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_2', 62);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '最近，中国政府决定将其工业升级。中国现在涉足建造高速列车、远洋船舶、机器人，甚至飞机。不久前，中国获得了在印度尼西亚(Indonesia)建造一条高铁的合同；中国还与马来西亚(Malaysia)签署了为其提供高速列车的合同,这证明人们信赖中国造产品。 中国造严品越来越受欢迎。中国为此付出了代价，但这确实有助于消除贫困，同时还为世界各地的人们提供了就业机会。这是一件好事，值得称赞。下次你去商店时，可能想看一看你所购商品的出产国名。很有可能这件商品是中国造的。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 63);


-- ============================================================
-- [4] 2015年下半年大学英语四级真题（第1套）
-- 题目数: 16
-- 源文件: 四六级历年真题汇总/2015年12月英语四六级/2015年12月英语四级真题及答案/卷一 2015年12月英语四级真题及答案/卷一 2015年12月英语四级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (4, 2015, 2, '2015年下半年大学英语四级真题（第1套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write an essay commenting on the saying “',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. the words in the bank more than once.\n\nQuestions 36 to 45 are based on the following passage.\nScholars',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. es as well.\nIt seems that the information society 37 the quantity of information available to the membe',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. and exchanging information. But such a view is a 38 analysis based on the quantity of information supp',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. d by various forms of the mass media. A different 39 is possible when the actual amount of information',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Reading Comprehension          (40 minutes)\nSection A\nDirections: In this section, th',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. taken into account. In fact, the more information 41 throughout the entire society, the wider the gap b',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. pper and middle classes and the lower class. With 43 to sex, digital divide exists between men and wome',
  'M',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. test gap, however, is between the Net-generation, 44 with personal computers and the Internet, and the',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. ords in the bank more than once.\n\nQuestions 36 to 45 are based on the following passage.\nScholars of th',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author think of time displayed everywhere?',
  'C',
  '[{"label": "A", "content": "It makes everybody time-conscious."}, {"label": "B", "content": "It is a convenience for work and life"}, {"label": "C", "content": "It may have a negative effect on creative work."}, {"label": "D", "content": "It clearly indicates the fast pace of modem life."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'How do people usually go about their work according to the author?',
  'A',
  '[{"label": "A", "content": "They combine clock-based and task-based planning."}, {"label": "B", "content": "They give priority to the most urgent task on hand."}, {"label": "C", "content": "They set a time limit for each specific task."}, {"label": "D", "content": "They accomplish their tasks one by one."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What did Tamar Avnet and Anne-Laure Sellier find in their experiments about clocks timers?',
  'D',
  '[{"label": "A", "content": "They seize opportunities as they come up."}, {"label": "B", "content": "They always get their work done in time."}, {"label": "C", "content": "They have more control over their lives."}, {"label": "D", "content": "They tend to be more productive."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do the researchers say about today’s business culture?',
  'B',
  '[{"label": "A", "content": "It does not support the strategies adopted by smart companies."}, {"label": "B", "content": "It does not attach enough importance to task-based practice."}, {"label": "C", "content": "It places more emphasis on work efficiency than on workers5 lives."}, {"label": "D", "content": "It aims to bring employees, potential and creativity into full play."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do the researchers suggest?',
  'A',
  '[{"label": "A", "content": "Task-based timing is preferred for doing creative work."}, {"label": "B", "content": "It is important to keep a balance between work and life."}, {"label": "C", "content": "Performing creative jobs tends to make workers happier."}, {"label": "D", "content": "A scientific standard should be adopted in job evaluation."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '中国父母往往过于关注孩子的学习，以至于不要他们帮忙做家务。他们对孩子的首要要求就是努力学习，考得好，能上名牌大学。他们相信这是为孩子好，因为在中国这样竞争激烈的社会里，只有成绩好才能保证前途光明。中国父母还认为，如果孩子能在社会上取得大的成就，父母就会受到尊敬。因此，他们愿意牺牲自己的时间、爱好和兴趣，为孩子提供更好的条件。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 16);


-- ============================================================
-- [5] 2015年下半年大学英语四级真题（第3套）
-- 题目数: 34
-- 源文件: 四六级历年真题汇总/2015年12月英语四六级/2015年12月英语四级真题及答案/卷三 2015年12月英语四级真题及答案/卷三 2015年12月英语四级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (4, 2015, 2, '2015年下半年大学英语四级真题（第3套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write an essay commenting on the saying" Never go out there to see what happens, go out there to make things happen." You can cit examples to illustrate the importance of being participants rather than mere onlookers in life. You should write at least 120 words but no more than 180 words. Part Ⅱ',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. the words in the bank more than once.\n\nQuestions 36 to 45 are based on the following passage.\nChildren',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. peared and stops looking for it. A 4-year-old may 37 that a sister has more fruit juice when it is only',
  'M',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. ly the shapes of the glasses that differ, not the 38 of juice.\nYet children are smart in their own way.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. ts, children are always testing their child-sized 39 about how things work. When your child throws her',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Reading Comprehension            (40 minutes)\nSection A\nDirections: In this section, th',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. es and yours can differ, and that sometimes those 42 are important and sometimes they are not.\nHow and',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. g of a flower, almost independent of what else is 44 in their lives. Although many of his specific conc',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. ords in the bank more than once.\n\nQuestions 36 to 45 are based on the following passage.\nChildren do no',
  'N',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '46. The author was advised against the improper use of figures of speech.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. The author\'s mother taught him a valuable lesson by pointing out lots of flaws in his seemingly perfect essay.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. A writer should polish his writing repeatedly so as to get closer to perfection.',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. Writers may experience periods of time in their life when they just can\'t produce anything.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. The author was not much surprised when his school teacher marked his essay as "flawless".',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '51. Criticizing someone\'s speech is said to be easier than coming up with a better one.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '52. The author looks upon his mother as his most demanding and caring instructor.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. The criticism the author received from his mother changed him as a person.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. The author gradually improved his writing by avoiding fancy language.',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. Constructive criticism gives an author a good start to improve his writing.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'The author was advised against the improper use of figures of speech.',
  'I',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'The author\'s mother taught him a valuable lesson by pointing out lots of flaws in his seemingly perfect essay.',
  'C',
  NULL,
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'A writer should polish his writing repeatedly so as to get closer to perfection.',
  'K',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Writers may experience periods of time in their life when they just can\'t produce anything.',
  'E',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'The author was not much surprised when his school teacher marked his essay as "flawless".',
  'B',
  NULL,
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Criticizing someone\'s speech is said to be easier than coming up with a better one.',
  'F',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'The author looks upon his mother as his most demanding and caring instructor.',
  'A',
  NULL,
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'The criticism the author received from his mother changed him as a person.',
  'H',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'The author gradually improved his writing by avoiding fancy language.',
  'J',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Constructive criticism gives an author a good start to improve his writing.  Section C Directions: There are 2 passages in this section. Each passage is followed by some questions or unfinished statements. For each of them there are four choices marked A, B,',
  'G',
  '[{"label": "C", "content": "and"}, {"label": "D", "content": "You should decide on the best choice and mark the corresponding letter on Answer Sheet 2 with a single line through the center."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn about Silicon Valley from the passage?',
  'A',
  '[{"label": "A", "content": "Its success is hard to copy anywhere else."}, {"label": "B", "content": "It is the biggest technology hub in the US."}, {"label": "C", "content": "Its fame in high technology is incomparable."}, {"label": "D", "content": "It leads the world in information technology."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What makes Miami unfit to produce a Silicon Valley?',
  'B',
  '[{"label": "A", "content": "Lack of incentive for investment."}, {"label": "B", "content": "Lack of the right kind of talents."}, {"label": "C", "content": "Lack of government support."}, {"label": "D", "content": "Lack of famous universities."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'In what way is Carnegie-Mellon different from Stanford, Berkeley and MIT?',
  'A',
  '[{"label": "A", "content": "Its location is not as attractive to rich people."}, {"label": "B", "content": "Its science departments are not nearly as good."}, {"label": "C", "content": "It does not produce computer hackers and nerds."}, {"label": "D", "content": "It does not pay much attention to business startups."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author imply about Boston?',
  'D',
  '[{"label": "A", "content": "It has pleasant weather all year round."}, {"label": "B", "content": "It produces wealth as well as high-tech."}, {"label": "C", "content": "It is not likely to attract lots of investors and nerds."}, {"label": "D", "content": "It is an old city with many sites of historical interest."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author say about startup investors?',
  'C',
  '[{"label": "A", "content": "They are especially wise in making investments."}, {"label": "B", "content": "They have good connections in the government."}, {"label": "C", "content": "They can do more than providing money."}, {"label": "D", "content": "They are rich enough to invest in nerds."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 34);


-- ============================================================
-- [6] 2015年下半年大学英语四级真题（第2套）
-- 题目数: 59
-- 源文件: 四六级历年真题汇总/2015年12月英语四六级/2015年12月英语四级真题及答案/卷二 2015年12月英语四级真题及答案/卷二 2015年12月英语四级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (4, 2015, 2, '2015年下半年大学英语四级真题（第2套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write an essay commenting on the saying “Learning is a daily experience and a lifetime mission.” You can cite examples to illustrate the importance of lifelong learning. You should write at least 120 words but no more than 180 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  'D',
  '[{"label": "A", "content": "The agenda for the board of directors’ meeting."}, {"label": "B", "content": "The reason for the man’s absence from the meeting."}, {"label": "C", "content": "The details of the meeting to be held next week."}, {"label": "D", "content": "The time for the man’s visit to the woman’s company."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  'C',
  '[{"label": "A", "content": "At a travel agency."}, {"label": "B", "content": "At a department store."}, {"label": "C", "content": "In a library."}, {"label": "D", "content": "In a post office."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  'B',
  '[{"label": "A", "content": "He cannot hear the woman’s call."}, {"label": "B", "content": "He cannot get through to New York."}, {"label": "C", "content": "He cannot recall the phone number."}, {"label": "D", "content": "He cannot find a public phone nearby."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  'D',
  '[{"label": "A", "content": "Watch a movie with the woman."}, {"label": "B", "content": "Revise his thesis in the office."}, {"label": "C", "content": "Do some shopping with Jane."}, {"label": "D", "content": "Discuss his thesis with Prof. Hudson."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q5',
  'C',
  '[{"label": "A", "content": "He just cannot work properly without a watch."}, {"label": "B", "content": "He has no idea where he can buy a gold watch."}, {"label": "C", "content": "He still does not know where he left his watch."}, {"label": "D", "content": "He is not sure what went wrong with his watch."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  'A',
  '[{"label": "A", "content": "He forgot all about what he said."}, {"label": "B", "content": "He slipped and hurt his head."}, {"label": "C", "content": "He was sorry for being off sick last week."}, {"label": "D", "content": "He thought the woman’s car had been sold."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  'C',
  '[{"label": "A", "content": "She should try to catch an earlier bus."}, {"label": "B", "content": "She is absent from his class too often."}, {"label": "C", "content": "She is always making excuses for being late."}, {"label": "D", "content": "She should come up with a better excuse."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  'B',
  '[{"label": "A", "content": "He is going to help the woman out."}, {"label": "B", "content": "He has to move out of the building soon."}, {"label": "C", "content": "He is on his way to see a real estate agent."}, {"label": "D", "content": "He will stay with the woman’s brother."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  'B',
  '[{"label": "A", "content": "From the wanted column."}, {"label": "B", "content": "From some of her friends."}, {"label": "C", "content": "From a telephone directory."}, {"label": "D", "content": "From a television commercial."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  'C',
  '[{"label": "A", "content": "She received full-time education abroad."}, {"label": "B", "content": "She graduated from an open university."}, {"label": "C", "content": "She finished her secondary school."}, {"label": "D", "content": "She studied in a vocational college."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  'A',
  '[{"label": "A", "content": "She is a shorthand-typist."}, {"label": "B", "content": "She works as a tour guide."}, {"label": "C", "content": "She is a policewoman."}, {"label": "D", "content": "She teaches an evening class."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  'C',
  '[{"label": "A", "content": "It provides him with career opportunities."}, {"label": "B", "content": "It helps enlarge his customer network."}, {"label": "C", "content": "It has been off and on for ten years."}, {"label": "D", "content": "It was interrupted for four years."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  'D',
  '[{"label": "A", "content": "Individualized service."}, {"label": "B", "content": "Traditional setting."}, {"label": "C", "content": "Home-made beer."}, {"label": "D", "content": "Social games."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  'C',
  '[{"label": "A", "content": "The quality of beer."}, {"label": "B", "content": "The atmosphere."}, {"label": "C", "content": "The owner’s attitude."}, {"label": "D", "content": "The right location."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  'A',
  '[{"label": "A", "content": "It is a rather tough job."}, {"label": "B", "content": "It is a profitable business."}, {"label": "C", "content": "It helps old people kill time."}, {"label": "D", "content": "It makes retirees feel useful."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  'D',
  '[{"label": "A", "content": "It is becoming increasingly popular."}, {"label": "B", "content": "It helps the user to escape reality."}, {"label": "C", "content": "It gives rise to serious social instability."}, {"label": "D", "content": "It hurts a person and those around them."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  'B',
  '[{"label": "A", "content": "They use drugs just for fun."}, {"label": "B", "content": "They take drugs to get high."}, {"label": "C", "content": "They use drugs as medicine."}, {"label": "D", "content": "They keep drug use a secret."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  'C',
  '[{"label": "A", "content": "It is quite common in entertainment circles."}, {"label": "B", "content": "It is the cause of various social problems."}, {"label": "C", "content": "It is hard to get rid of."}, {"label": "D", "content": "It is fatal to the user."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  'B',
  '[{"label": "A", "content": "Taking up exercises after recovery."}, {"label": "B", "content": "Producing tasty healthy frozen food."}, {"label": "C", "content": "Finding new ways to cure heart disease."}, {"label": "D", "content": "Going on a diet upon leaving the hospital."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  'A',
  '[{"label": "A", "content": "It was carefully tested with consumers."}, {"label": "B", "content": "It was promoted by health organizations."}, {"label": "C", "content": "It was disapproved by many diet experts."}, {"label": "D", "content": "It was highly expected by the general public."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  'B',
  '[{"label": "A", "content": "Competitive price."}, {"label": "B", "content": "Low expectations."}, {"label": "C", "content": "Vigorous promotion."}, {"label": "D", "content": "Unique ingredients."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  'C',
  '[{"label": "A", "content": "It was suggested by the firm’s vice-president."}, {"label": "B", "content": "It matches the food’s dark green packaging."}, {"label": "C", "content": "It has a positive implication for consumers."}, {"label": "D", "content": "It tricks the elders into impulse purchasing."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  'A',
  '[{"label": "A", "content": "It is practiced in most of the states."}, {"label": "B", "content": "It will be abolished sooner or later."}, {"label": "C", "content": "It has drawn a lot of criticism from overseas."}, {"label": "D", "content": "It has to be approved by the Supreme Court."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  'B',
  '[{"label": "A", "content": "Whether the practice should be allowed to continue in future."}, {"label": "B", "content": "Whether there should be a minimum age limit for execution."}, {"label": "C", "content": "What type of criminals should receive it."}, {"label": "D", "content": "What effect it might have on youngsters."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  'D',
  '[{"label": "A", "content": "The court sentenced him to life in prison for killing two friends."}, {"label": "B", "content": "The governor changed his death sentence to life in prison."}, {"label": "C", "content": "He was the first minor to be executed in South Carolina."}, {"label": "D", "content": "He was sentenced to death for a crime he committed as a minor."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. the words in the bank more than once.\n\nQuestions 36 to 45 are based on the following passage.\nFor many',
  'N',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. ttest year on record.\nEnjoy the snow now, because 39 are good that 2014 will be even hotter, perhaps th',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Reading Comprehension           (40 minutes)\nSection A\nDirections: In this section, th',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. c, covering 30% of the planet’s surface, that the 41 energy generated by its warming is enough to touch',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. of weather changes around the world. El Ninos are 42 with abnormally dry conditions in Southeast Asia a',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. North and South America, even as southern Africa 43 dry weather. Marine life may be affected too: El N',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. er. Marine life may be affected too: El Ninos can 44 the rising of the cold, nutrient-rich (营养丰富的) wate',
  'M',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. ords in the bank more than once.\n\nQuestions 36 to 45 are based on the following passage.\nFor many Ameri',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '46. Cooking benefits people in many ways and enables them to connect with one another.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. Abundant information about cooking is available either online or on TV.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. Young people do less cooking at home than the elderly these days.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. Cooking skills can be improved with practice.',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. In the mid-20th century, most families ate dinner at home instead of eating out.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '51. Even those short of time or money should be encouraged to cook for themselves and their family.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '52. Eating food not cooked by ourselves can cause serious consequences.',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. To eat well and still save money, people should buy fresh food and cook it themselves.',
  'M',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 42);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. We get a fairly large portion of calories from fast food and snacks.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 43);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. The popularity of TV led to the popularity of frozen food.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 44);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Cooking benefits people in many ways and enables them to connect with one another.',
  'D',
  NULL,
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 45);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Abundant information about cooking is available either online or on TV.',
  'B',
  NULL,
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 46);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Young people do less cooking at home than the elderly these days.',
  'F',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 47);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Cooking skills can be improved with practice.',
  'O',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 48);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'In the mid-20th century, most families ate dinner at home instead of eating out.',
  'G',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 49);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Even those short of time or money should be encouraged to cook for themselves and their family.',
  'E',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 50);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Eating food not cooked by ourselves can cause serious consequences.',
  'J',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 51);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'To eat well and still save money, people should buy fresh food and cook it themselves.',
  'M',
  NULL,
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 52);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'We get a fairly large portion of calories from fast food and snacks.',
  'C',
  NULL,
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 53);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'The popularity of TV led to the popularity of frozen food.  Section C Directions: There are 2 passages in this section. Each passage is followed by some questions or unfinished statements. For each of them there are four choices marked',
  'H',
  '[{"label": "A", "content": ","}, {"label": "B", "content": ","}, {"label": "C", "content": "and"}, {"label": "D", "content": ". You should decide on the best choice and mark the corresponding letter on Answer Sheet 2 with a single line through the centre."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 54);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is happening to the wallet?',
  'A',
  '[{"label": "A", "content": "It is disappearing."}, {"label": "B", "content": "It is being fattened."}, {"label": "C", "content": "It is becoming costly."}, {"label": "D", "content": "It is changing in style."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 55);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'How are business transactions done in big modem stores?',
  'B',
  '[{"label": "A", "content": "Individually."}, {"label": "B", "content": "Electronically."}, {"label": "C", "content": "In the abstract."}, {"label": "D", "content": "Via a cash register."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 56);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What makes the author feel uncomfortable nowadays?',
  'D',
  '[{"label": "A", "content": "Saving money is becoming a thing of the past."}, {"label": "B", "content": "The pleasing Friday-night feeling is fading."}, {"label": "C", "content": "Earning money is getting more difficult."}, {"label": "D", "content": "Spending money is so fast and easy."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 57);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Why does the author choose to write about what’s happening to the wallet?',
  'A',
  '[{"label": "A", "content": "It represents a change in the modem world."}, {"label": "B", "content": "It has something to do with everybody’s life."}, {"label": "C", "content": "It marks the end of a time-honoured tradition."}, {"label": "D", "content": "It is the concern of contemporary economists. What can we infer from the passage about the author? He is resistant to social changes. He is against technological progress. He feels reluctant to part with the traditional wallet. He feels insecure in the ever-changing modem world."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 58);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '云南省的丽江古镇是中国著名的旅游目的地之一。那里的生活节奏比大多数中国城市都要缓慢。丽江到处都是美丽的自然风光，众多的少数民族同胞提供了各式各样、丰富多彩的文化让游客体验。历史上，丽江还以“爱之城”而闻名。当地人中流传着许多关于因爱而生、为爱而死的故事。如今，在中外游客眼中，这个古镇被视为爱情和浪漫的天堂 (paradise) 。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 59);


-- ============================================================
-- [7] 2016年下半年大学英语六级真题（第1套）
-- 题目数: 47
-- 源文件: 四六级历年真题汇总/2016年12月英语四六级/2016年12月英语六级真题及答案/卷一 2016年12月英语六级真题及答案/卷一 2016年12月英语六级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2016, 2, '2016年下半年大学英语六级真题（第1套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
'In this section , you are going to read a passage with ten statements attached to it. Each statement contains information given in one of the paragraphs. Identify the paragraph from which the information is derived. You may choose a paragraph more than once. Each paragraph is marked -with a letter. Answer the questions by marking the corresponding letter on Answer Sheet 2. Are We in an Innovation Lull? [A] Scan the highlights of this year\'s Consumer Electronics Show (CES), and you may get a slight feeling of having seen them before. Many of the coolest gadgets this year are the same as the coolest gadgets last year — or the year before, even. The booths are still exciting, and the demos are still just as crazy. It is still easy to be dazzled by the display of drones (无 人机)，3D printers, virtual reality goggles (眼镜)and more "smart" devices than you could ever hope to catalog. Upon reflection, however, it is equally easy to feel like you have seen it all before. And it is hard not to think： Are we in an innovation lull (间歇期)？ [B] In some ways, the answer is yes. For years, smartphones, televisions, tablets, laptops and desk-tops have made up a huge part of the market and driven innovation. But now these segments are looking at slower growth curves — or shrinking markets in some cases — as consumers are not as eager to spend money on new gadgets. Meanwhile, emerging technologies — the drones, 3D printers and short-home devices of the world — now seem a bit too old to be called "the next big thing.w [C] Basically the tech industry seems to be in an awkward period now. "There is not any one-hit wonder, and there will not be one- for years to come," said Gary Shapiro, president and chief executive of the Consumer Technology Associaton (CTA). In his eyes, however, that doesn\'t necessarily mean that innovation has stopped. It has just grown up a little. "Many industries are going out of infancy and becoming adolescents,M Shapiro said. [D] For instance, new techno',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  'B',
  '[{"label": "A", "content": "It focuses on the efforts countries can make to deal with global warming."}, {"label": "B", "content": "It links the science of climate change to economic and policy issues."}, {"label": "C", "content": "It studies the impacts of global climate change on people\'s lives."}, {"label": "D", "content": "It tries to predict the possible trends of global climate change."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  'A',
  '[{"label": "A", "content": "It would be more costly to deal with its consequences than to avoid it,"}, {"label": "B", "content": "It will take a long time before a consensus is reached on its impact."}, {"label": "C", "content": "It is the most pressing issue confronting all countries."}, {"label": "D", "content": "It is bound to cause endless disputes among nations."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  'D',
  '[{"label": "A", "content": "The raising of people\'s awareness."}, {"label": "B", "content": "The signing of a global agreement."}, {"label": "C", "content": "The cooperation among world major powers."}, {"label": "D", "content": "The transition to low-carbon energy systems."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  'A',
  '[{"label": "A", "content": "Plan well in advance."}, {"label": "B", "content": "Adopt new technology."}, {"label": "C", "content": "Carry out more research on it."}, {"label": "D", "content": "Cut down energy consumption."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q5',
  'C',
  '[{"label": "A", "content": "When luck plays a role."}, {"label": "B", "content": "Whether practice makes perfect."}, {"label": "C", "content": "What determines success."}, {"label": "D", "content": "How important natural talent is."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  'B',
  '[{"label": "A", "content": "It knocks at your door only once in a while."}, {"label": "B", "content": "It means being good at seizing opportunities."}, {"label": "C", "content": "It is something that no one can possibly create."}, {"label": "D", "content": "It comes naturally out of one\'s self-confidence."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  'A',
  '[{"label": "A", "content": "Practice is essential to becoming good at something."}, {"label": "B", "content": "One should always be ready to seize opportunities."}, {"label": "C", "content": "One must have natural talent to be successful."}, {"label": "D", "content": "Luck rarely contributes to a person\'s success."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  'B',
  '[{"label": "A", "content": "People who love what they do care little about money."}, {"label": "B", "content": "Being passionate about work can make one wealthy."}, {"label": "C", "content": "Putting time and effort into fun things is profitable."}, {"label": "D", "content": "People in need of money work hard automatically."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  'D',
  '[{"label": "A", "content": "A tall chimney."}, {"label": "B", "content": "A huge piece of rock."}, {"label": "C", "content": "The peak of a mountain."}, {"label": "D", "content": "The stump of a giant tree."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  'C',
  '[{"label": "A", "content": "Human activity."}, {"label": "B", "content": "Chemical processes."}, {"label": "C", "content": "Wind and water."}, {"label": "D", "content": "Fire and fury."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  'C',
  '[{"label": "A", "content": "It was built in ancient times."}, {"label": "B", "content": "It is a historical monument."}, {"label": "C", "content": "It was created by supernatural powers."}, {"label": "D", "content": "It is Indians\' sacred place for worship."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  'C',
  '[{"label": "A", "content": "By killing the attacking bears."}, {"label": "B", "content": "By sheltering them in a cave."}, {"label": "C", "content": "By lifting them well above the ground."}, {"label": "D", "content": "By taking them to the top of a mountain."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  'D',
  '[{"label": "A", "content": "They will pick up some souvenirs or gift items."}, {"label": "B", "content": "They will have their vehicles washed or serviced."}, {"label": "C", "content": "They will take advantage of the time to rest a while."}, {"label": "D", "content": "They will buy something from the convenience stores."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  'D',
  '[{"label": "A", "content": "They may eventually drive one to bankruptcy."}, {"label": "B", "content": "They should be done away with altogether."}, {"label": "C", "content": "They are meant for the extremely wealthy."}, {"label": "D", "content": "They can bring only temporary pleasures."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  'A',
  '[{"label": "A", "content": "Small daily savings can make a big difference in one\'s life."}, {"label": "B", "content": "A vacation will be affordable if one saves 20 dollars a week."}, {"label": "C", "content": "Retirement savings should come first in one\'s family budgeting."}, {"label": "D", "content": "A good way to socialize is to have daily lunch with one\'s colleagues."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  'C',
  '[{"label": "A", "content": "They are harmful to health."}, {"label": "B", "content": "They enrich our experience."}, {"label": "C", "content": "They are necessary in our lives."}, {"label": "D", "content": "They should be done away with."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  'B',
  '[{"label": "A", "content": "They are exhausted even without doing any heavy work."}, {"label": "B", "content": "They feel too overwhelmed to deal with life\'s problems."}, {"label": "C", "content": "They are anxious to free themselves from life\'s troubles."}, {"label": "D", "content": "They feel stressed out even without any challenges in life."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  'D',
  '[{"label": "A", "content": "They lessen our burdens."}, {"label": "B", "content": "They narrow our focus. They prolong our lives. They expand our mind."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  'C',
  '[{"label": "A", "content": "It is not easily breakable."}, {"label": "B", "content": "It represents the latest style. It came from a 3D printer. It was made by a fashion designer."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  'B',
  '[{"label": "A", "content": "When she attended a fashion show nine months ago."}, {"label": "B", "content": "When she was studying at a fashion design school."}, {"label": "C", "content": "When she had just graduated from her college."}, {"label": "D", "content": "When she attended a conference in New York."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  'A',
  '[{"label": "A", "content": "It was hard and breakable."}, {"label": "B", "content": "It was extremely expensive."}, {"label": "C", "content": "It was difficult to print."}, {"label": "D", "content": "It was hard to come by."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  'C',
  '[{"label": "A", "content": "It is the latest model of a 3D printer."}, {"label": "B", "content": "It is a plastic widely used in 3D printing."}, {"label": "C", "content": "It marks a breakthrough in printing material."}, {"label": "D", "content": "It gives fashion designers room for imagination."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  'D',
  '[{"label": "A", "content": "They can\'t be solved without government support."}, {"label": "B", "content": "They are easy to solve with modern technology."}, {"label": "C", "content": "They have not been examined in detail so far."}, {"label": "D", "content": "They arise from the advances in technology."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  'A',
  '[{"label": "A", "content": "It is intensely competitive."}, {"label": "B", "content": "It focuses on new products."}, {"label": "C", "content": "It demands huge investment."}, {"label": "D", "content": "It is attractive to entrepreneurs."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  'B',
  '[{"label": "A", "content": "Cooperation with big companies."}, {"label": "B", "content": "Sharing of costs with each other."}, {"label": "C", "content": "Recruiting more qualified staff."}, {"label": "D", "content": "In-service training of IT personnel."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Consumers are often hesitant to try smart-home devices because they are worried about compatibility problems.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. This year\'s electronics show featured the presence of many officials from the federal government.',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. The market demand for electronic devices is now either declining or not growing as fast as before.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. One analyst suggests it is necessary to accept both the positive and negative aspects of innovative products.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. The Consumer Electronics Show in recent years has begun to focus more on the practical value than the showiness of electronic devices.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Fewer innovative products were found at this year\'s electronic products show.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Consumers are becoming more worried about giving personal information to tech companies to get customized products and services.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. The Consumer Technology Association is the sponsor of the annual Consumer Electronics Show.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Many consumers wonder about the necessity of having their fitness monitored.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. The electronic industry is maturing even though no wonder products hit the market.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Consumers are often hesitant to try smart-home devices because they are worried about compatibility problems.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. This year\'s electronics show featured the presence of many officials from the federal government.',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. The market demand for electronic devices is now either declining or not growing as fast as before.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. One analyst suggests it is necessary to accept both the positive and negative aspects of innovative products.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. The Consumer Electronics Show in recent years has begun to focus more on the practical value than the showiness of electronic devices.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Fewer innovative products were found at this year\'s electronic products show.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 42);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Consumers are becoming more worried about giving personal information to tech companies to get customized products and services.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 43);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. The Consumer Technology Association is the sponsor of the annual Consumer Electronics Show.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 44);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Many consumers wonder about the necessity of having their fitness monitored.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 45);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. The electronic industry is maturing even though no wonder products hit the market.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 46);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '随着生活水平的提高，度假在中国人生活中的作用越来越重要。过去，中国人的时间主要花在谋生上，很少有机会外出旅行。然而，近年来中国旅游业发展迅速。经济的繁荣和富裕中产阶级的岀现，引发了一个前所未有的旅游热潮。中国人不仅在国内旅游，岀国旅游也越来越普遍。2016年国庆节假日期间，旅游消费总计超过4000亿元。据世界贸易组织估计，2020年中国将成为世界上最大的旅游国，在未来几年里将成为处境旅游支出增长最快的国家。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 47);


-- ============================================================
-- [8] 2016年下半年大学英语六级真题（第3套）
-- 题目数: 38
-- 源文件: 四六级历年真题汇总/2016年12月英语四六级/2016年12月英语六级真题及答案/卷三 2016年12月英语六级真题及答案/卷三 2016年12月大学英语六级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2016, 2, '2016年下半年大学英语六级真题（第3套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write a short essay on invention. Your essay should include the importance of invention and measures to be taken to encourage invention. You are required to write at least 150 words but no more than 200 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Workplace norms pressure employees to overwork, deterring them from taking paid time off.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. The overwhelming majority of employees attribute their stress mainly to low pay and an excessive workload.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. According to Moen, flexibility gives employees better control over their work and time.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Flexibility resulting from the use of digital devices benefits employers instead of employees.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Research finds that if employees suffer from high stress, they will be less motivated, less productive and more likely to quit.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. In-of£ice wellness programs may help reduce stress levels, but they are hardly an ultimate solution to the problem.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Health problems caused by stress in the workplace result in huge public health expenses.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. If employees respond quickly to their job assignments, the employer is likely to demand more from them.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. With technology everywhere in our life, it has become virtually impossible for most workers to keep a balance between work and life.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. In America today, even teenagers suffer from stress, and their problem is even more serious than grown-ups\'.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Workplace norms pressure employees to overwork, deterring them from taking paid time off.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. The overwhelming majority of employees attribute their stress mainly to low pay and an excessive workload.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. According to Moen, flexibility gives employees better control over their work and time.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Flexibility resulting from the use of digital devices benefits employers instead of employees.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Research finds that if employees suffer from high stress, they will be less motivated, less productive and more likely to quit.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. In-of£ice wellness programs may help reduce stress levels, but they are hardly an ultimate solution to the problem.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Health problems caused by stress in the workplace result in huge public health expenses.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. If employees respond quickly to their job assignments, the employer is likely to demand more from them.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. With technology everywhere in our life, it has become virtually impossible for most workers to keep a balance between work and life.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. In America today, even teenagers suffer from stress, and their problem is even more serious than grown-ups\'.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. What is most likely to happen when advanced batteries become widely used?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. In some rural communities of emerging economies, people have begun to  .',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. Utility companies have begun to realize that battery technologies  .',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. What does the author imply about the centralized electric grid?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '52. The study by Svante Paabo served as an example to show .',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. The example of the disease cystic fibrosis underdiagnosed in people of African ancestry demonstrates that   .',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. What is Yudell\'s suggestion to scientists?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. What can be inferred from Yudell\'s remark in the last paragraph?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is most likely to happen when advanced batteries become widely used?',
  'D',
  '[{"label": "A", "content": "Mobile-first lifestyles will become popular."}, {"label": "B", "content": "The globalization process will be accelerated."}, {"label": "C", "content": "Communications will take more diverse forms."}, {"label": "D", "content": "The world will undergo revolutionary changes."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'In some rural communities of emerging economies, people have begun to  .',
  'C',
  '[{"label": "A", "content": "find digital devices simply indispensable."}, {"label": "B", "content": "communicate primarily by mobile phone."}, {"label": "C", "content": "light their homes with stored solar energy."}, {"label": "D", "content": "distribute power with wires and wooden poles."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Utility companies have begun to realize that battery technologies  .',
  'A',
  '[{"label": "A", "content": "benefit their business."}, {"label": "B", "content": "transmit power faster."}, {"label": "C", "content": "promote innovation."}, {"label": "D", "content": "encourage competition."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author imply about the centralized electric grid?',
  'A',
  '[{"label": "A", "content": "It might become a thing of the past."}, {"label": "B", "content": "It might turn out to be a \\"prosumer\\"."}, {"label": "C", "content": "It will be easier to operate and maintain."}, {"label": "D", "content": "It will have to be completely transformed."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'The study by Svante Paabo served as an example to show .',
  'B',
  '[{"label": "A", "content": "modern genetics research is likely to fuel racial conflicts."}, {"label": "B", "content": "race is a poorly defined marker of human genetic diversity."}, {"label": "C", "content": "race as a biological term can explain human genetic diversity."}, {"label": "D", "content": "genetics research should consider social and cultural variables."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'The example of the disease cystic fibrosis underdiagnosed in people of African ancestry demonstrates that   .',
  'C',
  '[{"label": "A", "content": "it is absolutely necessary to put race aside in making diagnosis."}, {"label": "B", "content": "it is important to include social variables in genetics research."}, {"label": "C", "content": "racial categories for genetic diversity could lead to wrong clinical predictions."}, {"label": "D", "content": "discrimination against black people may cause negligence in clinical treatment."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is Yudell\'s suggestion to scientists?',
  'A',
  '[{"label": "A", "content": "They be more precise with the language they use."}, {"label": "B", "content": "They refrain from using politically sensitive terms."}, {"label": "C", "content": "They throw out irrelevant concepts in their research."}, {"label": "D", "content": "They examine all possible variables in their research."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What can be inferred from Yudell\'s remark in the last paragraph?',
  'D',
  '[{"label": "A", "content": "Clinging to racism prolongs inequity and discrimination."}, {"label": "B", "content": "Physiological disparities are quite striking among races."}, {"label": "C", "content": "Doing away with racial discrimination is challenging."}, {"label": "D", "content": "Racial terms are still useful in certain fields of study."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '农业是中国的一个重要产业，从业者超过3亿。中国农业产量全球第一，主要生产水稻、小麦和豆类。虽然中国的农业用地仅占世界的百分之十，但为世界百分之二十的人提供了粮食。中国7700年开始种植水稻。早在使用机械和化肥之前，勤劳和富有创造性的中国农民就已经采用各种各样的方法来增加农作物产量。中国农业最新的发展是推进有机农业。有机农业可以同时服务于多种目的，包括食品安全，大众健康和可持续发展。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 38);


-- ============================================================
-- [9] 2016年下半年大学英语六级真题（第2套）
-- 题目数: 57
-- 源文件: 四六级历年真题汇总/2016年12月英语四六级/2016年12月英语六级真题及答案/卷二 2016年12月英语六级真题及答案/卷二 2016年12月英语六级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2016, 2, '2016年下半年大学英语六级真题（第2套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Directions: For this part, you are allowed 30 minutes to write a short essay on creation. Your essay should include the importance of creation and measures to be taken to encourage creation. You are required to write at least 150 words but no more than 200 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  'C',
  '[{"label": "A", "content": "They were proud of their cuisine."}, {"label": "B", "content": "They were particular about food."}, {"label": "C", "content": "They were all good at cooking."}, {"label": "D", "content": "They were fond of bacon and eggs."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  'C',
  '[{"label": "A", "content": "His parents."}, {"label": "B", "content": "His parents\' friends."}, {"label": "C", "content": "His friends."}, {"label": "D", "content": "His schoolmates."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  'A',
  '[{"label": "A", "content": "No one of the group ate it."}, {"label": "B", "content": "It was a little overcooked."}, {"label": "C", "content": "No tea was served with the meal."}, {"label": "D", "content": "It was the real English breakfast."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  'B',
  '[{"label": "A", "content": "It was full of excitement."}, {"label": "B", "content": "It was rather disappointing."}, {"label": "C", "content": "It was a risky experience."}, {"label": "D", "content": "It was really extraordinary."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q5',
  'C',
  '[{"label": "A", "content": "The woman\'s earnings over the years."}, {"label": "B", "content": "The key to running a shop at a low cost."}, {"label": "C", "content": "The business success of the woman\'s shop."}, {"label": "D", "content": "The woman\'s relationship with other shops."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  'A',
  '[{"label": "A", "content": "Keep down its expenses."}, {"label": "B", "content": "Improve its customer service."}, {"label": "C", "content": "Expand its business scale."}, {"label": "D", "content": "Upgrade the goods it sells."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  'D',
  '[{"label": "A", "content": "They are in great demand."}, {"label": "B", "content": "They are delivered free of charge."}, {"label": "C", "content": "They are very popular with the local residents."}, {"label": "D", "content": "They are sold at lower prices than in other shops."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  'A',
  '[{"label": "A", "content": "To maintain friendly relationships with other shops."}, {"label": "B", "content": "To avoid being put out of business in competition."}, {"label": "C", "content": "To attract more customers in the neighborhood."}, {"label": "D", "content": "To follow the custom of the local shopkeepers."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  'C',
  '[{"label": "A", "content": "They are on the verge of extinction because of pollution."}, {"label": "B", "content": "They carry plant seeds and spread them to faraway places."}, {"label": "C", "content": "They deliver pollutants from the ocean to their nesting sites."}, {"label": "D", "content": "They can be used to deliver messages in times of emergency."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  'D',
  '[{"label": "A", "content": "They originate from Devon Island in the Arctic area."}, {"label": "B", "content": "They migrate to the Arctic Circle during the summer."}, {"label": "C", "content": "They have the ability to survive in extreme weathers."}, {"label": "D", "content": "They travel as far as 400 kilometers in search of food."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  'B',
  '[{"label": "A", "content": "They had become more poisonous."}, {"label": "B", "content": "They were carried by the wind."}, {"label": "C", "content": "They poisoned some of the fulmars."}, {"label": "D", "content": "They were less than on the continent."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  'B',
  '[{"label": "A", "content": "The effects of the changing climate on Arctic seabirds."}, {"label": "B", "content": "The harm Arctic seabirds may cause to humans."}, {"label": "C", "content": "The diminishing colonies for Arctic seabirds."}, {"label": "D", "content": "The threats humans pose to Arctic seabirds,"}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  'D',
  '[{"label": "A", "content": "It has remained basically the same."}, {"label": "B", "content": "It has become better understood."}, {"label": "C", "content": "It has been exaggerated."}, {"label": "D", "content": "It has decreased."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  'A',
  '[{"label": "A", "content": "It is now the second leading cause of death for centenarians."}, {"label": "B", "content": "It develops more easily in centenarians who are not active."}, {"label": "C", "content": "It calls for more intensive research."}, {"label": "D", "content": "It has had no effective cure so far."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  'B',
  '[{"label": "A", "content": "They cherish their life more than ever."}, {"label": "B", "content": "Their minds fall before their bodies do."}, {"label": "C", "content": "Their quality of life deteriorates rapidly."}, {"label": "D", "content": "They care more about their physical health."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  'D',
  '[{"label": "A", "content": "They form the basis on which he builds his theory of love."}, {"label": "B", "content": "They were carried out over a period of some thirty years."}, {"label": "C", "content": "They were done by his former colleague at Yale."}, {"label": "D", "content": "They are focused more on attraction than love."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  'B',
  '[{"label": "A", "content": "The relationship cannot last long if no passion is involved."}, {"label": "B", "content": "It is not love if you don\'t wish to maintain the relationship."}, {"label": "C", "content": "Romance is just impossible without mutual understanding."}, {"label": "D", "content": "Intimacy is essential but not absolutely indispensable to love."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  'C',
  '[{"label": "A", "content": "Whether it is true love without commitment."}, {"label": "B", "content": "Which of them is considered most important."}, {"label": "C", "content": "How the relationship is to be defined if any one is missing."}, {"label": "D", "content": "When the absence of any one doesn\'t affect the relationship."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  'B',
  '[{"label": "A", "content": "The history of social work."}, {"label": "B", "content": "Social work as a profession."}, {"label": "C", "content": "Academic degrees required of social work applicants."}, {"label": "D", "content": "The aim of the National Association of Social Workers."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  'D',
  '[{"label": "A", "content": "They try to change people\'s social behavior."}, {"label": "B", "content": "They raise people\'s awareness of environment."}, {"label": "C", "content": "They create a lot of opportunities for the unemployed."}, {"label": "D", "content": "They help enhance the well-being of the underprivileged."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  'C',
  '[{"label": "A", "content": "They have all made a difference through their work."}, {"label": "B", "content": "They are all members of the National Association."}, {"label": "C", "content": "They all have an academic degree in social work."}, {"label": "D", "content": "They have all received strict clinical training."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  'A',
  '[{"label": "A", "content": "Social workers\' job options and responsibilities."}, {"label": "B", "content": "Ways for social workers to meet people\'s needs."}, {"label": "C", "content": "The importance of training for social workers."}, {"label": "D", "content": "The promotion of social workers\' social status."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  'A',
  '[{"label": "A", "content": "To fight childhood obesity."}, {"label": "B", "content": "To help disadvantaged kids."}, {"label": "C", "content": "To urge kids to follow their role models."}, {"label": "D", "content": "To encourage kids to play more sports."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  'D',
  '[{"label": "A", "content": "They are most effective when appearing on TV."}, {"label": "B", "content": "They best boost product sales when put online."}, {"label": "C", "content": "They are becoming more and more prevalent."}, {"label": "D", "content": "They impress kids more than they do adults."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  'D',
  '[{"label": "A", "content": "Do what they advocate in public."}, {"label": "B", "content": "Always place kids\' interest first."}, {"label": "C", "content": "Pay attention to their image before children."}, {"label": "D", "content": "Message positive behaviors at all times."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. According to Chinese officials, their activities in Antarctica lay greater emphasis on scientific research.',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Efforts to create one of the world\'s largest ocean sanctuaries failed because of Russia\'s obstruction.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. With several monitoring stations operating in Antarctica, Russia is trying hard to counter America\'s dominance in the field of worldwide navigational facilities.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. According to geologists\' estimates, Antarctica has enormous reserves of oil and natural gas.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. It is estimated that Antarctica boasts of the richest reserves of fresh water on earth.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. The demand for energy resources may compel renegotiation of Antarctica\'s treaties before their expiration.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Many countries are racing against each other to increase their business and strategic influence on Antarctica.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Antarctica\'s harsh natural conditions constitute huge obstacles to the exploitation of its resources.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. With competition from many countries, Antarctica is no longer dominated by the traditional white nations.',
  'Q',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. American scientists complain about lack of sufficient money and equipment for their expansion in Antarctica.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. According to Chinese officials, their activities in Antarctica lay greater emphasis on scientific research.',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Efforts to create one of the world\'s largest ocean sanctuaries failed because of Russia\'s obstruction.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. With several monitoring stations operating in Antarctica, Russia is trying hard to counter America\'s dominance in the field of worldwide navigational facilities.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. According to geologists\' estimates, Antarctica has enormous reserves of oil and natural gas.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. It is estimated that Antarctica boasts of the richest reserves of fresh water on earth.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. The demand for energy resources may compel renegotiation of Antarctica\'s treaties before their expiration.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 42);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Many countries are racing against each other to increase their business and strategic influence on Antarctica.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 43);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Antarctica\'s harsh natural conditions constitute huge obstacles to the exploitation of its resources.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 44);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. With competition from many countries, Antarctica is no longer dominated by the traditional white nations.',
  'Q',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 45);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. American scientists complain about lack of sufficient money and equipment for their expansion in Antarctica.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 46);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. Why has it taken so long for the UK government to consider plain packaging?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 47);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. What did Cameron say about chocolate oranges at supermarket checkouts?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 48);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. What does the author say is important for university students besides classroom instruction?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 49);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. What is said to be an advantage of going to university?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 50);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. What can we infer from the last paragraph?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 51);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Why has it taken so long for the UK government to consider plain packaging?',
  'A',
  '[{"label": "A", "content": "Prime Minister Cameron has been reluctant to take action."}, {"label": "B", "content": "There is strong opposition from veteran nicotine addicts."}, {"label": "C", "content": "Many Members of Parliament are addicted to smoking."}, {"label": "D", "content": "Pressure from tobacco manufacturers remains strong."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 52);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What did Cameron say about chocolate oranges at supermarket checkouts?',
  'C',
  '[{"label": "A", "content": "They fueled a lot of controversy."}, {"label": "B", "content": "They attracted a lot of smokers."}, {"label": "C", "content": "They made more British people obese."}, {"label": "D", "content": "They had certain ingredients missing."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 53);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author say is important for university students besides classroom instruction?',
  'C',
  '[{"label": "A", "content": "Making sure to obtain an upper-second class degree."}, {"label": "B", "content": "Practical skills they will need in their future careers."}, {"label": "C", "content": "Interactions among themselves outside the classroom."}, {"label": "D", "content": "Developing independent and creative thinking abilities."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 54);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is said to be an advantage of going to university?',
  'B',
  '[{"label": "A", "content": "Learning how to take risks in an ever-changing world."}, {"label": "B", "content": "Meeting people who will be helpful to you in the future."}, {"label": "C", "content": "Having opportunities of playing a leading role in society."}, {"label": "D", "content": "Gaining up-to-date knowledge in science and technology."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 55);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What can we infer from the last paragraph?',
  'D',
  '[{"label": "A", "content": "It is natural for students to make complaints about university education."}, {"label": "B", "content": "Few students are willing to bear the burden of debt incurred at university."}, {"label": "C", "content": "University education is becoming attractive to students who can afford it."}, {"label": "D", "content": "The prestige of the university influences employers\' recruitment decisions."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 56);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '随着中国经济的蓬勃发展，学汉语的人数迅速增加，使汉语成了世界上人们最爱学的语言之一。近年来，中国大学在国际上的排名也有了明显的提高。由于中国教育的巨大进步，中国成为最受海外学生欢迎的留学目的地之一就不足为奇了。2015年，近四十万国际学生蜂拥来到中国学习。他们学习的科目不再限于中国语言和文化，而包括科学与工程。在全球教育市场上，美国和英国仍占主导地位，但中国正在迅速赶上。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 57);


-- ============================================================
-- [10] 2016年下半年大学英语四级真题（第3套）
-- 题目数: 42
-- 源文件: 四六级历年真题汇总/2016年12月英语四六级/2016年12月英语四级真题及答案/卷三 2016年12月英语四级真题及答案/卷三 2016年12月英语四级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (4, 2016, 2, '2016年下半年大学英语四级真题（第3套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write an essay. Suppose you have two options upon graduation : one is to find a job somewhere and the other to start a business of your own. You are to make a choice between the two. Write an essay to explain the reasons for your choice. You should write at least 120 words but no more than 180 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Some famous companies are already using gamification and more are trying to do the same.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Gamification is not a miracle cure for all workplaces as it may have negative results.',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. To enhance morale, one company asks its employees to identify their fellow workers when starting their computers.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. The idea of gamifacation was practiced by some businesses more than a century ago.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. There is reason to believe that gamification will be here to stay.',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Video games contributed in some ways to the wide application of gamification.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. When turning work into a game, it is necessary to understand what makes games interesting.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Gamification in employee training does not always need technology.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. The most successful gamification platforms transform daily work assignments into fun experiences.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. It is necessary to use terms other than “gamification” for some professions.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Some famous companies are already using gamification and more are trying to do the same.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Gamification is not a miracle cure for all workplaces as it may have negative results.',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. To enhance morale, one company asks its employees to identify their fellow workers when starting their computers.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. The idea of gamifacation was practiced by some businesses more than a century ago.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. There is reason to believe that gamification will be here to stay.',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Video games contributed in some ways to the wide application of gamification.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. When turning work into a game, it is necessary to understand what makes games interesting.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Gamification in employee training does not always need technology.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. The most successful gamification platforms transform daily work assignments into fun experiences.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. It is necessary to use terms other than “gamification” for some professions.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '46. What does the author say about present-day universities?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. According to the author, what kind of people do university lack most?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. What does the author imply about the classes at present?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. What does the author think of teaching ability?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. What is the author’s suggestion for improving university teaching?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '51. What do we learn about McDonald’s inclusion of toys in its happy meals?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '52. What is the finding of the researchers led by Martin Reimann?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. What is most interesting in Martin Reimann’s finding?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. How does Martin Reimann interpret his finding?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. What can we infer from Martin Reimann’s finding?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author say about present-day universities?',
  'C',
  '[{"label": "A", "content": "They are effectively tackling real or imagined problems."}, {"label": "B", "content": "They often fail to combine teaching with research."}, {"label": "C", "content": "They are over-burdened with administrative staff."}, {"label": "D", "content": "They lack talent to fix their deepening problems."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'According to the author, what kind of people do university lack most?',
  'A',
  '[{"label": "A", "content": "Good classroom teachers."}, {"label": "B", "content": "Efficient administrators."}, {"label": "C", "content": "Talented researchers."}, {"label": "D", "content": "Motivated students."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author imply about the classes at present?',
  'D',
  '[{"label": "A", "content": "They facilitate students’ independent learning."}, {"label": "B", "content": "They help students form closer relationships."}, {"label": "C", "content": "They have more older students than before."}, {"label": "D", "content": "They are much bigger than is desirable."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author think of teaching ability?',
  'A',
  '[{"label": "A", "content": "It requires talent and practice."}, {"label": "B", "content": "It is closely related to research."}, {"label": "C", "content": "It is a chief factor affecting students’ learning."}, {"label": "D", "content": "It can be acquired through persistent practice."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is the author’s suggestion for improving university teaching?',
  'B',
  '[{"label": "A", "content": "Creating an environment for teachers to share their teaching experiences."}, {"label": "B", "content": "Hiring more classroom teachers and allowing them to teach in their own way."}, {"label": "C", "content": "Using high technology in classroom and promoting exchange of information."}, {"label": "D", "content": "Cutting down meetings and encouraging administrative staff to go to classrooms."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn about McDonald’s inclusion of toys in its happy meals?',
  'D',
  '[{"label": "A", "content": "It may shed light on people’s desire to crack a secret."}, {"label": "B", "content": "It has proved to be key to McDonald’s business success."}, {"label": "C", "content": "It appeals to kid’s curiosity to find out what is hidden inside."}, {"label": "D", "content": "It may be a pleasant way for kids to reduce their food intake."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is the finding of the researchers led by Martin Reimann?',
  'D',
  '[{"label": "A", "content": "Reducing food intake is not that difficult if people go to McDonald’s more."}, {"label": "B", "content": "More kids and adults don’t actually feel hungry when they eat half of their meal."}, {"label": "C", "content": "Eating a smaller portion of food does good to the health of kids and adults alike."}, {"label": "D", "content": "Most kids and adults would choose a smaller meal that came with a non-food item."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is most interesting in Martin Reimann’s finding?',
  'B',
  '[{"label": "A", "content": "Kids preferred an award in the form of money to one in the form of a toy."}, {"label": "B", "content": "Adults choose the smaller portion on the more promise of a future award."}, {"label": "C", "content": "Both kids and adults felt satisfied with only half of their meal portions."}, {"label": "D", "content": "Neither children nor adults could resist the temptation of a free toy."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'How does Martin Reimann interpret his finding?',
  'A',
  '[{"label": "A", "content": "The emotional component of the prize is at work."}, {"label": "B", "content": "People now care more about quality than quantity."}, {"label": "C", "content": "People prefer certainty awards to possible award."}, {"label": "D", "content": "The desire for a future rewards is overwhelming."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What can we infer from Martin Reimann’s finding?',
  'C',
  '[{"label": "A", "content": "People should eat much less if they wish to stay healthy and happy."}, {"label": "B", "content": "More fast food restaurants are likely to follow McDonald’s example."}, {"label": "C", "content": "We can lead people to eat less while helping the restaurant business."}, {"label": "D", "content": "More studies are needed to find out the impact of emotion on behavior."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '随着中国的改革开放，如今很多年轻人都喜欢举行西式婚礼。新娘在婚礼上穿着白色婚纱，因为白色被认为是纯洁的象征。然而，在中国传统文化中，白色经常是葬礼上使用的颜色。因此，务必记住，白花一定不要用作祝人康复的礼物，尤其不要送给老年人或危重病人。同样，礼金也不能装在白色的信封里，而要装在红色的信封里。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 42);


-- ============================================================
-- [11] 2016年上半年大学英语六级真题（第1套）
-- 题目数: 57
-- 源文件: 四六级历年真题汇总/2016年6月英语四六级/2016年6月英语六级真题及答案/卷一 2016年6月英语六级真题及答案/2016年6月英语六级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2016, 1, '2016年上半年大学英语六级真题（第1套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write a short essay on living in the virtual world. Try to imagine what will happen when people spend more and more time in the virtual world instead of interacting in the real world. You are required to write at least 150 words but no more than 200 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  'D',
  '[{"label": "A", "content": "Project organizer."}, {"label": "B", "content": "Public relations officer."}, {"label": "C", "content": "Marketing manager."}, {"label": "D", "content": "Market research consultant."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  'A',
  '[{"label": "A", "content": "Quantitative advertising research."}, {"label": "B", "content": "Questionnaire design."}, {"label": "C", "content": "Research methodology."}, {"label": "D", "content": "Interviewer training."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  'D',
  '[{"label": "A", "content": "They are intensive studies of people\'s spending habits."}, {"label": "B", "content": "They examine relations between producers and customers."}, {"label": "C", "content": "They look for new and effective ways to promote products."}, {"label": "D", "content": "They study trends or customer satisfaction over a long period."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  'B',
  '[{"label": "A", "content": "The lack of promotion opportunity."}, {"label": "B", "content": "Checking charts and tables."}, {"label": "C", "content": "Designing questionnaires."}, {"label": "D", "content": "The persistent intensity."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q5',
  'A',
  '[{"label": "A", "content": "His view on Canadian universities."}, {"label": "B", "content": "His understanding of higher education."}, {"label": "C", "content": "His suggestions for improvements in higher education."}, {"label": "D", "content": "His complaint about bureaucracy in American universities."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  'B',
  '[{"label": "A", "content": "It is well designed."}, {"label": "B", "content": "It is rather inflexible."}, {"label": "C", "content": "It varies among universities."}, {"label": "D", "content": "It has undergone great changes."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  'C',
  '[{"label": "A", "content": "The United States and Canada can learn from each other."}, {"label": "B", "content": "Public universities are often superior to private universities."}, {"label": "C", "content": "Everyone should be given equal access to higher education."}, {"label": "D", "content": "Private schools work more efficiently than public institutions."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  'C',
  '[{"label": "A", "content": "University systems vary from country to country."}, {"label": "B", "content": "Efficiency is essential to university management."}, {"label": "C", "content": "It is hard to say which is better, a public university or a private one."}, {"label": "D", "content": "Many private universities in the U.S. are actually large bureaucracies."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  'B',
  '[{"label": "A", "content": "Government\'s role in resolving an economic crisis."}, {"label": "B", "content": "The worsening real wage situation around the world."}, {"label": "C", "content": "Indications of economic recovery in the United States."}, {"label": "D", "content": "The impact of the current economic crisis on people\'s life."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  'A',
  '[{"label": "A", "content": "They will feel less pressure to raise employees5 wages."}, {"label": "B", "content": "They will feel free to choose the most suitable employees."}, {"label": "C", "content": "They will feel inclined to expand their business operations."}, {"label": "D", "content": "They will feel more confident in competing with their rivals."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  'C',
  '[{"label": "A", "content": "Employees and companies cooperate to pull through the economic crisis."}, {"label": "B", "content": "Government and companies join hands to create jobs for the unemployed."}, {"label": "C", "content": "Employees work shorter hours to avoid layoffs."}, {"label": "D", "content": "Team work will be encouraged in companies."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  'A',
  '[{"label": "A", "content": "Whether memory supplements work."}, {"label": "B", "content": "Whether herbal medicine works wonders."}, {"label": "C", "content": "Whether exercise enhances one\'s memory."}, {"label": "D", "content": "Whether a magic memory promises success."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  'D',
  '[{"label": "A", "content": "They help the elderly more than the young."}, {"label": "B", "content": "They are beneficial in one way or another."}, {"label": "C", "content": "They generally do not have side effects."}, {"label": "D", "content": "They are not based on real science."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  'D',
  '[{"label": "A", "content": "They are available at most country fairs."}, {"label": "B", "content": "They are taken in relatively high dosage."}, {"label": "C", "content": "They are collected or grown by farmers."}, {"label": "D", "content": "They are prescribed by trained practitioners."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  'B',
  '[{"label": "A", "content": "They have often proved to be as helpful as doing mental exercise."}, {"label": "B", "content": "Taking them with other medications might entail unnecessary risks."}, {"label": "C", "content": "Their effect lasts only a short time."}, {"label": "D", "content": "Many have benefited from them."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  'D',
  '[{"label": "A", "content": "How catastrophic natural disasters turn out to be to developing nations."}, {"label": "B", "content": "How the World Meteorological Organization studies natural disasters."}, {"label": "C", "content": "How powerless humans appear to be in face of natural disasters."}, {"label": "D", "content": "How the negative impacts of natural disasters can be reduced."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  'B',
  '[{"label": "A", "content": "By training rescue teams for emergencies."}, {"label": "B", "content": "By taking steps to prepare people fbr them."}, {"label": "C", "content": "By changing people\'s views of nature."}, {"label": "D", "content": "By relocating people to safer places."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  'A',
  '[{"label": "A", "content": "How preventive action can reduce the loss of life."}, {"label": "B", "content": "How courageous Cubans are in face of disasters."}, {"label": "C", "content": "How Cubans suffer from tropical storms."}, {"label": "D", "content": "How destructive tropical storms can be."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  'C',
  '[{"label": "A", "content": "Pay back their loans to the American government."}, {"label": "B", "content": "Provide loans to those in severe financial difficulty."}, {"label": "C", "content": "Contribute more to the goal of a wider recovery."}, {"label": "D", "content": "Speed up their recovery from the housing bubble."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  'B',
  '[{"label": "A", "content": "Some banks may have to merge with others."}, {"label": "B", "content": "Many smaller regional banks are going to fail."}, {"label": "C", "content": "It will be hard for banks to provide more loans."}, {"label": "D", "content": "Many banks will have to lay off some employees."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  'D',
  '[{"label": "A", "content": "It will work closely with the government."}, {"label": "B", "content": "It will endeavor to write off bad loans."}, {"label": "C", "content": "It will try to lower the interest rate."}, {"label": "D", "content": "It will try to provide more loans."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  'D',
  '[{"label": "A", "content": "It won\'t help the American economy to turn around."}, {"label": "B", "content": "It won\'t do any good to the major commercial banks."}, {"label": "C", "content": "It will win the approval of the Obama administration."}, {"label": "D", "content": "It will be necessary if the economy starts to shrink again."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  'A',
  '[{"label": "A", "content": "Being unable to learn new things."}, {"label": "B", "content": "Being rather slow to make changes."}, {"label": "C", "content": "Losing temper more and more often."}, {"label": "D", "content": "Losing the ability to get on with others."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  'A',
  '[{"label": "A", "content": "Cognitive stimulation."}, {"label": "B", "content": "Community activity."}, {"label": "C", "content": "Balanced diet."}, {"label": "D", "content": "Fresh air."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  'C',
  '[{"label": "A", "content": "Ignoring the signs and symptoms of aging."}, {"label": "B", "content": "Adopting an optimistic attitude towards life."}, {"label": "C", "content": "Endeavoring to give up unhealthy lifestyles."}, {"label": "D", "content": "Seeking advice from doctors from time to time."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Examples show that both rich and poor countries exploited the environment for economic progress.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Environmental protection and improvement benefit people all over the world.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. It is not necessarily true that economic growth will make our world cleaner.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. The common theme of the UN reports is the relation between environmental protection and economic growth.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Development agencies disagree regarding how to tackle environment issues while ensuring economic progress.',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. It is difficult to find solid evidence to prove environmental friendliness generates more profits than exploiting the natural environment.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Sustainable management of ecosystems will prove rewarding in the long run.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. A politician noted for being cautious asserts that sustainable human development depends on the natural environment.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Poor countries will have to bear the cost for rich nations\' economic development.',
  'N',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. One recent study warns us of the danger of the exhaustion of natural resources on Earth.',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Examples show that both rich and poor countries exploited the environment for economic progress.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Environmental protection and improvement benefit people all over the world.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. It is not necessarily true that economic growth will make our world cleaner.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. The common theme of the UN reports is the relation between environmental protection and economic growth.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Development agencies disagree regarding how to tackle environment issues while ensuring economic progress.',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. It is difficult to find solid evidence to prove environmental friendliness generates more profits than exploiting the natural environment.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 42);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Sustainable management of ecosystems will prove rewarding in the long run.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 43);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. A politician noted for being cautious asserts that sustainable human development depends on the natural environment.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 44);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Poor countries will have to bear the cost for rich nations\' economic development.',
  'N',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 45);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. One recent study warns us of the danger of the exhaustion of natural resources on Earth.',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 46);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '46. What does Colin Dixon mean by saying "It\'s been the year of interactive television advertising for the last ten or twelve years" (Line 4, Para. 1)?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 47);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. What is the public\'s response to Cablevision\'s planned interactive TV advertising program?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 48);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. What is the impact of the wide use of digital video recorders on TV advertising?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 49);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. What do we learn about Unilever\'s interactive campaign?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 50);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. How does the author view the hitherto high click-through rates?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 51);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does Colin Dixon mean by saying "It\'s been the year of interactive television advertising for the last ten or twelve years" (Line 4, Para. 1)?',
  'D',
  '[{"label": "A", "content": "Interactive television advertising will become popular in 10-12 years."}, {"label": "B", "content": "Interactive television advertising has been under debate for the last decade or so."}, {"label": "C", "content": "Interactive television advertising is successful when incorporated into situation comedies."}, {"label": "D", "content": "Interactive television advertising has not achieved the anticipated results."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 52);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is the public\'s response to Cablevision\'s planned interactive TV advertising program?',
  'C',
  '[{"label": "A", "content": "Pretty positive."}, {"label": "B", "content": "Totally indifferent."}, {"label": "C", "content": "Somewhat doubtful."}, {"label": "D", "content": "Rather critical."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 53);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is the impact of the wide use of digital video recorders on TV advertising?',
  'C',
  '[{"label": "A", "content": "It has made TV advertising easily accessible to viewers."}, {"label": "B", "content": "It helps advertisers to measure the click-through rates."}, {"label": "C", "content": "It has placed TV advertising at a great disadvantage."}, {"label": "D", "content": "It enables viewers to check the sales items with ease."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 54);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn about Unilever\'s interactive campaign?',
  'B',
  '[{"label": "A", "content": "It proves the advantage of TV advertising."}, {"label": "B", "content": "It has done well in engaging the viewers."}, {"label": "C", "content": "It helps attract investments in the company."}, {"label": "D", "content": "It has boosted the TV advertising industry."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 55);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'How does the author view the hitherto high click-through rates?',
  'A',
  '[{"label": "A", "content": "They may be due to the novel way of advertising."}, {"label": "B", "content": "They signify the popularity of interactive advertising."}, {"label": "C", "content": "They point to the growing curiosity of TV viewers."}, {"label": "D", "content": "They indicate the future direction of media reform."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 56);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '中国的创新正在以前所未有的速度蓬勃发展。为了在科学技术上尽快赶超世界发达国家，中国近年来大幅度增加了研究开发资金。中国的大学和研究所正在积极开展创新研究，这些研究覆盖了从大数据到生物化学、从新能源到机器人等各类高科技领域。它们还与各地的科技园合作，使创新成果商业化。与此同时，无论在产品还是商业模式上，中国企业家也在努力争做创新的先锋，以适应国内外消费市场不断变化和增长的需求。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 57);


-- ============================================================
-- [12] 2016年上半年大学英语六级真题（第3套）
-- 题目数: 30
-- 源文件: 四六级历年真题汇总/2016年6月英语四六级/2016年6月英语六级真题及答案/卷三 2016年6月英语六级真题及答案/卷三 2016年6月英语六级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2016, 1, '2016年上半年大学英语六级真题（第3套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write a short essay on the use of robots. Try to imagine what will happen when more and more robots take the place of human beings in industry as -well as people\'s daily lives. You are required to write at least 150 words but no more than 200 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Not many young people eligible for voting are interested in local or national elections these days.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Parents are concerned that their children may get involved in criminal offences once they reach their teens.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. Even during the turbulent years of last century, youth rebellion was often exaggerated in the media.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Teenagers of today often turn to their parents for advice on such important matters as career choice.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. The incidence of teenage crime and misbehavior is decreasing nowadays.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Young people should have lofty ideals in life and strive to be leaders.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Some young people like to keep something to themselves and don\'t want their parents to know about it.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. It is beneficial to encourage young people to explore the broader world and get ready to make it a better place.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Many teenagers now offer to render service to the needy.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. Interviews with students find many of them are only concerned about personal matters.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Not many young people eligible for voting are interested in local or national elections these days.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Parents are concerned that their children may get involved in criminal offences once they reach their teens.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. Even during the turbulent years of last century, youth rebellion was often exaggerated in the media.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Teenagers of today often turn to their parents for advice on such important matters as career choice.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. The incidence of teenage crime and misbehavior is decreasing nowadays.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Young people should have lofty ideals in life and strive to be leaders.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Some young people like to keep something to themselves and don\'t want their parents to know about it.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. It is beneficial to encourage young people to explore the broader world and get ready to make it a better place.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Many teenagers now offer to render service to the needy.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. Interviews with students find many of them are only concerned about personal matters.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. What does the author say about consumers facing an explosion of green claims?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. What was SC Johnson accused of in the class-action lawsuits?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. How did Christopher Beard defend his company\'s labeling practice?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. What does Kevin Wilhelm imply by saying "It\'s kind of a Wild West" (Lines 2-3, Para. 11)?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author say about consumers facing an explosion of green claims?',
  'D',
  '[{"label": "A", "content": "They can easily see through the businesses5 tricks."}, {"label": "B", "content": "They have to spend lots of time choosing products."}, {"label": "C", "content": "They have doubt about current green certification."}, {"label": "D", "content": "They are not clear which products are truly green."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What was SC Johnson accused of in the class-action lawsuits?',
  'C',
  '[{"label": "A", "content": "It gave consumers the impression that all its products were truly green."}, {"label": "B", "content": "It gave a third party the authority to label its products as environmentally friendly."}, {"label": "C", "content": "It misled consumers to believe that its products had been certified by a third party."}, {"label": "D", "content": "It sold cleaning products that were not included in the official \\"Greenlist\\"."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'How did Christopher Beard defend his company\'s labeling practice?',
  'A',
  '[{"label": "A", "content": "There were no clear guidelines concerning green labeling."}, {"label": "B", "content": "His company\'s products had been well received by the public."}, {"label": "C", "content": "It was in conformity to the prevailing practice in the market."}, {"label": "D", "content": "No law required the involvement of a third party in certification."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does Kevin Wilhelm imply by saying "It\'s kind of a Wild West" (Lines 2-3, Para. 11)?',
  'B',
  '[{"label": "A", "content": "Businesses compete to produce green products.-"}, {"label": "B", "content": "Each business acts its own way in green labeling."}, {"label": "C", "content": "Consumers grow wild with products labeled green."}, {"label": "D", "content": "Anything produced in the West can be labeled green."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '旗袍(qipao )是一种雅致的中国服饰，源于中国的满族 ( Manchu Nationality ) 。在清代，旗袍是王室女性穿着的宽松长袍。上世纪20年代，受西方服饰影响，旗袍发生了一些变化。袖口(cuffs)变窄，袍身变短。这些变化使女性美得以充分展现。 如今，旗袍经常出现在世界级的时装秀上。中国女性出席重要社交聚会时，旗袍往往是她们的首选。很多中国新娘也会选择旗袍作为结婚礼服。一些有影响的入士甚至建议将旗袍作为中国女性的民族服饰。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 30);


-- ============================================================
-- [13] 2016年上半年大学英语六级真题（第2套）
-- 题目数: 57
-- 源文件: 四六级历年真题汇总/2016年6月英语四六级/2016年6月英语六级真题及答案/卷二 2016年6月英语六级真题及答案/卷二 2016年6月英语六级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2016, 1, '2016年上半年大学英语六级真题（第2套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write a short essay on e-learning. Try to imagine what will happen when more and more people study online instead of attending school. You are required to write at least 150 words but no more than 200 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  'A',
  '[{"label": "A", "content": "The project the man managed at CucinTech."}, {"label": "B", "content": "The updating of technology at CucinTech."}, {"label": "C", "content": "The man\'s switch to a new career."}, {"label": "D", "content": "The restructuring of her company."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  'B',
  '[{"label": "A", "content": "Talented personnel."}, {"label": "B", "content": "Strategic innovation."}, {"label": "C", "content": "Competitive products."}, {"label": "D", "content": "Effective promotion."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  'C',
  '[{"label": "A", "content": "Expand the market."}, {"label": "B", "content": "Recruit more talents."}, {"label": "C", "content": "Innovate constantly."}, {"label": "D", "content": "Watch out for his competitors."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  'D',
  '[{"label": "A", "content": "Possible bankruptcy."}, {"label": "B", "content": "Unforeseen difficulties."}, {"label": "C", "content": "Conflicts within the company."}, {"label": "D", "content": "Imitation by one\'s competitors."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q5',
  'A',
  '[{"label": "A", "content": "The job of an interpreter."}, {"label": "B", "content": "The stress felt by professionals."}, {"label": "C", "content": "The importance of language proficiency"}, {"label": "D", "content": "The best way to effective communication."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  'B',
  '[{"label": "A", "content": "Promising."}, {"label": "B", "content": "Admirable."}, {"label": "C", "content": "Rewarding."}, {"label": "D", "content": "Meaningful."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  'B',
  '[{"label": "A", "content": "They all have a strong interest in language."}, {"label": "B", "content": "They all have professional qualifications."}, {"label": "C", "content": "They have all passed language proficiency tests."}, {"label": "D", "content": "They have all studied cross-cultural differences."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  'C',
  '[{"label": "A", "content": "It requires a much larger vocabulary."}, {"label": "B", "content": "It attaches more importance to accuracy."}, {"label": "C", "content": "It is more stressful than simultaneous interpreting."}, {"label": "D", "content": "It puts one\'s long-term memory under more stress."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  'C',
  '[{"label": "A", "content": "It might affect mothers\' health."}, {"label": "B", "content": "It might disturb infants, sleep."}, {"label": "C", "content": "It might increase the risk of infants\' death."}, {"label": "D", "content": "It might increase mothers\' mental distress."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  'D',
  '[{"label": "A", "content": "Mothers who breast-feed their babies have a harder time falling asleep."}, {"label": "B", "content": "Mothers who sleep with their babies need a little more sleep each night."}, {"label": "C", "content": "Sleeping patterns of mothers greatly affect their newborn babies\' health."}, {"label": "D", "content": "Sleeping with infants in the same room has a negative impact on mothers."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  'B',
  '[{"label": "A", "content": "Change their sleep patterns to adapt to their newborn babies5."}, {"label": "B", "content": "Sleep in the same room but not in the same bed as their babies."}, {"label": "C", "content": "Sleep in the same house but not in the same room as their babies."}, {"label": "D", "content": "Take precautions to reduce the risk of sudden infant death syndrome."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  'A',
  '[{"label": "A", "content": "A lot of native languages have already died out in the US."}, {"label": "B", "content": "The US ranks first in the number of endangered languages."}, {"label": "C", "content": "The efforts to preserve Indian languages have proved fruitless."}, {"label": "D", "content": "More money is needed to record the native languages in the US."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  'D',
  '[{"label": "A", "content": "To set up more language schools."}, {"label": "B", "content": "To document endangered languages."}, {"label": "C", "content": "To educate native American children."}, {"label": "D", "content": "To revitalise America\'s native languages."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  'A',
  '[{"label": "A", "content": "The US governments policy of Americanising Indian children."}, {"label": "B", "content": "The failure of American Indian languages to gain an official status."}, {"label": "C", "content": "The US governments unwillingness to spend money educating Indians."}, {"label": "D", "content": "The long-time isolation of American Indians from the outside world."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  'C',
  '[{"label": "A", "content": "It is being utilised to teach native languages."}, {"label": "B", "content": "It tells traditional stories during family time."}, {"label": "C", "content": "It speeds up the extinction of native languages."}, {"label": "D", "content": "It is widely used in language immersion schools."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  'A',
  '[{"label": "A", "content": "It pays them up to half of their previous wages while they look for work."}, {"label": "B", "content": "It covers their mortgage payments and medical expenses for 99 weeks."}, {"label": "C", "content": "It pays their living expenses until they find employment again."}, {"label": "D", "content": "It provides them with the basic necessities of everyday life."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  'B',
  '[{"label": "A", "content": "Creating jobs for the huge army of unemployed workers."}, {"label": "B", "content": "Providing training and guidance for unemployed workers."}, {"label": "C", "content": "Convincing local lawmakers to extend unemployment benefits."}, {"label": "D", "content": "Raising funds to help those having no unemployment insurance."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  'C',
  '[{"label": "A", "content": "To offer them loans they need to start their own businesses."}, {"label": "B", "content": "To allow them to postpone their monthly mortgage payments."}, {"label": "C", "content": "To create more jobs by encouraging private investments in local companies."}, {"label": "D", "content": "To encourage big businesses to hire back workers with government subsidies."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  'D',
  '[{"label": "A", "content": "They measured the depths of sea water."}, {"label": "B", "content": "They analyzed the water content."}, {"label": "C", "content": "They explored the ocean floor."}, {"label": "D", "content": "They investigated the ice."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  'D',
  '[{"label": "A", "content": "Eighty percent of the ice disappears in summer time."}, {"label": "B", "content": "Most of the ice was accumulated over the past centuries."}, {"label": "C", "content": "The ice ensures the survival of many endangered species."}, {"label": "D", "content": "The ice decrease is more evident than previously thought."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  'C',
  '[{"label": "A", "content": "Arctic ice is a major source of the world\'s fresh water."}, {"label": "B", "content": "The melting Arctic ice has drowned many coastal cities."}, {"label": "C", "content": "The decline of Arctic ice is irreversible."}, {"label": "D", "content": "Arctic ice is essential to human survival."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  'D',
  '[{"label": "A", "content": "It will do a lot of harm to mankind."}, {"label": "B", "content": "There is no easy way to understand it."}, {"label": "C", "content": "It will advance nuclear technology."}, {"label": "D", "content": "There is no easy technological solution to it."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  'B',
  '[{"label": "A", "content": "The reason why New Zealand children seem to have better self-control."}, {"label": "B", "content": "The relation between children\'s self-control and their future success."}, {"label": "C", "content": "The health problems of children raised by a single parent."}, {"label": "D", "content": "The deciding factor in children\'s academic performance."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  'D',
  '[{"label": "A", "content": "Children raised by single parents will have a hard time in their thirties."}, {"label": "B", "content": "Those with a criminal record mostly come from single parent families."}, {"label": "C", "content": "Parents must learn to exercise self control in front of their children."}, {"label": "D", "content": "Lack of self-control in parents is a disadvantage for their children."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  'A',
  '[{"label": "A", "content": "Self-control can be improved through education."}, {"label": "B", "content": "Self-control can improve one\'s financial situation."}, {"label": "C", "content": "Self-control problems may be detected early in children."}, {"label": "D", "content": "Self-control problems will diminish as one grows up."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. With a tax imposed on expensive health insurance plans, most employers will likely transfer money from health expenses into wages.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Changes in policy would be approved or rejected as a whole so that lobbyists would find it hard to influence lawmakers.',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. It is not easy to curb the rising medical costs in America.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Standardization of forms for automatic processing will save a lot of medical expenses.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Republicans and the insurance industry are strongly opposed to the creation of a public insurance plan.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Conversion of paper to electronic medical records will help eliminate redundant tests and prevent drug interactions.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. The high cost of medical services and unnecessary tests and treatments have driven up medical expenses.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. One main factor that has driven up medical expenses is that doctors are compensated for the amount of care rather than its effect.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Contrary to analysts\' doubts, the author believes drug prices may be lowered through negotiation.',
  'P',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. Fair competition might create a strong incentive for insurers to charge less.',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. With a tax imposed on expensive health insurance plans, most employers will likely transfer money from health expenses into wages.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Changes in policy would be approved or rejected as a whole so that lobbyists would find it hard to influence lawmakers.',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. It is not easy to curb the rising medical costs in America.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Standardization of forms for automatic processing will save a lot of medical expenses.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Republicans and the insurance industry are strongly opposed to the creation of a public insurance plan.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Conversion of paper to electronic medical records will help eliminate redundant tests and prevent drug interactions.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 42);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. The high cost of medical services and unnecessary tests and treatments have driven up medical expenses.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 43);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. One main factor that has driven up medical expenses is that doctors are compensated for the amount of care rather than its effect.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 44);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Contrary to analysts\' doubts, the author believes drug prices may be lowered through negotiation.',
  'P',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 45);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. Fair competition might create a strong incentive for insurers to charge less.',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 46);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '46. What does the author say about the use of raw sewage for farming?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 47);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. What is the main problem caused by the use of waste water for irrigation?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 48);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. What is environmental scientist Pay DrechseVs attitude towards the use of untreated human waste in agriculture?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 49);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. What does Pay Drechsel think of the risks involved in using untreated human waste for farming?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 50);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. What do we learn about James Bartram\'s position on the use of human waste for farming?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 51);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author say about the use of raw sewage for farming?',
  'C',
  '[{"label": "A", "content": "Its risks cannot be overestimated."}, {"label": "B", "content": "It should be forbidden altogether."}, {"label": "C", "content": "Its benefits outweigh the hazards involved."}, {"label": "D", "content": "It is polluting millions of acres of cropland."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 52);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is the main problem caused by the use of waste water for irrigation?',
  'C',
  '[{"label": "A", "content": "Rivers and lakes nearby will gradually become contaminated."}, {"label": "B", "content": "It will drive producers of chemical fertilizers out of business."}, {"label": "C", "content": "Farmers and consumers may be affected by harmful bacteria.-"}, {"label": "D", "content": "It will make the farm produce less competitive on the market."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 53);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is environmental scientist Pay DrechseVs attitude towards the use of untreated human waste in agriculture?',
  'A',
  '[{"label": "A", "content": "Favorable."}, {"label": "B", "content": "Skeptical."}, {"label": "C", "content": "Indifferent."}, {"label": "D", "content": "Responsible."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 54);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does Pay Drechsel think of the risks involved in using untreated human waste for farming?',
  'B',
  '[{"label": "A", "content": "They have been somewhat exaggerated."}, {"label": "B", "content": "They can be dealt with through education."}, {"label": "C", "content": "They will be minimized with new technology."}, {"label": "D", "content": "They can be addressed by improved sanitation."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 55);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn about James Bartram\'s position on the use of human waste for farming?',
  'A',
  '[{"label": "A", "content": "He echoes Pay DrechseFs opinion on the issue."}, {"label": "B", "content": "He challenges Liqa Raschid-Sally\'s conclusion."}, {"label": "C", "content": "He thinks it the only way out of the current food crisis."}, {"label": "D", "content": "He deems it indispensable for combating global poverty."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 56);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '深圳是中国广东省一座新开发的城市。在改革开放之前，深圳不过息一个渔村，仅有三万多人。20世纪80年代，中国政府创建了深圳经济特区，作为实施社会主义市场经济的试验田。如今，深圳 的人口已超过1 000万，整个城市发生了巨大的变化。 到2014年，深圳的人均( per-capita )GDP已达25000美元，相当于世界上一些发达国家的水平。就综合经济实力而言，深圳居于中国顶尖城市之列。由于其独特的地位，深圳也是国内外企业家创业的理想之地。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 57);


-- ============================================================
-- [14] 2016年上半年大学英语四级真题（第1套）
-- 题目数: 22
-- 源文件: 四六级历年真题汇总/2016年6月英语四六级/2016年6月英语四级真题及答案/卷一 2016年6月英语四级真题及答案/卷一 2016年6月英语四级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (4, 2016, 1, '2016年上半年大学英语四级真题（第1套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write a letter to express your thanks to your parents or any family members upon making memorable achievement. You should write at least 120 words but no more than 180 words. Part Ⅱ',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Many people feel guilty when they cannot find a place other than a nursing home for their parents.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Though it helps for children to investigate care facilities, involving their parents in the decision-making process may prove very important.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. It is really difficult to tell if assisted living is better than a nursing home.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. How a resident feels depends on an interaction between themselves and the care facility they live in.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. The author thinks her friend made a rational decision in choosing a more hospitable place over an apparently elegant assisted living home.',
  'N',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. The system Medicare developed to rate nursing home quality is of little help to finding a satisfactory place.',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. At first the researchers of the most recent study found residents in assisted living facilities gave  higher scores on social interaction.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. What kind of care facility old people live in may be less important than we think.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. The findings of the latest research were similar to an earlier multi-state study of assisted living.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. A resident\'s satisfaction with a care facility has much to do with whether they had participated  in the decision to move in and how long they had stayed there.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Many people feel guilty when they cannot find a place other than a nursing home for their parents.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Though it helps for children to investigate care facilities, involving their parents in the decision-making process may prove very important.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. It is really difficult to tell if assisted living is better than a nursing home.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. How a resident feels depends on an interaction between themselves and the care facility they live in.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. The author thinks her friend made a rational decision in choosing a more hospitable place over an apparently elegant assisted living home.',
  'N',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. The system Medicare developed to rate nursing home quality is of little help to finding a satisfactory place.',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. At first the researchers of the most recent study found residents in assisted living facilities gave  higher scores on social interaction.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. What kind of care facility old people live in may be less important than we think.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. The findings of the latest research were similar to an earlier multi-state study of assisted living.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. A resident\'s satisfaction with a care facility has much to do with whether they had participated  in the decision to move in and how long they had stayed there.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '功夫（Kong Fu) 是中国武术（martial arts）的俗称。中国武术的起源可以追溯到自卫的需要，狩猎活动以及古代中国的军士训练。它是中国传统体育运动的一种，年轻人和老年人都练。它已逐渐演变成了中国文化的独特元素。作为中国的国宝，武术有上百种不同的风格，是世界上练得最多的武术形式。有些风格模仿了动物的动作，还有一些则受到了中国哲学思想，神话和传说的启发。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 22);


-- ============================================================
-- [15] 2017年下半年大学英语六级真题（第1套）
-- 题目数: 43
-- 源文件: 四六级历年真题汇总/2017年12月英语四六级/2017年12月英语六级真题及答案/卷一 2017年12月英语六级真题及答案/卷一 2017年12月英语六级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2017, 2, '2017年下半年大学英语六级真题（第1套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write an essay commenting on the saying “Respect others, and you will be respected.” You can cite examples to illustrate your views. You should write at least 150 words but no more than 200 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  'C',
  '[{"label": "A", "content": "They reward businesses that eliminate food waste."}, {"label": "B", "content": "They prohibit the sale of foods that have gone stale."}, {"label": "C", "content": "They facilitate the donation of unsold foods to the needy."}, {"label": "D", "content": "They forbid businesses to produce more foods than needed."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  'B',
  '[{"label": "A", "content": "It imposed penalties on businesses that waste food."}, {"label": "B", "content": "It passed a law aiming to stop overproduction."}, {"label": "C", "content": "It voted against food import from outside Europe."}, {"label": "D", "content": "It prohibited the promotion of bulk food sales."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  'D',
  '[{"label": "A", "content": "It has warmed its people against possible food shortage."}, {"label": "B", "content": "It has penalized businesses that keep overproducing foods."}, {"label": "C", "content": "It has started a nationwide campaign against food waste."}, {"label": "D", "content": "It has banned supermarkets from dumping edible foods."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  'A',
  '[{"label": "A", "content": "The confusion over food expiration labels."}, {"label": "B", "content": "The surplus resulting from overproduction."}, {"label": "C", "content": "Americans\' habit of buying food in bulk."}, {"label": "D", "content": "A lack of regulation on food consumption."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  'D',
  '[{"label": "A", "content": "Price reductions for its frequent customers."}, {"label": "B", "content": "Coupons for customers with bulk purchases."}, {"label": "C", "content": "Free delivery of purchases for senior customers."}, {"label": "D", "content": "Price adjustments within seven days of purchase."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  'C',
  '[{"label": "A", "content": "Mail a gift card to her."}, {"label": "B", "content": "Allow her to buy on credit."}, {"label": "C", "content": "Credit it to her account."}, {"label": "D", "content": "Give her some coupons."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  'D',
  '[{"label": "A", "content": "Refunding for goods returned."}, {"label": "B", "content": "Free installing of appliances."}, {"label": "C", "content": "Prolonged goods warranty."}, {"label": "D", "content": "Complimentary tailoring."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  'A',
  '[{"label": "A", "content": "They are thin, tall, and unlike real human beings."}, {"label": "B", "content": "They have more than twenty different hair textures."}, {"label": "C", "content": "They have twenty-four different body shapes in total."}, {"label": "D", "content": "They represent people from virtually all walks of life."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  'D',
  '[{"label": "A", "content": "They do not reflect young girls’ aspirations."}, {"label": "B", "content": "They are not sold together with the original."}, {"label": "C", "content": "Their flat feet do not appeal to adolescents."}, {"label": "D", "content": "Their body shapes have not changed much."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  'C',
  '[{"label": "A", "content": "In toy stores."}, {"label": "B", "content": "In shopping malls."}, {"label": "C", "content": "On the Internet."}, {"label": "D", "content": "At Barbie shops."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  'A',
  '[{"label": "A", "content": "Moveable metal type began to be used in printing."}, {"label": "B", "content": "Chinese printing technology was first introduce."}, {"label": "C", "content": "The earliest known book was published."}, {"label": "D", "content": "Metal type was imported from Korea."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  'B',
  '[{"label": "A", "content": "It had more than a hundred printing presses."}, {"label": "B", "content": "It was the biggest printer in the 16th century."}, {"label": "C", "content": "It helped the German people become literate."}, {"label": "D", "content": "It produced some 20 million volumes in total."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  'B',
  '[{"label": "A", "content": "It pushed handwritten books out of circulation."}, {"label": "B", "content": "It boosted the circulation of popular works."}, {"label": "C", "content": "It made writing a very profitable career."}, {"label": "D", "content": "It provided readers with more choices."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  'D',
  '[{"label": "A", "content": "It accelerated the extinction of the Latin language."}, {"label": "B", "content": "It standardized the publication of grammar books."}, {"label": "C", "content": "It turned translation into a welcome profession."}, {"label": "D", "content": "It promoted the growth of national languages."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  'D',
  '[{"label": "A", "content": "They get bored after working for a period of time."}, {"label": "B", "content": "They spend an average of one year finding a job."}, {"label": "C", "content": "They become stuck in the same job for decades."}, {"label": "D", "content": "They choose a job without thinking it through."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  'B',
  '[{"label": "A", "content": "See if there will be chances for promotion."}, {"label": "B", "content": "Find out what job choices are available."}, {"label": "C", "content": "Watch a film about ways of job hunting."}, {"label": "D", "content": "Decide which job is most attractive to you."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  'A',
  '[{"label": "A", "content": "The qualifications you have."}, {"label": "B", "content": "The pay you are going to get."}, {"label": "C", "content": "The culture of your target company."}, {"label": "D", "content": "The work environment you will be in."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  'B',
  '[{"label": "A", "content": "It is as important as Christmas for African-Americans."}, {"label": "B", "content": "It is a cultural festival founded for African-Americans."}, {"label": "C", "content": "It is an ancient festival celebrated by African-Americans."}, {"label": "D", "content": "It is a religious festival celebrated by African-Americans."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  'C',
  '[{"label": "A", "content": "To urge African-Americans to do more for society."}, {"label": "B", "content": "To call on African-Americans to worship their gods."}, {"label": "C", "content": "To help African-Americans to realize their goals."}, {"label": "D", "content": "To remind African-Americans of their sufferings."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  'B',
  '[{"label": "A", "content": "Faith in self-determination."}, {"label": "B", "content": "The first fruits of the harvest."}, {"label": "C", "content": "Unity and cooperative economics."}, {"label": "D", "content": "Creative work and achievement."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  'A',
  '[{"label": "A", "content": "They recite a principle."}, {"label": "B", "content": "They take a solemn oath."}, {"label": "C", "content": "They drink wine from the unity cup."}, {"label": "D", "content": "They call out their ancestors’ names."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  'A',
  '[{"label": "A", "content": "It is one of the world’s most healthy diets."}, {"label": "B", "content": "It contains large amounts of dairy products."}, {"label": "C", "content": "It began to impact the world in recent years."}, {"label": "D", "content": "It consists mainly of various kinds of seafood."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  'C',
  '[{"label": "A", "content": "It involved 13, 000 researchers from Asia, Europe and America."}, {"label": "B", "content": "It was conducted in seven Mid-Eastern countries in the 1950s."}, {"label": "C", "content": "It is regarded as one of the greatest researches of its kind."}, {"label": "D", "content": "It has drawn the attention of medical doctors the world over."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  'D',
  '[{"label": "A", "content": "They care much about their health."}, {"label": "B", "content": "They eat foods with little fat."}, {"label": "C", "content": "They use little oil in cooking."}, {"label": "D", "content": "They have lower mortality rates."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Reading Comprehension                        (40 minutes) \nSection A\nDirections: In this section, t',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '46. What do we learn about chemist John Pemberton?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. What does the passage say about kola nuts?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. How come kola-extract colas became popular?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. What is known about the taste of Coca-Cola?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. What is the passage mainly about?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. Years ago, many downtown cores in small to mid-sized cities().',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. What characterizes the new downtown areas in 18-hour cities?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. What have 18-hour cities brought to the local residents?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn about chemist John Pemberton?',
  'D',
  '[{"label": "A", "content": "He used a strangely potent ingredient in a food supplement."}, {"label": "B", "content": "He created a drink containing alcohol without breaking law."}, {"label": "C", "content": "He became notorious because of the coca drink he developed."}, {"label": "D", "content": "He risked breaking local law to make a drink with coca leaves."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the passage say about kola nuts?',
  'C',
  '[{"label": "A", "content": "Their commercial value was first discovered by Portuguese settler."}, {"label": "B", "content": "They contain some kind of energy boost not found in any other food."}, {"label": "C", "content": "Many were shipped to Europe in the late 19th century for medicinal use."}, {"label": "D", "content": "They were strange to the Europeans when first imported from West Africa."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'How come kola-extract colas became popular?',
  'A',
  '[{"label": "A", "content": "Cocaine had become notorious."}, {"label": "B", "content": "Alcoholic drinks were prohibited."}, {"label": "C", "content": "Fountains were set up to sell them."}, {"label": "D", "content": "Rights were sold to bottle the soda."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is known about the taste of Coca-Cola?',
  'D',
  '[{"label": "A", "content": "It was so designed as to create addiction in consumers."}, {"label": "B", "content": "It still relies on traditional kola nut extract."}, {"label": "C", "content": "It has become more popular among the old."}, {"label": "D", "content": "It has remained virtually unchanged since its creation."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is the passage mainly about?',
  'A',
  '[{"label": "A", "content": "The evolution of Coca-Cola."}, {"label": "B", "content": "The medicinal value of Coca-Cola."}, {"label": "C", "content": "The success story of Coca-Cola."}, {"label": "D", "content": "The business strategy of Coca-Cola."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Years ago, many downtown cores in small to mid-sized cities().',
  'D',
  '[{"label": "A", "content": "Had hardly any business activity."}, {"label": "B", "content": "Were crowded in business hours."}, {"label": "C", "content": "Exhibited no signs of prosperity."}, {"label": "D", "content": "Looked deserted in the evenings."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What characterizes the new downtown areas in 18-hour cities?',
  'C',
  '[{"label": "A", "content": "Sudden emergence of the knowledge industry."}, {"label": "B", "content": "Flooding in of large crowds of migrant workers."}, {"label": "C", "content": "Modernized housing and improved infrastructure."}, {"label": "D", "content": "More comfortable life and greater upward mobility."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What have 18-hour cities brought to the local residents?',
  'D',
  '[{"label": "A", "content": "More chances for promotion."}, {"label": "B", "content": "Healthier living environment."}, {"label": "C", "content": "Greater cultural diversity."}, {"label": "D", "content": "Better job opportunities."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 42);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '太湖是中国东部的一个淡水湖,占地面积2250平方公里,是中国第三大淡水湖,仅次于鄱阳和洞庭。太湖约有90个岛屿,大小从几平方米到几平方公里不等。太湖以其独特的“太湖石”而闻名,太湖石常用于装饰中国传统园林。太湖也以高产的捕鱼业闻名。自上世纪70年代后期以来,捕捞鱼蟹对沿湖的居民来说极为重要,并对周边地区的经济作出了重大贡献。太湖地区是中国陶瓷( ceramics )业基地之一,其中宜兴的陶瓷厂家生产举世闻名的宜兴紫砂壶( clay teapot )。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 43);


-- ============================================================
-- [16] 2017年下半年大学英语六级真题（第3套）
-- 题目数: 32
-- 源文件: 四六级历年真题汇总/2017年12月英语四六级/2017年12月英语六级真题及答案/卷三 2017年12月英语六级真题及答案/卷三 2017年12月英语六级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2017, 2, '2017年下半年大学英语六级真题（第3套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write an essay commenting on the saying "Help others, and you will be helped when you are in need " You can cite examples to illustrate your views. You should write at least 150 words but no more than 200 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. It is a popular belief that tech companies are committed to protecting their customers’ private data.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. The US government believes that its access to people’s iPhones could be used to prevent terrorist attacks.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. A federal court asked Apple to help the FBI access data in a terrorist’s iPhone.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Privacy advocates now have Apple fighting alongside them against government access to personal data.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Snowden revealed that the American government had tried hard to access private data in massive scale.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. The FBI might have been able to access private data in earlier iPhones without Apple’s help.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. After the Snowden incident, Apple made clear its position to counter government intrusion into personal data by means of encryption.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. According to one digital expert, no iPhone can be entirely free from hacking.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Timothy Cook’s long web post has helped enhance Apple’s image.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. Apple’s CEO has decided to appeal the federal court’s order to unlock a user’s iPhone.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. It is a popular belief that tech companies are committed to protecting their customers’ private data.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. The US government believes that its access to people’s iPhones could be used to prevent terrorist attacks.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. A federal court asked Apple to help the FBI access data in a terrorist’s iPhone.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Privacy advocates now have Apple fighting alongside them against government access to personal data.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Snowden revealed that the American government had tried hard to access private data in massive scale.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. The FBI might have been able to access private data in earlier iPhones without Apple’s help.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. After the Snowden incident, Apple made clear its position to counter government intrusion into personal data by means of encryption.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. According to one digital expert, no iPhone can be entirely free from hacking.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Timothy Cook’s long web post has helped enhance Apple’s image.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. Apple’s CEO has decided to appeal the federal court’s order to unlock a user’s iPhone.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '46. What can we learn about Lake Natron?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. Flamingos nest only when the lake water is at a specific level so that their babies can  .',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. Flamingos in the Rift Valley are unique in that  .',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. Why can certain species of tilapia sometimes survive around Lake Natron?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. What may be the consequence of Tanzanian government’s planned operation?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What can we learn about Lake Natron?',
  'A',
  '[{"label": "A", "content": "It is simply uninhabitable for most animals."}, {"label": "B", "content": "It remains little known to the outside world."}, {"label": "C", "content": "It is a breeding ground for a variety of birds."}, {"label": "D", "content": "It makes an ideal habitat for lots of predators."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Flamingos nest only when the lake water is at a specific level so that their babies can  .',
  'C',
  '[{"label": "A", "content": "find safe shelter more easily."}, {"label": "B", "content": "grow thick feathers on their feet."}, {"label": "C", "content": "stay away from predators."}, {"label": "D", "content": "get accustomed to the salty water."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Flamingos in the Rift Valley are unique in that  .',
  'B',
  '[{"label": "A", "content": "they can move swiftly across lagoons."}, {"label": "B", "content": "they can survive well in salty water."}, {"label": "C", "content": "they breed naturally in corrosive ditches."}, {"label": "D", "content": "they know where and when to nest."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Why can certain species of tilapia sometimes survive around Lake Natron?',
  'A',
  '[{"label": "A", "content": "They can take refuge in the less salty waters."}, {"label": "B", "content": "They can flee quick enough from predators."}, {"label": "C", "content": "They can move freely from lagoon to lagoon."}, {"label": "D", "content": "They can stand the heat of the spring water."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What may be the consequence of Tanzanian government’s planned operation?',
  'D',
  '[{"label": "A", "content": "The accelerated extinction of flamingos."}, {"label": "B", "content": "The change of flamingos’ migration route."}, {"label": "C", "content": "The overmining of Lake Natron’s soda ash."}, {"label": "D", "content": "The disruption of Lake Natron’s ecosystem."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '洞庭湖位于湖南省东北部，面积很大，但湖水很浅。洞庭湖是长江的蓄洪池，湖的大校很大程度上取决于季节变化。湖北和湖南两省因其与湖的相对位置而得名，湖北意为“湖的北边”，而湖南则为“湖的南边”。洞庭湖作为龙舟赛的发源地，在中国文化中享有盛名。据说龙舟赛始于洞庭湖东岸。为的是搜寻楚国爱国诗人屈原的遗体。龙舟赛与洞庭湖及周边的美景，每年都吸引着成千上万来自全国和世界各地的游客。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 32);


-- ============================================================
-- [17] 2017年下半年大学英语六级真题（第2套）
-- 题目数: 47
-- 源文件: 四六级历年真题汇总/2017年12月英语四六级/2017年12月英语六级真题及答案/卷二 2017年12月英语六级真题及答案/卷二 2017年12月英语六级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2017, 2, '2017年下半年大学英语六级真题（第2套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write an essay commenting on the saying "Seek to understand others, and you will be understood " You can cite examples to illustrate your views. You should write at least 150 words but no more than 200.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  'A',
  '[{"label": "A", "content": "Say a few words to thank the speaker."}, {"label": "B", "content": "Introduce the speaker to the audience."}, {"label": "C", "content": "Give a lecture on the history of the town."}, {"label": "D", "content": "Host a talk on how to give a good speech."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  'D',
  '[{"label": "A", "content": "He was the founder of the local history society."}, {"label": "B", "content": "He has worked with Miss Bligh for 20 years."}, {"label": "C", "content": "He has published a book on public speaking."}, {"label": "D", "content": "He joined the local history society when young."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  'B',
  '[{"label": "A", "content": "She was obviously better at talking than writing."}, {"label": "B", "content": "She had a good knowledge of the town’s history."}, {"label": "C", "content": "Her speech was so funny as to amuse the audience."}, {"label": "D", "content": "Her ancestors came to the town in the 18th century."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  'C',
  '[{"label": "A", "content": "He read exactly what was written in his notes."}, {"label": "B", "content": "He kept forgetting what he was going to say."}, {"label": "C", "content": "He made an embarrassing remark."}, {"label": "D", "content": "He was too nervous to speak up."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q5',
  'B',
  '[{"label": "A", "content": "What their retailers demand."}, {"label": "B", "content": "What their rivals are doing."}, {"label": "C", "content": "How they are going to beat their rivals."}, {"label": "D", "content": "How dramatically the market is changing."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  'A',
  '[{"label": "A", "content": "They should be taken seriously."}, {"label": "B", "content": "They are rapidly catching up."}, {"label": "C", "content": "How they are going to beat their rivals."}, {"label": "D", "content": "How dramatically the market is changing."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  'C',
  '[{"label": "A", "content": "She had given it to Tom."}, {"label": "B", "content": "It simply made her go frantic."}, {"label": "C", "content": "She had not seen it yet."}, {"label": "D", "content": "It was not much of a big concern."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  'D',
  '[{"label": "A", "content": "Restructuring the whole company."}, {"label": "B", "content": "Employing more forwarding agents."}, {"label": "C", "content": "Promoting cooperation with Jayal Motors."}, {"label": "D", "content": "Exporting their motorbikes to Indonesia."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  'B',
  '[{"label": "A", "content": "It makes claims in conflict with the existing research."}, {"label": "B", "content": "It focuses on the link between bedtime and nutrition."}, {"label": "C", "content": "It cautions against the overuse of coffee and alcohol."}, {"label": "D", "content": "It shows that “night owls” work much less efficiently."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  'C',
  '[{"label": "A", "content": "They pay greater attention to food choice."}, {"label": "B", "content": "They tend to achieve less than their peers."}, {"label": "C", "content": "They run a higher risk of gaining weight."}, {"label": "D", "content": "They stand a greater chance to fall sick."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  'D',
  '[{"label": "A", "content": "Get up late."}, {"label": "B", "content": "Sleep 8 hours a day."}, {"label": "C", "content": "Exercise more."}, {"label": "D", "content": "Go to bed earlier."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  'A',
  '[{"label": "A", "content": "All of the acting nominees are white."}, {"label": "B", "content": "It has got too much publicity on TV."}, {"label": "C", "content": "It is prejudiced against foreign films."}, {"label": "D", "content": "Only 7% of the nominees are female."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  'D',
  '[{"label": "A", "content": "22 percent of movie directors were people of color."}, {"label": "B", "content": "Half of the TV programs were ethnically balanced."}, {"label": "C", "content": "Only one-fifth of TV shows had black characters."}, {"label": "D", "content": "Only 3.4 percent of film directors were women."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  'C',
  '[{"label": "A", "content": "Non-white males."}, {"label": "B", "content": "Program creators."}, {"label": "C", "content": "Females of color over 40."}, {"label": "D", "content": "Asian speaking characters ."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  'B',
  '[{"label": "A", "content": "They constitute 17% of Hollywood movie characters."}, {"label": "B", "content": "They are most underrepresented across TV and film."}, {"label": "C", "content": "They contribute little to the U.S. film industry."}, {"label": "D", "content": "They account for 8.5% of the U.S. population."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  'C',
  '[{"label": "A", "content": "One that can provide for emergency needs."}, {"label": "B", "content": "One that can pay for their medical expenses."}, {"label": "C", "content": "One that covers their debts and burial expenses."}, {"label": "D", "content": "One that ensures a healthy life for their later years."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  'D',
  '[{"label": "A", "content": "Purchase insurance for their children."}, {"label": "B", "content": "Save sufficient money for a rainy day."}, {"label": "C", "content": "Buy a home with a small down payment."}, {"label": "D", "content": "Add more insurance on the breadwinner."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  'A',
  '[{"label": "A", "content": "When their children grow up and leave home."}, {"label": "B", "content": "When they have saved enough for retirement."}, {"label": "C", "content": "When their family move to a different place."}, {"label": "D", "content": "When they have found better-paying jobs."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  'D',
  '[{"label": "A", "content": "They do more harm than good."}, {"label": "B", "content": "They have often been ignored."}, {"label": "C", "content": "They do not help build friendship."}, {"label": "D", "content": "They may not always be negative."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  'A',
  '[{"label": "A", "content": "Biased sources of information."}, {"label": "B", "content": "Ignorance of cultural differences."}, {"label": "C", "content": "Misinterpretation of Shakespeare."}, {"label": "D", "content": "Tendency to jump to conclusions."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  'B',
  '[{"label": "A", "content": "They are hard to dismiss once attached to a certain group."}, {"label": "B", "content": "They may have a negative impact on people they apply to."}, {"label": "C", "content": "They persist even when circumstances have changed."}, {"label": "D", "content": "They are often applied to minorities and ethnic people."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  'C',
  '[{"label": "A", "content": "They impact people more or less in the same way."}, {"label": "B", "content": "Some people are more sensitive to them than others."}, {"label": "C", "content": "A positive stereotype may help one achieve better results."}, {"label": "D", "content": "A negative stereotype sticks while a positive one does not."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  'B',
  '[{"label": "A", "content": "Use some over-the-counter medicine instead ."}, {"label": "B", "content": "Quit taking the medicine immediately."}, {"label": "C", "content": "Take some drug to relieve the side effect."}, {"label": "D", "content": "Ask your pharmacist to explain why it occurs."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  'D',
  '[{"label": "A", "content": "It may help patients fall asleep."}, {"label": "B", "content": "It may lead to mental problems."}, {"label": "C", "content": "It may cause serious harm to one’s liver."}, {"label": "D", "content": "It may increase the effect of certain drugs."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  'A',
  '[{"label": "A", "content": "Tell their children to treat medicines with respect."}, {"label": "B", "content": "Keep medicines out of the reach of their children."}, {"label": "C", "content": "Make sure their children use quality medicines."}, {"label": "D", "content": "Ask their children to use legitimate medicines."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Astronomer David Hogg doesn\'t think scooping is as serious a problem as generally thought.',
  'M',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Some researchers are hesitant to make their data public for fear that others might publish something similar before them.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. Some psychology journals have offered incentives to encourage authors to share their data.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. There is a growing demand in the science community that research data be open to the public.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Sharing data offers early-career researchers the chance to build a certain level of reputation.',
  'P',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Data sharing enables scientists to publish each step of their research work, thus leading to more citations.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Scientists hold different opinions about the extent and timing of data sharing.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Potential problems related to data sharing should be made known to and discussed by all participants at the beginning of a joint research project.',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Sharing data and handling data-related issues can be time-consuming.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. Junior researchers may have no say when it comes to sharing data.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Astronomer David Hogg doesn\'t think scooping is as serious a problem as generally thought.',
  'M',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Some researchers are hesitant to make their data public for fear that others might publish something similar before them.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. Some psychology journals have offered incentives to encourage authors to share their data.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. There is a growing demand in the science community that research data be open to the public.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Sharing data offers early-career researchers the chance to build a certain level of reputation.',
  'P',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Data sharing enables scientists to publish each step of their research work, thus leading to more citations.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 42);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Scientists hold different opinions about the extent and timing of data sharing.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 43);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Potential problems related to data sharing should be made known to and discussed by all participants at the beginning of a joint research project.',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 44);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Sharing data and handling data-related issues can be time-consuming.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 45);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. Junior researchers may have no say when it comes to sharing data.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 46);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '青海湖位于海拔 3,205 米、青海省省会西宁以西约 100 公里处,是中国最大的咸水湖,面积 4,317 平方公里,最深处25.5 米,有 23 条河注入湖中,其中大部分是季节性的。百分之八十的湖水源于五条主要河流。青海湖位于跨越亚洲的几条候鸟迁徙路线的交叉处。许多鸟类把青海湖作为迁徙过程中的暂息地。湖的西侧是著名的“鸟岛”,吸引着来自世界各地的观鸟者。每年夏天，游客们也来这里观看国际自行车比赛。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 47);


-- ============================================================
-- [18] 2017年下半年大学英语四级真题（第1套）
-- 题目数: 32
-- 源文件: 四六级历年真题汇总/2017年12月英语四六级/2017年12月英语四级真题及答案/卷一 2017年12月英语四级真题及答案/卷一 2017年12月英语四级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (4, 2017, 2, '2017年下半年大学英语四级真题（第1套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write a short essay on how to best handle the relationship between parents and children. You should write at least120 words but no more than 180 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  'D',
  '[{"label": "A", "content": "Her grandfather."}, {"label": "B", "content": "Her grandmother."}, {"label": "C", "content": "Her friend Erika."}, {"label": "D", "content": "Her little brother."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  'B',
  '[{"label": "A", "content": "By taking pictures for passers-by."}, {"label": "B", "content": "By selling lemonade and pictures."}, {"label": "C", "content": "By working part time at a hospital."}, {"label": "D", "content": "By asking for help on social media."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  'B',
  '[{"label": "A", "content": "Testing the efficiency of the new solar panel."}, {"label": "B", "content": "Providing clean energy to five million people."}, {"label": "C", "content": "Generating electric power for passing vehicles."}, {"label": "D", "content": "Finding cheaper ways of highway construction."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  'C',
  '[{"label": "A", "content": "They are only about half an inch thick."}, {"label": "B", "content": "They are made from cheap materials."}, {"label": "C", "content": "They can be laid right on top of existing highways."}, {"label": "D", "content": "They can stand the wear and tear of naturalelements."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q5',
  'C',
  '[{"label": "A", "content": "The lack of clues about the species."}, {"label": "B", "content": "Inadequate funding for research."}, {"label": "C", "content": "Endless fighting in the region."}, {"label": "D", "content": "The hazards from the desert."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  'D',
  '[{"label": "A", "content": "To observe the wildlife in the two national parks."}, {"label": "B", "content": "To study the habitat of lions in Sudan and Ethiopia."}, {"label": "C", "content": "To identify the reasons for the lions’ disappearance."}, {"label": "D", "content": "To find evidence of the existence of the “lost lions”."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  'A',
  '[{"label": "A", "content": "Lions’ tracks."}, {"label": "B", "content": "Lions walking."}, {"label": "C", "content": "Some camping facilities."}, {"label": "D", "content": "Traps set by local hunters."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  'D',
  '[{"label": "A", "content": "A special gift from the man."}, {"label": "B", "content": "Her wedding anniversary."}, {"label": "C", "content": "A call from her dad."}, {"label": "D", "content": "Her ‘lucky birthday’."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  'A',
  '[{"label": "A", "content": "Threw her a surprise party."}, {"label": "B", "content": "Took her on a trip overseas."}, {"label": "C", "content": "Bought her a gold necklace."}, {"label": "D", "content": "Gave her a big model plane."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  'C',
  '[{"label": "A", "content": "What her husband and the man are up to."}, {"label": "B", "content": "What has been troubling her husband."}, {"label": "C", "content": "The trip her husband has planned."}, {"label": "D", "content": "The gift her husband has bought."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  'B',
  '[{"label": "A", "content": "He wants to find out about the couple’s holiday plan."}, {"label": "B", "content": "He is eager to learn how the couple’s holiday turns out."}, {"label": "C", "content": "He will tell the women the secret if her husband agrees."}, {"label": "D", "content": "He will be glad to be a guide for the couple’s holiday trip."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  'D',
  '[{"label": "A", "content": "They take the rival’s attitude into account."}, {"label": "B", "content": "They know when to adopt a tough attitude."}, {"label": "C", "content": "They see the importance of making compromises."}, {"label": "D", "content": "They are sensitive to the dynamics of a negotiation."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  'A',
  '[{"label": "A", "content": "They know when to stop."}, {"label": "B", "content": "They know how to adapt."}, {"label": "C", "content": "They know when to make compromises."}, {"label": "D", "content": "They know how to control their emotion."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  'B',
  '[{"label": "A", "content": "They are patient."}, {"label": "B", "content": "They learn quickly."}, {"label": "C", "content": "They are good at expression."}, {"label": "D", "content": "They uphold their principles."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  'C',
  '[{"label": "A", "content": "Clarify items of negotiation."}, {"label": "B", "content": "Make clear one\'s intentions."}, {"label": "C", "content": "Get to know the other side."}, {"label": "D", "content": "Formulate one\'s strategy."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  'A',
  '[{"label": "A", "content": "How space research benefits people on Earth."}, {"label": "B", "content": "When the International Space Station was built."}, {"label": "C", "content": "How many space shuttle missions there will be."}, {"label": "D", "content": "When America\'s earliest space programstarted."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  'C',
  '[{"label": "A", "content": "They tried to make best use of the latest technology."}, {"label": "B", "content": "They tried to meet astronauts\' specific requirements."}, {"label": "C", "content": "They developed objects for astronauts to use in outer space."}, {"label": "D", "content": "They accurately calculated the speed of the orbiting shuttles."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  'B',
  '[{"label": "A", "content": "They are expensive to make."}, {"label": "B", "content": "They are extremely accurate."}, {"label": "C", "content": "They were first made in space."}, {"label": "D", "content": "They were invented in the 1970s."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  'C',
  '[{"label": "A", "content": "Everything was natural and genuine then."}, {"label": "B", "content": "People had plenty of land to cultivate then."}, {"label": "C", "content": "It marked the beginning of something new."}, {"label": "D", "content": "It was when her ancestors came to America."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  'D',
  '[{"label": "A", "content": "They were known to be creative."}, {"label": "B", "content": "They enjoyed living a living a life of ease."}, {"label": "C", "content": "They had all kinds of entertainment."}, {"label": "D", "content": "They believed in working for goals."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  'B',
  '[{"label": "A", "content": "Chatting with her ancestors."}, {"label": "B", "content": "Doing needlework by the fire."}, {"label": "C", "content": "Furnishing her country house."}, {"label": "D", "content": "Polishing all the silver work."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  'A',
  '[{"label": "A", "content": "Sit down and try to calm yourself."}, {"label": "B", "content": "Call your family or friends for help."}, {"label": "C", "content": "Use a map to identify your location."}, {"label": "D", "content": "Try to follow your footprints back."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  'C',
  '[{"label": "A", "content": "You may end up entering a wonderland."}, {"label": "B", "content": "You may get drowned in a sudden flood."}, {"label": "C", "content": "You may expose yourself to unexpected dangers."}, {"label": "D", "content": "You may find a way out without your knowing it."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  'A',
  '[{"label": "A", "content": "Walk uphill"}, {"label": "B", "content": "Look for food."}, {"label": "C", "content": "Start a fire."}, {"label": "D", "content": "Wait patiently."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  'D',
  '[{"label": "A", "content": "Check the local weather."}, {"label": "B", "content": "Find a map and a compass."}, {"label": "C", "content": "Prepare enough food and drink."}, {"label": "D", "content": "Inform somebody of your plan. Part Ⅲ"}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Reading Comprehension                          ( 40 minutes )\nSection A\nDirections: In this section, t',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. sted? Nearly twice as many women than men ages 18-44 reported feeling “very tired” or “exhausted”, acco',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. Men and woman differ in their approach to resolving workplace conflicts in that   .',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. What is important to a good leader?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Men and woman differ in their approach to resolving workplace conflicts in that   .',
  'C',
  '[{"label": "A", "content": "women tend to be easily satisfied"}, {"label": "B", "content": "men are generally more persuasive"}, {"label": "C", "content": "men tend to put their personal interests first"}, {"label": "D", "content": "women are much more ready to compromise"}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is important to a good leader?',
  'B',
  '[{"label": "A", "content": "dominant personality."}, {"label": "B", "content": "The ability to delegate."}, {"label": "C", "content": "The courage to admit failure"}, {"label": "D", "content": "A strong sense of responsibility. Part Ⅳ Translation (30 minutes) Directions: For this part, you are allowed 30 minutes to translate a passage from Chinese into English. You should write your answer on Answer Sheet 2. 泰山位于山东省西部,海拔 1500 余米,方圆约 400 平方公里。泰山不仅雄伟壮观,而且是一座历史文化名山,过去3000 多年一直是人们前往朝拜的地方。据记载,共有 72 位帝王曾来此游览,许多作家到泰山获取灵感,写诗作文,艺术家也来此绘画,山上因此留下了许许多多的文物古迹。泰山如今已成为中国一处主要的旅游景点。 【 参 考 答 案 】 【参考范文】 The relationship between parents and children is an eternal and universal topic for mankind. Our relationship with parents might be different at different ages. And for young people at their 20s, I think it will depend more on what children do. The reason why I say so is that as we grow up, our parents who were our idols before gradually get old and even out-dated. However hard efforts they make, they could not catch up with our steps, leading to the so-called invisible generation gap. Thus, if we cannot slow down our pace, there will definitely be an awkward silence between parents and us, which is not rare now. As a result, young people should talk more with parents to share our feelings and to understand each other better. Everyone wants loving parents who are open and supportive. Only through frequent communication with them, can we establish such a harmonious relationship. 【1-5】DBBCC 【6-10】DADAC 【11-15】BDABC 【16-20】ACBCD 【21-25】BACAD 【26-30】KDMOA 【31-35】FHICB 【36-40】IECDB 【41-45】HGFAJ 【46-50】DCACB 【51-55】DAACB 【"}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 32);


-- ============================================================
-- [19] 2017年下半年大学英语四级真题（第3套）
-- 题目数: 11
-- 源文件: 四六级历年真题汇总/2017年12月英语四六级/2017年12月英语四级真题及答案/卷三 2017年12月英语四级真题及答案/卷三 2017年12月英语四级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (4, 2017, 2, '2017年下半年大学英语四级真题（第3套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write a short essay on how to best handle the relationship between doctors and patients. You should write at least 120 words but no more than 180 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. ading Comprehension                              (40 minutes)\nSection A\nDirections: In this section, th',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. creation centers. Today, the EFK program 33 over 144 branches in 32 states within the United States and',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '46. What do people generally believe about aging?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. How do many scientists view aging now?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. What does Alex Zhavoronkov think of “describing aging as a disease”?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. What do we learn about the medical community?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do people generally believe about aging?',
  'B',
  '[{"label": "A", "content": "It should cause no alarm whatsoever."}, {"label": "B", "content": "They just cannot do anything about it."}, {"label": "C", "content": "It should be regarded as a kind of disease."}, {"label": "D", "content": "They can delay it with advances in science."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'How do many scientists view aging now?',
  'A',
  '[{"label": "A", "content": "It might be prevented and treated."}, {"label": "B", "content": "It can be as risky as heart disease."}, {"label": "C", "content": "It results from a vitamin deficiency."}, {"label": "D", "content": "It is an irreversible biological process."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does Alex Zhavoronkov think of “describing aging as a disease”?',
  'D',
  '[{"label": "A", "content": "It will prompt people to take aging more seriously."}, {"label": "B", "content": "It will greatly help reduce the side effects of aging."}, {"label": "C", "content": "It will free pharmacists from the conventional beliefs about aging."}, {"label": "D", "content": "It will motivate doctors and pharmacists to find ways to treat aging."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn about the medical community?',
  'C',
  '[{"label": "A", "content": "They now have a strong interest in research on aging."}, {"label": "B", "content": "They differ from the academic circles in their view on aging."}, {"label": "C", "content": "They can contribute to people’s health only to a limited extent."}, {"label": "D", "content": "They have ways to intervene in people’s aging process. What does Professor Leonard Hayflick believe? The human lifespan cannot be prolonged. Aging is hardly separable from disease. Few people can live up to the age of 92. Heart disease is the major cause of aging."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 11);


-- ============================================================
-- [20] 2017年下半年大学英语四级真题（第2套）
-- 题目数: 56
-- 源文件: 四六级历年真题汇总/2017年12月英语四六级/2017年12月英语四级真题及答案/卷二 2017年12月英语四级真题及答案/卷二 2017年12月英语四级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (4, 2017, 2, '2017年下半年大学英语四级真题（第2套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write a short essay on how to best handle the relationship between teachers and students. You should write at least 120 words but no more than 180 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  'D',
  '[{"label": "A", "content": "It tries to entertain its audience."}, {"label": "B", "content": "It tries to look into the distance."}, {"label": "C", "content": "It wants to catch people’s attention."}, {"label": "D", "content": "It has got one of its limbs injured."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  'C',
  '[{"label": "A", "content": "It was spotted by animal protection officials."}, {"label": "B", "content": "It was filmed by a local television reporter."}, {"label": "C", "content": "Its videos were posted on social media."}, {"label": "D", "content": "Its picture won a photography prize."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  'A',
  '[{"label": "A", "content": "The distance travelled."}, {"label": "B", "content": "The incidence of road accidents."}, {"label": "C", "content": "The spending on gas."}, {"label": "D", "content": "The number of people travelling."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  'D',
  '[{"label": "A", "content": "Fewer people are commuting."}, {"label": "B", "content": "Gas consumption is soaring."}, {"label": "C", "content": "Job growth is slowing down."}, {"label": "D", "content": "Rush-hour traffic is worsening."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q5',
  'B',
  '[{"label": "A", "content": "He told a stranger the sad story about himself."}, {"label": "B", "content": "He helped a stranger to carry groceries to his car."}, {"label": "C", "content": "He went up to a stranger and pulled at his sleeves."}, {"label": "D", "content": "He washed a stranger’s car in return for some food."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  'C',
  '[{"label": "A", "content": "He ordered a lot of food for his family."}, {"label": "B", "content": "He gave him a job at his own company."}, {"label": "C", "content": "He raised a large sum of money for him."}, {"label": "D", "content": "He offered him a scholarship for college."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  'B',
  '[{"label": "A", "content": "He works hard to support his family."}, {"label": "B", "content": "He is an excellent student at school."}, {"label": "C", "content": "He is very good at making up stories."}, {"label": "D", "content": "He has been disabled since boyhood."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  'A',
  '[{"label": "A", "content": "Attended an economics lecture."}, {"label": "B", "content": "Taken a walk on Charles Street."}, {"label": "C", "content": "Had a drink at Queen Victoria."}, {"label": "D", "content": "Had dinner at a new restaurant."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  'C',
  '[{"label": "A", "content": "Treat a college friend to dinner."}, {"label": "B", "content": "Make preparations for a seminar."}, {"label": "C", "content": "Attend his brother’s birthday party."}, {"label": "D", "content": "Visit some of his high school friends."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  'D',
  '[{"label": "A", "content": "Gather statistics for his lecture."}, {"label": "B", "content": "Throw a surprise birthday party."}, {"label": "C", "content": "Meet with Jonathan’s friends on the weekend."}, {"label": "D", "content": "Join him in his brother’s birthday celebration."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  'B',
  '[{"label": "A", "content": "By car."}, {"label": "B", "content": "By train."}, {"label": "C", "content": "By taxi."}, {"label": "D", "content": "By bus."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  'A',
  '[{"label": "A", "content": "Taking a vacation abroad."}, {"label": "B", "content": "Reviewing for his last exam."}, {"label": "C", "content": "Saving enough money for a rainy day."}, {"label": "D", "content": "Finding a better way to earn money."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  'C',
  '[{"label": "A", "content": "Preparing for his final exams."}, {"label": "B", "content": "Negotiating with his boss for a raise."}, {"label": "C", "content": "Working part time as a waiter."}, {"label": "D", "content": "Helping the woman with her courses."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  'B',
  '[{"label": "A", "content": "Finish her term paper."}, {"label": "B", "content": "Save enough money."}, {"label": "C", "content": "Learn a little bit of Spanish."}, {"label": "D", "content": "Ask her parent’s permission."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  'A',
  '[{"label": "A", "content": "He has rich sailing experience."}, {"label": "B", "content": "He speaks Spanish fluently."}, {"label": "C", "content": "He is also eager to go to Spain."}, {"label": "D", "content": "He is easy to get along with."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  'D',
  '[{"label": "A", "content": "She went to the same university as her mother."}, {"label": "B", "content": "She worked as a nurse in the First World War."}, {"label": "C", "content": "She won the Nobel Prize two times."}, {"label": "D", "content": "She was also a Nobel Prize winner."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  'B',
  '[{"label": "A", "content": "She fought bravely in a series of military operations."}, {"label": "B", "content": "She developed X-ray facilities for military hospitals."}, {"label": "C", "content": "She helped to set up several military hospitals."}, {"label": "D", "content": "She made donations to save wounded soldiers."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  'A',
  '[{"label": "A", "content": "Both died of blood cancer."}, {"label": "B", "content": "Both fought in World War I."}, {"label": "C", "content": "Both won military medals."}, {"label": "D", "content": "Both married their assistants."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  'C',
  '[{"label": "A", "content": "They were the first settlers in Europe."}, {"label": "B", "content": "They were the conquerors of Norway."}, {"label": "C", "content": "They discovered Iceland in the ninth century."}, {"label": "D", "content": "They settled on a small island north of England."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  'D',
  '[{"label": "A", "content": "It was some five hundred miles west of Norway."}, {"label": "B", "content": "It was covered with green most time of the year."}, {"label": "C", "content": "It was the Vikings’ most important discovery."}, {"label": "D", "content": "It was a rocky mass of land covered with ice."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  'A',
  '[{"label": "A", "content": "The Vikings’ ocean explorations."}, {"label": "B", "content": "The making of European nations."}, {"label": "C", "content": "The Vikings’ everyday life."}, {"label": "D", "content": "The Europeans’ Arctic discoveries."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  'C',
  '[{"label": "A", "content": "Work hard for a better life."}, {"label": "B", "content": "Make mistakes now and then."}, {"label": "C", "content": "Dream about the future."}, {"label": "D", "content": "Save against a rainy day."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  'B',
  '[{"label": "A", "content": "Teach foreign languages for the rest of his life."}, {"label": "B", "content": "Change what he has for his past imaginary world."}, {"label": "C", "content": "Exchange his two-story house for a beach cottage."}, {"label": "D", "content": "well on the dreams he had dreamed when young."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  'D',
  '[{"label": "A", "content": "Criminal law."}, {"label": "B", "content": "City planning."}, {"label": "C", "content": "Oriental architecture."}, {"label": "D", "content": "International business."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  'C',
  '[{"label": "A", "content": "Dream and make plans."}, {"label": "B", "content": "Take things easy in life."}, {"label": "C", "content": "Be content with what you have."}, {"label": "D", "content": "Enjoy whatever you are doing. Part Ⅲ"}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. When the author was a college student, she found that knitting helped her concentrate.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Knitting can help people stay away from tobacco.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. Even men and children are now joining the army of knitters.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Being a member of a crafts group enhances one’s health and prolongs one’s life.',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Knitting diverts people’s attention from their pain.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. The author learnt to knit as a teenager, but it was not until she was much older that she became keenly interested.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. When people are knitting, they tend to eat fewer snacks.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Survey findings show that knitting can help people relieve stress.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. According to a study, knitters and crocheters are less likely to suffer mild cognitive damage.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. The products of knitting can increase one’s sense of self-respect.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. When the author was a college student, she found that knitting helped her concentrate.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Knitting can help people stay away from tobacco.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. Even men and children are now joining the army of knitters.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Being a member of a crafts group enhances one’s health and prolongs one’s life.',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Knitting diverts people’s attention from their pain.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. The author learnt to knit as a teenager, but it was not until she was much older that she became keenly interested.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 42);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. When people are knitting, they tend to eat fewer snacks.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 43);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Survey findings show that knitting can help people relieve stress.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 44);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. According to a study, knitters and crocheters are less likely to suffer mild cognitive damage.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 45);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. The products of knitting can increase one’s sense of self-respect.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 46);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '51. It used to be commonly acknowledged that to succeed in America, one had to have  .',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 47);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '52. What is the finding of the latest National Journal poll concerning the American dream?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 48);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. What do Americans now think of the role of college education in achieving success?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 49);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. How do some people view college education these days?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 50);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. What is one factor essential to success in America, according to Will Fendley?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 51);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'It used to be commonly acknowledged that to succeed in America, one had to have  .',
  'A',
  '[{"label": "A", "content": "an advanced academic degree"}, {"label": "B", "content": "an ambition to get ahead"}, {"label": "C", "content": "a firm belief in their dream"}, {"label": "D", "content": "a sense of drive and purpose"}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 52);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is the finding of the latest National Journal poll concerning the American dream?',
  'C',
  '[{"label": "A", "content": "More and more Americans are finding it hard to realize."}, {"label": "B", "content": "It remains alive among the majority of American people."}, {"label": "C", "content": "Americans’ idea of it has changed over the past few decades."}, {"label": "D", "content": "An increasing number of young Americans are abandoning it."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 53);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do Americans now think of the role of college education in achieving success?',
  'C',
  '[{"label": "A", "content": "It still remains open to debate."}, {"label": "B", "content": "It has proved to be beyond doubt."}, {"label": "C", "content": "It is no longer as important as it used to be."}, {"label": "D", "content": "It is much better understood now than ever."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 54);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'How do some people view college education these days?',
  'D',
  '[{"label": "A", "content": "It promotes gender equality."}, {"label": "B", "content": "It needs to be strengthened."}, {"label": "C", "content": "It adds to cultural diversity."}, {"label": "D", "content": "It helps broaden their minds."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 55);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is one factor essential to success in America, according to Will Fendley?',
  'D',
  '[{"label": "A", "content": "desire to learn and to adapt."}, {"label": "B", "content": "A strong sense of responsibility."}, {"label": "C", "content": "A willingness to commit oneself."}, {"label": "D", "content": "A clear aim and high motivation. Part Ⅳ Translation (30 minutes) Directions: For this part, you are allowed 30 minutes to translate a passage from Chinese into English. You should write your answer on Answer Sheet 2. 华山位于华阴市，距西安 120 公里。华山是秦岭的一部分，秦岭不仅分割陕南与陕北，也分隔华南与华北。与从前人们常去朝拜的泰山不同，华山过去很少有人光临，因为上山的道路极其危险。然而，希望长寿的人却经常上 山，因为山上生长着许多草药，特别是一些稀有的药草。自上世纪 90 年代安装缆车以来，参观人数大大增加。 【 参 考 答 案 】 【参考范文】 The relationship between teachers and students has been hotly discussed in recent years in China for more and more attention has been paid to education. Today I would like to share some tips on how to get along well with teachers from students’ perspective. First and foremost, leave a good first impression on your teacher. As the saying goes, well begun is half done. A good first impression is important for teachers to remember your name among your fellow students. Secondly, study hard and be active in class. A student who loves study can definitely impress teachers deeply. Finally, keep contact with your teacher after. To conclude, teacher-student relationship is never complex if you could have an excellent academic performance, be cooperative in class or make friends with your teacher. 【1-5】DCADB 【6-10】CBACD 【11-15】BACBA 【16-20】DBACD 【21-25】ACBDC 【26-30】FALGE 【31-35】BMKON 【36-40】CHDOL 【41-45】BIFLE 【46-50】BBACD 【51-55】ACCDD 【"}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 56);


-- ============================================================
-- [21] 2017年上半年大学英语六级真题（第1套）
-- 题目数: 65
-- 源文件: 四六级历年真题汇总/2017年6月英语四六级/2017年6月英语六级真题及答案/卷一 2017年6月英语六级真题及答案/卷一 2017年6月英语六级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2017, 1, '2017年上半年大学英语六级真题（第1套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
'In this section, you will hear two passages. At the end of each passage, you will hear three or four questions. Both the passage and the questions will be spoken only once. After you hear a question，you must choose the best answer from the four choices marked A), B), C) and D). Then mark the corresponding letter on Answer Sheet 1 with a single line through the centre. Questions9 to 12 are based on the passage you have just heard. 9. A) Marketing strategies. B) Holiday shopping. C) Shopping malls. D) Online stores. 10. A) About 50% of holiday shoppers. B) About 20-30% of holiday shoppers. C) About 136 million. D) About 183.8 million. 11. A) They have fewer customers. B) They find it hard to survive. C) They are thriving once more. D) They appeal to elderly customers. 12. A) Better quality of consumer goods B) Higher employment and wages. C) Greater varieties of commodities. D) People having more leisure time. Questions 13 to 15 are based on the passage you have just heard. 13. A) They are new species of big insects. B) They are over prescribed antibiotics. C) They are life-threatening diseases. D) They are antibiotic-resistant bacteria. 14. A) Antibiotics are now in short supply. B) Many infections are no longer curable. C) Large amounts of tax money are wasted. D) Routine operations have become complex. 15. A) Facilities. B) Expertise. C) Money. D) Publicity. Section C Directions: In this section, you will hear three recordings of lectures or talks followed by three or four questions. The recordings will be played only once. After you hear a question, you must choose the best answer from the four choices marked A), B)，C) and D). Then mark the corresponding letter on Answer Sheet 1 with a single line through the centre. Questions 16 to18 are based on the recording you have just heard. 16. A) It is accessible only to the talented. B) It improves students’ ability to think. C) It starts a lifelong learning process. D) It gives birth to many eminent scholars. ',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  'A',
  '[{"label": "A", "content": "He would feel insulted."}, {"label": "B", "content": "He would feel very sad."}, {"label": "C", "content": "He would be embarrassed."}, {"label": "D", "content": "He would be disappointed."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  'B',
  '[{"label": "A", "content": "They are worthy of a prize."}, {"label": "B", "content": "They are of little value."}, {"label": "C", "content": "They make good reading."}, {"label": "D", "content": "They need improvement."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  'A',
  '[{"label": "A", "content": "He seldom writes a book straight through."}, {"label": "B", "content": "He writes several books simultaneously."}, {"label": "C", "content": "He draws on his real-life experiences."}, {"label": "D", "content": "He often turns to his wife for help."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  'D',
  '[{"label": "A", "content": "Writing a book is just like watching a football match."}, {"label": "B", "content": "Writers actually work every bit as hard as footballers."}, {"label": "C", "content": "He likes watching a football match after finishing a book."}, {"label": "D", "content": "Unlike a football match, there is no end to writing a book."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q5',
  'C',
  '[{"label": "A", "content": "Achievements of black male athletes in college."}, {"label": "B", "content": "Financial assistance to black athletes in college."}, {"label": "C", "content": "High college dropout rates among black athletes."}, {"label": "D", "content": "Undergraduate enrollments of black athletes."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  'D',
  '[{"label": "A", "content": "They display great talent in every kind of game."}, {"label": "B", "content": "They are better at sports than at academic work."}, {"label": "C", "content": "They have difficulty finding money to complete their studies."}, {"label": "D", "content": "They make money for the college but often fail to earn a degree."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  'C',
  '[{"label": "A", "content": "About 15%."}, {"label": "B", "content": "Around 40%."}, {"label": "C", "content": "Slightly over 50%."}, {"label": "D", "content": "Approximately 70%."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  'A',
  '[{"label": "A", "content": "Coaches lack the incentive to graduate them."}, {"label": "B", "content": "College degrees do not count much to them."}, {"label": "C", "content": "They have little interest in academic work."}, {"label": "D", "content": "Schools do not deem it a serious problem."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  'B',
  '[{"label": "A", "content": "Marketing strategies."}, {"label": "B", "content": "Holiday shopping."}, {"label": "C", "content": "Shopping malls."}, {"label": "D", "content": "Online stores."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  'D',
  '[{"label": "A", "content": "About 50% of holiday shoppers."}, {"label": "B", "content": "About 20-30% of holiday shoppers."}, {"label": "C", "content": "About 136 million."}, {"label": "D", "content": "About 183.8 million."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  'C',
  '[{"label": "A", "content": "They have fewer customers."}, {"label": "B", "content": "They find it hard to survive."}, {"label": "C", "content": "They are thriving once more."}, {"label": "D", "content": "They appeal to elderly customers."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  'B',
  '[{"label": "A", "content": "Better quality of consumer goods"}, {"label": "B", "content": "Higher employment and wages."}, {"label": "C", "content": "Greater varieties of commodities."}, {"label": "D", "content": "People having more leisure time."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  'D',
  '[{"label": "A", "content": "They are new species of big insects."}, {"label": "B", "content": "They are over prescribed antibiotics."}, {"label": "C", "content": "They are life-threatening diseases."}, {"label": "D", "content": "They are antibiotic-resistant bacteria."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  'D',
  '[{"label": "A", "content": "Antibiotics are now in short supply."}, {"label": "B", "content": "Many infections are no longer curable."}, {"label": "C", "content": "Large amounts of tax money are wasted."}, {"label": "D", "content": "Routine operations have become complex."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  'A',
  '[{"label": "A", "content": "Facilities."}, {"label": "B", "content": "Expertise."}, {"label": "C", "content": "Money."}, {"label": "D", "content": "Publicity."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  'B',
  '[{"label": "A", "content": "It is accessible only to the talented."}, {"label": "B", "content": "It improves students’ ability to think."}, {"label": "C", "content": "It starts a lifelong learning process."}, {"label": "D", "content": "It gives birth to many eminent scholars."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  'A',
  '[{"label": "A", "content": "They encourage academic democracy."}, {"label": "B", "content": "They promote globalization."}, {"label": "C", "content": "They uphold the presidents\' authority."}, {"label": "D", "content": "They protect students’ rights."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  'A',
  '[{"label": "A", "content": "His thirst for knowledge."}, {"label": "B", "content": "His eagerness to find a job."}, {"label": "C", "content": "His contempt for authority."}, {"label": "D", "content": "His potential for leadership."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  'D',
  '[{"label": "A", "content": "Few people know how to retrieve information properly."}, {"label": "B", "content": "People can enhance their memory with a few tricks."}, {"label": "C", "content": "Most people have a rather poor long-term memory."}, {"label": "D", "content": "People tend to underestimate their mental powers."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  'B',
  '[{"label": "A", "content": "They present the states in a surprisingly different order."}, {"label": "B", "content": "They include more or less the same number of states."}, {"label": "C", "content": "They are exactly the same as is shown in the atlas."}, {"label": "D", "content": "They contain names of the most familiar states."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  'C',
  '[{"label": "A", "content": "Focusing on what is likely to be tested."}, {"label": "B", "content": "Having a good sleep the night before."}, {"label": "C", "content": "Reviewing your lessons where the exam is to lake place."}, {"label": "D", "content": "Making sensible decisions while choosing your answers."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  'A',
  '[{"label": "A", "content": "Discover when you can learn best."}, {"label": "B", "content": "Change your time of study daily."}, {"label": "C", "content": "Give yourself a double bonus afterwards."}, {"label": "D", "content": "Follow the example of a marathon runner."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  'C',
  '[{"label": "A", "content": "He is a politician."}, {"label": "B", "content": "He is a businessman."}, {"label": "C", "content": "He is a sociologist."}, {"label": "D", "content": "He is a economist"}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  'D',
  '[{"label": "A", "content": "In slums."}, {"label": "B", "content": "In Africa."}, {"label": "C", "content": "In pre-industrial societies."}, {"label": "D", "content": "In developing countries."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  'B',
  '[{"label": "A", "content": "They have no access to health care, let alone entertainment or recreation."}, {"label": "B", "content": "Their income is less than 50% of the national average family income."}, {"label": "C", "content": "They work extra hours to have their basic needs met."}, {"label": "D", "content": "Their children cannot afford to go to private schools. Part Ⅲ"}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. A number of factors are driving down the global oil prices not just for now but in the foreseeable  future.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Pricing carbon proves the most economical way to reduce greenhouse gas emissions.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. It is estimated that extreme weather conditions have endangered the lives of millions of African',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. The prices of coal are low as a result of over-supply and decreasing demand.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Higher fossil fuel prices prove to be conducive to innovation and application of cleaner technology.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. If fossil fuel prices remain low for a long time, it may lead to higher emissions of greenhouse gases.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Fossil fuels remain the major source of primary energy consumption in today\'s world.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Even major fossil fuel exporting countries have great potential to develop renewable energies.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Greenhouse gas emissions, if not properly dealt with, will pose endless risks for mankind.',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. It is urgent for governments to increase the cost of using fossil fuels to an appropriate level to lessen the catastrophic effects of climate change.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. A number of factors are driving down the global oil prices not just for now but in the foreseeable  future.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Pricing carbon proves the most economical way to reduce greenhouse gas emissions.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. It is estimated that extreme weather conditions have endangered the lives of millions of African',
  'J',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. The prices of coal are low as a result of over-supply and decreasing demand.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Higher fossil fuel prices prove to be conducive to innovation and application of cleaner technology.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. If fossil fuel prices remain low for a long time, it may lead to higher emissions of greenhouse gases.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 42);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Fossil fuels remain the major source of primary energy consumption in today\'s world.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 43);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Even major fossil fuel exporting countries have great potential to develop renewable energies.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 44);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Greenhouse gas emissions, if not properly dealt with, will pose endless risks for mankind.',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 45);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. It is urgent for governments to increase the cost of using fossil fuels to an appropriate level to lessen the catastrophic effects of climate change.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 46);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. What is the attitude of most researchers towards making their own data public?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 47);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. According to the passage，what might hinder open data sharing?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 48);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. What helps lift some of the barriers to open data sharing?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 49);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. Dryad serves as an example to show how open data sharing_______.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 50);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '51. What does the author say about the shrinking spending of international tourists in the U.S.?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 51);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '52. What does Macy’s believe about its problems?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 52);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. In order to cut costs, Macy’s decided to_______.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 53);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. Why does Macy’s plan to expand Bluemercury in 2016?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 54);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. What can we learn about Macy’s during the holiday season?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 55);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is the attitude of most researchers towards making their own data public?',
  'A',
  '[{"label": "A", "content": "Opposed."}, {"label": "B", "content": "Ambiguous."}, {"label": "C", "content": "Liberal."}, {"label": "D", "content": "Neutral."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 56);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'According to the passage，what might hinder open data sharing?',
  'C',
  '[{"label": "A", "content": "The fear of massive copying."}, {"label": "B", "content": "The lack of a research culture."}, {"label": "C", "content": "The belief that research data is private intellectual property."}, {"label": "D", "content": "The concern that certain agencies may make a profit out of it."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 57);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What helps lift some of the barriers to open data sharing?',
  'C',
  '[{"label": "A", "content": "The ever-growing demand for big data."}, {"label": "B", "content": "The advancement of digital technology."}, {"label": "C", "content": "The changing attitude of journals and funders."}, {"label": "D", "content": "The trend of social and economic development."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 58);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Dryad serves as an example to show how open data sharing_______.',
  'B',
  '[{"label": "A", "content": "is becoming increasingly popular"}, {"label": "B", "content": "benefits sharers and users alike"}, {"label": "C", "content": "makes researchers successful"}, {"label": "D", "content": "saves both money and labor"}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 59);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author say about the shrinking spending of international tourists in the U.S.?',
  'A',
  '[{"label": "A", "content": "It is attributable to the rising value of the U.S. dollar."}, {"label": "B", "content": "It is a direct result of the global economic recession."}, {"label": "C", "content": "It reflects a shift of their interest in consumer goods."}, {"label": "D", "content": "It poses a potential threat to the retail business in the U.S."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 60);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does Macy’s believe about its problems?',
  'B',
  '[{"label": "A", "content": "They can be solved with better management."}, {"label": "B", "content": "They cannot be attributed to weather only."}, {"label": "C", "content": "They are not as serious in its online stores."}, {"label": "D", "content": "They call for increased investments."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 61);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'In order to cut costs, Macy’s decided to_______.',
  'D',
  '[{"label": "A", "content": "cut the salary of senior executives"}, {"label": "B", "content": "relocate some of its chain stores"}, {"label": "C", "content": "adjust its promotion strategies"}, {"label": "D", "content": "reduce the size of its staff"}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 62);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Why does Macy’s plan to expand Bluemercury in 2016?',
  'D',
  '[{"label": "A", "content": "To experiment on its new business concept."}, {"label": "B", "content": "To focus more on beauty products than clothing."}, {"label": "C", "content": "To promote sales of its products by lowering prices."}, {"label": "D", "content": "To be more competitive in sales of beauty products."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 63);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What can we learn about Macy’s during the holiday season?',
  'A',
  '[{"label": "A", "content": "Sales dropped sharply in its physical stores."}, {"label": "B", "content": "Its retail sales exceeded those of T.J. Maxx."}, {"label": "C", "content": "It helped Bluemercury establish its position worldwide."}, {"label": "D", "content": "It filled its stores with abundant supply of merchandise."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 64);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '明朝统治中国276年，被人们描绘成人类历史上治理有序、社会稳定的最伟大的时代之一。 这一时期，手工业的发展促进了市场经济和城市化。大量商品，包括酒和丝绸，都在市场销售。同时，还进口许多外国商品，如时钟和烟草。北京、南京、扬州、苏州这样的大商业中心相继形成。也是在明代，由郑和率领的船队曾到印度洋进行了七次规模探险航行。还值得一提的是，中国文学的四大经典名著中有三部写于明代。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 65);


-- ============================================================
-- [22] 2017年上半年大学英语六级真题（第3套）
-- 题目数: 38
-- 源文件: 四六级历年真题汇总/2017年6月英语四六级/2017年6月英语六级真题及答案/卷三 2017年6月英语六级真题及答案/卷三 2017年6月英语六级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2017, 1, '2017年上半年大学英语六级真题（第3套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Suppose you are asked to give advice on whether to attend college at home or abroad, write an essay to state your opinion. You are required to write at least 150 words but no more than 200 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Elite high school math competitions are attracting more interest throughout the United States.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. Math circles provide students with access to advanced-math training by university professors.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Students may take advantage of online resources to learn to solve math problems.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. The summer program run by a nonprofit organization has helped many under served students learn advanced math.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Winners of local contests will participate in the national math competition for free.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Some intensive summer programs are very expensive but most of them provide scholarships.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Many schools don’t place academic competitions at the top of their priority list.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Contestants of elite high school math competitions are mostly Asian and white students from well-off families.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Some math training programs primarily focus on raising students’ math scores.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Elite high school math competitions are attracting more interest throughout the United States.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. Math circles provide students with access to advanced-math training by university professors.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Students may take advantage of online resources to learn to solve math problems.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. The summer program run by a nonprofit organization has helped many under served students learn advanced math.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Winners of local contests will participate in the national math competition for free.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Many schools don’t place academic competitions at the top of their priority list.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Contestants of elite high school math competitions are mostly Asian and white students from well-off families.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Some math training programs primarily focus on raising students’ math scores.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Some intensive summer programs are very expensive but most of them provide scholarships.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. What do we learn about American designer sportswear?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. What characterized American designer sportswear?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. What occurred in the design of women’s apparel in America during the 1930s-40s?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. What do we learn about designers of American sportswear?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '51. What is the impact of rubbish dumps on wildlife?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '52. What do we learn about birds following the traditional migration routes?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. What does Andrea Flack say about the birds overwintering on rubbish dumps?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. What can be inferred about the Spanish birds tagged in the study?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. What is scientists，other concern about white storks feeding on landfills?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn about American designer sportswear?',
  'D',
  '[{"label": "A", "content": "It imitated the European model."}, {"label": "B", "content": "It laid emphasis on woman’s beauty."}, {"label": "C", "content": "It represented genuine American art."}, {"label": "D", "content": "It was a completely new invention."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What characterized American designer sportswear?',
  'C',
  '[{"label": "A", "content": "Pursuit of beauty."}, {"label": "B", "content": "Decorative closings."}, {"label": "C", "content": "Ease of care."}, {"label": "D", "content": "Fabric quality."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What occurred in the design of women’s apparel in America during the 1930s-40s?',
  'A',
  '[{"label": "A", "content": "A shift of emphasis from beauty to utility."}, {"label": "B", "content": "The emulation of traditional Parisian design."}, {"label": "C", "content": "A search for balance between tradition and novelty."}, {"label": "D", "content": "The involvement of more women in fashion design."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn about designers of American sportswear?',
  'C',
  '[{"label": "A", "content": "They catered to the taste of the younger generation."}, {"label": "B", "content": "They radically changed people’s concept of beauty."}, {"label": "C", "content": "They advocated equity between men and women."}, {"label": "D", "content": "They became rivals of their Parisian counterparts."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is the impact of rubbish dumps on wildlife?',
  'D',
  '[{"label": "A", "content": "They have forced white storks to search for safer winter shelters."}, {"label": "B", "content": "They have seriously polluted the places where birds spend winter."}, {"label": "C", "content": "They have accelerated the reproduction of some harmful insects."}, {"label": "D", "content": "They have changed the previous migration habits of certain birds."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn about birds following the traditional migration routes?',
  'D',
  '[{"label": "A", "content": "They can multiply at an accelerating rate."}, {"label": "B", "content": "They can better pull through the winter."}, {"label": "C", "content": "They help humans kill harmful insects."}, {"label": "D", "content": "They are more likely to be at risk of dying."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does Andrea Flack say about the birds overwintering on rubbish dumps?',
  'B',
  '[{"label": "A", "content": "They may end up staying there permanently."}, {"label": "B", "content": "They may eat something harmful."}, {"label": "C", "content": "They may evolve new feeding habits."}, {"label": "D", "content": "They may have trouble getting adequate food."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What can be inferred about the Spanish birds tagged in the study?',
  'C',
  '[{"label": "A", "content": "They gradually lose the habit of migrating in winter."}, {"label": "B", "content": "They prefer rubbish dumps far away to those at home."}, {"label": "C", "content": "They are not attracted to the rubbish dumps on their migration routes."}, {"label": "D", "content": "They join the storks form Germany on rubbish dumps in Morocco."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is scientists，other concern about white storks feeding on landfills?',
  'A',
  '[{"label": "A", "content": "The potential harm to the ecosystem."}, {"label": "B", "content": "The genetic change in the stork species."}, {"label": "C", "content": "The spread of epidemics to their homeland."}, {"label": "D", "content": "The damaging effect on bio-diversity."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '唐朝始于618年，终于907年，是中国历史上最灿烂的时期。经过近三百年的发展，唐代中国成为世界上最繁荣的强国，其首都长安是当时世界上最大的都市。这一时期，经济发达、商业繁荣、社会秩序稳定，甚至边境也对外开放。随着城市化和财富的增加，艺术和文学也繁荣起来。李白和杜甫是以作品简洁自然而著称的诗人。他们的诗歌打动了学者和普通人的心。即使在今天，他们的许多诗歌仍广为儿童及成人阅读背诵。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 38);


-- ============================================================
-- [23] 2017年上半年大学英语六级真题（第2套）
-- 题目数: 61
-- 源文件: 四六级历年真题汇总/2017年6月英语四六级/2017年6月英语六级真题及答案/卷二 2017年6月英语六级真题及答案/卷二 2017年6月英语六级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2017, 1, '2017年上半年大学英语六级真题（第2套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Suppose you are asked to give advice on whether to major in science or humanities at college，write an essay to state your opinion. You are required to write at least 150 words but no more than 200 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  'C',
  '[{"label": "A", "content": "Doing enjoyable work."}, {"label": "B", "content": "Earning a competitive salary."}, {"label": "C", "content": "Having friendly colleagues."}, {"label": "D", "content": "Working for supportive bosses."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  'A',
  '[{"label": "A", "content": "20%."}, {"label": "B", "content": "25%."}, {"label": "C", "content": "31%."}, {"label": "D", "content": "73%."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  'D',
  '[{"label": "A", "content": "Those full of skilled workers."}, {"label": "B", "content": "Those that are well managed."}, {"label": "C", "content": "Those run by women."}, {"label": "D", "content": "Those of a small size."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  'B',
  '[{"label": "A", "content": "They can win recognition of their work."}, {"label": "B", "content": "They can better balance work and life."}, {"label": "C", "content": "They can hop from job to job easily."}, {"label": "D", "content": "They can take on more than one job."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q5',
  'A',
  '[{"label": "A", "content": "It is a collection of photos."}, {"label": "B", "content": "It is an introduction to music."}, {"label": "C", "content": "It is about the city of Bruges."}, {"label": "D", "content": "It is a book of European history."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  'B',
  '[{"label": "A", "content": "When writing about Belgium’s coastal regions."}, {"label": "B", "content": "When taking pictures for a concert catalogue."}, {"label": "C", "content": "When vacationing in an Italian coastal city."}, {"label": "D", "content": "When painting the concert hall of Bruges."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  'C',
  '[{"label": "A", "content": "The rich heritage of Europe will be lost completely."}, {"label": "B", "content": "The seawater of Europe will be seriously polluted."}, {"label": "C", "content": "The entire European coastline will be submerged."}, {"label": "D", "content": "The major European scenic spots will disappear."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  'A',
  '[{"label": "A", "content": "Tourists use wooden paths to reach their hotels in the morning."}, {"label": "B", "content": "It attracts large numbers of tourists from home and abroad."}, {"label": "C", "content": "People cannot get around without using boats."}, {"label": "D", "content": "Its waterways are being increasingly polluted."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  'B',
  '[{"label": "A", "content": "They try hard to avoid getting off on the wrong foot."}, {"label": "B", "content": "They spend too much time anticipating their defeat."}, {"label": "C", "content": "They take too many irrelevant factors into account."}, {"label": "D", "content": "They make careful preparations beforehand."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  'C',
  '[{"label": "A", "content": "Mental images often interfere with athletes’ performance."}, {"label": "B", "content": "Golfers usually have positive mental images of themselves."}, {"label": "C", "content": "Thinking has the same effect on the nervous system as doing."}, {"label": "D", "content": "A person’s nervous system is more complicated than imagined."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  'D',
  '[{"label": "A", "content": "Anticipate possible problems."}, {"label": "B", "content": "Make a list of do’s and dont’s."}, {"label": "C", "content": "Try to appear more professional."}, {"label": "D", "content": "Picture themselves succeeding."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  'A',
  '[{"label": "A", "content": "She won her first jury trial."}, {"label": "B", "content": "She wore a designer dress."}, {"label": "C", "content": "She presented moving pictures."}, {"label": "D", "content": "She did not speak loud enough."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  'D',
  '[{"label": "A", "content": "It enables patients with diabetes to recover sooner."}, {"label": "B", "content": "Its health benefits have been overestimated."}, {"label": "C", "content": "Its long-term effects are yet to be proved."}, {"label": "D", "content": "It helps people to avoid developing breast cancer."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  'A',
  '[{"label": "A", "content": "It tracked their eating habits since their adolescence."}, {"label": "B", "content": "It focused on their difference from men in fiber intake."}, {"label": "C", "content": "It tracked their change in food preferences for 20 years."}, {"label": "D", "content": "It focused on their ways of life during young adulthood."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  'D',
  '[{"label": "A", "content": "Fiber may bring more benefits to women than men."}, {"label": "B", "content": "Fiber may improve the function of heart muscles."}, {"label": "C", "content": "Fiber may make blood circulation more smooth."}, {"label": "D", "content": "Fiber may help to reduce hormones in the body."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  'C',
  '[{"label": "A", "content": "Investigating the impact of media on government."}, {"label": "B", "content": "Studying the hazards of young people drinking."}, {"label": "C", "content": "Conducting research on consumer behaviour."}, {"label": "D", "content": "Observing the changes in marketing."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  'B',
  '[{"label": "A", "content": "It is a chief concern of parents."}, {"label": "B", "content": "It is an act of socialising."}, {"label": "C", "content": "It is the cause of many street riots."}, {"label": "D", "content": "It is getting worse year by year."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  'B',
  '[{"label": "A", "content": "They researched the impact of mobile phones on young people."}, {"label": "B", "content": "They spent a week studying their own purchasing behaviour."}, {"label": "C", "content": "They conducted a thorough research on advertising."}, {"label": "D", "content": "They analysed their family budgets over the years."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  'A',
  '[{"label": "A", "content": "It is likely to give up paper money in the near future."}, {"label": "B", "content": "It is the first country to use credit cards in the world."}, {"label": "C", "content": "It is trying hard to do away with dirty money."}, {"label": "D", "content": "It is helping its banks to improve efficiency."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  'C',
  '[{"label": "A", "content": "Whether it is possible to travel without carrying any physical currency."}, {"label": "B", "content": "Whether it is possible to predict how much money one is going to spend."}, {"label": "C", "content": "Whether the absence of physical currency is going to affect everyday life."}, {"label": "D", "content": "Whether the absence of physical currency causes a person to spend more."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  'C',
  '[{"label": "A", "content": "The cash in her handbag was missing."}, {"label": "B", "content": "The service on the train was not good."}, {"label": "C", "content": "The restaurant car accepted cash only."}, {"label": "D", "content": "There was no food service on the train."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  'A',
  '[{"label": "A", "content": "By drawing money week by week."}, {"label": "B", "content": "By putting money into envelopes."}, {"label": "C", "content": "By limiting their day-to-day spending."}, {"label": "D", "content": "By refusing to buy anything on credit."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  'C',
  '[{"label": "A", "content": "Population explosion."}, {"label": "B", "content": "Extinction of rare species."}, {"label": "C", "content": "Chronic hunger."}, {"label": "D", "content": "Environmental deterioration."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  'A',
  '[{"label": "A", "content": "About half of them are unintended."}, {"label": "B", "content": "They contribute to overpopulation."}, {"label": "C", "content": "They have been brought under control."}, {"label": "D", "content": "The majority of them tend to end halfway."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  'D',
  '[{"label": "A", "content": "It is beginning to attract postgraduates’ attention."}, {"label": "B", "content": "It is neglected in many of the developing countries."}, {"label": "C", "content": "It is becoming a subject of interdisciplinary research."}, {"label": "D", "content": "It is essential to the well being of all species on earth. Part Ⅲ"}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. While rich parents are more concerned with their children’s psychological well-being, poor parents  are more worried about their children’s safety.',
  'M',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. The increasing differences in child rearing between rich and poor families reflect growing social  inequality.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Parenting approaches of working-class and affluent families both have advantages.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Higher-income families and working-class families now tend to live in different neighborhoods.',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Physical punishment is used much less by well-educated parents.',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Ms. Lareau doesn’t believe participating in fewer after-class activities will negatively affect children’s development.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Wealthy parents are concerned about their children’s mental health and busy schedules.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. Some socioeconomic differences in child rearing have shrunk in the past ten years.',
  'P',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. While rich parents are more concerned with their children’s psychological well-being, poor parents  are more worried about their children’s safety.',
  'M',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. The increasing differences in child rearing between rich and poor families reflect growing social  inequality.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Parenting approaches of working-class and affluent families both have advantages.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Higher-income families and working-class families now tend to live in different neighborhoods.',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Physical punishment is used much less by well-educated parents.',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Ms. Lareau doesn’t believe participating in fewer after-class activities will negatively affect children’s development.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Wealthy parents are concerned about their children’s mental health and busy schedules.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. Some socioeconomic differences in child rearing have shrunk in the past ten years.',
  'P',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 42);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. What does the campus spending analysis reveal?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 43);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. Worker’ supporters argue that Bill Haslam’s proposal would_______.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 44);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. What do we learn from the state spokeswoman’s response to John Morgan’s decision?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 45);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. Why did John Morgan decide to resign?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 46);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '51. What is said about the Grand Tour?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 47);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '52. What did Grand Tourists have in common?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 48);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. How did Grand Tourists benefit from their travel?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 49);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. Why did many Grand Tourists visit the private collections?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 50);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. How did the Grand Tour influence the architecture in England?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 51);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the campus spending analysis reveal?',
  'B',
  '[{"label": "A", "content": "Private companies play a big role in campus management."}, {"label": "B", "content": "Facilities management by colleges is more cost-effective."}, {"label": "C", "content": "Facilities management has greatly improved in recent years."}, {"label": "D", "content": "Colleges exercise full control over their own financial affairs."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 52);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Worker’ supporters argue that Bill Haslam’s proposal would_______.',
  'C',
  '[{"label": "A", "content": "deprive colleges of the right to manage their facilities"}, {"label": "B", "content": "make workers less motivated in performing duties"}, {"label": "C", "content": "render a number of campus workers jobless"}, {"label": "D", "content": "lead to the privatization of campus facilities"}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 53);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn from the state spokeswoman’s response to John Morgan’s decision?',
  'A',
  '[{"label": "A", "content": "The outsourcing plan is not yet finalized."}, {"label": "B", "content": "The outsourcing plan will be implemented."}, {"label": "C", "content": "The state officials are confident about the outsourcing plan."}, {"label": "D", "content": "The college spending analysis justifies the outsourcing plan."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 54);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Why did John Morgan decide to resign?',
  'D',
  '[{"label": "A", "content": "He had lost confidence in the Tennessee state government."}, {"label": "B", "content": "He disagreed with the governor on higher education policies."}, {"label": "C", "content": "He thought the state’s outsourcing proposal was simply unworkable."}, {"label": "D", "content": "He opposed the governor’s plan to reconstruct the college board system."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 55);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is said about the Grand Tour?',
  'B',
  '[{"label": "A", "content": "It was fashionable among young people of the time."}, {"label": "B", "content": "It was unaffordable for ordinary people."}, {"label": "C", "content": "It produced some famous European artists."}, {"label": "D", "content": "It made a compulsory part of college education."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 56);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What did Grand Tourists have in common?',
  'C',
  '[{"label": "A", "content": "They had much geographic knowledge."}, {"label": "B", "content": "They were courageous and venturesome."}, {"label": "C", "content": "They were versed in literature and interested in art."}, {"label": "D", "content": "They had enough travel and outdoor-life experience."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 57);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'How did Grand Tourists benefit from their travel?',
  'D',
  '[{"label": "A", "content": "They found inspiration in the world’s greatest masterpieces."}, {"label": "B", "content": "They got a better understanding of early human civilization."}, {"label": "C", "content": "They developed an interest in the origin of modem art forms."}, {"label": "D", "content": "They gained some knowledge of classical art and architecture."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 58);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Why did many Grand Tourists visit the private collections?',
  'B',
  '[{"label": "A", "content": "They could buy unique souvenirs there to take back home."}, {"label": "B", "content": "Europe hardly had any museums before the 19th century."}, {"label": "C", "content": "They found the antiques there more valuable."}, {"label": "D", "content": "Private collections were of greater variety."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 59);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'How did the Grand Tour influence the architecture in England?',
  'A',
  '[{"label": "A", "content": "There appeared more and more Roman-style buildings."}, {"label": "B", "content": "Many aristocrats began to move into Roman-style villas."}, {"label": "C", "content": "Aristocrats’ country houses all had Roman-style gardens."}, {"label": "D", "content": "Italian architects were hired to design houses and gardens."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 60);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '宋朝始于960年，一直延续到1279年。这一时期，中国经济大幅增长，成为世界上最先进的经济体，科学、技术、哲学和数学蓬勃发展。宋代中国是世界历史上首先发行纸币的国家, 宋朝还最早使用火药并发明了适室（movable-type)印刷。人口增长迅速，越来越多的人住进城市，那里有热闹的娱乐场所, 社会生活多种多样, 人们聚集在一起观看和交易珍贵艺术品。宋朝的政府体制在当时也是先进的, 政府官员均通过竞争性考试选拔作用。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 61);


-- ============================================================
-- [24] 2017年上半年大学英语四级真题（第1套）
-- 题目数: 63
-- 源文件: 四六级历年真题汇总/2017年6月英语四六级/2017年6月英语四级真题及答案/卷一 2017年6月英语四级真题及答案/卷一 2017年6月英语四级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (4, 2017, 1, '2017年上半年大学英语四级真题（第1套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write an advertisement on your campus website to sell a computer you used at college. Your advertisement may include its brand, specifications / features, condition and price, and your contact information.You should write at least 120 words but no more than 180 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  'B',
  '[{"label": "A", "content": "The man in the car was absent-minded."}, {"label": "B", "content": "The test driver made a wrong judgement."}, {"label": "C", "content": "The self-driving system was faulty."}, {"label": "D", "content": "The car was moving at a fast speed."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  'D',
  '[{"label": "A", "content": "They have done better than conventional cars."}, {"label": "B", "content": "They have caused several severe crashes."}, {"label": "C", "content": "They have posed a threat to other drivers."}, {"label": "D", "content": "They have generally done quite well."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  'A',
  '[{"label": "A", "content": "He works at a national park."}, {"label": "B", "content": "He is a queen been specialist."}, {"label": "C", "content": "He removed the beyond from the boot."}, {"label": "D", "content": "He drove the bees away from his car."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  'B',
  '[{"label": "A", "content": "They were looking after the queen."}, {"label": "B", "content": "They were making a lot of noise."}, {"label": "C", "content": "They were looking for a new box to live in."}, {"label": "D", "content": "They were dancing in a unique way."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q5',
  'A',
  '[{"label": "A", "content": "The discovery of a new species of snake."}, {"label": "B", "content": "The second trip to a small remote island."}, {"label": "C", "content": "The finding of 2 new species of frog."}, {"label": "D", "content": "The latest test on rare animal species."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  'C',
  '[{"label": "A", "content": "A poisonous snake attacked him on his field trip."}, {"label": "B", "content": "He discovered a rare fog on a deserted."}, {"label": "C", "content": "A snake crawled onto his head in his sleep."}, {"label": "D", "content": "He fell from a tall palm tree by accident."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  'D',
  '[{"label": "A", "content": "From its genes."}, {"label": "B", "content": "From its length."}, {"label": "C", "content": "From its origin."}, {"label": "D", "content": "From its colour."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  'C',
  '[{"label": "A", "content": "The security check takes time."}, {"label": "B", "content": "He has to check a lot of luggage."}, {"label": "C", "content": "His flight is leaving in less than 2 hours."}, {"label": "D", "content": "The airport is a long way from the hotel."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  'B',
  '[{"label": "A", "content": "In cash."}, {"label": "B", "content": "By credit card."}, {"label": "C", "content": "With a traveler’s check."}, {"label": "D", "content": "With his smart phone."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  'A',
  '[{"label": "A", "content": "Give him a receipt."}, {"label": "B", "content": "Confirm his flight."}, {"label": "C", "content": "Look after his luggage."}, {"label": "D", "content": "Find a porter for him."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  'D',
  '[{"label": "A", "content": "Signing up for membership of S Hotel."}, {"label": "B", "content": "Staying in the same hotel next time he comes."}, {"label": "C", "content": "Loading her luggage onto the airport shuttle."}, {"label": "D", "content": "Posting a comment on the hotel’s webpage."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  'C',
  '[{"label": "A", "content": "He is the only boy in his family."}, {"label": "B", "content": "He becomes tearful in wind."}, {"label": "C", "content": "He has stopped making terrible faces."}, {"label": "D", "content": "He is his teacher\'s favorite student."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  'D',
  '[{"label": "A", "content": "Tell him to play in her backyard."}, {"label": "B", "content": "Do something funny to amuse him."}, {"label": "C", "content": "Give him some cherry stones to play with."}, {"label": "D", "content": "Warn him of danger by making up a story."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  'A',
  '[{"label": "A", "content": "They could break pp\'s legs."}, {"label": "B", "content": "They could sometimes terrify adults."}, {"label": "C", "content": "They could fly against a strong wind."}, {"label": "D", "content": "They could knock pp unconscious."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  'B',
  '[{"label": "A", "content": "One would get a spot on their tongues if they told a lie deliberately."}, {"label": "B", "content": "One would have to shave their head to remove a bat in their hair."}, {"label": "C", "content": "One would go to prison if they put a stamp on upside down."}, {"label": "D", "content": "One would have curly hair if they ate too much stale bread."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  'A',
  '[{"label": "A", "content": "Everything seemed to be changing."}, {"label": "B", "content": "People were formal and disciplined."}, {"label": "C", "content": "People were excited to go travelling overseas."}, {"label": "D", "content": "Things from the Victorian era came back alive."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  'B',
  '[{"label": "A", "content": "Watching TV at home."}, {"label": "B", "content": "Meeting people."}, {"label": "C", "content": "Drinking coffee."}, {"label": "D", "content": "Trying new foods."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  'C',
  '[{"label": "A", "content": "He was interested in stylish dresses."}, {"label": "B", "content": "He was able to take a lot of money."}, {"label": "C", "content": "He was a student in the 1960s."}, {"label": "D", "content": "He was a man full of imagination."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  'A',
  '[{"label": "A", "content": "They avoid looking at them."}, {"label": "B", "content": "They run away immediately."}, {"label": "C", "content": "They show anger on their faces."}, {"label": "D", "content": "They make threatening sounds."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  'D',
  '[{"label": "A", "content": "It turns to its owner for help."}, {"label": "B", "content": "It turns away to avoid conflict."}, {"label": "C", "content": "It looks away and gets angry, too."}, {"label": "D", "content": "It focuses its eyes on their mouths."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  'C',
  '[{"label": "A", "content": "By observing their facial features carefully."}, {"label": "B", "content": "By focusing on a particular body movement."}, {"label": "C", "content": "By taking in their facial expressions as a whole."}, {"label": "D", "content": "By interpreting different emotions in different ways."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  'C',
  '[{"label": "A", "content": "They have to look for food and shelter underground."}, {"label": "B", "content": "They take little notice of the changes in temperature."}, {"label": "C", "content": "They resort to different means to survive the bitter cold."}, {"label": "D", "content": "They have difficulty adapting to the changed environment."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  'B',
  '[{"label": "A", "content": "They have their weight reduced to minimum."}, {"label": "B", "content": "They consume the energy stored before the long sleep."}, {"label": "C", "content": "They can maintain their heart beat at the normal rate."}, {"label": "D", "content": "They can keep their body temperature warm and stable."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  'D',
  '[{"label": "A", "content": "By staying in hiding places and eating very little."}, {"label": "B", "content": "By seeking food and shelter in people’s houses."}, {"label": "C", "content": "By growing thicker hair to stay warm."}, {"label": "D", "content": "By storing enough food beforehand."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  'A',
  '[{"label": "A", "content": "To stay safe."}, {"label": "B", "content": "To save energy."}, {"label": "C", "content": "To keep company."}, {"label": "D", "content": "To protect the young. Part Ⅲ"}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. People with HSAM have the same memory as ordinary people when it comes to impersonal information.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Fantasy proneness will not necessarily cause people to develop HSAM.',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. Veiseh began to remember the details of his everyday experiences after he met his first young love.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Many more people with HSAM started to contact researchers due to the mass media.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. People with HSAM often have to make efforts to avoid focusing on the past.',
  'P',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Most people do not have clear memories of past events.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. HSAM can be both a curse and a blessing.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. A young woman sought explanation from a brain scientist when she noticed her unusual memory.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Some people with HSAM find it very hard to get rid of unpleasant memories.',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. A recent study of people with HSAM reveals that they are liable to fantasy and full absorption in an activity.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. People with HSAM have the same memory as ordinary people when it comes to impersonal information.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Fantasy proneness will not necessarily cause people to develop HSAM.',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. Veiseh began to remember the details of his everyday experiences after he met his first young love.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Many more people with HSAM started to contact researchers due to the mass media.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. People with HSAM often have to make efforts to avoid focusing on the past.',
  'P',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Most people do not have clear memories of past events.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 42);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. HSAM can be both a curse and a blessing.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 43);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. A young woman sought explanation from a brain scientist when she noticed her unusual memory.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 44);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Some people with HSAM find it very hard to get rid of unpleasant memories.',
  'O',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 45);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. A recent study of people with HSAM reveals that they are liable to fantasy and full absorption in an activity.',
  'I',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 46);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. How does Barbara Hagerty view midlife?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 47);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. How is midlife pictured in the book Life Reimagined?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 48);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. According to Karl Barth, midlife is the time_______.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 49);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. What does the author say about midlife today?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 50);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '52. What do we learn about the decorated “eggs” in Russia?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 51);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. Why have contemporary artists continued the egg art tradition?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 52);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. Why does Chast enjoy the process of decorating eggs?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 53);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. What do we learn from the passage about egg-painting?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 54);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'How does Barbara Hagerty view midlife?',
  'B',
  '[{"label": "A", "content": "It may be the beginning of a crisis."}, {"label": "B", "content": "It can be a new phase of one’s life."}, {"label": "C", "content": "It can be terrifying for the unprepared."}, {"label": "D", "content": "It may see old-age diseases approaching."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 55);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'How is midlife pictured in the book Life Reimagined?',
  'A',
  '[{"label": "A", "content": "It can be quite rose."}, {"label": "B", "content": "It can be burdensome."}, {"label": "C", "content": "It undergoes radical transformation."}, {"label": "D", "content": "It makes for the best part of one’s life."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 56);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'According to Karl Barth, midlife is the time_______.',
  'C',
  '[{"label": "A", "content": "to relax."}, {"label": "B", "content": "to mature."}, {"label": "C", "content": "to harvest."}, {"label": "D", "content": "to reflect."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 57);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author say about midlife today?',
  'D',
  '[{"label": "A", "content": "It is more meaningful than other stages of life."}, {"label": "B", "content": "It is likely to change the narrative of one’s life,"}, {"label": "C", "content": "It is more important to those with a longer lifespan."}, {"label": "D", "content": "It is likely to be a critical turning point in one’s life."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 58);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn about the decorated “eggs” in Russia?',
  'D',
  '[{"label": "A", "content": "They are shaped like jewel cases."}, {"label": "B", "content": "They are cherished by the rich."}, {"label": "C", "content": "They are heavily painted in red."}, {"label": "D", "content": "They are favored as a form of art."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 59);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Why have contemporary artists continued the egg art tradition?',
  'C',
  '[{"label": "A", "content": "Eggs serve as an enduring symbol of new life."}, {"label": "B", "content": "Eggs have an oval shape appealing to artists."}, {"label": "C", "content": "Eggs reflect the anxieties of people today."}, {"label": "D", "content": "Eggs provide a unique surface to paint on."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 60);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Why does Chast enjoy the process of decorating eggs?',
  'A',
  '[{"label": "A", "content": "She never knows if the egg will break before the design is completed."}, {"label": "B", "content": "She can add multiple details to the design to communicate her idea."}, {"label": "C", "content": "She always derives great pleasure from designing something new."}, {"label": "D", "content": "She is never sure what the final design will look like until the end."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 61);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn from the passage about egg-painting?',
  'B',
  '[{"label": "A", "content": "It originated in the eastern part of Europe."}, {"label": "B", "content": "It has a history of over two thousand years."}, {"label": "C", "content": "It is the most time-honored form of fancy art."}, {"label": "D", "content": "It is especially favored as a church decoration."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 62);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '在珠江是华南一大河系，流经广州市，是中国第三长的河流，仅次于长江和黄河。珠江三角洲 (delta)是中国最发达的地区之一，面积约11，000平方公里。它在面积和人口方面也是世界上最大的城市聚集区。珠江三角洲九个最大城市共有5700多万人口。上世纪70年代末中国改革开放以来，珠江三角洲已成为中国和世界主要经济区域和制造中心之一。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 63);


-- ============================================================
-- [25] 2017年上半年大学英语四级真题（第3套）
-- 题目数: 40
-- 源文件: 四六级历年真题汇总/2017年6月英语四六级/2017年6月英语四级真题及答案/卷三 2017年6月英语四级真题及答案/卷三 2017年6月英语四级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (4, 2017, 1, '2017年上半年大学英语四级真题（第3套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write an advertisement on your campus website to sell some of the course books you used at college. Your advertisement may include a brief description of their content,their condition ,their price and your contact information. You should write at least 120 words but no more than 180 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Successful team leaders know exactly where the team should go and are able to take prompt action.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Decentralisation of authority was also found to be more effective in military operations.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. In many companies, the conventional form of organisation is giving way to a network of teams.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Members of poorly managed teams are easily distracted from their work.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Teamwork is most effective when team members share the same culture.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. According to a report by Deloitte, teamwork is becoming increasingly popular among companies.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Some team members find it hard to agree on questions like membership and the team’s purpose.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Some scholars think teamwork may not always be reliable, despite its potential to work wonders.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. To ensure employees’ commitment, it is advisable to give them more flexibility as to where and how they work.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. Product transitions take much less time now than in the past.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Successful team leaders know exactly where the team should go and are able to take prompt action.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. Decentralisation of authority was also found to be more effective in military operations.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. In many companies, the conventional form of organisation is giving way to a network of teams.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Members of poorly managed teams are easily distracted from their work.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Teamwork is most effective when team members share the same culture.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. According to a report by Deloitte, teamwork is becoming increasingly popular among companies.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Some team members find it hard to agree on questions like membership and the team’s purpose.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Some scholars think teamwork may not always be reliable, despite its potential to work wonders.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. To ensure employees’ commitment, it is advisable to give them more flexibility as to where and how they work.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. Product transitions take much less time now than in the past.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. What does the author think of the future of the tissue paper market in the UK?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. What does Jack Duckett say about toilet paper?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. What do we learn about Britons concerning toilet paper?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. What can we infer from the last paragraph?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '51. What does Lindson-Hawley say about her mother?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '52. What kind of support did smokers receive to quit smoking in Lindson-Hawley’s study?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. How does Dr. Gabriela Ferreira view the result of Lindson-Hawley’s experiment?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. The idea of “a marathon”（Line 2, Para. 5) illustrates the popular belief that quitting smoking?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. What happens when people try to quit smoking gradually?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author think of the future of the tissue paper market in the UK?',
  'B',
  '[{"label": "A", "content": "It will expend in time."}, {"label": "B", "content": "It will remain gloomy."}, {"label": "C", "content": "It will experience ups and downs."}, {"label": "D", "content": "It will recover as population grows."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does Jack Duckett say about toilet paper?',
  'C',
  '[{"label": "A", "content": "Special offers would promote its sales."}, {"label": "B", "content": "Consumers are loyal to certain brands."}, {"label": "C", "content": "Luxurious features add much to the price."}, {"label": "D", "content": "Consumers have a variety to choose from."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn about Britons concerning toilet paper?',
  'A',
  '[{"label": "A", "content": "They are particular about the quality of toilet paper."}, {"label": "B", "content": "They emphasize the strength of toilet paper the most."}, {"label": "C", "content": "They prefer cheap toilet paper to recycled toilet paper."}, {"label": "D", "content": "They reject using toilet paper with unnecessary features."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What can we infer from the last paragraph?',
  'D',
  '[{"label": "A", "content": "More and more Britons buy recycled toiler paper to protect the environment."}, {"label": "B", "content": "Toilet paper manufacturers are facing a great challenge in promoting its sales."}, {"label": "C", "content": "Toilet paper manufacturers compete with one another to improve product quality."}, {"label": "D", "content": "Environmental protection is not much of a concern when Britons buy toilet paper."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does Lindson-Hawley say about her mother?',
  'B',
  '[{"label": "A", "content": "She quit smoking with her daughter’s help."}, {"label": "B", "content": "She succeeded in quitting smoking abruptly."}, {"label": "C", "content": "She was also a researcher of tobacco and health."}, {"label": "D", "content": "She studied the smoking patterns of adult smokers."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What kind of support did smokers receive to quit smoking in Lindson-Hawley’s study?',
  'D',
  '[{"label": "A", "content": "They were given physical training."}, {"label": "B", "content": "They were looked after by physicians."}, {"label": "C", "content": "They were encouraged by psychologists."}, {"label": "D", "content": "They were offered nicotine replacements."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'How does Dr. Gabriela Ferreira view the result of Lindson-Hawley’s experiment?',
  'C',
  '[{"label": "A", "content": "It is idealized."}, {"label": "B", "content": "It is unexpected."}, {"label": "C", "content": "It is encouraging."}, {"label": "D", "content": "It is misleading."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'The idea of “a marathon”（Line 2, Para. 5) illustrates the popular belief that quitting smoking?',
  'C',
  '[{"label": "A", "content": "is something few can accomplish."}, {"label": "B", "content": "needs some practice first."}, {"label": "C", "content": "requires a lot of patience."}, {"label": "D", "content": "is a challenge at the beginning."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What happens when people try to quit smoking gradually?',
  'A',
  '[{"label": "A", "content": "They find it even more difficult."}, {"label": "B", "content": "They are simply unable to make it."}, {"label": "C", "content": "They show fewer withdrawal symptoms."}, {"label": "D", "content": "They feel much less pain in the process."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '黄河是亚洲第三、世界第六长的河流。“黄”这个字描述的是其河水浑浊的颜色。黄河发源于青海，流经九个省份，最后注入渤海。黄河是中国赖以生存的几条河流之一。黄河流域(river basin)是中国古代文明的诞生地，也是中国早期历史上最繁荣的地区。然而，由于极具破坏力的洪水频发，黄河曾造成多次灾害。在过去几十年里，政府采取了各种措施防止灾害发生。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 40);


-- ============================================================
-- [26] 2017年上半年大学英语四级真题（第2套）
-- 题目数: 67
-- 源文件: 四六级历年真题汇总/2017年6月英语四六级/2017年6月英语四级真题及答案/卷二 2017年6月英语四级真题及答案/卷二 2017年6月英语四级真题及答案.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (4, 2017, 1, '2017年上半年大学英语四级真题（第2套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write an advertisement on your campus website to sell a bicycle you used at college. Your advertisement may include its brand, features,condition and price, and your contact information. You should write at least 120 words but no more than 180 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  'C',
  '[{"label": "A", "content": "The majority of drivers prefer to drive and park themselves."}, {"label": "B", "content": "Human drivers become easily distracted or tired while driving."}, {"label": "C", "content": "Most drivers feel uncertain about the safety of self-driving cars."}, {"label": "D", "content": "Most drivers have test driven cars with automatic braking features."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  'A',
  '[{"label": "A", "content": "Their drivers would feel safe after getting used to the automatic devices."}, {"label": "B", "content": "They would be unpopular with drivers who only trust their own skills."}, {"label": "C", "content": "Their increased comfort levels have boosted their sales."}, {"label": "D", "content": "They are not actually as safe as automakers advertise."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  'C',
  '[{"label": "A", "content": "Thefts of snowmobile dogs in Alaska."}, {"label": "B", "content": "A series of injuries to snowmobile drivers."}, {"label": "C", "content": "Attacks on some Iditarod Race competitors."}, {"label": "D", "content": "A serious accident in the Alaska sports event."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  'B',
  '[{"label": "A", "content": "He stayed behind to look after his injured dogs."}, {"label": "B", "content": "He has won the Alaska Iditarod Race four times."}, {"label": "C", "content": "He received a minor injury in the Iditarod Race."}, {"label": "D", "content": "He has quit the competition in Alaska for good."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q5',
  'D',
  '[{"label": "A", "content": "It sank into the sea due to overloading."}, {"label": "B", "content": "It ran into Nicaragua’s Big Corn Island."}, {"label": "C", "content": "It disappeared between two large islands."}, {"label": "D", "content": "It turned over because of strong winds."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  'D',
  '[{"label": "A", "content": "13."}, {"label": "B", "content": "25."}, {"label": "C", "content": "30."}, {"label": "D", "content": "32."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  'B',
  '[{"label": "A", "content": "He has helped with the rescue effort."}, {"label": "B", "content": "He is being investigated by the police."}, {"label": "C", "content": "He was drowned with the passengers."}, {"label": "D", "content": "He is among those people missing."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  'C',
  '[{"label": "A", "content": "At a shopping centre."}, {"label": "B", "content": "At a community college."}, {"label": "C", "content": "At an accountancy firm."}, {"label": "D", "content": "At an IT company."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  'A',
  '[{"label": "A", "content": "Helping out with data input."}, {"label": "B", "content": "Arranging interviews."}, {"label": "C", "content": "Sorting application forms."}, {"label": "D", "content": "Making phone calls."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  'B',
  '[{"label": "A", "content": "He enjoys using computers."}, {"label": "B", "content": "He needs the money badly."}, {"label": "C", "content": "He wants to work in the city centre."}, {"label": "D", "content": "He has relevant working experience."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  'D',
  '[{"label": "A", "content": "Purchase some business suits."}, {"label": "B", "content": "Learn some computer language."}, {"label": "C", "content": "Improve his programming skills."}, {"label": "D", "content": "Review some accountancy terms."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  'B',
  '[{"label": "A", "content": "They are keen on high technology."}, {"label": "B", "content": "They are poor at technology skills."}, {"label": "C", "content": "They often listen to National Public Radio."}, {"label": "D", "content": "They feel superior in science and technology."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  'A',
  '[{"label": "A", "content": "Japanese."}, {"label": "B", "content": "Germans."}, {"label": "C", "content": "Poles."}, {"label": "D", "content": "Americans."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  'D',
  '[{"label": "A", "content": "Emailing."}, {"label": "B", "content": "Texting."}, {"label": "C", "content": "Science."}, {"label": "D", "content": "Literacy."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  'C',
  '[{"label": "A", "content": "It is undergoing a drastic reform."}, {"label": "B", "content": "It lays emphasis on creative thinking."}, {"label": "C", "content": "It has much room for improvement."}, {"label": "D", "content": "It prioritizes training of practical skills."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  'A',
  '[{"label": "A", "content": "They have small roots."}, {"label": "B", "content": "They grow white flowers."}, {"label": "C", "content": "They taste like apples."}, {"label": "D", "content": "They come from Central Africa."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  'D',
  '[{"label": "A", "content": "They turned from white to purple in color."}, {"label": "B", "content": "They became popular on the world market."}, {"label": "C", "content": "They became an important food for humans."}, {"label": "D", "content": "They began to look like modern-day carrots."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  'B',
  '[{"label": "A", "content": "They were found quite nutritious."}, {"label": "B", "content": "There were serious food shortages."}, {"label": "C", "content": "People discovered their medicinal value."}, {"label": "D", "content": "Farm machines helped lower their prices."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  'A',
  '[{"label": "A", "content": "She could update her family any time she liked."}, {"label": "B", "content": "She could call up her family whenever she liked"}, {"label": "C", "content": "She could locate her friends wherever they were."}, {"label": "D", "content": "She could download as many pictures as she liked."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  'B',
  '[{"label": "A", "content": "She liked to inform her friends about her success."}, {"label": "B", "content": "She enjoyed reading her friends’ status updates."}, {"label": "C", "content": "She felt quite popular among them."}, {"label": "D", "content": "She felt she was a teenager again."}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  'D',
  '[{"label": "A", "content": "She could barely respond to all her 500 Facebook friends."}, {"label": "B", "content": "She spent more time updating her friends than her family."}, {"label": "C", "content": "She could barely balance Facebook updates and her work."}, {"label": "D", "content": "She didn’t seem to be doing as well as her Facebook friends."}]',
  'D',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  'A',
  '[{"label": "A", "content": "They have strong muscles."}, {"label": "B", "content": "They live a longer life than horses."}, {"label": "C", "content": "They eat much less in winter."}, {"label": "D", "content": "They can work longer than donkeys."}]',
  'A',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  'C',
  '[{"label": "A", "content": "It was a pet of a Spanish king."}, {"label": "B", "content": "It was bought by George Washington."}, {"label": "C", "content": "It was brought over from Spain."}, {"label": "D", "content": "It was donated by a U.S. Ambassador."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  'C',
  '[{"label": "A", "content": "They met and exchanged ideas on animal breeding."}, {"label": "B", "content": "They participated in a mule-driving competition."}, {"label": "C", "content": "They showed and traded animals in the market."}, {"label": "D", "content": "They fed mules with the best food they could find."}]',
  'C',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  'B',
  '[{"label": "A", "content": "The wider use of horses."}, {"label": "B", "content": "The arrival of tractors."}, {"label": "C", "content": "A shrinking animal trade."}, {"label": "D", "content": "A growing donkey population. Part Ⅲ"}]',
  'B',
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Readiness to take advantage of new opportunities will make it easier to create one’s desired future.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. By conventional standards, Leah was a typical successful woman before she changed her career.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. Leah gained confidence by laying out her fears and confronting them directly.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. In search of a meaningful life, Leah gave up what she had and set up her own yoga studios.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Leah\'s interest in yoga prompted her to make a firm decision to reshape her life.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Small signs may indicate great changes to come and therefore merit attention.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Leah’s first yoga studio was by no means an immediate success.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Some people regard professional change as an unpleasant experience that disturbs their stable careers.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. The worst fear Leah ever had was the prospect of losing her yoga business.',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. As she explored new interests and developed new potentials，Leah felt powerful internally.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Readiness to take advantage of new opportunities will make it easier to create one’s desired future.',
  'G',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. By conventional standards, Leah was a typical successful woman before she changed her career.',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. Leah gained confidence by laying out her fears and confronting them directly.',
  'L',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. In search of a meaningful life, Leah gave up what she had and set up her own yoga studios.',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Leah\'s interest in yoga prompted her to make a firm decision to reshape her life.',
  'F',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Small signs may indicate great changes to come and therefore merit attention.',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 42);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. Leah’s first yoga studio was by no means an immediate success.',
  'H',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 43);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Some people regard professional change as an unpleasant experience that disturbs their stable careers.',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 44);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. The worst fear Leah ever had was the prospect of losing her yoga business.',
  'K',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 45);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. As she explored new interests and developed new potentials，Leah felt powerful internally.',
  'E',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 46);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '46. According to the new report, real estate development in 2015 will witness_______ .',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 47);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. What characterizes “24-hour cities” like New York?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 48);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. Why are Millennials reluctant to buy a house?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 49);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. What might hinder real estate development in the U.S.?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 50);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. How do most of the respondents in the survey feel about the U.S. real-estate market in 2015?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 51);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '51. What have past behavioural studies found about our brain?',
  'D',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 52);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '52. What is the benefit of forgetting?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 53);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. What is the emphasis of current studies of memory?',
  'B',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 54);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. What do people find about their rare ability to remember every detail of their life?',
  'A',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 55);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. What does the passage say about forgetting?',
  'C',
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 56);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'According to the new report, real estate development in 2015 will witness_______ .',
  'B',
  '[{"label": "A", "content": "an accelerating speed."}, {"label": "B", "content": "a shift to city centers."}, {"label": "C", "content": "a new focus on small cities."}, {"label": "D", "content": "an ever-increasing demand."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 57);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What characterizes “24-hour cities” like New York?',
  'C',
  '[{"label": "A", "content": "People can live without private cars."}, {"label": "B", "content": "People are generally more competitive."}, {"label": "C", "content": "People can enjoy services around the clock."}, {"label": "D", "content": "People are in harmony with the environment."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 58);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Why are Millennials reluctant to buy a house?',
  'C',
  '[{"label": "A", "content": "They can only afford small apartments."}, {"label": "B", "content": "The house prices are currently too high."}, {"label": "C", "content": "Their parents\' bad experience still haunts them."}, {"label": "D", "content": "They feel attached to the suburban environment."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 59);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What might hinder real estate development in the U.S.?',
  'D',
  '[{"label": "A", "content": "The continuing economic recession in the country."}, {"label": "B", "content": "The lack of confidence on the part of investors."}, {"label": "C", "content": "The fierce global competition."}, {"label": "D", "content": "The worsening infrastructure."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 60);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'How do most of the respondents in the survey feel about the U.S. real-estate market in 2015?',
  'B',
  '[{"label": "A", "content": "Pessimistic."}, {"label": "B", "content": "Hopeful."}, {"label": "C", "content": "Cautious."}, {"label": "D", "content": "Uncertain."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 61);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What have past behavioural studies found about our brain?',
  'D',
  '[{"label": "A", "content": "Its capacity actually knows no limits."}, {"label": "B", "content": "It grows sophisticated with practice."}, {"label": "C", "content": "It keeps our most precious memories until life’s end."}, {"label": "D", "content": "New information learned pushes old information out."}]',
  'D',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 62);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is the benefit of forgetting?',
  'C',
  '[{"label": "A", "content": "It frees us from painful memories."}, {"label": "B", "content": "It helps slow down our aging process."}, {"label": "C", "content": "It facilitates our access to relevant information."}, {"label": "D", "content": "It prevents old information from forming associations."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 63);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is the emphasis of current studies of memory?',
  'B',
  '[{"label": "A", "content": "When people tend to forget."}, {"label": "B", "content": "What contributes to forgetting."}, {"label": "C", "content": "How new technology hinders memory capacity."}, {"label": "D", "content": "Why learning and forgetting arc complementary."}]',
  'B',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 64);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do people find about their rare ability to remember every detail of their life?',
  'A',
  '[{"label": "A", "content": "It adds to the burden of their memory."}, {"label": "B", "content": "It makes their life more complicated."}, {"label": "C", "content": "It contributes to their success in life."}, {"label": "D", "content": "It constitutes a rare object of envy."}]',
  'A',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 65);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the passage say about forgetting?',
  'C',
  '[{"label": "A", "content": "It can enlarge our brain capacity."}, {"label": "B", "content": "It helps get rid of negative memories."}, {"label": "C", "content": "It is a way of organising our memories."}, {"label": "D", "content": "It should not cause any alarm in any way."}]',
  'C',
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 66);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '长江是亚洲最长、世界上第三长的河流。长江流经多种不同的生态系统，是诸多濒危物种的栖 息地，灌溉了中国五分之一的土地。长江流域(river basin )居住着三分之一的人口。长江在中国历史、文化和经济上起着很大的作用。长江三角洲(delta)产出多达20%的中国国民生产总值。几千年来，长江一直被用于供水、运输和工业生产。长江上还坐落着世界最大的水电站。 【 参 考 答 案 】 【参考范文】 【翻译参考译文】',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 67);


-- ============================================================
-- [27] 2023年上半年大学英语四级真题（第1套）
-- 题目数: 67
-- 源文件: 四六级历年真题汇总/2023年03月英语四六级【新】/2023年03月CET4题+解+听力/02、真题word版/2023.03英语四级真题第1套.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (4, 2023, 1, '2023年上半年大学英语四级真题（第1套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Suppose you have read a book recently and intend to recommend it to other members of your book club via an online forum. Briefly introduce the book and explain why it is worth reading. You will have 30 minutes for this task and should write at least 120 words but no more than 180 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  NULL,
  '[{"label": "A", "content": "A proposed policy allowing Africans to travel in Africa without a visa."}, {"label": "B", "content": "An agreement among 13 African countries to set up a free-trade zone."}, {"label": "C", "content": "A plan to invite all African countries to join the African Union."}, {"label": "D", "content": "An important initiative to permit tourists to visit Africa without a visa."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  NULL,
  '[{"label": "A", "content": "It will attract more investments from all over the world."}, {"label": "B", "content": "It will help many African countries reduce trade deficits."}, {"label": "C", "content": "It will reduce the cost of trade between African countries."}, {"label": "D", "content": "It will allow Africans to play a bigger role in world trade."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  NULL,
  '[{"label": "A", "content": "Cooling down volcanic rock with sea water."}, {"label": "B", "content": "Storing carbon dioxide underground as a gas."}, {"label": "C", "content": "Capturing carbon dioxide and burying it under the sea."}, {"label": "D", "content": "Pumping carbon dioxide underground to form stone."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  NULL,
  '[{"label": "A", "content": "Lack of burying ground."}, {"label": "C", "content": "High consumption of water."}, {"label": "B", "content": "Long time for processing."}, {"label": "D", "content": "Enormous cost of energy."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q5',
  NULL,
  '[{"label": "A", "content": "It varies with the seasons."}, {"label": "C", "content": "It has caused nationwide concern."}, {"label": "B", "content": "It has been on the decline."}, {"label": "D", "content": "It is ninety grams daily on average."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  NULL,
  '[{"label": "A", "content": "They emphasize food variety."}, {"label": "C", "content": "They do more cooking than men."}, {"label": "B", "content": "They prefer French stick loaves."}, {"label": "D", "content": "They favor diets lower in calories."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  NULL,
  '[{"label": "A", "content": "They bake more bread at home."}, {"label": "C", "content": "They eat more fruit than they used to."}, {"label": "B", "content": "They spend less time eating breakfast."}, {"label": "D", "content": "They put jam instead of butter on bread."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  NULL,
  '[{"label": "A", "content": "After the rush hour."}, {"label": "C", "content": "As soon as possible."}, {"label": "B", "content": "Early in the morning."}, {"label": "D", "content": "Around lunch time."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  NULL,
  '[{"label": "A", "content": "Two first class seats."}, {"label": "C", "content": "One window seat."}, {"label": "B", "content": "Two seats together."}, {"label": "D", "content": "One seat near the exit."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  NULL,
  '[{"label": "A", "content": "In the middle of the platform."}, {"label": "B", "content": "At the far end of the platform."}, {"label": "C", "content": "Behind the yellow line."}, {"label": "D", "content": "In the waiting room."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  NULL,
  '[{"label": "A", "content": "Wait in a queue for his turn."}, {"label": "C", "content": "Pay an extra fee for the service."}, {"label": "B", "content": "Go to the baggage claim area."}, {"label": "D", "content": "Give the ticket to the train guard."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  NULL,
  '[{"label": "A", "content": "Almost all of them were operating at a deficit."}, {"label": "B", "content": "They have all been turned into movie theatres."}, {"label": "C", "content": "Nearly all of them closed down decades ago."}, {"label": "D", "content": "They have adapted to meet fashion changes."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  NULL,
  '[{"label": "A", "content": "It shows foreign movies exclusively."}, {"label": "C", "content": "It is the oldest theatre in London."}, {"label": "B", "content": "It shows movies from the 1950s."}, {"label": "D", "content": "It is located next to a hat factory."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  NULL,
  '[{"label": "A", "content": "They wear hats on social occasions."}, {"label": "C", "content": "They enjoy watching foreign movies."}, {"label": "B", "content": "They don\'t speak foreign languages."}, {"label": "D", "content": "They don\'t go to movie theatres often."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  NULL,
  '[{"label": "A", "content": "They are meant mostly for immigrants."}, {"label": "B", "content": "They attract large crowds of young Londoners."}, {"label": "C", "content": "They are hard for English people to appreciate."}, {"label": "D", "content": "They have an English translation on the screen."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  NULL,
  '[{"label": "A", "content": "She doesn\'t think smartphones can replace tablets."}, {"label": "B", "content": "She incorporates smartphones into her teaching."}, {"label": "C", "content": "She cannot stop children using smartphones."}, {"label": "D", "content": "She regards smartphones as a distraction."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  NULL,
  '[{"label": "A", "content": "To enforce school discipline."}, {"label": "C", "content": "To help children grow up to be professionals."}, {"label": "B", "content": "To make students concentrate."}, {"label": "D", "content": "To cultivate children\'s good study habits."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  NULL,
  '[{"label": "A", "content": "Use books and pens only."}, {"label": "C", "content": "Make full use of electronic devices."}, {"label": "B", "content": "Cut down their screen time."}, {"label": "D", "content": "Learn to use the internet for research."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  NULL,
  '[{"label": "A", "content": "By cleaning the kitchen floor."}, {"label": "C", "content": "By helping her mother do the dishes."}, {"label": "B", "content": "By looking after her baby brother."}, {"label": "D", "content": "By helping her brother wash windows."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  NULL,
  '[{"label": "A", "content": "She ordered a large number of dolls."}, {"label": "B", "content": "She checked if a purple doll was ordered."}, {"label": "C", "content": "She mistakenly canceled her mom\'s order."}, {"label": "D", "content": "She ordered a more expensive doll instead."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  NULL,
  '[{"label": "A", "content": "They asked the children\'s hospital to pick them."}, {"label": "B", "content": "They took all of them to the children\'s hospital."}, {"label": "C", "content": "They opened all of them one by one."}, {"label": "D", "content": "They discussed where to keep them."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  NULL,
  '[{"label": "A", "content": "The time one starts school."}, {"label": "C", "content": "The school that one attends."}, {"label": "B", "content": "The classroom atmosphere."}, {"label": "D", "content": "The relationship with classmates."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  NULL,
  '[{"label": "A", "content": "To help parents decide when to send their children to school."}, {"label": "B", "content": "To find causes for differences in the participants\' performance."}, {"label": "C", "content": "To identify students having potential to be professional athletes."}, {"label": "D", "content": "To offer constructive suggestions for making educational policies."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  NULL,
  '[{"label": "A", "content": "Political leaders."}, {"label": "C", "content": "Professional athletes."}, {"label": "B", "content": "Financial analysts."}, {"label": "D", "content": "High-school students."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  NULL,
  '[{"label": "A", "content": "Leadership ability."}, {"label": "C", "content": "Risk-taking."}, {"label": "B", "content": "Commitment to work."}, {"label": "D", "content": "Self-confidence."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Many people today still find name hyphenation upon marriage unacceptable.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. As a compromise, a bride will in most cases adopt a name that combines the couple\'s last names.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. The bride should consider adopting her groom\'s last name whether he feels strongly about it or not.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Making preparations for marriage causes a lot of stress.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Hyphenating the last names could be a win-win solution should arguments arise about what name to adopt upon marriage.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. It used to be considered socially unacceptable for a bride to retain her maiden name.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. The bride who adopts a hyphenated last name after marriage can maintain connections with their past achievements.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Hyphenating names allows the bride to preserve her own identity while respecting tradition.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. No matter what name the bride adopts, it is most important that the newly weds truly love each other.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. Legally speaking, the bride is free to choose whatever name she prefers.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. Many people today still find name hyphenation upon marriage unacceptable.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. As a compromise, a bride will in most cases adopt a name that combines the couple\'s last names.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. The bride should consider adopting her groom\'s last name whether he feels strongly about it or not.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. Making preparations for marriage causes a lot of stress.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. Hyphenating the last names could be a win-win solution should arguments arise about what name to adopt upon marriage.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. It used to be considered socially unacceptable for a bride to retain her maiden name.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 42);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. The bride who adopts a hyphenated last name after marriage can maintain connections with their past achievements.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 43);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. Hyphenating names allows the bride to preserve her own identity while respecting tradition.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 44);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. No matter what name the bride adopts, it is most important that the newly weds truly love each other.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 45);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. Legally speaking, the bride is free to choose whatever name she prefers.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 46);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '46. What do we learn from the passage about the brightest people?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 47);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. What accounts for the existence of intelligent people\'s logical blind spots?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 48);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. How do smart people react when they are found to be wrong?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 49);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. What may happen to smart people who find it difficult to accept suggestions?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 50);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. What is said about those working with or under overachieving people?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 51);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '51. Why is the U.S. State Department launching an online learning program for refugees?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 52);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '52. What do we know about "Coursera for Refugees"?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 53);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. What does the passage say is a consequence of the global migrant crisis?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 54);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. What does the author say causes refugees\' difficulty in taking online courses?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 55);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. What did the joint study find about the MOOCs several years ago?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 56);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn from the passage about the brightest people?',
  NULL,
  '[{"label": "A", "content": "They can make silly mistakes in straightforward situations."}, {"label": "B", "content": "They usually turn a blind eye to their own weaknesses."}, {"label": "C", "content": "They are admired by people around them."}, {"label": "D", "content": "They can differ in their personalities."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 57);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What accounts for the existence of intelligent people\'s logical blind spots?',
  NULL,
  '[{"label": "A", "content": "Their irrational way of thinking."}, {"label": "C", "content": "Their ignorance of behavioural science."}, {"label": "B", "content": "Too much faith in their ability to think."}, {"label": "D", "content": "Too much concern about their work."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 58);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'How do smart people react when they are found to be wrong?',
  NULL,
  '[{"label": "A", "content": "They shift the blame to others."}, {"label": "C", "content": "They may feel shocked."}, {"label": "B", "content": "They graciously accept the facts."}, {"label": "D", "content": "They may get offended."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 59);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What may happen to smart people who find it difficult to accept suggestions?',
  NULL,
  '[{"label": "A", "content": "They may suffer in their professional and private life."}, {"label": "B", "content": "They may lose faith in their administrative abilities."}, {"label": "C", "content": "They may commit more errors than ever before."}, {"label": "D", "content": "They may experience a lot of emotional stress."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 60);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What is said about those working with or under overachieving people?',
  NULL,
  '[{"label": "A", "content": "They put a lot of effort into their work."}, {"label": "C", "content": "They are under increasing pressure."}, {"label": "B", "content": "They set higher goals for themselves."}, {"label": "D", "content": "They take less time to get things done."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 61);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Why is the U.S. State Department launching an online learning program for refugees?',
  NULL,
  '[{"label": "A", "content": "To enable them to settle down in host countries."}, {"label": "B", "content": "To allow them to learn as many job skills as possible."}, {"label": "C", "content": "To offer them a platform to pursue advanced degrees."}, {"label": "D", "content": "To help them to meet new employment standards."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 62);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we know about "Coursera for Refugees"?',
  NULL,
  '[{"label": "A", "content": "It provides refugees with a wide range of courses free of charge."}, {"label": "B", "content": "It offers free online data services for refugees around the world."}, {"label": "C", "content": "It allows refugees to obtain degrees in various academic fields."}, {"label": "D", "content": "It supplies refugees with a great variety of job opportunities."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 63);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the passage say is a consequence of the global migrant crisis?',
  NULL,
  '[{"label": "A", "content": "Instability increases in host countries."}, {"label": "C", "content": "A lot more refugees die during migration."}, {"label": "B", "content": "The global economic crisis intensifies."}, {"label": "D", "content": "Refugees find it more difficult to get a job."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 64);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the author say causes refugees\' difficulty in taking online courses?',
  NULL,
  '[{"label": "A", "content": "Cultural environment."}, {"label": "C", "content": "Lack of language skills."}, {"label": "B", "content": "Changed academic requirements."}, {"label": "D", "content": "Difference in teaching platforms."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 65);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What did the joint study find about the MOOCs several years ago?',
  NULL,
  '[{"label": "A", "content": "They helped solve learners\' financial problems."}, {"label": "B", "content": "They benefited most of the learners."}, {"label": "C", "content": "They changed some learners\' career path."}, {"label": "D", "content": "They provided the most needed vocational skills."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 66);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '近年来,越来越多的年轻人喜爱各种形式的自助旅游。许多自助旅游者选择徒步或骑自行车出游。他们自己设计路线,自带帐篷、厨具以及其他必备的生活用品。在旅途中,自助旅游者经常能够发现一些新的美丽景点,但有时也会遇见意想不到的困难或突发事件。游客在旅行中拥抱自然、欣赏美景,同时也增强了自己克服困难的勇气和野外生存的能力。',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 67);


-- ============================================================
-- [28] 2023年上半年大学英语四级真题（第2套）
-- 题目数: 2
-- 源文件: 四六级历年真题汇总/2023年03月英语四六级【新】/2023年03月CET4题+解+听力/02、真题word版/2023.03英语四级真题第2套.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (4, 2023, 1, '2023年上半年大学英语四级真题（第2套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Suppose you have attended a lecture delivered by a famous scholar. Write a report to the campus newspaper, summarizing its most important points. You will have 30 minutes for this task and should write at least 120 words but no more than 180 words. Part IV Translation (30 minutes) Directions: For this part, you are allowed 30 minutes to translate a passage from Chinese into English. You should write your answer on Answer Sheet 2. 随着生活水平的提高，更多人开始加入到自驾游的行列之中。自驾游者既可驾驶自家车也可借车或租车出游。司机可能是车主或结伴出游者。自驾游与传统的组团旅游不同,它能够更好地满足旅游者的个性化需求，使他们更好地享受旅游的过程。自驾游尤其受到年轻出游者的欢迎。年轻人追求独立自由的生活,而自驾游恰好满足了他们的这一需求。',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '随着生活水平的提高，更多人开始加入到自驾游的行列之中。自驾游者既可驾驶自家车也可借车或租车出游。司机可能是车主或结伴出游者。自驾游与传统的组团旅游不同,它能够更好地满足旅游者的个性化需求，使他们更好地享受旅游的过程。自驾游尤其受到年轻出游者的欢迎。年轻人追求独立自由的生活,而自驾游恰好满足了他们的这一需求。',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 2);


-- ============================================================
-- [29] 2023年上半年大学英语四级真题（第3套）
-- 题目数: 2
-- 源文件: 四六级历年真题汇总/2023年03月英语四六级【新】/2023年03月CET4题+解+听力/02、真题word版/2023.03英语四级真题第3套.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (4, 2023, 1, '2023年上半年大学英语四级真题（第3套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Suppose you have taken part in a career planning seminar. Write an account of the seminar and summarize what you have learned from it. You will have 30 minutes for this task and should write at least 120 words but no more than 180 words. Part IV Translation (30 minutes) Directions: For this part, you are allowed 30 minutes to translate a passage from Chinese into English. You should write your answer on Answer Sheet 2. 近年来，越来越多的城市居民为农村的田园风光所吸引,利用节假日到乡村旅游。他们住在农民家中,品尝具有当地风味的农家饭菜。有些游客还参与采摘瓜果等活动,亲身感受收获的喜悦。乡村旅游能够有效地帮助游客舒缓压力,放松心情,增进身心健康。实际上,这种旅游形式不仅能使城市游客受益,同时也能增加农民的收入,促进农村经济发展。',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '近年来，越来越多的城市居民为农村的田园风光所吸引,利用节假日到乡村旅游。他们住在农民家中,品尝具有当地风味的农家饭菜。有些游客还参与采摘瓜果等活动,亲身感受收获的喜悦。乡村旅游能够有效地帮助游客舒缓压力,放松心情,增进身心健康。实际上,这种旅游形式不仅能使城市游客受益,同时也能增加农民的收入,促进农村经济发展。',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 2);


-- ============================================================
-- [30] 2023年上半年大学英语六级真题（第1套）
-- 题目数: 67
-- 源文件: 四六级历年真题汇总/2023年03月英语四六级【新】/2023年3月CET6真题+解析+听力/02、真题word版/2023.03英语六级真题第1套.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2023, 1, '2023年上半年大学英语六级真题（第1套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write an essay that begins with the sentence "People are now increasingly aware of the danger of \'appearance anxiety\' or being obsessed with one\'s looks." You can make comments, cite examples or use your personal experiences to develop your essay. You should write at least 150 words but no more than 200 words.',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q1',
  NULL,
  '[{"label": "A", "content": "In a restaurant."}, {"label": "C", "content": "In a food store."}, {"label": "B", "content": "In a kitchen."}, {"label": "D", "content": "In a supermarket."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 2);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q2',
  NULL,
  '[{"label": "A", "content": "She eats meat occasionally."}, {"label": "C", "content": "She is allergic to seafood."}, {"label": "B", "content": "She enjoys cheeseburgers."}, {"label": "D", "content": "She is a partial vegetarian."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 3);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q3',
  NULL,
  '[{"label": "A", "content": "Dealing with one\'s colleagues."}, {"label": "C", "content": "Following the same diet for years."}, {"label": "B", "content": "Changing one\'s eating habit."}, {"label": "D", "content": "Keeping awake at morning meetings."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 4);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q4',
  NULL,
  '[{"label": "A", "content": "They enjoy perfect health."}, {"label": "C", "content": "They only eat organic food."}, {"label": "B", "content": "They are both animal lovers."}, {"label": "D", "content": "They are cutting back on coffee."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 5);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q5',
  NULL,
  '[{"label": "A", "content": "The man got a poor evaluation from his colleagues."}, {"label": "B", "content": "The man made little contribution to the company."}, {"label": "C", "content": "The man paid attention to trivial things."}, {"label": "D", "content": "The man had an attitude problem."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 6);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q6',
  NULL,
  '[{"label": "A", "content": "They make unhelpful decisions for solving problems."}, {"label": "B", "content": "They favor some employees\' suggestions over others\'."}, {"label": "C", "content": "They use manipulative language to mask their irrational choices."}, {"label": "D", "content": "They reject employees\' reasonable arguments for work efficiency."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 7);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q7',
  NULL,
  '[{"label": "A", "content": "It is a must for rational judgment."}, {"label": "C", "content": "It is a good quality in the workplace."}, {"label": "B", "content": "It is more of a sin than a virtue."}, {"label": "D", "content": "It is more important now than ever."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'news', 8);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q8',
  NULL,
  '[{"label": "A", "content": "Smoothing relationships in the workplace."}, {"label": "B", "content": "Making rational and productive decisions."}, {"label": "C", "content": "Focusing on employees\' career growth."}, {"label": "D", "content": "Preserving their power and prestige."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 9);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q9',
  NULL,
  '[{"label": "A", "content": "They show genius which defies description."}, {"label": "C", "content": "They create very high commercial value."}, {"label": "B", "content": "They accomplish feats many of us cannot."}, {"label": "D", "content": "They bring great honor to their country."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 10);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q10',
  NULL,
  '[{"label": "A", "content": "They take part in kids\' extra-curricular activities."}, {"label": "B", "content": "They work in spare time to teach children sports."}, {"label": "C", "content": "They try to be positive role models to children."}, {"label": "D", "content": "They serve as spokespersons for luxury goods."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 11);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q11',
  NULL,
  '[{"label": "A", "content": "Separating an athlete\'s professional life from their personal life."}, {"label": "B", "content": "Preventing certain athletes from getting in trouble with the law."}, {"label": "C", "content": "Keeping athletes away from drug or alcohol problems."}, {"label": "D", "content": "Being super sports stars without appearing arrogant."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 12);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q12',
  NULL,
  '[{"label": "A", "content": "They always cost more than expected."}, {"label": "C", "content": "They should be paid up by the attendees."}, {"label": "B", "content": "They are joyous and exciting occasions."}, {"label": "D", "content": "They are dreams coming true to the brides."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 13);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q13',
  NULL,
  '[{"label": "A", "content": "It cost $60,000."}, {"label": "C", "content": "It had eight guests only."}, {"label": "B", "content": "It was cancelled."}, {"label": "D", "content": "It was held in Las Vegas."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 14);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q14',
  NULL,
  '[{"label": "A", "content": "Postpone her wedding."}, {"label": "C", "content": "Keep to her budget."}, {"label": "B", "content": "Ask her friends for help."}, {"label": "D", "content": "Invite more guests."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 15);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q15',
  NULL,
  '[{"label": "A", "content": "She called it romantic."}, {"label": "C", "content": "She said she would think about it."}, {"label": "B", "content": "She welcomed it with open arms."}, {"label": "D", "content": "She rejected it flatly."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'conversation', 16);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q16',
  NULL,
  '[{"label": "A", "content": "It determines people\'s moods."}, {"label": "C", "content": "It is closely related to people\'s emotions."}, {"label": "B", "content": "It can impact people\'s wellbeing."}, {"label": "D", "content": "It can influence people\'s personalities."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 17);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q17',
  NULL,
  '[{"label": "A", "content": "They make people more reproductive."}, {"label": "C", "content": "They tend to produce positive feelings."}, {"label": "B", "content": "They increase people\'s life expectancy."}, {"label": "D", "content": "They may alter people\'s genes gradually."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 18);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q18',
  NULL,
  '[{"label": "A", "content": "The link between temperature and personality is fairly weak."}, {"label": "B", "content": "People share many personality traits despite their nationalities."}, {"label": "C", "content": "People in the same geographical area may differ in personality."}, {"label": "D", "content": "The Americans are apparently more outgoing than the Chinese."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 19);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q19',
  NULL,
  '[{"label": "A", "content": "The number of older Americans living alone is on the rise."}, {"label": "B", "content": "Chronic loneliness does harm to senior citizens in particular."}, {"label": "C", "content": "Correlations have been found between loneliness and ill health."}, {"label": "D", "content": "A growing number of US seniors face the risk of early mortality."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 20);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q20',
  NULL,
  '[{"label": "A", "content": "Medication is available for treating loneliness."}, {"label": "C", "content": "Being busy helps fight loneliness."}, {"label": "B", "content": "Loneliness rarely results from living alone."}, {"label": "D", "content": "Loneliness is probably reversible."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 21);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q21',
  NULL,
  '[{"label": "A", "content": "Living with one\'s children."}, {"label": "C", "content": "Meaningful social contact."}, {"label": "B", "content": "Meeting social expectations."}, {"label": "D", "content": "Timely medical intervention."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 22);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q22',
  NULL,
  '[{"label": "A", "content": "She had a successful career in finance."}, {"label": "C", "content": "She made regular trips to Asian countries."}, {"label": "B", "content": "She wrote stories about women travelers."}, {"label": "D", "content": "She invested in several private companies."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 23);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q23',
  NULL,
  '[{"label": "A", "content": "Buy a ranch."}, {"label": "C", "content": "Travel round the world."}, {"label": "B", "content": "Start a blog."}, {"label": "D", "content": "Set up a travel agency."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 24);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q24',
  NULL,
  '[{"label": "A", "content": "Work hard to attract attention from publishers."}, {"label": "C", "content": "Try to find a full-time job in the travel business."}, {"label": "B", "content": "Gain support from travel advertising companies."}, {"label": "D", "content": "Create something unique to enter the industry."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 25);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'Q25',
  NULL,
  '[{"label": "A", "content": "Attracting sufficient investment."}, {"label": "C", "content": "Avoiding too much advertising early on."}, {"label": "B", "content": "Creating an exotic corporate culture."}, {"label": "D", "content": "Refraining from promoting similar products."}]',
  NULL,
  'listening', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'listening', 'passage', 26);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. The higher rate of employment, combined with limited housing supply, did not make it any easier to buy a house.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 27);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. One way to deal with the housing crisis is for the government to simplify approval procedures for housing projects.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 28);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. Residents of the San Francisco Bay Area strongly resent the tech industry because of the economic inequality it has contributed to.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 29);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. The fast rise in the prices of land and houses increases the economic inequality among people.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 30);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. San Francisco city government offered tax benefits to attract tech companies to establish operations in a less developed area.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 31);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Innovative solutions to social and economic problems should be introduced before it is too late.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 32);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. When people compare their own living standard with others\', it has a greater impact on their sense of contentment.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 33);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. San Francisco has been found to have the biggest income gap in California between the rich and the poor.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 34);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Improved transport networks connecting the city to distant outlying areas will also help solve the housing crisis.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 35);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. Average incomes in the Bay Area make it virtually impossible for most tenant families to buy a home.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'cloze', 36);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '36. The higher rate of employment, combined with limited housing supply, did not make it any easier to buy a house.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 37);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '37. One way to deal with the housing crisis is for the government to simplify approval procedures for housing projects.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 38);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '38. Residents of the San Francisco Bay Area strongly resent the tech industry because of the economic inequality it has contributed to.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 39);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '39. The fast rise in the prices of land and houses increases the economic inequality among people.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 40);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '40. San Francisco city government offered tax benefits to attract tech companies to establish operations in a less developed area.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 41);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '41. Innovative solutions to social and economic problems should be introduced before it is too late.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 42);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '42. When people compare their own living standard with others\', it has a greater impact on their sense of contentment.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 43);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '43. San Francisco has been found to have the biggest income gap in California between the rich and the poor.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 44);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '44. Improved transport networks connecting the city to distant outlying areas will also help solve the housing crisis.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 45);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '45. Average incomes in the Bay Area make it virtually impossible for most tenant families to buy a home.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 46);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '46. In what way were humans thought to be unique?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 47);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '47. What do we learn from the study published in Science?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 48);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '48. What did the researchers discover about most ducklings from their experiment?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 49);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '49. What was novel about the experiment in the study reported in Science?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 50);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '50. What do we learn from Dr. Wasserman\'s comment on the study of animal minds at the end of the passage?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 51);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '51. What has been a standard piece of dietary advice for decades?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 52);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '52. What did the new research by the American Heart Association find?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 53);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '53. What could help to explain the contradiction between the new findings and the common public health.',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 54);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '54. What did Dr. Rao find after 20 years of research on obesity?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 55);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '55. What does the passage say about people who eat a great variety of food?',
  NULL,
  NULL, NULL, 'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'matching', 56);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'In what way were humans thought to be unique?',
  NULL,
  '[{"label": "A", "content": "Being a major source of animal intelligence."}, {"label": "C", "content": "Being capable of same-different discrimination."}, {"label": "B", "content": "Being the cornerstone of the creative world."}, {"label": "D", "content": "Being able to distinguish abstract from concrete."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 57);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn from the study published in Science?',
  NULL,
  '[{"label": "A", "content": "Our understanding of the bird world was biased."}, {"label": "B", "content": "Our conception of birds\' intelligence was wrong."}, {"label": "C", "content": "Our communication with birds was far from adequate."}, {"label": "D", "content": "Our knowledge about bird psychology needs updating."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 58);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What did the researchers discover about most ducklings from their experiment?',
  NULL,
  '[{"label": "A", "content": "They could associate shape with color."}, {"label": "B", "content": "They reacted quickly to moving objects."}, {"label": "C", "content": "They preferred colored objects to colorless ones."}, {"label": "D", "content": "They could tell whether the objects were the same."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 59);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What was novel about the experiment in the study reported in Science?',
  NULL,
  '[{"label": "A", "content": "The animals used received no training."}, {"label": "B", "content": "It used a number of colors and shapes."}, {"label": "C", "content": "It was conducted by experimental psychologists."}, {"label": "D", "content": "The ducklings were compared with other animals."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 60);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What do we learn from Dr. Wasserman\'s comment on the study of animal minds at the end of the passage?',
  NULL,
  '[{"label": "A", "content": "It is getting more and more intricate."}, {"label": "C", "content": "It is attracting more public attention."}, {"label": "B", "content": "Research methods are being updated."}, {"label": "D", "content": "Remarkable progress is being made."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 61);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What has been a standard piece of dietary advice for decades?',
  NULL,
  '[{"label": "A", "content": "People should cultivate a healthy eating habit."}, {"label": "B", "content": "People should have a well-balanced diet."}, {"label": "C", "content": "People should diversify what they eat."}, {"label": "D", "content": "People should limit calorie intake to avoid obesity."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 62);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What did the new research by the American Heart Association find?',
  NULL,
  '[{"label": "A", "content": "People seeking dietary diversity tend to eat more."}, {"label": "B", "content": "Big eaters are more likely to become overweight."}, {"label": "C", "content": "Dietary diversity is positively related to good health."}, {"label": "D", "content": "Unhealthy food makes people gain weight more easily."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 63);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What could help to explain the contradiction between the new findings and the common public health. recommendation?',
  NULL,
  '[{"label": "A", "content": "Most dietary guidelines around the world contradict one another."}, {"label": "B", "content": "Conventional wisdom about diet is seldom supported by science."}, {"label": "C", "content": "The methods researchers use to measure nutrition vary greatly."}, {"label": "D", "content": "There is little consensus on the definition of dietary diversity."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 64);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What did Dr. Rao find after 20 years of research on obesity?',
  NULL,
  '[{"label": "A", "content": "Dietary diversity promotes healthy body weight."}, {"label": "B", "content": "Eating patterns and weight gain go hand in hand."}, {"label": "C", "content": "Diversified food intake may not contribute to health."}, {"label": "D", "content": "There is no clear definition of optimal eating patterns."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 65);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'What does the passage say about people who eat a great variety of food?',
  NULL,
  '[{"label": "A", "content": "They tend to consume more sweets, sugar and red meat."}, {"label": "B", "content": "They don\'t feel they have had enough until they overeat."}, {"label": "C", "content": "They don\'t have any problems getting sufficient nutrition."}, {"label": "D", "content": "They are more likely to eat foods beneficial to their health."}]',
  NULL,
  'reading', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'reading', 'reading_1', 66);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '张骞(Zhang Qian)是中国第一个伟大的探险家。他不畏艰险,克服重重困难,两次出使西城,开通了中国同西亚和欧洲的通商关系,将中国的丝和丝织品运往西亚和欧洲,开拓了历史上著名的“丝绸之路”。同时,他又将西城的风土人情、地理文化以及特有物种等介绍到中原,极大地开阔了人们的视野。 正如历史学家所指出的那样,如果没有张骞出使西域,就不可能有丝绸之路的开辟,也就不会有汉朝同西域或欧洲的文化交流。',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 67);


-- ============================================================
-- [31] 2023年上半年大学英语六级真题（第2套）
-- 题目数: 2
-- 源文件: 四六级历年真题汇总/2023年03月英语四六级【新】/2023年3月CET6真题+解析+听力/02、真题word版/2023.03英语六级真题第2套.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2023, 1, '2023年上半年大学英语六级真题（第2套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write an essay that begins with the sentence "People are now increasingly aware of the challenges in making a decision when faced with too many choices." You can make comments, cite examples or use your personal experiences to develop your essay. You should write at least 150 words but no more than 200 words. Part IV Translation (30 minutes) Directions: For this part, you are allowed 30 minutes to translate a passage from Chinese into English. You should write your answer on Answer Sheet 2. 郑和是中国历史上最杰出的航海家,在航海、外交、军事等诸多领域都表现出非凡的智慧和卓越的才能。他曾七次率领庞大的船队远航,访问了西太平洋和印度洋的许多国家和地区,加深了中国同东南亚、东非的相互了解。 郑和下西洋对中外的经济和文化交流起到了十分积极的推进作用,也为维护区域和平做出了巨大贡献。为了永远铭记郑和及其丰功伟绩，7月11日，即郑和首次率船队远航启程的日子，被定为中国的航海节。',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '郑和是中国历史上最杰出的航海家,在航海、外交、军事等诸多领域都表现出非凡的智慧和卓越的才能。他曾七次率领庞大的船队远航,访问了西太平洋和印度洋的许多国家和地区,加深了中国同东南亚、东非的相互了解。 郑和下西洋对中外的经济和文化交流起到了十分积极的推进作用,也为维护区域和平做出了巨大贡献。为了永远铭记郑和及其丰功伟绩，7月11日，即郑和首次率船队远航启程的日子，被定为中国的航海节。',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 2);


-- ============================================================
-- [32] 2023年上半年大学英语六级真题（第3套）
-- 题目数: 2
-- 源文件: 四六级历年真题汇总/2023年03月英语四六级【新】/2023年3月CET6真题+解析+听力/02、真题word版/2023.03英语六级真题第3套.docx
-- ============================================================

INSERT INTO `paper` (`level`, `exam_year`, `exam_half`, `title`, `total_score`) VALUES (6, 2023, 1, '2023年上半年大学英语六级真题（第3套）', 710);
SET @pid = LAST_INSERT_ID();

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  'For this part, you are allowed 30 minutes to write an essay that begins with the sentence "People are now increasingly aware of the ‘digital gap\' or challenges the elderly face in a digital world." You can make comments, cite examples or use your personal experiences to develop your essay. You should write at least 150 words but no more than 200 words. Part IV Translation (30 minutes) Directions: For this part, you are allowed 30 minutes to translate a passage from Chinese into English. You should write your answer on Answer Sheet 2. 徐霞客是中国明代的著名地理学家。他花费了三十多年的时间游遍了大半个中国。他主要靠徒步跋涉,寻访了许多荒远偏僻的地区。他把自己的见闻和考察结果详细记录下来,为后人留下了珍贵的考察资料。他通过对许多河流的实地调查,纠正了文献中关于水源的错误。他还详细地描述了地形、气候等因素对植物的影响，生动地描绘了各地的名胜古迹和风土人情。他的考察记录由后人整理成了《徐霞客游记》,在国内外产生了广泛的影响。',
  NULL,
  NULL, NULL, 'writing', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'writing', 'writing', 1);

INSERT INTO `topic` (`topic_name`,`answer`,`options`,`correct_option`,`question_type`,`analysis`,`article`,`status`,`create_by`) VALUES (
  '徐霞客是中国明代的著名地理学家。他花费了三十多年的时间游遍了大半个中国。他主要靠徒步跋涉,寻访了许多荒远偏僻的地区。他把自己的见闻和考察结果详细记录下来,为后人留下了珍贵的考察资料。他通过对许多河流的实地调查,纠正了文献中关于水源的错误。他还详细地描述了地形、气候等因素对植物的影响，生动地描绘了各地的名胜古迹和风土人情。他的考察记录由后人整理成了《徐霞客游记》,在国内外产生了广泛的影响。',
  NULL,
  NULL, NULL, 'translation', NULL, NULL, 0, 'admin');
INSERT INTO `paper_topic` (`paper_id`,`topic_id`,`section`,`sub_section`,`sorted`) VALUES (@pid, LAST_INSERT_ID(), 'translation', 'translation', 2);


SET FOREIGN_KEY_CHECKS=1;
