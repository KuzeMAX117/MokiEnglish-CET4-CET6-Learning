
export const asyncRoute = {
  label: '首页',
  key: '/home',
  icon: 'HomeOutlined'
}

export const constantRoute = [
  
  {
    path: '/login',
    component: () => import('@/views/login.vue'),
    name: 'login',
    meta: {
      title: '登录', 
      hidden: true, 
    },
  },
  
  {
    path: '/',
    component: () => import('../layout/index.vue'),
    name: 'layout',
    meta: {
      title: '首页',
    },
    redirect: '/home',
    children: [{
      path: '/home',
      component: () => import('@/views/index.vue'),
    },
    ]
  },
  
  {
    path: '/system',
    redirect: '/system/user',
    meta: {
      title: '系统管理',
    },
    component: () => import('../layout/index.vue'),
    children: [
      {
        path: '/system/user',
        component: () => import('@/views/system/user/index.vue'),
        meta: {
          title: '用户管理',
        },
      },
      {
        path: '/system/role',
        component: () => import('@/views/system/role/index.vue'),
        meta: {
          title: '角色管理',
        },
      },
      {
        path: '/system/menu',
        component: () => import('@/views/system/menu/index.vue'),
        meta: {
          title: '菜单管理',
        },
      },
      {
        path: '/system/feedback',
        component: () => import('@/views/system/feedback/index.vue'),
        meta: {
          title: '反馈管理',
        },
      }
    ]
  },
  
  {
    path: '/content',
    redirect: '/content/paper',
    meta: {
      title: '内容管理',
    },
    component: () => import('../layout/index.vue'),
    children: [
      {
        path: '/content/paper',
        component: () => import('@/views/content/paper/index.vue'),
        meta: {
          title: '试卷管理',
        },
      },
      {
        path: '/content/paper/editor/:id',
        component: () => import('@/views/content/paper/editor.vue'),
        meta: {
          title: '试卷编辑',
          hidden: true,
        },
      },
      {
        path: '/content/wordbook',
        component: () => import('@/views/content/wordbook/index.vue'),
        meta: {
          title: '词书管理',
        },
      },
      {
        path: '/content/article',
        component: () => import('@/views/content/article/index.vue'),
        meta: {
          title: '文章管理',
        },
      },
      {
        path: '/content/writing',
        component: () => import('@/views/content/writing/index.vue'),
        meta: {
          title: '作文记录',
        },
      },
      {
        path: '/content/translation',
        component: () => import('@/views/content/translation/index.vue'),
        meta: {
          title: '翻译记录',
        },
      }
    ]
  },
  
  {
    path: '/pk',
    redirect: '/pk/rank',
    meta: {
      title: 'PK管理',
    },
    component: () => import('../layout/index.vue'),
    children: [
      {
        path: '/pk/rank',
        component: () => import('@/views/pk/rank/index.vue'),
        meta: {
          title: '排行榜',
        },
      },
      {
        path: '/pk/record',
        component: () => import('@/views/pk/record/index.vue'),
        meta: {
          title: '对战记录',
        },
      }
    ]
  },
  

  {
    path: '/profile',
    component: () => import('../layout/index.vue'),
    redirect: '/profile/index',
    meta: {
      title: '个人中心',
    },
    children: [{
      path: '/profile/index',
      meta: {
        title: '个人中心',
      },
      component: () => import('@/views/profile/index.vue'),
    }]
  },
  
  {
    path: '/screen',
    component: () => import('@/views/screen/index.vue'),
    meta: {
      title: '数据大屏',
    },
  },
  
  {
    path: '/404',
    component: () => import('@/views/404.vue'),
    name: '404',
    meta: {
      title: '404',
      hidden: true,
      icon: '',
    },
  },
  {
    
    path: '/:pathMatch(.*)*',
    redirect: '/404',
    name: 'Any',
    meta: {
      title: '任意路由',
    },
  }
]
