import request from '@/utils/request.js'

const prefix = '/system/notice/'

export const apiRecordNotice = (data) =>
  request({
    url: prefix + 'record',
    method: 'post',
    data
  })

export const apiGetNoticeHas = () => {
  return request.get(prefix + "has");
}

export const apiClearNotice = () => {
  return request.put(prefix + "clear");
}