import request from '@/utils/request.js'

const prefix = '/system/feedback/'

export const apiSendFeedback = (data) => {
  return request({
    url: prefix + 'send',
    method: 'post',
    data
  })
}

export const apiQueryFeedbackList = () => {
  return request({
    url: prefix + 'feedback',
    method: 'get',
  })
}