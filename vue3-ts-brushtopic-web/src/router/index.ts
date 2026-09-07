import { createRouter, createWebHistory } from 'vue-router'
import { useUserStore } from '@/stores/user'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/login',
      name: 'Login',
      component: () => import('@/views/Login.vue'),
      meta: { title: '登录' },
    },
    {
      path: '/',
      component: () => import('@/layouts/MainLayout.vue'),
      redirect: '/home',
      children: [
        {
          path: 'home',
          name: 'Home',
          component: () => import('@/views/Home.vue'),
          meta: { title: '首页' },
        },
        {
          path: 'ranking',
          name: 'Ranking',
          component: () => import('@/views/Ranking.vue'),
          meta: { title: '排行榜' },
        },
        {
          path: 'database',
          name: 'Database',
          component: () => import('@/views/Database.vue'),
          meta: { title: '题库' },
        },
        {
          path: 'subject/:id',
          name: 'Subject',
          component: () => import('@/views/Subject.vue'),
          meta: { title: '专题' },
        },
        {
          path: 'paper',
          name: 'PaperList',
          component: () => import('@/views/PaperList.vue'),
          meta: { title: '真题试卷' },
        },
        {
          path: 'paper/:id/exam',
          name: 'PaperExam',
          component: () => import('@/views/PaperExam.vue'),
          meta: { title: '真题答题' },
        },
        {
          path: 'topic/:id',
          name: 'TopicDetail',
          component: () => import('@/views/TopicDetail.vue'),
          meta: { title: '刷题' },
        },
        {
          path: 'ai',
          name: 'AiChat',
          component: () => import('@/views/AiChat.vue'),
          meta: { title: 'AI 问答' },
        },
        {
          path: 'user',
          name: 'UserCenter',
          component: () => import('@/views/UserCenter.vue'),
          meta: { title: '个人中心' },
        },
        {
          path: 'favorite',
          name: 'Favorite',
          component: () => import('@/views/Favorite.vue'),
          meta: { title: '我的收藏' },
        },
        {
          path: 'feedback',
          name: 'Feedback',
          component: () => import('@/views/Feedback.vue'),
          meta: { title: '我的反馈' },
        },
      ],
    },
  ],
})

router.beforeEach((to) => {
  document.title = to.meta.title ? `${to.meta.title} · HaoAi 刷题` : 'HaoAi 刷题'
  const userStore = useUserStore()
  if (!userStore.isLogin && to.name !== 'Login') {
    return { name: 'Login', query: { redirect: to.fullPath } }
  }
  if (to.name === 'Login' && userStore.isLogin) {
    return { name: 'Home' }
  }
  return true
})

export default router
