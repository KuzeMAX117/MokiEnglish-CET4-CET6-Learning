import request from "@/utils/request.ts";
import type { WordBookQueryType } from "./type";

const prefix = "/system/content/wordbook/";

export const apiGetWordBookList = (query: WordBookQueryType) => {
  return request({ url: prefix + "list", method: "get", params: query });
};

export const apiAddWordBook = (data: any) => {
  return request({ url: prefix + "add", method: "post", data });
};

export const apiUpdateWordBook = (data: any) => {
  return request({ url: prefix + "update", method: "put", data });
};

export const apiDeleteWordBook = (ids: number[]) => {
  return request({ url: prefix + "delete/" + ids, method: "delete" });
};

export const apiImportWordBook = (bookId: number, file: File) => {
  const formData = new FormData();
  formData.append("file", file);
  return request({ url: prefix + "import/" + bookId, method: "post", data: formData, headers: { "Content-Type": "multipart/form-data" } });
};
