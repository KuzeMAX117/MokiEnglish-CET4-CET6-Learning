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
  section: string
  sorted: number
}

export interface PaperSection {
  section: string
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
