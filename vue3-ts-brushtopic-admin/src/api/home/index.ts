import request from "@/utils/request.ts";

const prefix = "/topic/data/"

export const apiAdminHomeCount = () => {
    return request({
        url: prefix + "adminHomeCount",
        method: "get",
    })
}

export const apiAdminHomeCategory = () => {
    return request({
        url: prefix + "adminHomeCategory",
        method: "get",
    })
}

export const apiTopicTrend = () => {
    return request({
        url: prefix + "topicTrend",
        method: "get",
    })
}

export const apiUserTrend = () =>
    request.get(prefix + "userTrend");

export const apiAiTrend = () =>
    request.get(prefix + "aiTrend");

export const apiUserHomeCount = () =>
    request.get(prefix + "userHomeCount");

export const apiUserHomeCategory = () =>
    request.get(prefix + "userHomeCategory");

export const apiUserTopicCount = (date: string) =>
    request.get(prefix + "userTopicCount/" + date);

export const apiAdminModuleCount = () => {
    return request({
        url: prefix + "adminModuleCount",
        method: "get",
    })
}