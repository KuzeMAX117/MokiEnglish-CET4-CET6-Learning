import request from "@/utils/request.ts";
import type { SubjectCatgoryQueryType } from "./type";

const prefix = "/topic/subject/";

export const apiGetSubjectList = (query: SubjectCatgoryQueryType) => {
  return request({
    url: prefix + "list",
    method: "get",
    params: query
  });
};

export const apiAddSubject = (data: any) => {
  return request({
    url: prefix + "add",
    method: "post",
    data
  });
};

export const apiUpdateSubject = (data: any) => {
  return request({
    url: prefix + "update",
    method: "put",
    data
  });
};

export const apiDeleteSubject = (ids: number[]) => {
  return request({
    url: prefix + "delete/" + ids,
    method: "delete",
  });
};

export const apiExportSubject = (query: SubjectCatgoryQueryType | null, ids: number[] | null) => {
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

export function apiGetSubjectName() {
  return request({
    url: prefix + 'getSubject',
    method: 'get'
  })
}