
import axios from 'axios'
import { clearStorage } from '@/utils/auth'

const request = axios.create({
  
  baseURL: "http://localhost:9993/api", 
  timeout: 100000, 
})

request.interceptors.request.use((config) => {
  
  const userInfo = uni.getStorageSync('h5UserInfo')
  if (userInfo) {
    const json =  JSON.parse(userInfo)
    config.headers.Authorization = uni.getStorageSync(json.account + 'token')
  }
  
  return config
})

request.interceptors.response.use(
  (response) => {
    
    return response.data
  },
  (error) => {
    console.log("error1", error);

    console.log(error);

    const status = error.response.status

    if (status === 401) {
      
      
      uni.showToast({
        title: '登录过期 请重新登录',
        icon: 'error',
        duration: 2000
      });
      clearStorage()
      
      setTimeout(() => {
        uni.reLaunch({
          url: '/pages/login/login',
        })
      }, 1500)
      return
    }

    
    uni.showToast({
      title: error.response.data.message || '请求错误',
      icon: 'error',
      duration: 2000
    });
    return Promise.reject(error)
  },
)

export default request