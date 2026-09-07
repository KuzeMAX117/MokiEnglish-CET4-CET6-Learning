import axios from 'axios'
import { message } from 'ant-design-vue'
import { useUserStore } from '@/stores/user'
import router from '@/router'

const request = axios.create({
  baseURL: import.meta.env.VITE_APP_BASE_API || '/api',
  timeout: 120000,
})

request.interceptors.request.use((config) => {
  const userStore = useUserStore()
  if (userStore.token) {
    config.headers.Authorization = userStore.token
  }
  return config
})

request.interceptors.response.use(
  (response) => response.data,
  (error) => {
    const status = error.response?.status
    if (status === 401) {
      message.error('登录过期，请重新登录')
      const userStore = useUserStore()
      userStore.clear()
      router.push('/login')
      return Promise.reject(error)
    }
    message.error(error.response?.data?.message || '请求错误')
    return Promise.reject(error)
  }
)

export default request
