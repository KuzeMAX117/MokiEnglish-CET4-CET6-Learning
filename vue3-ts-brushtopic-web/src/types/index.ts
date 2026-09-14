export interface ApiResult<T = any> {
  code: number
  message: string
  data: T
}

export interface UserInfo {
  id?: number
  account?: string
  nickname?: string
  avatar?: string
  email?: string
  role?: number
  [key: string]: any
}

export interface LoginResult {
  userInfo: string
  token: string
  role: number
}

export interface WebHomeCount {
  todayTopicCount?: number
  todayCount?: number
  totalTopicRecordCount?: number
  totalTopicCount?: number
  rank?: number
  userCount?: number
}

export interface TodayTopicVo {
  id: number
  topicId: number
  topicName: string
  subjectId: number
  labelNames: string[]
  status: number
}

export interface Category {
  id: number
  categoryName: string
  [key: string]: any
}

export interface Subject {
  id: number
  subjectName: string
  subjectDesc?: string
  imageUrl?: string
  viewCount?: number
  topicNameVos?: { id: number; topicName: string }[]
  [key: string]: any
}

export interface TopicDetail {
  id: number
  topicName: string
  labelNames: string[]
  isMember: number
  isCollected: boolean
  [key: string]: any
}

export interface TopicAnswer {
  answer: string
  aiAnswer: string
}

export interface RankItem {
  [key: string]: any
}

export interface AiHistoryGroup {
  date: string
  aiHistoryVos: { id: number; title: string }[]
}

export interface Paper {
  id: number
  level: number
  examYear: number
  examHalf: number
  title: string
  totalScore?: number
  topicCount?: number
  doneCount?: number
}

export interface PaperOption {
  label: string
  content: string
}

export interface PaperTopicItem {
  topicId: number
  topicName: string
  options: string
  questionType: string
  article?: string
  subSection?: string
  section: string
  correctOption?: string
  analysis?: string
  sorted: number
}

export interface PaperSection {
  section: string
  subSection?: string
  topics: PaperTopicItem[]
}

export interface PaperDetail {
  id: number
  level: number
  examYear: number
  examHalf: number
  title: string
  totalScore?: number
  sections: PaperSection[]
}

export interface PaperAnswerResult {
  correct: boolean
  selected: string
  correctOption: string
  analysis: string
  answer: string
}

export interface PaperProgressItem {
  topicId: number
  selected: string
  correct: boolean
}

/** 翻译批改 —— 核心信息点核查 */
export interface TranslationCoreInfoItem {
  /** 原文核心信息点 */
  point: string
  /** ok（译出）/ missing（漏译）/ wrong（错译） */
  status: string
  note: string
}

/** 翻译批改 —— 错误标识 */
export interface TranslationErrorItem {
  /** spelling / grammar / word_choice / expression / omission / completeness */
  type: string
  /** serious 严重错误（会降档）/ minor 轻微小错 */
  severity: string
  /** 用户译文中出错的片段（用于高亮标识，漏译为空串） */
  errorText: string
  /** 错误解释 */
  explanation: string
  /** 建议替换词 */
  suggestion: string
  /** 错误影响：会降档 / 仅小幅扣分，不影响档次 */
  impact: string
}

/** 翻译批改 —— 逐句明细 */
export interface TranslationCorrectionDetail {
  source: string
  userTranslation: string
  reference: string
  /** 翻译完整程度简评 */
  completeness: string
  /** 修改优化——保守稳妥版（应试拿分） */
  polishedConservative: string
  /** 修改优化——进阶润色版（冲击高分） */
  polishedAdvanced: string
  errors: TranslationErrorItem[]
  comment: string
}

/** 翻译批改 —— AI 评分结果（四六级阅卷标准） */
export interface TranslationCorrectionResult {
  /** 档次：14 / 11 / 8 / 5 / 2 / 0 */
  band: number
  /** 总分 0-15 */
  score: number
  /** 档次标签 */
  bandLabel: string
  /** 档次原文（大纲描述） */
  bandDescription: string
  /** 定档依据 */
  bandReason: string
  /** 评分场景（四级/六级） */
  levelScene: string
  /** 准确度 0-5 */
  accuracy: number
  /** 流畅度 0-5 */
  fluency: number
  /** 语法 0-5 */
  grammar: number
  /** 总体评语 */
  overall: string
  /** 核心信息点核查 */
  coreInfoCheck: TranslationCoreInfoItem[]
  /** 考生自查清单 */
  selfCheckList: string[]
  details: TranslationCorrectionDetail[]
}

/** 翻译批改 —— 提交参数 */
export interface TranslationCorrectPayload {
  direction: 'cn2en' | 'en2cn'
  level: number
  topic: string
  items: { source: string; reference: string; userTranslation: string }[]
}

// ======================== 作文批改 ========================

/** 作文批改 —— 语法错误 */
export interface EssayGrammarError {
  /** 错误类型 */
  type: string
  /** 错误分级 */
  severity: string
  /** 原句 */
  original: string
  /** 修正后的句子 */
  correction: string
  /** 错误解释 */
  explanation: string
  /** 错误影响 */
  impact: string
}

/** 作文批改 —— 词汇建议 */
export interface EssayVocabularySuggestion {
  /** 原始词汇/短语 */
  original: string
  /** 建议替换 */
  suggestion: string
  /** 建议原因 */
  reason: string
}

/** 作文批改 —— AI 评分结果 */
export interface EssayCorrectionResult {
  /** 总分 0-15 */
  score: number
  /** 档次 */
  band: number
  /** 档次标签 */
  bandLabel: string
  /** 档次原文 */
  bandDescription: string
  /** 定档依据 */
  bandReason: string
  /** 评分场景 */
  levelScene: string
  /** 总体评语 */
  overall: string
  /** 内容 0-5 */
  content: number
  /** 语言 0-5 */
  language: number
  /** 词汇 0-5 */
  vocabulary: number
  /** 结构 0-5 */
  structure: number
  /** 语法错误列表 */
  grammarErrors: EssayGrammarError[]
  /** 词汇建议列表 */
  vocabularySuggestions: EssayVocabularySuggestion[]
  /** 考生自查清单 */
  selfCheckList: string[]
}

/** 作文批改 —— 提交参数 */
export interface EssayCorrectPayload {
  /** 作文内容 */
  essay: string
  /** 作文题目 */
  topic: string
  /** 难度等级：4 / 6 */
  level: number
}
