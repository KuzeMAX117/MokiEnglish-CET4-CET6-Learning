import request from "@/utils/request.ts";
import type { LoginType, LoginResultType, UserResponse } from "./type";
import type { CommonResultType } from "../common";

const prefix = "/security/user/"

export const apiLogin = (data: LoginType): Promise<LoginResultType> => {
  return request({
    url: prefix + "login",
    method: "post",
    data: JSON.stringify(data),  
    headers: {
      'Content-Type': 'application/json',  
      'remember': data.remember
    },
  })
}

export const apiLogout = () => {
  return request({
    url: prefix + "logout",
    method: "post",
  })
}

export const apiGetUserInfo = (token: string | null): Promise<CommonResultType<UserResponse>> => {
  return request({
    url: prefix + "userInfo",
    method: "get",
    params: {
      token
    }
  })
}

export function apiGetUserInfoDetail(id: number | null) {
  return request({
    url: prefix + 'info/' + id,
    method: 'get'
  })
}

export function apiSaveUserAvatar(data: any) {
  return request({
    url: prefix + 'avatar',
    method: 'put',
    data
  })
}

export function apiUpdateUserInfo(data: any) {
  return request({
    url: prefix + 'updateNicknameAndEmail',
    method: 'put',
    data
  })
}

export function apiUpdatePassword(data: any) {
  return request({
    url: prefix + 'updatePassword',
    method: 'put',
    data
  })
}

export const apiSendEmail = (email: string) => {
  return request({
    url: prefix + "sendEmail",
    method: "get",
    params: { email },
  })
}