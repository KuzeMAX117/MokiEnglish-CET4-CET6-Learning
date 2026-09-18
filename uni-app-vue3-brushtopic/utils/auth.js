export const isLogin = () => {
  const user = uni.getStorageSync('h5UserInfo')
  const pages = getCurrentPages()
  const currentPage = pages[pages.length - 1]?.route || ''
  
  
  if (!user && currentPage !== 'pages/login/login') {
    uni.reLaunch({
      url: "/pages/login/login"
    })
    return
  }

  
  if (user && currentPage === 'pages/login/login') {
    uni.reLaunch({
      url: "/pages/index/index"
    })
    return
  }
}

export const clearStorage = () => {
  
  const userInfo = JSON.parse(uni.getStorageSync('h5UserInfo'))
  uni.removeStorageSync('h5UserInfo')
  uni.removeStorageSync(userInfo.account + "token")
  uni.removeStorageSync("role")
}
