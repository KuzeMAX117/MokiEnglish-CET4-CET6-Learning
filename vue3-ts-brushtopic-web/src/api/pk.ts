import request from '@/utils/request'
import type { ApiResult } from '@/types'

export interface PkRankItem {
  userId: number
  nickname?: string
  avatar?: string
  score: number
  rank: number
}

export interface PkStats {
  dailyScore: number
  dailyRank: number
  totalScore: number
  totalRank: number
  totalGames: number
  wins: number
  winRate: number
  level: number
  score: number
  levelName: string
}

export interface PkAnswerResult {
  correct: boolean
  correctOption: string
  scoreA: number
  scoreB: number
}

export interface WarmUpResult {
  correct: boolean
  correctAnswer: string
  currentIndex: number
  totalCount: number
  type?: string
  level?: number
  levelName?: string
}

export interface UserLevel {
  level: number
  levelName: string
}

export const apiStartMatch = () =>
  request.post<any, ApiResult>('/topic/pk/match')

export const apiCancelMatch = () =>
  request.post<any, ApiResult>('/topic/pk/cancel')

export const apiSubmitAnswer = (data: { roomId: string; questionIndex: number; answer: string }) =>
  request.post<any, ApiResult<PkAnswerResult>>('/topic/pk/answer', data)

export const apiSubmitWarmUp = (data: { roomId: string; questionIndex: number; answer: string }) =>
  request.post<any, ApiResult<WarmUpResult>>('/topic/pk/warmup/answer', data)

export const apiGetUserLevel = () =>
  request.get<any, ApiResult<UserLevel>>('/topic/pk/level')

export const apiGetPkRank = (type: string, page = 1, size = 20) =>
  request.get<any, ApiResult<PkRankItem[]>>(`/topic/pk/rank/${type}`, { params: { page, size } })

export const apiGetPkStats = () =>
  request.get<any, ApiResult<PkStats>>('/topic/pk/stats')
