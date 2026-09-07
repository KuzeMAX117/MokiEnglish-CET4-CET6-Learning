import request from "@/utils/request.ts";

const prefix = "/system/notice/";

export const apiGetNoticeList = () => {
  return request.get(prefix + "list");
}

export const apiGetNoticeHas = () => {
  return request.get(prefix + "has");
}

export const apiReadNotice = (idsList: any[]) => {
  return request({
    url: prefix + "read",
    method: "put",
    data: {
      idsList: idsList
    }
  });
}