import request from "@/utils/request.js";
const prefix = "/topic/data/"

export const apiQueryWebHomeCount = () =>
  request(prefix + 'webHomeCount')

export const apiQueryRank = () =>
  request(prefix + 'rank')

export const apiQueryUserRank = () =>
  request(prefix + 'userRank')

export const apiQueryTopicTodayVo = () =>
  request(prefix + 'topicTodayVo')

export const apiFlushTopic = (id) =>
  request(prefix + 'flush/' + id)