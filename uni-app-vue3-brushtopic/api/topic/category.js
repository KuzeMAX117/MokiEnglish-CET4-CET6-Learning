import request from '@/utils/request.js'

const prefix = '/topic/category/'

export const apiQueryCategoryList = (isCustomQuestion) =>
  request(prefix + 'category/' + isCustomQuestion)