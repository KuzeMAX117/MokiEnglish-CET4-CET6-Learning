import request from '@/utils/request.js'

const prefix = '/ai/model/'

export const apiGetManageList = (param) => {
  return request({
    url: prefix + "history",
    method: "get",
    params: param
  });
}

export const apiGetHistoryDetail = (id) => {
  return request({
    url: prefix + "history/" + id,
    method: "get"
  });
}