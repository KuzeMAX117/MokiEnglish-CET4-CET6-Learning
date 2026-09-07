import request from "@/utils/request.ts";
import type { RoleQueryType, RoleDtoType } from "./type";

const prefix = "/system/role/";

export const apiGetRoleList = (query: RoleQueryType) => {
  return request({
    url: prefix + "list",
    method: "get",
    params: query
  });
};

export const apiAddRole = (data: RoleDtoType) => {
  return request({
    url: prefix + "add",
    method: "post",
    data
  });
};

export const apiUpdateRole = (data: RoleDtoType) => {
  return request({
    url: prefix + "update",
    method: "put",
    data
  });
};

export const apiDeleteRole = (id: number) => {
  return request({
    url: prefix + "delete/" + id,
    method: "delete"
  });
};

export const apiGetRoleMenu = (id: number | null) => {
  return request({
    url: prefix + "menu/" + id,
    method: "get"
  });
};