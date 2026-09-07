import request from '@/utils/request'
import type { ApiResult } from '@/types'

const prefix = '/system/feedback/'

export const apiSendFeedback = (data: { feedbackContent: string; status: number }) =>
  request.post<any, ApiResult>(prefix + 'send', data)

export const apiQueryFeedbackList = () => request.get<any, ApiResult<any[]>>(prefix + 'feedback')
