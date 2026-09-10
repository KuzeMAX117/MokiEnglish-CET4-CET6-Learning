-- =====================================================
-- 四六级历年真题完整导入SQL
-- 生成时间: 2026-09-10 00:13:43
-- 共 32 套试卷
-- =====================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

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


