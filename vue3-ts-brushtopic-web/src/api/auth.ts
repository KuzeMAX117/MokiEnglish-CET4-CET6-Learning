import request from '@/utils/request'
import type { ApiResult, LoginResult, UserInfo } from '@/types'

const prefix = '/security/user/'

export const apiLogin = (data: { loginType: number; account?: string; email?: string; password: string }) =>
  request.post<any, ApiResult<LoginResult>>(prefix + 'loginType', data)

export const apiRegister = (data: {
  account: string
  nickname: string
  password: string
  code: string
  email: string
}) => request.post<any, ApiResult>(prefix + 'register', data)

export const apiSendEmail = (email: string) =>
  request.get<any, ApiResult>(prefix + 'sendEmail', { params: { email } })

export const apiResetPassword = (data: { code: string; password: string; newPassword: string; email: string }) =>
  request.put<any, ApiResult>(prefix + 'resetPassword', data)

export const apiGetUserInfo = (id: number) => request.get<any, ApiResult<UserInfo>>(prefix + 'info/' + id)

export const apiUpdateNicknameAndEmail = (data: { nickname: string; email: string }) =>
  request.put<any, ApiResult>(prefix + 'updateNicknameAndEmail', data)

export const apiUpdatePassword = (data: { oldPassword: string; password: string; newPassword: string }) =>
  request.put<any, ApiResult>(prefix + 'updatePassword', data)

export const apiSaveUserAvatar = (data: { avatar: string }) =>
  request.put<any, ApiResult>(prefix + 'avatar', data)

export const apiLogout = () => request.post<any, ApiResult>(prefix + 'logout')
