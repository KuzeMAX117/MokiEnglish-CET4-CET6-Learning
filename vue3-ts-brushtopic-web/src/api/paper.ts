import request from '@/utils/request'
import type {
  ApiResult,
  Paper,
  PaperDetail,
  PaperAnswerResult,
  PaperProgressItem,
} from '@/types'

const paperPrefix = '/topic/paper/'

export const apiQueryPaperList = (level: number) =>
  request.get<any, ApiResult<Paper[]>>(paperPrefix + 'list', { params: { level } })

export const apiQueryPaperDetail = (id: number) =>
  request.get<any, ApiResult<PaperDetail>>(paperPrefix + 'detail/' + id)

export const apiSubmitPaperAnswer = (data: { paperId: number; topicId: number; selected: string }) =>
  request.post<any, ApiResult<PaperAnswerResult>>(paperPrefix + 'answer', data)

export const apiQueryPaperProgress = (paperId: number) =>
  request.get<any, ApiResult<PaperProgressItem[]>>(paperPrefix + 'progress/' + paperId)

export const apiResetPaperProgress = (paperId: number) =>
  request.post<any, ApiResult<boolean>>(paperPrefix + 'reset/' + paperId)
