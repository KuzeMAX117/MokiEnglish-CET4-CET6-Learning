<template>
  <div class="home-dashboard">
    <div class="welcome-section">
      <div class="welcome-text">
        <div class="greeting">{{ greeting }}，{{ userStore.nickname }}</div>
        <div class="subtitle">今天也要加油备考哦，坚持就是胜利！</div>
      </div>
      <div class="quick-actions">
        <a-button type="primary" size="large" @click="router.push('/paper')">
          <template #icon><ThunderboltOutlined /></template>
          开始刷题
        </a-button>
        <a-button size="large" @click="router.push('/vocabulary')">
          <template #icon><BookOutlined /></template>
          背单词
        </a-button>
      </div>
    </div>

    <div class="entry-grid">
      <div class="entry-card" v-for="entry in entries" :key="entry.path" @click="router.push(entry.path)">
        <div class="entry-icon" :style="{ background: entry.bgColor, color: entry.color }">
          <component :is="entry.icon" />
        </div>
        <div class="entry-text">
          <div class="entry-name">{{ entry.name }}</div>
          <div class="entry-desc">{{ entry.desc }}</div>
        </div>
        <RightOutlined class="entry-arrow" />
      </div>
    </div>

    <div class="content-row">
      <div class="panel user-rank">
        <div class="panel-header">
          <span class="panel-title">
            <span class="title-bar"></span>
            排行榜
          </span>
          <a-button type="link" @click="router.push('/ranking')">查看全部</a-button>
        </div>
        <div class="rank-list">
          <div class="rank-item" v-for="(user, idx) in rankList" :key="idx">
            <div class="rank-num" :class="'rank-' + (idx + 1)">{{ idx + 1 }}</div>
            <a-avatar :size="32" :src="user.avatar" style="background: linear-gradient(135deg, #4257B2, #364899)">
              {{ (user.nickname || '').charAt(0) }}
            </a-avatar>
            <div class="rank-info">
              <div class="rank-name">{{ user.nickname }}</div>
              <div class="rank-count">{{ user.count }} 题</div>
            </div>
          </div>
          <a-empty v-if="!rankList.length" description="暂无排行数据" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import {
  ThunderboltOutlined,
  BookOutlined,
  RightOutlined,
  FileTextOutlined,
  TrophyOutlined,
  ReadOutlined,
  EditOutlined,
  SwapOutlined,
} from '@ant-design/icons-vue'
import { useUserStore } from '@/stores/user'
import { apiQueryRank } from '@/api/home'
import type { RankItem } from '@/types'

const router = useRouter()
const userStore = useUserStore()

const rankList = ref<RankItem[]>([])

const greeting = computed(() => {
  const h = new Date().getHours()
  if (h < 6) return '凌晨好'
  if (h < 12) return '上午好'
  if (h < 14) return '中午好'
  if (h < 18) return '下午好'
  return '晚上好'
})

const entries = [
  { name: '四级真题', desc: 'CET-4 历年真题', icon: FileTextOutlined, path: '/paper?level=4', bgColor: 'rgba(64, 169, 255, 0.1)', color: '#40A9FF' },
  { name: '六级真题', desc: 'CET-6 历年真题', icon: FileTextOutlined, path: '/paper?level=6', bgColor: 'rgba(115, 46, 209, 0.1)', color: '#722ED1' },
  { name: '作文批改', desc: 'AI 智能批改', icon: EditOutlined, path: '/writing', bgColor: 'rgba(250, 173, 20, 0.1)', color: '#FAAD14' },
  { name: '翻译练习', desc: '中英互译训练', icon: SwapOutlined, path: '/translation', bgColor: 'rgba(82, 196, 26, 0.1)', color: '#52C41A' },
  { name: '文章阅读', desc: '阅读理解提升', icon: ReadOutlined, path: '/reading', bgColor: 'rgba(22, 119, 255, 0.1)', color: '#1677FF' },
  { name: '背单词', desc: 'CET 核心词汇', icon: BookOutlined, path: '/vocabulary', bgColor: 'rgba(255, 77, 79, 0.1)', color: '#FF4D4F' },
  { name: '排行榜', desc: '学习排行', icon: TrophyOutlined, path: '/ranking', bgColor: 'rgba(250, 173, 20, 0.1)', color: '#FAAD14' },
]

const fetchData = async () => {
  try {
    const rankRes = await apiQueryRank('today')
    if (rankRes.code === 200) rankList.value = (rankRes.data || []).slice(0, 5)
  } catch (e) {
    // ignore
  }
}

onMounted(() => {
  fetchData()
})
</script>

<style scoped lang="scss">
.home-dashboard {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.welcome-section {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 32px 36px;
  border-radius: 16px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;

  .greeting {
    font-size: 28px;
    font-weight: 700;
  }

  .subtitle {
    margin-top: 8px;
    font-size: 15px;
    opacity: 0.85;
  }

  .quick-actions {
    display: flex;
    gap: 12px;
  }
}

.entry-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
}

.entry-card {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 20px 22px;
  border-radius: 12px;
  background: var(--page-bg);
  border: 1px solid var(--border);
  cursor: pointer;
  transition: box-shadow 0.2s, transform 0.2s;

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
  }

  .entry-icon {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 22px;
    flex-shrink: 0;
  }

  .entry-text {
    flex: 1;
    min-width: 0;

    .entry-name {
      font-size: 15px;
      font-weight: 600;
      color: var(--text-title);
    }

    .entry-desc {
      margin-top: 4px;
      font-size: 13px;
      color: var(--text-muted);
    }
  }

  .entry-arrow {
    color: var(--text-muted);
    font-size: 12px;
    flex-shrink: 0;
  }
}

.content-row {
  display: flex;
  gap: 20px;

  .panel {
    flex: 1;
    background: var(--page-bg);
    border-radius: 12px;
    border: 1px solid var(--border);
    padding: 20px;
  }

  .panel-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 16px;

    .panel-title {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 16px;
      font-weight: 600;
      color: var(--text-title);

      .title-bar {
        display: inline-block;
        width: 4px;
        height: 16px;
        border-radius: 2px;
        background: var(--primary, #40A9FF);
      }
    }
  }
}

.rank-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.rank-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 10px 12px;
  border-radius: 8px;
  background: var(--card-bg);
  border: 1px solid var(--border);

  .rank-num {
    width: 24px;
    height: 24px;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    font-weight: 700;
    background: #f0f0f0;
    color: #999;

    &.rank-1 { background: #fff7e6; color: #FAAD14; }
    &.rank-2 { background: #f0f5ff; color: #40A9FF; }
    &.rank-3 { background: #f6ffed; color: #52C41A; }
  }

  .rank-info {
    flex: 1;
    min-width: 0;

    .rank-name {
      font-size: 14px;
      font-weight: 500;
      color: var(--text-title);
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }

    .rank-count {
      font-size: 12px;
      color: var(--text-muted);
      margin-top: 2px;
    }
  }
}

@media (max-width: 1200px) {
  .entry-grid { grid-template-columns: repeat(2, 1fr); }
  .content-row { flex-direction: column; }
}

@media (max-width: 768px) {
  .welcome-section {
    flex-direction: column;
    text-align: center;
    gap: 20px;
  }

  .entry-grid { grid-template-columns: 1fr; }
}
</style>
