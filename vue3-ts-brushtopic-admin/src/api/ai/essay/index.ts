import request from "@/utils/request.ts";
import type { EssayQueryType } from "./type";

const prefix = "/ai/essay/";

export const apiGetEssayRecordList = (query: EssayQueryType) => {
  return request({
    url: prefix + "list",
    method: "get",
    params: query
  });
};
