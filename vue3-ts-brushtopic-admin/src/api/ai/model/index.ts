import request from "@/utils/request.ts";
import type { AiHistoryDto } from "./type";

const prefix = "/ai/model/";

export const apiGetManageList = (param: AiHistoryDto) => {
  return request({
    url: prefix + "history",
    method: "get",
    params: param
  });
}

export const apiGetHistoryDetail = (id: number) => {
  return request({
    url: prefix + "history/" + id,
    method: "get"
  });
}

export const apiRenameHistory = (data: any) => {
  return request({
    url: prefix + "history",
    method: "put",
    data
  });
}

export const apiDeleteHistory = (id: number) => {
  return request({
    url: prefix + "history/" + id,
    method: "delete"
  });
}