import request from '@/utils/request.js'

const prefix = '/topic/subject/'

export const apiQuerySubjectList = (categoryId) =>
  request(prefix + 'subject/' + categoryId)

export const apiQuerySubjectDetail = (id) =>
  request(prefix + 'subjectDetail/' + id)

