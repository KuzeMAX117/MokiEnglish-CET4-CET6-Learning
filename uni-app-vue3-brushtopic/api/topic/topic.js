
import request from '@/utils/request.js'

const prefix = '/topic/topic/'

export const apiQueryTopicDetail = (id) =>
  request(prefix + 'detail/' + id)

export const apiQueryTopicAnswer = (id) =>
  request(prefix + 'answer/' + id)

export const apiCollectionTopic = (id) =>
  request(prefix + 'collection/' + id)

export const apiQueryCollectionTopicList = () =>
  request(prefix + 'collection/list')

export const apiCountTopic = (data) =>
  request({
    url: prefix + 'count',
    method: 'post',
    data
  })