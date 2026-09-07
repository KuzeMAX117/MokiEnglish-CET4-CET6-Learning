import request from '@/utils/request'
import type { ApiResult, AiHistoryGroup } from '@/types'

const prefix = '/ai/model/'

export const apiGetManageList = (params: { pageNum: number; pageSize: number; title?: string | null }) =>
  request.get<any, ApiResult<AiHistoryGroup[]>>(prefix + 'history', { params })

export const apiGetHistoryDetail = (id: number) => request.get<any, ApiResult<any[]>>(prefix + 'history/' + id)
