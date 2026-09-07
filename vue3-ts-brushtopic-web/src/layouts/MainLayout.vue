<template>
  <div class="app-shell">
    
    <div class="bg-glow">
      <div class="glow-orb orb-1"></div>
      <div class="glow-orb orb-2"></div>
    </div>

    
    <aside class="sidebar">
      <div class="sidebar-brand" @click="router.push('/home')">
        <div class="brand-logo">
          <span class="logo-glyph">H</span>
          <span class="logo-pulse"></span>
        </div>
        <div class="brand-text">
          <span class="brand-name">HaoAi</span>
          <span class="brand-sub">刷题引擎</span>
        </div>
      </div>

      <div class="nav-section">
        <div class="nav-caption">导航菜单</div>
        <nav class="sidebar-nav">
          <div
            v-for="item in navItems"
            :key="item.key"
            class="nav-item"
            :class="{ active: isActive(item.key) }"
            @click="router.push(item.key)"
          >
            <component :is="item.icon" class="nav-icon" />
            <span class="nav-label">{{ item.label }}</span>
            <span class="nav-indicator"></span>
          </div>
        </nav>
      </div>

      <div class="sidebar-foot">
        <div class="mini-links">
          <div class="mini-link" @click="router.push('/favorite')">
            <StarOutlined />
            <span>我的收藏</span>
          </div>
          <div class="mini-link" @click="router.push('/feedback')">
            <MessageOutlined />
            <span>我的反馈</span>
          </div>
        </div>

        <a-dropdown placement="top" :trigger="['click']">
          <div class="user-card">
            <div class="avatar-ring">
              <a-avatar v-if="userStore.userInfo?.avatar" :src="userStore.userInfo.avatar" :size="42" />
              <a-avatar v-else :size="42" style="background: linear-gradient(135deg, #8b5cf6, #22d3ee)">
                {{ userStore.nickname.charAt(0).toUpperCase() }}
              </a-avatar>
            </div>
            <div class="user-info">
              <span class="user-name">{{ userStore.nickname }}</span>
              <span class="user-role">{{ roleName }}</span>
            </div>
            <DownOutlined class="user-more" />
          </div>
          <template #overlay>
            <a-menu @click="onUserMenuClick">
              <a-menu-item key="user">
                <UserOutlined /> 个人中心
              </a-menu-item>
              <a-menu-item key="favorite">
                <StarOutlined /> 我的收藏
              </a-menu-item>
              <a-menu-item key="feedback">
                <MessageOutlined /> 我的反馈
              </a-menu-item>
              <a-menu-divider />
              <a-menu-item key="logout">
                <LogoutOutlined /> 退出登录
              </a-menu-item>
            </a-menu>
          </template>
        </a-dropdown>
      </div>
    </aside>

    
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
                <a-avatar v-else :size="30" style="background: linear-gradient(135deg, #8b5cf6, #22d3ee)">
                  {{ userStore.nickname.charAt(0).toUpperCase() }}
                </a-avatar>
              </div>
            </div>
            <template #overlay>
              <a-menu @click="onUserMenuClick">
                <a-menu-item key="user">
                  <UserOutlined /> 个人中心
                </a-menu-item>
                <a-menu-item key="favorite">
                  <StarOutlined /> 我的收藏
                </a-menu-item>
                <a-menu-item key="feedback">
                  <MessageOutlined /> 我的反馈
                </a-menu-item>
                <a-menu-divider />
                <a-menu-item key="logout">
                  <LogoutOutlined /> 退出登录
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
  UserOutlined,
  StarOutlined,
  MessageOutlined,
  LogoutOutlined,
  HomeOutlined,
  DatabaseOutlined,
  RobotOutlined,
  TrophyOutlined,
  DownOutlined,
} from '@ant-design/icons-vue'
import { useUserStore } from '@/stores/user'
import { apiLogout } from '@/api/auth'

const router = useRouter()
const route = useRoute()
const userStore = useUserStore()

