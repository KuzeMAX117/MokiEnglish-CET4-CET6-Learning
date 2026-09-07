import request from "@/utils/request.ts";
import type { UserQueryType } from "./type";

const prefix = "/system/user/";

export const apiGetUserList = (query: UserQueryType) => {
  return request({
    url: prefix + "list",
    method: "get",
    params: query
  });
};

export const apiGetRoleList = () => {
  return request({
    url: prefix + "roleList",
    method: "get",
  });
};

export const apiAddUser = (data: any) => {
  return request({
    url: prefix + "add",
    method: "post",
    data
  });
};

export const apiUpdateUser = (data: any) => {
  return request({
    url: prefix + "update",
    method: "put",
    data
  });
};

export const apiDeleteUser = (ids: number[]) => {
  return request({
    url: prefix + "delete/" + ids,
    method: "delete",
  });
};

export const apiExportUser = (query: UserQueryType | null, ids: number[] | null) => {
  return request({
    url: prefix + "export/" + ids,
    method: "get",
    params: query,
    responseType: "blob"
  });
};

export function apiGetExportTemplate() {
  return request({
    url: prefix + 'template',
    responseType: 'blob' 
  })
}

