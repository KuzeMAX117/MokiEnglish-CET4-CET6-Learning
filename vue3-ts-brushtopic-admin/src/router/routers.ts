
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
          title: '菜单管理',
        },
      },
      {
        path: '/system/menu',
        component: () => import('@/views/system/menu/index.vue'),
        meta: {
          title: '角色管理',
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
    path: '/topic',
    redirect: '/topic/topic',
    meta: {
      title: '题库管理',
    },
    component: () => import('../layout/index.vue'),
    children: [
      {
        path: '/topic/topic',
        component: () => import('@/views/topic/topic/index.vue'),
        meta: {
          title: '题目管理',
        },
      },

      {
        path: '/topic/category',
        component: () => import('@/views/topic/category/index.vue'),
        meta: {
          title: '分类管理',
        },
      },
      {
        path: '/topic/label',
        component: () => import('@/views/topic/label/index.vue'),
        meta: {
          title: '标签管理',
        },
      },
      {
        path: '/topic/subject',
        component: () => import('@/views/topic/subject/index.vue'),
        meta: {
          title: '专题管理',
        },
      },
      {
        path: '/topic/paper',
        component: () => import('@/views/topic/paper/index.vue'),
        meta: {
          title: '试卷管理',
        },
      },
      {
        path: '/topic/paper/editor/:id',
        component: () => import('@/views/topic/paper/editor.vue'),
        meta: {
          title: '试卷编辑',
          hidden: true,
        },
      }
    ]
  },
  
  {
    path: '/ai',
    component: () => import('@/layout/index.vue'),
    redirect: '/ai/manage',
    meta: {
      title: '模型管理',
    },
    children: [{
      path: '/ai/manage',
      meta: {
        title: 'AI管理',
      },
      component: () => import('@/views/ai/manage/index.vue'),
    },
    {
      path: '/ai/model',
      meta: {
        title: 'AI模型',
      },
      component: () => import('@/views/ai/model/index.vue'),
    }
    ]
  },
  
  {
    path: '/profile',
    component: () => import('@/layout/index.vue'),
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