const navItems = [
  { key: '/home', label: '首页', icon: HomeOutlined },
  { key: '/database', label: '题库', icon: DatabaseOutlined },
  { key: '/ai', label: 'AI 问答', icon: RobotOutlined },
  { key: '/ranking', label: '排行榜', icon: TrophyOutlined },
]

const isActive = (key: string) => {
  const p = route.path
  if (key === '/home') return p === '/home'
  if (key === '/database') return p.startsWith('/database') || p.startsWith('/subject') || p.startsWith('/topic')
  if (key === '/ai') return p === '/ai'
  if (key === '/ranking') return p === '/ranking'
  return false
}

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

const onUserMenuClick = ({ key }: { key: string }) => {
  if (key === 'logout') {
    Modal.confirm({
      title: '确认退出登录？',
      content: '退出后需要重新登录才能继续刷题',
      okText: '退出',
      cancelText: '取消',
      onOk: async () => {
        try {
          await apiLogout()
        } catch (e) {
          
        }
        userStore.clear()
        message.success('已退出登录')
        router.push('/login')
      },
    })
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
    opacity: 0.26;
  }

  .orb-1 {
    width: 540px;
    height: 540px;
    top: -200px;
    left: 32%;
    background: radial-gradient(circle, #8b5cf6, transparent 70%);
    animation: float 14s infinite ease-in-out;
  }

  .orb-2 {
    width: 480px;
    height: 480px;
    bottom: -180px;
    right: 8%;
    background: radial-gradient(circle, #22d3ee, transparent 70%);
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

.sidebar {
  position: relative;
  z-index: 20;
  width: 248px;
  flex-shrink: 0;
  height: 100vh;
  display: flex;
  flex-direction: column;
  background: rgba(12, 16, 30, 0.82);
  backdrop-filter: blur(20px);
  border-right: 1px solid rgba(255, 255, 255, 0.07);
}

.sidebar-brand {
  display: flex;
  align-items: center;
  padding: 22px 24px;
  cursor: pointer;
  border-bottom: 1px solid rgba(255, 255, 255, 0.06);

  .brand-logo {
    position: relative;
    width: 40px;
    height: 40px;
    border-radius: 12px;
    background: linear-gradient(135deg, #8b5cf6, #22d3ee);
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 12px;
    box-shadow: 0 0 22px rgba(139, 92, 246, 0.55);

    .logo-glyph {
      color: #fff;
      font-weight: 800;
      font-size: 21px;
      text-shadow: 0 0 12px rgba(255, 255, 255, 0.6);
    }

    .logo-pulse {
      position: absolute;
      inset: -3px;
      border-radius: 14px;
      border: 1px solid rgba(139, 92, 246, 0.6);
      animation: pulse 2.4s infinite;
    }
  }

  .brand-text {
    display: flex;
    flex-direction: column;
    line-height: 1.15;

    .brand-name {
      font-size: 18px;
      font-weight: 800;
      background: linear-gradient(90deg, #a78bfa, #22d3ee);
      -webkit-background-clip: text;
      background-clip: text;
      -webkit-text-fill-color: transparent;
      letter-spacing: 0.5px;
    }

    .brand-sub {
      font-size: 10px;
      color: #6b7693;
      letter-spacing: 3px;
    }
  }
}

@keyframes pulse {
  0%,
  100% {
    opacity: 0.6;
    transform: scale(1);
  }
  50% {
    opacity: 0.1;
    transform: scale(1.14);
  }
}

.nav-section {
  flex: 1;
  overflow-y: auto;
  padding: 18px 16px;

  .nav-caption {
    font-size: 11px;
    letter-spacing: 3px;
    color: #56618a;
    padding: 0 12px 10px;
  }

  .sidebar-nav {
    display: flex;
    flex-direction: column;
    gap: 6px;
  }

  .nav-item {
    position: relative;
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 14px;
    border-radius: 12px;
    font-size: 14px;
    color: #9aa4bd;
    cursor: pointer;
    transition: all 0.25s;
    overflow: hidden;

    .nav-icon {
      font-size: 17px;
      flex-shrink: 0;
      transition: all 0.25s;
    }

    .nav-label {
      flex: 1;
    }

    .nav-indicator {
      width: 4px;
      height: 4px;
      border-radius: 50%;
      background: transparent;
      transition: all 0.25s;
    }

    &:hover {
      color: #e5eaf3;
      background: rgba(255, 255, 255, 0.05);
    }

    &.active {
      color: #fff;
      background: linear-gradient(90deg, rgba(139, 92, 246, 0.32), rgba(34, 211, 238, 0.16));
      box-shadow: inset 0 0 0 1px rgba(139, 92, 246, 0.4);

      .nav-icon {
        color: #22d3ee;
        filter: drop-shadow(0 0 8px rgba(34, 211, 238, 0.7));
      }

      .nav-indicator {
        background: #22d3ee;
        box-shadow: 0 0 10px #22d3ee;
      }

      &::before {
        content: '';
        position: absolute;
        left: 0;
        top: 50%;
        transform: translateY(-50%);
        width: 4px;
        height: 24px;
        border-radius: 4px;
        background: linear-gradient(180deg, #8b5cf6, #22d3ee);
        box-shadow: 0 0 12px rgba(139, 92, 246, 0.8);
      }
    }
  }
}

.sidebar-foot {
  padding: 16px;
  border-top: 1px solid rgba(255, 255, 255, 0.06);

  .mini-links {
    display: flex;
    gap: 8px;
    margin-bottom: 12px;

    .mini-link {
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 6px;
      padding: 9px 0;
      border-radius: 10px;
      font-size: 12px;
      color: #8b95b5;
      background: rgba(255, 255, 255, 0.04);
      border: 1px solid rgba(255, 255, 255, 0.06);
      cursor: pointer;
      transition: all 0.25s;

      &:hover {
        color: #22d3ee;
        border-color: rgba(34, 211, 238, 0.4);
        background: rgba(34, 211, 238, 0.08);
      }
    }
  }

  .user-card {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 14px;
    border-radius: 14px;
    cursor: pointer;
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.08);
    transition: all 0.25s;

    &:hover {
      border-color: rgba(139, 92, 246, 0.5);
      background: rgba(255, 255, 255, 0.08);
    }

    .avatar-ring {
      border-radius: 50%;
      padding: 2px;
      background: conic-gradient(#8b5cf6, #22d3ee, #8b5cf6);
      display: inline-flex;
      flex-shrink: 0;
    }

    .user-info {
      flex: 1;
      min-width: 0;
      display: flex;
      flex-direction: column;

      .user-name {
        font-size: 14px;
        color: #e5eaf3;
        font-weight: 600;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }

      .user-role {
        font-size: 11px;
        color: #8b95b5;
        margin-top: 2px;
      }
    }

    .user-more {
      font-size: 11px;
      color: #56618a;
    }
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
  background: rgba(11, 15, 26, 0.6);
  backdrop-filter: blur(16px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.06);

  .page-title-box {
    .page-title {
      font-size: 18px;
      font-weight: 700;
      color: #e5eaf3;
      letter-spacing: 0.5px;
    }
  }

  .topbar-right {
    display: flex;
    align-items: center;
    gap: 18px;

    .date-text {
      font-size: 13px;
      color: #7c86a6;
    }

    .user-chip {
      cursor: pointer;
      display: flex;
      align-items: center;

      .avatar-ring {
        border-radius: 50%;
        padding: 2px;
        background: conic-gradient(#8b5cf6, #22d3ee, #8b5cf6);
        display: inline-flex;
        transition: all 0.25s;
      }

      &:hover .avatar-ring {
        box-shadow: 0 0 14px rgba(139, 92, 246, 0.6);
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
  max-width: 1500px;
  margin: 0 auto;
}
</style>
