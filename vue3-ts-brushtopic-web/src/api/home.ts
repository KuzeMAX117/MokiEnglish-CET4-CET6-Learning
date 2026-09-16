import request from '@/utils/request'
import type { ApiResult, WebHomeCount, TodayTopicVo, RankItem, TopicTrendVo, UserTrendVo, CategoryDataVo, UserTopicCountVo } from '@/types'

const prefix = '/topic/data/'

export const apiQueryWebHomeCount = () => request.get<any, ApiResult<WebHomeCount>>(prefix + 'webHomeCount')

export const apiQueryRank = (type: string) => request.get<any, ApiResult<RankItem[]>>(prefix + 'rank/' + type)

export const apiQueryUserRank = (type: string) => request.get<any, ApiResult<RankItem>>(prefix + 'userRank/' + type)

export const apiQueryTopicTodayVo = () => request.get<any, ApiResult<TodayTopicVo[]>>(prefix + 'topicTodayVo')

export const apiFlushTopic = (id: number) => request.get<any, ApiResult>(prefix + 'flush/' + id)

export const apiQueryTopicTrend = () => request.get<any, ApiResult<TopicTrendVo>>(prefix + 'topicTrend')

export const apiQueryUserTrend = () => request.get<any, ApiResult<UserTrendVo>>(prefix + 'userTrend')

export const apiQueryAdminHomeCategory = () => request.get<any, ApiResult<CategoryDataVo[]>>(prefix + 'adminHomeCategory')

export const apiQueryUserTopicCount = (date: string) => request.get<any, ApiResult<UserTopicCountVo[]>>(prefix + 'userTopicCount/' + date)
