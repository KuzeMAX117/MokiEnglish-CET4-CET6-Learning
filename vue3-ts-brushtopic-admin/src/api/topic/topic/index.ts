import request from "@/utils/request.ts";
import type { TopicQueryType } from "./type";

const prefix = "/topic/topic/";

export const apiGetTopicList = (query: TopicQueryType) => {
  return request({
    url: prefix + "list",
    method: "get",
    params: query
  });
};

export const apiAddTopic = (data: any) => {
  return request({
    url: prefix + "add",
    method: "post",
    data
  });
};

export const apiUpdateTopic = (data: any) => {
  return request({
    url: prefix + "update",
    method: "put",
    data
  });
};

export const apiDeleteTopic = (ids: number[]) => {
  return request({
    url: prefix + "delete/" + ids,
    method: "delete",
  });
};

export const apiExportTopic = (query: TopicQueryType | null, ids: number[] | null) => {
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

export function apiGenerateAnswer(id: number) {
  return request({
    url: prefix + 'generateAnswer/' + id,
    method: 'get',
  })
}