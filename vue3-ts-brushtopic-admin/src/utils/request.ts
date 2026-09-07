
import axios from 'axios'
import { message } from 'ant-design-vue';

import {
  useUserStore
} from '@/stores/modules/user.js'
import router from '@/router'

const request = axios.create({
  
  baseURL: import.meta.env.VITE_APP_BASE_API, 
  timeout: 100000, 
})

request.interceptors.request.use((config) => {
  
  const userStore = useUserStore()
  
  if (userStore.token) {
    
    config.headers.Authorization = userStore.token
  }
  
  
  return config
})

request.interceptors.response.use(
  (response) => {
    
    return response.data
  },
  (error) => {
    console.log(error);

    const status = error.response.status
    const userStore = useUserStore()

    if (status === 401) {
      
      
      message.error('登录过期 请重新登录')
      router.push('/login')
      userStore.clearUserInfo()
      return
    }
    
    message.error(error.response.data.message)
    return Promise.reject(error)
  },
)

export default request