import request from '@/utils/request'
import type { ApiResult } from '@/types'

export interface WordBook {
  id: number
  name: string
  type: number
  totalCount: number
}

export interface WordItem {
  id: number
  bookId: number
  word: string
  phonetic: string
  meaning: string
  phrase: string
  syllableWord: string
  example: string
  exampleTranslate: string
  proficiency: number
  status: number
}

export interface WordCalendarItem {
  date: string
  count: number
}

export interface UserWordSetting {
  id: number
  userId: number
  bookId: number
  dailyCount: number
}

export interface SelectBookDto {
  bookId: number
  dailyCount: number
}

export interface StudyResultDto {
  wordId: number
  known: boolean
}

export interface WordStats {
  learned: number
  mastered: number
  reviewDue: number
  toLearn: number
  todayLearned: number
  cet4Learned: number
  cet4Total: number
  cet6Learned: number
  cet6Total: number
}

/** 用户生词本（阅读收藏）条目 */
export interface WordCollectionItem {
  id?: number
  word: string
  phonetic?: string
  meaning?: string
  example?: string
  exampleTranslate?: string
  createTime?: string
}

const prefix = '/system/word/'

export const apiGetBooks = () => request.get<any, ApiResult<WordBook[]>>(prefix + 'books')

export const apiSelectBook = (data: SelectBookDto) =>
  request.post<any, ApiResult>(prefix + 'selectBook', data)

export const apiGetWordSetting = () => request.get<any, ApiResult<UserWordSetting>>(prefix + 'setting')

export const apiGetTodayWords = () => request.get<any, ApiResult<WordItem[]>>(prefix + 'today')

export const apiGetTodayLearnedWords = () => request.get<any, ApiResult<WordItem[]>>(prefix + 'todayLearned')

export const apiSubmitWordResult = (data: StudyResultDto) =>
  request.post<any, ApiResult>(prefix + 'studyResult', data)

export const apiGetWordStats = () => request.get<any, ApiResult<WordStats>>(prefix + 'stats')

export const apiGetWordCalendar = (days = 90) =>
  request.get<any, ApiResult<WordCalendarItem[]>>(prefix + 'calendar', { params: { days } })

export const apiLookupWord = (word: string) =>
  request.get<any, ApiResult<WordItem>>(prefix + 'lookup', { params: { word } })

export const apiTranslateText = (text: string) =>
  request.post<any, ApiResult<string>>('/ai/model/translate', { text })

// ===== 用户生词本（阅读收藏） =====
export const apiGetCollection = () =>
  request.get<any, ApiResult<WordCollectionItem[]>>(prefix + 'collection')

export const apiAddCollection = (data: WordCollectionItem) =>
  request.post<any, ApiResult>(prefix + 'collection/add', data)

export const apiRemoveCollection = (word: string) =>
  request.post<any, ApiResult>(prefix + 'collection/remove', null, { params: { word } })
