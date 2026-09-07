import request from '@/utils/request.js'

const prefix = '/system/role/'

export const apiGetRoleDetail = (role) => {
  return request({
    url: prefix + 'identify/' + role,
    method: 'get',
  })
}