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
      path: '/paper/:id/exam',
      name: 'PaperExam',
      component: () => import('@/views/PaperExam.vue'),
      meta: { title: '真题答题' },
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
          path: 'paper',
          name: 'PaperList',
          component: () => import('@/views/PaperList.vue'),
          meta: { title: '真题试卷' },
        },
        {
          path: 'vocabulary',
          name: 'Vocabulary',
          component: () => import('@/views/Vocabulary.vue'),
          meta: { title: '背单词' },
        },
        {
          path: 'vocabulary/review',
          name: 'WordReview',
          component: () => import('@/views/WordReview.vue'),
          meta: { title: '单词复习' },
        },
        {
          path: 'vocabulary/article',
          name: 'VocabArticleReader',
          component: () => import('@/views/VocabArticleReader.vue'),
          meta: { title: 'AI 短文阅读' },
        },
        {
          path: 'reading',
          name: 'ReadingList',
          component: () => import('@/views/ReadingList.vue'),
          meta: { title: '文章阅读' },
        },
        {
          path: 'reading/:id',
          name: 'ReadingDetail',
          component: () => import('@/views/ReadingDetail.vue'),
          meta: { title: '阅读文章' },
        },
        {
          path: 'writing',
          name: 'WritingList',
          component: () => import('@/views/WritingList.vue'),
          meta: { title: '作文批改' },
        },
        {
          path: 'writing/:id',
          name: 'WritingEditor',
          component: () => import('@/views/WritingEditor.vue'),
          meta: { title: '写作练习' },
        },
        {
          path: 'translation',
          name: 'TranslationList',
          component: () => import('@/views/TranslationList.vue'),
          meta: { title: '翻译练习' },
        },
        {
          path: 'translation/:id',
          name: 'TranslationPractice',
          component: () => import('@/views/TranslationPractice.vue'),
          meta: { title: '翻译练习' },
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
  document.title = to.meta.title ? `${to.meta.title} · CET备考` : 'CET备考'
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
