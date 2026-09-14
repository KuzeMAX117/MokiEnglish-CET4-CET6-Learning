<template>
  <div class="app-shell">
    
    <div class="bg-glow">
      <div class="glow-orb orb-1"></div>
      <div class="glow-orb orb-2"></div>
    </div>

    
    <Sidebar
      :menu-groups="sidebarMenuGroups"
      :user-info="sidebarUserInfo"
      :active-key="activeNavKey"
      @item-click="onSidebarItemClick"
      @logout="handleLogout"
    />

    
    <div class="main-area">
      <header class="topbar">
        <div class="page-title-box">
          <span class="page-title">{{ routeTitle }}</span>
        </div>
        <div class="topbar-right">
          <span class="date-text">{{ todayStr }}</span>
          <a-dropdown placement="bottomRight">
            <div class="user-chip">
              <div class="avatar-ring">
                <a-avatar v-if="userStore.userInfo?.avatar" :src="userStore.userInfo.avatar" :size="30" />
                <a-avatar v-else :size="30" style="background: linear-gradient(135deg, #4257B2, #364899)">
                  {{ userStore.nickname.charAt(0).toUpperCase() }}
                </a-avatar>
              </div>
            </div>
            <template #overlay>
              <a-menu @click="onUserMenuClick">
                <a-menu-item key="user">
                  <component :is="User" :size="14" /> 个人中心
                </a-menu-item>
                <a-menu-item key="favorite">
                  <component :is="Star" :size="14" /> 我的收藏
                </a-menu-item>
                <a-menu-item key="feedback">
                  <component :is="MessageSquare" :size="14" /> 我的反馈
                </a-menu-item>
                <a-menu-divider />
                <a-menu-item key="logout">
                  <component :is="LogOut" :size="14" /> 退出登录
                </a-menu-item>
              </a-menu>
            </template>
          </a-dropdown>
        </div>
      </header>

      <main class="main">
        <div class="main-inner">
          <router-view />
        </div>
      </main>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { Modal, message } from 'ant-design-vue'
import {
  Home,
  Database,
  Trophy,
  BookOpen,
  FileText,
  Pencil,
  Languages,
  Star,
  MessageSquare,
  User,
  LogOut,
  ChevronDown,
  Zap,
} from 'lucide-vue-next'
import { useUserStore } from '@/stores/user'
import { apiLogout } from '@/api/auth'
import Sidebar from '@/components/ui/sidebar.vue'
import type { SidebarMenuGroup, SidebarUserInfo } from '@/components/ui/sidebar.vue'

const router = useRouter()
const route = useRoute()
const userStore = useUserStore()

/* ── Sidebar data ── */

const navItems = [
  { key: '/home', label: '首页', icon: Home },
  { key: '/paper', label: '真题刷题', icon: Database },
  { key: '/vocabulary', label: '背单词', icon: BookOpen },
  { key: '/reading', label: '文章阅读', icon: FileText },
  { key: '/writing', label: '作文批改', icon: Pencil },
  { key: '/translation', label: '翻译练习', icon: Languages },
  { key: '/pk', label: '词汇量PK', icon: Zap },
  { key: '/ranking', label: '排行榜', icon: Trophy },
]

const sidebarMenuGroups = computed<SidebarMenuGroup[]>(() => [
  {
    key: 'nav',
    label: '导航菜单',
    items: navItems,
  },
  {
    key: 'quick',
    label: '快捷入口',
    items: [
      { key: '/favorite', label: '我的收藏', icon: Star },
      { key: '/feedback', label: '我的反馈', icon: MessageSquare },
    ],
  },
])

const sidebarUserInfo = computed<SidebarUserInfo>(() => ({
  name: userStore.nickname,
  email: userStore.userInfo?.email || roleName.value,
  avatar: userStore.userInfo?.avatar,
}))

const activeNavKey = computed(() => {
  const p = route.path
  for (const item of navItems) {
    if (item.key === '/home' && p === '/home') return item.key
    if (item.key !== '/home' && p.startsWith(item.key)) return item.key
  }
  return p
})

const onSidebarItemClick = (key: string) => {
  router.push(key)
}

/* ── Topbar ── */

const routeTitle = computed(() => route.meta.title || '')

const todayStr = computed(() => {
  const d = new Date()
  const week = ['日', '一', '二', '三', '四', '五', '六'][d.getDay()]
  return `${d.getFullYear()}年${d.getMonth() + 1}月${d.getDate()}日 星期${week}`
})

const roleName = computed(() => {
  const names: Record<number, string> = { 2: '管理员', 1: '普通会员', 0: '普通用户' }
  return names[userStore.role] || '普通用户'
})

const handleLogout = () => {
  Modal.confirm({
    title: '确认退出登录？',
    content: '退出后需要重新登录才能继续备考',
    okText: '退出',
    cancelText: '取消',
    onOk: async () => {
      try {
        await apiLogout()
      } catch (e) {
        // ignore
      }
      userStore.clear()
      message.success('已退出登录')
      router.push('/login')
    },
  })
}

const onUserMenuClick = ({ key }: { key: string }) => {
  if (key === 'logout') {
    handleLogout()
    return
  }
  router.push('/' + key)
}
</script>

<style scoped lang="scss">
.app-shell {
  height: 100vh;
  display: flex;
  position: relative;
  overflow: hidden;
  background: var(--card-bg);
  transition: background-color 0.3s ease;
}

.bg-glow {
  position: fixed;
  inset: 0;
  z-index: 0;
  pointer-events: none;
  overflow: hidden;

  .glow-orb {
    position: absolute;
    border-radius: 50%;
    filter: blur(120px);
  }

  .orb-1 {
    width: 540px;
    height: 540px;
    top: -200px;
    left: 32%;
    background: radial-gradient(circle, rgba(66, 87, 178, 0.1), transparent 70%);
    animation: float 14s infinite ease-in-out;
  }

  .orb-2 {
    width: 480px;
    height: 480px;
    bottom: -180px;
    right: 8%;
    background: radial-gradient(circle, rgba(66, 87, 178, 0.06), transparent 70%);
    animation: float 18s infinite ease-in-out reverse;
  }
}

@keyframes float {
  0%,
  100% {
    transform: translateY(0) scale(1);
  }
  50% {
    transform: translateY(-40px) scale(1.08);
  }
}

.main-area {
  position: relative;
  z-index: 1;
  flex: 1;
  min-width: 0;
  height: 100vh;
  display: flex;
  flex-direction: column;
}

.topbar {
  height: 64px;
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 32px;
  background: var(--page-bg);
  border-bottom: 1px solid var(--border);
  transition: background-color 0.3s ease;

  .page-title-box {
    .page-title {
      font-size: calc(18px + var(--font-offset, 0px));
      font-weight: 700;
      color: var(--text-title);
      letter-spacing: 0.5px;
    }
  }

  .topbar-right {
    display: flex;
    align-items: center;
    gap: 18px;

    .date-text {
      font-size: calc(13px + var(--font-offset, 0px));
      color: var(--text-muted);
    }

    .user-chip {
      cursor: pointer;
      display: flex;
      align-items: center;

      .avatar-ring {
        border-radius: 50%;
        padding: 2px;
        background: linear-gradient(135deg, #4257B2, #364899);
        display: inline-flex;
        transition: all 0.25s;
      }

      &:hover .avatar-ring {
        box-shadow: 0 0 10px rgba(66, 87, 178, 0.35);
      }
    }
  }
}

.main {
  flex: 1;
  overflow-y: auto;
  padding: 28px 32px 48px;
}

.main-inner {
  max-width: 1650px;
  margin: 0 auto;
}
</style>
