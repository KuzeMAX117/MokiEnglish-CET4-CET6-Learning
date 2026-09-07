import request from "@/utils/request.ts";
import type { MenuQueryType, MenuType } from "./type";

const prefix = "/system/menu/";

export const apiGetMenuList = (query: MenuQueryType) => {
  return request({
    url: prefix + "list",
    method: "get",
    params: query
  });
};

export const apiAddMenu = (data: MenuType) => {
  return request({
    url: prefix + "add",
    method: "post",
    data
  });
};

export const apiUpdateMenu = (data: MenuType) => {
  return request({
    url: prefix + "update",
    method: "put",
    data
  });
};

export const apiDeleteMenu = (id: number) => {
  return request({
    url: prefix + "delete/" + id,
    method: "delete"
  });
};