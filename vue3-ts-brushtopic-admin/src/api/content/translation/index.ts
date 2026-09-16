import request from "@/utils/request.ts";
import type { TranslationQueryType } from "./type";

const prefix = "/system/content/translation/";

export const apiGetTranslationList = (query: TranslationQueryType) => {
  return request({ url: prefix + "list", method: "get", params: query });
};

export const apiAddTranslation = (data: any) => {
  return request({ url: prefix + "add", method: "post", data });
};

export const apiUpdateTranslation = (data: any) => {
  return request({ url: prefix + "update", method: "put", data });
};

export const apiDeleteTranslation = (ids: number[]) => {
  return request({ url: prefix + "delete/" + ids, method: "delete" });
};
