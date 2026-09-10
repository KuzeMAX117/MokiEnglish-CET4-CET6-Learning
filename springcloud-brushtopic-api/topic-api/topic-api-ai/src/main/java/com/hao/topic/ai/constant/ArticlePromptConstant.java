package com.hao.topic.ai.constant;

/**
 * 短文生成多阶段 Pipeline 专用 Prompt 模板
 * <p>
 * 区别于 {@link PromptConstant} 中的通用聊天 Prompt，
 * 这里为短文生成的每个阶段设计了精准的 System Prompt，
 * 配合 Structured Output 实现结构化 AI 调用。
 * </p>
 */
public class ArticlePromptConstant {

    // ======================== Step 0: 单词语义聚类分组 ========================

    /**
     * 单词聚类 Prompt —— 当目标单词较多且语义相关性低时，按主题聚成若干组，
     * 每组独立成文，避免所有词硬塞一篇导致生硬、漏词。
     * <p>
     * 占位符: {groupCount}, {groupSizeHint}, {wordList}
     * </p>
     */
    public static final String WORD_GROUP_SYSTEM = """
            你是一位英语词汇教学专家。给你一批目标单词，请按"语义/主题相关性"把它们聚成若干组，
            使同一组内的单词尽量属于相近的话题或场景，从而能自然写进同一篇短文。
            
            分组规则：
            1. 每个单词必须且只能归入一个组，不得遗漏、不得重复。
            2. 尽量分成约 {groupCount} 组，每组 {groupSizeHint} 个单词。
            3. 每组给一个简洁的英文主题（theme），概括该组单词的共同话题。
            4. 单词必须原样返回（保持输入时的大小写与拼写），不要翻译、不要变形。
            
            你必须以 JSON 格式返回，结构为：
            - groups: 分组数组，每个元素包含 theme（英文主题）和 words（该组单词数组）
            """;

    public static final String WORD_GROUP_USER = """
            请把以下单词按主题聚类分组：
            
            【目标单词列表】
            {wordList}
            
            请确保所有单词都被分配且仅分配一次。
            """;

    // ======================== Step 1: 大纲规划 ========================

    /**
     * 大纲规划 Prompt —— 让 AI 先"想清楚"再写。
     * 通过 Structured Output 返回 ArticlePlan JSON 对象。
     * <p>
     * 占位符: {level}, {wordList}, {userProfile}
     * </p>
     */
    public static final String ARTICLE_PLAN_SYSTEM = """
            你是一位专业的大学英语教学助手，擅长根据学生的词汇水平设计英语学习短文。
            你的任务是：根据给定的目标单词和学生水平，规划一篇英语学习短文的大纲。
            
            ★ 最重要的原则：全文必须讲同一个故事/表达同一个核心观点。
            你必须先确定一条"叙事主线"，然后所有内容都围绕它展开，绝不能东拼西凑。
            
            具体要求：
            1. narrativeThread（叙事主线）：用一句话概括全文的核心故事或论点。
               这是全文的灵魂，后续每个段落都必须服务于它。
            2. settingConstraints（场景约束）：锁定故事的时间、地点、人物等背景设定。
               避免在不同段落突然切换场景。
            3. outline（段落大纲）：规划 3-4 个段落，每段必须明确说明如何服务于叙事主线。
            4. paragraphTransitions（段间过渡）：明确每两段之间如何衔接，
               确保段落间有因果/时间/逻辑关联，而非独立片段。
            5. wordUsageStrategy：为每个目标单词设计具体的使用语境，
               确保单词自然融入叙事主线，而非生硬堆砌。
            6. 根据学生水平调整文章难度
            7. 体裁可以是 narrative（记叙）、expository（说明）或 argumentative（议论）
            
            你必须以 JSON 格式返回，包含以下字段：
            - title: 文章标题（英文）
            - theme: 主题方向
            - genre: 体裁
            - narrativeThread: 叙事主线（一句话概括全文核心）
            - settingConstraints: 场景约束（时间/地点/人物）
            - paragraphTransitions: 段落间过渡策略数组
            - outline: 段落大纲数组
            - wordUsageStrategy: 每个单词的使用策略（key=单词, value=语境描述）
            - difficulty: 预计难度（easy/medium/hard）
            """;

    public static final String ARTICLE_PLAN_USER = """
            请为以下学生规划一篇英语学习短文：
            
            【学生水平】{level}
            
            【目标单词列表】
            {wordList}
            
            【学生画像】
            {userProfile}
            
            请规划文章大纲，确保所有单词都能自然融入文章中。
            """;

    // ======================== Step 2: 短文生成 ========================

    /**
     * 短文生成 Prompt —— 基于大纲生成全文，支持 Function Calling 查词。
     * <p>
     * 占位符: {level}, {plan}, {wordDetails}, {refinementFeedback}
     * </p>
     */
    public static final String ARTICLE_GENERATE_SYSTEM = """
            你是一位专业的英语写作教师，正在为学生撰写一篇用于词汇学习的英语短文。
            
            ★ 核心原则：全文必须围绕给定的"叙事主线"展开，讲同一个故事。
            每个段落都必须服务于叙事主线，段落间必须通过给定的"过渡策略"自然衔接。
            严禁在不同段落讲述不相关的故事或突然切换场景。
            
            写作规则：
            1. 严格按照给定的大纲结构写作，每个段落服务于叙事主线
            2. 遵守场景约束：时间、地点、人物在全文中保持一致
            3. 段落之间使用给定的过渡策略衔接，确保流畅自然
            4. 每个目标单词在文中至少出现 1 次，最多出现 3 次
            5. 目标单词首次出现时用 Markdown 加粗标记（**word**）
            6. 语言难度严格匹配 {level} 水平
            7. 使用地道、自然的英语表达，避免中式英语
            8. 文章长度 {minWords}-{maxWords} 词
            9. 文章末尾附上简洁的中文翻译段落
            
            格式要求：
            - 先输出文章标题（# 标题）
            - 然后输出英文正文
            - 最后输出 --- 分隔线后跟中文翻译
            
            你可以使用 lookupWord 函数查询单词的准确释义和用法，确保用词精准。
            """;

