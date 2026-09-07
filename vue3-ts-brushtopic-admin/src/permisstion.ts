
import router from '@/router'

import nprogress from 'nprogress'

import 'nprogress/nprogress.css'

import {
  useUserStore
} from './stores/modules/user.js'
import { message } from 'ant-design-vue'

const whiteList = ['/login', '/404', '/captchaImage', '/screen']
router.beforeEach(async (to, from, next) => {
  
  
  
  nprogress.start()
  
  const userStore = useUserStore()
  
  const token = userStore.token
  
  const account = userStore.userInfo?.account

  
  if (token) {
    
    if (to.path == '/login') {
      next('/')
    } else {
      
      if (account) {
        next()
        return
      } else {
        try {
          
          await userStore.getUserInfo()
          
          next({
            ...to
          })
        } catch (error) {
          console.log(error);
          message.success('请重新登录')
          
          await userStore.clearUserInfo()
          next('/login')
        }
      }
    }
  } else {
    if (whiteList.includes(to.path)) {
      console.log('不需要登录就可以访问');
      next()
    } else {
      console.log('没有token');
      next('/login')
    }
  }
})

router.afterEach(() => {
  nprogress.done()
})