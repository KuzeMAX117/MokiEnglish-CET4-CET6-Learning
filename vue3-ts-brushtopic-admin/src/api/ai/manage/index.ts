import request from "@/utils/request.ts";
import type { ManageQueryType } from "./type";

const prefix = "/ai/manage/";

export const apiGetManageList = (query: ManageQueryType) => {
  return request({
    url: prefix + "list",
    method: "get",
    params: query
  });
};

export const apiUpdateAiUser = (data: any) => {
  return request({
    url: prefix + "update",
    method: "put",
    data
  });
};