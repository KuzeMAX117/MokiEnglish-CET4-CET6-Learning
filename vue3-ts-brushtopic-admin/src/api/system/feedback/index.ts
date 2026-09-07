import request from "@/utils/request.ts";
import type { FeedbackQueryType } from "./type";

const prefix = "/system/feedback/";

export const apiGetFeedbackList = (query: FeedbackQueryType) => {
  return request({
    url: prefix + "list",
    method: "get",
    params: query
  });
};

export const apiReplyFeedback = (data: any) => {
  return request({
    url: prefix + "reply",
    method: "post",
    data
  });
};