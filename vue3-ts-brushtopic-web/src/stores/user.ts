import { defineStore } from 'pinia'
import type { UserInfo } from '@/types'

interface UserState {
  token: string
  userInfo: UserInfo | null
  role: number
}

export const useUserStore = defineStore('user', {
  state: (): UserState => ({
    token: localStorage.getItem('web_token') || '',
    userInfo: JSON.parse(localStorage.getItem('web_user_info') || 'null'),
    role: Number(localStorage.getItem('web_role') || 0),
  }),
  getters: {
    isLogin: (state) => !!state.token,
    nickname: (state) => state.userInfo?.nickname || state.userInfo?.account || '同学',
  },
  actions: {
    setLogin(token: string, userInfo: UserInfo, role: number) {
      this.token = token
      this.userInfo = userInfo
      this.role = role
      localStorage.setItem('web_token', token)
      localStorage.setItem('web_user_info', JSON.stringify(userInfo))
      localStorage.setItem('web_role', String(role))
    },
    setUserInfo(userInfo: UserInfo) {
      this.userInfo = userInfo
      localStorage.setItem('web_user_info', JSON.stringify(userInfo))
    },
    clear() {
      this.token = ''
      this.userInfo = null
      this.role = 0
      localStorage.removeItem('web_token')
      localStorage.removeItem('web_user_info')
      localStorage.removeItem('web_role')
    },
  },
})
