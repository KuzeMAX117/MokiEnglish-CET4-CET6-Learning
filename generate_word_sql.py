import re

file_path = r'D:\202401\study\Topic\word'
output_path = r'D:\202401\study\Topic\sql\import_cet4_words.sql'

EXAMPLES = {
    'abandon': ('They had to abandon the sinking ship.', '他们不得不弃船逃生。'),
    'abundant': ('The region has abundant natural resources.', '该地区拥有丰富的自然资源。'),
    'accelerate': ('The car accelerated as it entered the highway.', '汽车驶入高速公路时加速了。'),
    'access': ('Students have free access to the library.', '学生可以免费使用图书馆。'),
    'accommodate': ('The hotel can accommodate up to 500 guests.', '这家酒店最多可容纳500位客人。'),
    'accumulate': ('Dust had accumulated on the shelves over the years.', '灰尘多年来在架子上积聚。'),
    'adequate': ('Make sure there is adequate ventilation in the room.', '确保房间有足够的通风。'),
    'adjust': ('You need to adjust the mirror before driving.', '开车前你需要调整后视镜。'),
    'advocate': ('She advocated for equal rights for women.', '她倡导女性享有平等权利。'),
    'affect': ('The weather can affect your mood.', '天气会影响你的心情。'),
    'aggravate': ('His constant complaints only aggravated the situation.', '他不断的抱怨只会恶化局势。'),
    'alarm': ('The fire alarm woke everyone in the building.', '火警警报叫醒了大楼里的每个人。'),
    'allocate': ('The government allocated funds for education.', '政府为教育拨款。'),
    'alternative': ('We need to find an alternative solution.', '我们需要找到一个替代方案。'),
    'amateur': ('He is an amateur photographer.', '他是一名业余摄影师。'),
    'analyze': ('Scientists analyze the data carefully.', '科学家们仔细分析数据。'),
    'approach': ('We need a new approach to this problem.', '我们需要一个新的方法来解决这个问题。'),
    'appropriate': ('Wear appropriate clothing for the occasion.', '穿着适合场合的服装。'),
    'arise': ('Problems may arise during the project.', '项目期间可能会出现问题。'),
    'arouse': ('The speech aroused great enthusiasm.', '演讲激起了极大的热情。'),
    'assemble': ('Please assemble the furniture according to the instructions.', '请按照说明书组装家具。'),
    'assign': ('The teacher assigned homework to the students.', '老师给学生布置了作业。'),
    'assist': ('Can you assist me with this heavy box?', '你能帮我搬这个重箱子吗？'),
    'associate': ('People often associate happiness with money.', '人们常把幸福和金钱联系在一起。'),
    'assume': ('I assume you are coming to the party.', '我假定你会来参加聚会。'),
    'assure': ('I assure you that the product is safe.', '我向你保证这个产品是安全的。'),
    'authority': ('The local authority is responsible for education.', '地方当局负责教育。'),
    'available': ('Is this seat available?', '这个座位有人吗？'),
    'benefit': ('Exercise benefits your health.', '锻炼有益于你的健康。'),
    'career': ('She decided to pursue a career in medicine.', '她决定从事医学事业。'),
    'challenge': ('Learning a new language is a challenge.', '学习一门新语言是一个挑战。'),
    'circumstance': ('Under no circumstance should you leave early.', '在任何情况下你都不应该提前离开。'),
    'colleague': ('I discussed the project with my colleague.', '我和同事讨论了这个项目。'),
    'community': ('The community came together to help.', '社区团结起来提供帮助。'),
    'complex': ('The issue is more complex than it appears.', '这个问题比看起来更复杂。'),
    'concentrate': ('Please concentrate on your work.', '请专心于你的工作。'),
    'conclude': ('The meeting concluded at 5 p.m.', '会议在下午5点结束。'),
    'conduct': ('The experiment was conducted in a laboratory.', '实验在实验室进行。'),
    'confident': ('She felt confident about passing the exam.', '她对通过考试感到自信。'),
    'consequence': ('Climate change has serious consequences.', '气候变化有严重的后果。'),
    'considerable': ('He spent a considerable amount of time on this.', '他在这上面花了相当多的时间。'),
    'contribute': ('Everyone should contribute to the team effort.', '每个人都应该为团队努力做出贡献。'),
    'convince': ('He tried to convince me to change my mind.', '他试图说服我改变主意。'),
    'crucial': ('Timing is crucial in this business.', '时机在这个行业至关重要。'),
    'decade': ('The technology has changed dramatically in the past decade.', '过去十年技术发生了巨大变化。'),
    'decline': ('Sales continued to decline last quarter.', '上季度销售额继续下降。'),
    'define': ('How would you define success?', '你如何定义成功？'),
    'deliberate': ('It was a deliberate decision, not an accident.', '这是一个深思熟虑的决定，不是意外。'),
    'demonstrate': ('The teacher demonstrated the experiment.', '老师演示了这个实验。'),
    'deny': ('He denied all the accusations.', '他否认了所有指控。'),
    'depend': ('Success depends on hard work.', '成功取决于努力工作。'),
    'deprive': ('They were deprived of their basic rights.', '他们被剥夺了基本权利。'),
    'derive': ('Many English words derive from Latin.', '许多英语单词源自拉丁语。'),
    'determine': ('She determined to finish the project on time.', '她下定决心按时完成项目。'),
    'device': ('This device can detect smoke.', '这个装置可以探测烟雾。'),
    'devote': ('He devoted his life to science.', '他把一生献给了科学。'),
    'digest': ('It takes time to digest new information.', '消化新信息需要时间。'),
    'diminish': ('Nothing can diminish the importance of education.', '没有什么能降低教育的重要性。'),
    'display': ('The museum displayed ancient artifacts.', '博物馆展出了古代文物。'),
    'distinct': ('There are two distinct approaches to the problem.', '有两种截然不同的方法来解决这个问题。'),
    'distribute': ('The company distributed profits to shareholders.', '公司向股东分配利润。'),
    'domestic': ('The domestic market is growing rapidly.', '国内市场正在快速增长。'),
    'dominate': ('The team dominated the competition.', '这支球队主导了比赛。'),
    'dramatic': ('There has been a dramatic increase in prices.', '价格出现了急剧上涨。'),
    'efficient': ('We need a more efficient system.', '我们需要一个更高效的系统。'),
    'eliminate': ('We must eliminate waste from the process.', '我们必须消除流程中的浪费。'),
    'embrace': ('We should embrace new technology.', '我们应该拥抱新技术。'),
    'emerge': ('New evidence emerged during the investigation.', '调查过程中出现了新证据。'),
    'emergency': ('Call 911 in case of emergency.', '紧急情况下拨打911。'),
    'emotion': ('She could not control her emotions.', '她无法控制自己的情绪。'),
    'emphasis': ('The emphasis should be on quality, not quantity.', '重点应该是质量而非数量。'),
    'encounter': ('I encountered many difficulties during the project.', '我在项目中遇到了许多困难。'),
    'encourage': ('Parents should encourage children to read.', '父母应该鼓励孩子阅读。'),
    'engage': ('Students should engage in more discussions.', '学生应该参与更多讨论。'),
    'enhance': ('Technology can enhance learning experiences.', '技术可以增强学习体验。'),
    'enormous': ('The project requires an enormous amount of energy.', '这个项目需要大量的精力。'),
    'ensure': ('Please ensure all doors are locked before leaving.', '离开前请确保所有门都锁好。'),
    'entire': ('I read the entire book in one sitting.', '我一口气读完了整本书。'),
    'environment': ('We must protect the environment.', '我们必须保护环境。'),
    'equivalent': ('One mile is roughly equivalent to 1.6 kilometers.', '一英里大约等于1.6公里。'),
    'essential': ('Water is essential for life.', '水对生命至关重要。'),
    'establish': ('The company was established in 1990.', '这家公司成立于1990年。'),
    'estimate': ('The cost is estimated at $10,000.', '估计费用为10,000美元。'),
    'evaluate': ('We need to evaluate the results carefully.', '我们需要仔细评估结果。'),
    'evidence': ('The evidence supports his theory.', '证据支持他的理论。'),
    'evolve': ('Technology continues to evolve rapidly.', '技术继续快速发展。'),
    'exceed': ('Sales exceeded our expectations.', '销售额超出了我们的预期。'),
    'exclude': ('The price excludes tax and insurance.', '价格不包括税费和保险。'),
    'execute': ('The plan was executed perfectly.', '计划执行得很完美。'),
    'exhibit': ('The museum will exhibit the paintings next month.', '博物馆下个月将展出这些画作。'),
    'expand': ('The company plans to expand overseas.', '公司计划向海外扩展。'),
    'expense': ('Traveling is a major expense for me.', '旅行对我来说是一笔主要开支。'),
    'experiment': ('The experiment yielded surprising results.', '实验产生了令人惊讶的结果。'),
    'expert': ('She is an expert in artificial intelligence.', '她是人工智能方面的专家。'),
    'explicit': ('The instructions were very explicit.', '说明非常明确。'),
    'exploit': ('We must exploit every opportunity.', '我们必须利用每一个机会。'),
    'expose': ('Do not expose your skin to direct sunlight.', '不要让皮肤暴露在阳光直射下。'),
    'extend': ('We need to extend the deadline by two weeks.', '我们需要将截止日期延长两周。'),
    'extent': ('The damage was extensive in extent.', '损坏的范围很广。'),
    'external': ('External factors also influence the result.', '外部因素也会影响结果。'),
    'factor': ('Cost is an important factor to consider.', '成本是需要考虑的重要因素。'),
    'feature': ('This phone has many advanced features.', '这款手机有许多先进的功能。'),
    'flexible': ('We need a more flexible schedule.', '我们需要更灵活的时间表。'),
    'fluctuate': ('Prices tend to fluctuate seasonally.', '价格往往随季节波动。'),
    'focus': ('Let us focus on the main issue.', '让我们专注于主要问题。'),
    'forbid': ('Smoking is forbidden in this building.', '这栋建筑内禁止吸烟。'),
    'formal': ('This is a formal occasion, so dress appropriately.', '这是正式场合，请着装得体。'),
    'foundation': ('The foundation of good health is exercise.', '健康的基础是锻炼。'),
    'frequent': ('Frequent exercise helps maintain good health.', '经常锻炼有助于保持健康。'),
    'function': ('What is the function of this button?', '这个按钮的功能是什么？'),
    'fundamental': ('Reading is a fundamental skill.', '阅读是一项基本技能。'),
    'generate': ('The power plant generates electricity.', '发电厂发电。'),
    'genuine': ('Is this a genuine diamond?', '这是真正的钻石吗？'),
    'guarantee': ('We guarantee delivery within three days.', '我们保证三天内送达。'),
    'hesitate': ('Do not hesitate to ask for help.', '不要犹豫寻求帮助。'),
    'highlight': ('The report highlights the main issues.', '报告强调了主要问题。'),
    'identical': ('These two documents are identical.', '这两份文件完全相同。'),
    'ignore': ('You should not ignore the warning signs.', '你不应该忽视警告信号。'),
    'illustrate': ('The teacher used examples to illustrate the point.', '老师用例子来说明这一点。'),
    'impact': ('The new policy had a significant impact.', '新政策产生了重大影响。'),
    'implement': ('We need to implement the new strategy.', '我们需要实施新战略。'),
    'imply': ('His silence implied agreement.', '他的沉默表示同意。'),
    'impose': ('The government imposed new taxes.', '政府征收了新税。'),
    'incentive': ('Financial incentives attract talented people.', '经济激励吸引有才华的人。'),
    'incident': ('The incident caused a lot of damage.', '这起事件造成了很大损失。'),
    'incorporate': ('The design incorporates modern elements.', '设计融合了现代元素。'),
    'indicate': ('The data indicates a positive trend.', '数据表明呈积极趋势。'),
    'individual': ('Each individual has unique talents.', '每个人都有独特的才能。'),
    'inevitable': ('Change is inevitable in life.', '变化在生活中是不可避免的。'),
    'influence': ('Parents have a strong influence on children.', '父母对孩子有很强的影响。'),
    'initial': ('The initial results are encouraging.', '初步结果令人鼓舞。'),
    'innocent': ('He was proven innocent of the crime.', '他被证明无罪。'),
    'inspire': ('Her story inspired many people.', '她的故事激励了很多人。'),
}

