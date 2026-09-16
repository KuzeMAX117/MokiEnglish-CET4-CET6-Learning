import request from "@/utils/request.ts";
import type { EssayQueryType } from "./type";

const prefix = "/system/content/essay/";

export const apiGetEssayList = (query: EssayQueryType) => {
  return request({ url: prefix + "list", method: "get", params: query });
};

export const apiAddEssay = (data: any) => {
  return request({ url: prefix + "add", method: "post", data });
};

export const apiUpdateEssay = (data: any) => {
  return request({ url: prefix + "update", method: "put", data });
};

export const apiDeleteEssay = (ids: number[]) => {
  return request({ url: prefix + "delete/" + ids, method: "delete" });
};
