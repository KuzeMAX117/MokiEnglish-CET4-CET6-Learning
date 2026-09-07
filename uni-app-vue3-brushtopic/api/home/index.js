import request from "@/utils/request.js";
const prefix = "/topic/data/"

export const apiQueryWebHomeCount = () =>
  request(prefix + 'webHomeCount')

export const apiQueryRank = (type) =>
  request(prefix + 'rank/' + type)

export const apiQueryUserRank = (type) =>
  request(prefix + 'userRank/' + type)

export const apiQueryTopicTodayVo = () =>
  request(prefix + 'topicTodayVo')

export const apiFlushTopic = (id) =>
  request(prefix + 'flush/' + id)