def get_example(word):
    if word in EXAMPLES:
        en, cn = EXAMPLES[word]
        word_safe = word.replace("'", "\\'")
        return (
            en.replace(word, f'<u>{word}</u>'),
            cn
        )
    word_safe = word.replace("'", "\\'")
    return (
        f'This is an example sentence using the word <u>{word_safe}</u>.',
        f'这是一个使用单词 <u>{word_safe}</u> 的例句。'
    )

with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

words = []
seen = set()
for line in lines:
    line = line.strip()
    if not line or line.startswith('##'):
        continue
    m = re.match(r'^\d+\.\s+([a-zA-Z]+)\s+((?:[a-zA-Z]+\.)+)\s*(.+)$', line)
    if not m:
        continue
    w, pos, meaning = m.group(1), m.group(2).strip(), m.group(3).strip()
    if w in seen:
        continue
    seen.add(w)
    meaning_full = f"{pos} {meaning}".replace("'", "\\'")
    word_safe = w.replace("'", "\\'")
    example_en, example_cn = get_example(w)
    words.append((word_safe, meaning_full, example_en.replace("'", "\\'"), example_cn.replace("'", "\\'")))

with open(output_path, 'w', encoding='utf-8') as f:
    f.write("SET NAMES utf8mb4;\n")
    f.write("DELETE FROM `word_item` WHERE `book_id` = 1;\n")
    for w, m, e_en, e_cn in words:
        f.write(
            f"INSERT INTO `word_item` (`book_id`, `word`, `phonetic`, `meaning`, `syllable_word`, `example`, `example_translate`) "
            f"VALUES (1, '{w}', '', '{m}', NULL, '{e_en}', '{e_cn}');\n"
        )

print(f'Generated {len(words)} words with examples to {output_path}')
