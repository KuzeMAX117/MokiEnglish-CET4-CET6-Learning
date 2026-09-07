import request from "@/utils/request.ts";
const prefix = "/system/"

export const apiGetCode = () => {
  return request({
    url: prefix + "captchaImage",
    method: "get",
    responseType: 'blob'  
  });
}

