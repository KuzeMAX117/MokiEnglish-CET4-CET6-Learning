import request from "@/utils/request.ts";
import type { TopicLabelQueryType } from "./type";

const prefix = "/topic/label/";

export const apiGetLabelList = (query: TopicLabelQueryType | null) => {
  return request({
    url: prefix + "list",
    method: "get",
    params: query
  });
};

export const apiAddLabel = (data: any) => {
  return request({
    url: prefix + "add",
    method: "post",
    data
  });
};

export const apiUpdateLabel = (data: any) => {
  return request({
    url: prefix + "update",
    method: "put",
    data
  });
};

export const apiDeleteLabel = (ids: number[]) => {
  return request({
    url: prefix + "delete/" + ids,
    method: "delete",
  });
};

export const apiExportLabel = (query: TopicLabelQueryType | null, ids: number[] | null) => {
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

export function apiGetLabelName() {
  return request({
    url: prefix + 'getLabel',
    method: 'get'
  })
}
