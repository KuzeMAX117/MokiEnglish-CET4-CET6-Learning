import request from "@/utils/request.ts";
import type { PaperQueryType, PaperSectionSaveType } from "./type";

const prefix = "/topic/paper/manage/";

export const apiGetPaperManageList = (query: PaperQueryType) => {
  return request({
    url: prefix + "list",
    method: "get",
    params: query
  });
};

export const apiAddPaper = (data: any) => {
  return request({
    url: prefix + "add",
    method: "post",
    data
  });
};

export const apiUpdatePaper = (data: any) => {
  return request({
    url: prefix + "update",
    method: "put",
    data
  });
};

export const apiDeletePaper = (ids: number[]) => {
  return request({
    url: prefix + "delete/" + ids,
    method: "delete",
  });
};

export const apiGetPaperManageDetail = (id: number) => {
  return request({
    url: prefix + "detail/" + id,
    method: "get",
  });
};

export const apiSavePaperSection = (data: PaperSectionSaveType) => {
  return request({
    url: prefix + "section/save",
    method: "post",
    data
  });
};

export const apiPublishPaper = (id: number) => {
  return request({
    url: prefix + "publish/" + id,
    method: "post",
  });
};

export const apiUnpublishPaper = (id: number) => {
  return request({
    url: prefix + "unpublish/" + id,
    method: "post",
  });
};

/** 粘贴文本解析（不落库） */
export const apiParsePaperText = (data: { section: string; subSection?: string; text: string }) => {
  return request({
    url: prefix + "parse/text",
    method: "post",
    data
  });
};

/** docx 上传解析（不落库） */
export const apiParsePaperDocx = (data: FormData) => {
  return request({
    url: prefix + "parse/docx",
    method: "post",
    data,
    headers: {
      "Content-Type": "multipart/form-data"
    }
  });
};