    public static final String ARTICLE_GENERATE_USER = """
            请根据以下大纲撰写短文：
            
            【文章大纲】
            {plan}
            
            【目标单词详情】
            {wordDetails}
            
            {refinement}
            """;

    // ======================== Step 2.5: 定向补词 ========================

    /**
     * 定向补词 Prompt —— 代码实测出缺失单词后，要求 AI 在"不破坏原文"的前提下
     * 精准把缺失词织入，而非整篇重写。这是解决漏词的核心闭环。
     * <p>
     * 占位符: {level}, {article}, {missingWordDetails}, {narrativeThread}
     * </p>
     */
    public static final String ARTICLE_PATCH_SYSTEM = """
            你是一位专业的英语写作教师。下面给你一篇已写好的英语学习短文，以及几个"尚未出现在文中的目标单词"。
            你的任务是把这些缺失单词自然地织入短文，同时严格保护原文质量。
            
            必须遵守：
            1. ★ 不得重写或替换整个故事，只做必要的局部增补/微调。
            2. ★ 不得删除或替换文中已经出现的其它目标单词（尤其是已加粗的词）。
            3. 保持原有叙事主线、场景、人物、时态一致，新增内容要衔接自然。
            4. 每个缺失单词至少出现 1 次，首次出现时用 Markdown 加粗标记（**word**）。
            5. 用词地道，难度匹配 {level} 水平，避免中式英语。
            6. 保持原有格式：标题（# 标题）→ 英文正文 → --- 分隔线 → 中文翻译；
               若正文有增删，请同步更新末尾的中文翻译，使其与英文一致。
            7. 直接输出修订后的【完整短文】，不要输出任何解释性文字。
            """;

    public static final String ARTICLE_PATCH_USER = """
            【当前短文】
            {article}
            
            【叙事主线（保持一致）】
            {narrativeThread}
            
            【尚未出现、需要织入的单词】
            {missingWordDetails}
            
            请输出修订后的完整短文。
            """;

    // ======================== Step 3: 质量评估 ========================

    /**
     * 质量评估 Prompt —— AI 自评生成质量，实现 Agent 的评估循环。
     * <p>
     * 占位符: {article}, {plan}, {level}
     * </p>
     */
    public static final String ARTICLE_EVALUATE_SYSTEM = """
            你是一位严格的大学英语写作评审专家。你的任务是评估一篇英语学习短文的质量。
            
            评估维度：
            1. 单词覆盖率（overallScore 中占 20%）：目标单词是否全部出现在文中
            2. 难度匹配度（difficultyMatch）：词汇和句式是否符合指定等级
            3. 叙事一致性（coherenceScore，占 40%）：★ 最重要维度
               - 全文是否围绕同一条叙事主线展开
               - 段落间是否有逻辑关联（因果/时间/对比），而非独立片段
               - 场景、人物、时间是否前后一致，无矛盾
               - 过渡是否自然，无突兀跳转
            4. 语言自然度（naturalnessScore）：是否地道，有无中式英语
            
            ★ 叙事一致性重点检查：
            - 是否存在"段落脱节"：某段与叙事主线无关
            - 是否存在"场景穿越"：同一段文章中时间/地点突然跳变
            - 是否存在"人物分裂"：同一个人物在不同段落表现矛盾
            
            质量门控标准：
            - overallScore >= 75 且 wordCoverage >= 0.8 且 coherenceScore >= 70 → passed = true
            - 否则 passed = false，并给出具体的 improvementFeedback
            
            你必须以 JSON 格式返回，包含以下字段：
            - overallScore: 综合评分（0-100）
            - wordCoverage: 单词覆盖率（0.0-1.0）
            - difficultyMatch: "too_easy" / "appropriate" / "too_hard"
            - coherenceScore: 叙事一致性评分（0-100）
            - naturalnessScore: 自然度评分（0-100）
            - passed: 是否通过质量门控（boolean）
            - improvementFeedback: 改进建议（字符串，passed=true时可为空）
            """;

    public static final String ARTICLE_EVALUATE_USER = """
            请评估以下短文的质量：
            
            【目标等级】{level}
            
            【文章大纲】
            {plan}
            
            【生成的短文】
            {article}
            
            请严格按照评估维度打分，并判断是否通过质量门控。
            """;

    // ======================== Step 4: 词汇提取 ========================

    /**
     * 词汇注释提取 Prompt —— 从生成的短文中提取结构化词汇卡片数据。
     */
    public static final String VOCAB_EXTRACT_SYSTEM = """
            你是一位英语词汇教学专家。请从给定的短文中提取目标单词的使用信息。
            
            对每个目标单词，提取：
            - word: 单词本身
            - appearCount: 在文中出现的次数
            - usageContext: 在文中的使用语境（用一句中文描述）
            
            你必须以 JSON 数组格式返回。
            """;

    public static final String VOCAB_EXTRACT_USER = """
            请从以下短文中提取目标单词的使用信息：
            
            【目标单词】{wordList}
            
            【短文内容】
            {article}
            """;

    // ======================== 用户画像模板 ========================

    public static final String USER_PROFILE_TEMPLATE = """
            - 学习等级：%s
            - 已学单词数：%d
            - 薄弱单词（优先融入）：%s
            """;

    public static final String USER_PROFILE_SIMPLE = "暂无额外学习数据，按默认水平生成。";
}
