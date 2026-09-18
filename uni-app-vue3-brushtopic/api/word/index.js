import request from '@/utils/request.js'

export const apiGetBooks = () => {
  return request({
    url: '/system/word/books',
    method: 'GET'
  })
}

export const apiSelectBook = (data) => {
  return request({
    url: '/system/word/selectBook',
    method: 'POST',
    data
  })
}

export const apiGetWordSetting = () => {
  return request({
    url: '/system/word/setting',
    method: 'GET'
  })
}

export const apiGetTodayWords = () => {
  return request({
    url: '/system/word/today',
    method: 'GET'
  })
}

export const apiSubmitWordResult = (data) => {
  return request({
    url: '/system/word/studyResult',
    method: 'POST',
    data
  })
}
