import request from "@/utils/request.js";
const prefix = "/system/"

export const apiGetConfig = (status) => {
  return request({
    url: prefix + "config/" + status,
    method: "get",
  });
}