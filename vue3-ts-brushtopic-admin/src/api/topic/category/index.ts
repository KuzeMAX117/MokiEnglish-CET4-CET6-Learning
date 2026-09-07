import request from "@/utils/request.ts";
import type { TopicCatgoryQueryType } from "./type";

const prefix = "/topic/category/";

export const apiGetCategoryList = (query: TopicCatgoryQueryType | null) => {
  return request({
    url: prefix + "list",
    method: "get",
    params: query
  });
};

export const apiAddCategory = (data: any) => {
  return request({
    url: prefix + "add",
    method: "post",
    data
  });
};

export const apiUpdateCategory = (data: any) => {
  return request({
    url: prefix + "update",
    method: "put",
    data
  });
};

export const apiDeleteCategory = (ids: number[]) => {
  return request({
    url: prefix + "delete/" + ids,
    method: "delete",
  });
};

export const apiExportCategory = (query: TopicCatgoryQueryType | null, ids: number[] | null) => {
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