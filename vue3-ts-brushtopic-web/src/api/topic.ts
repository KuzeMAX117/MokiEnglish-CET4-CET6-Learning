import request from '@/utils/request'
import type { ApiResult, Category, Subject, TopicDetail, TopicAnswer } from '@/types'

const categoryPrefix = '/topic/category/'
const subjectPrefix = '/topic/subject/'
const topicPrefix = '/topic/topic/'

export const apiQueryCategoryList = (isCustomQuestion: boolean | string) =>
  request.get<any, ApiResult<Category[]>>(categoryPrefix + 'category/' + isCustomQuestion)

export const apiQuerySubjectList = (categoryId: number) =>
  request.get<any, ApiResult<Subject[]>>(subjectPrefix + 'subject/' + categoryId)

export const apiQuerySubjectDetail = (id: number) =>
  request.get<any, ApiResult<Subject>>(subjectPrefix + 'subjectDetail/' + id)

export const apiQueryTopicDetail = (id: number) => request.get<any, ApiResult<TopicDetail>>(topicPrefix + 'detail/' + id)

export const apiQueryTopicAnswer = (id: number) => request.get<any, ApiResult<TopicAnswer>>(topicPrefix + 'answer/' + id)

export const apiCollectionTopic = (id: number) => request.get<any, ApiResult>(topicPrefix + 'collection/' + id)

export const apiQueryCollectionTopicList = () => request.get<any, ApiResult<any[]>>(topicPrefix + 'collection/list')

export const apiCountTopic = (data: { topicId: number; subjectId: number; nickname?: string; avatar?: string }) =>
  request.post<any, ApiResult>(topicPrefix + 'count', data)
