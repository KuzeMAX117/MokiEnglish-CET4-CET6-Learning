import request from "@/utils/request.ts";
import type { ArticleQueryType } from "./type";

const prefix = "/system/content/article/";

export const apiGetArticleList = (query: ArticleQueryType) => {
  return request({ url: prefix + "list", method: "get", params: query });
};

export const apiAddArticle = (data: any) => {
  return request({ url: prefix + "add", method: "post", data });
};

export const apiUpdateArticle = (data: any) => {
  return request({ url: prefix + "update", method: "put", data });
};

export const apiDeleteArticle = (ids: number[]) => {
  return request({ url: prefix + "delete/" + ids, method: "delete" });
};
