import {
  defineStore
} from 'pinia';
import {
  ref
} from 'vue'
import { apiLogin, apiGetUserInfo, apiLogout } from '@/api/auth/index.ts'
import type { LoginType, UserResponse } from '@/api/auth/type';
import type { CommonResultType } from '@/api/common.ts'
import { message } from 'ant-design-vue';
import router from '@/router';
import { asyncRoute } from '@/router/routers';

export const useUserStore = defineStore('user', () => {
  
  const userInfo = ref<UserResponse>({
    account: '',
    avatar: '',
    identity: null,
    nickname: null,
    menuList: [],
    id: null
  });
  
  const token = ref<string | null>(null)
  
  const login = async (data: LoginType) => {
    const res = await apiLogin(data)
    console.log(res);
    
    if (res.code !== 200 && res.code !== '200') {
      message.error(res.message)
      return
    }
    
    token.value = res.token
    
    const userInfoRes = await getUserInfo()
    if (userInfoRes && userInfoRes.code === 200) {
      message.success("登录成功")
      router.push('/')
    }
  }
  
  const getUserInfo = async (): Promise<CommonResultType<UserResponse> | undefined> => {
    const res = await apiGetUserInfo(token.value)
    console.log(res);

    if (res.data) {
      userInfo.value = res.data
      
      if (!userInfo.value.menuList) {
        userInfo.value.menuList = []
      }
      
      userInfo.value.menuList.unshift({ ...asyncRoute })
    } else {
      message.error("获取用户信息失败")
      return undefined
    }
    return res
  }

  const clearUserInfo = () => {
    apiLogout()
    userInfo.value = {
      account: '',
      avatar: '',
      identity: null,
      menuList: [],
      nickname: null,
      id: null
    }
    token.value = null
    window.localStorage.removeItem("user")
  }

  const logout = () => {
    userInfo.value = {
      account: '',
      nickname: null,
      avatar: '',
      identity: null,
      menuList: [],
      id: null

    }
    token.value = null
    router.push('/login')
  }

  
  return {
    userInfo,
    getUserInfo,
    clearUserInfo,
    login,
    token,
    logout
  }
}, {
  persist: true
})