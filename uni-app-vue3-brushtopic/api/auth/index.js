import request from '@/utils/request.js'

const prefix = '/security/user/'

export const apiLogin = (data) => {
  return request({
    url: prefix + 'loginType',
    method: 'post',
    data
  })
}

export const apiGetUserInfo = (id) => {
  return request({
    url: prefix + 'info/' + id,
    method: 'get',
  })
}

export const apiUpdateNicknameAndEmail = (data) => {
  return request({
    url: prefix + 'updateNicknameAndEmail',
    method: 'put',
    data
  })
}

export const apiUpdatePassword = (data) => {
  return request({
    url: prefix + 'updatePassword',
    method: 'put',
    data
  })
}

export function apiSaveUserAvatar (data) {
  return request({
    url: prefix + 'avatar',
    method: 'put',
    data
  })
}

export const apiLogout = () => {
  return request({
    url: prefix + "logout",
    method: "post",
  })
}

export const apiSendEmail = (email) => {
  return request({
    url: prefix + "sendEmail",
    method: "get",
    params: { email },
  })
}

export const apiResetPassword = (data) => {
  return request({
    url: prefix + "resetPassword",
    method: "put",
    data,
  })
}

export const apiRegister = (data) => {
  return request({
    url: prefix + "register",
    method: "post",
    data,
  })
}