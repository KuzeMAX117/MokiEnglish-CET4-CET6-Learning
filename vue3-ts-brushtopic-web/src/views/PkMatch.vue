<template>
  <div class="pk-match-page">
    <div class="match-header">
      <h2 class="page-title">
        <ThunderboltFilled class="title-icon" />
        词汇量 PK
      </h2>
      <p class="page-desc">与对手实时对战，比拼词汇量</p>
    </div>

    <div class="match-card">
      <div v-if="!matched && !matching" class="match-waiting">
        <div class="match-icon">⚔</div>
        <h3>准备开始 PK</h3>
        <p>每人 10 道题，答对得分高者获胜</p>
        <a-button type="primary" size="large" class="start-btn" @click="startMatch">
          <ThunderboltFilled /> 开始匹配
        </a-button>
      </div>

      <div v-else-if="matching && !matched" class="matching-animation">
        <div class="spinner"></div>
        <h3>正在匹配对手...</h3>
        <p>已等待 {{ matchTime }} 秒</p>
        <a-button @click="cancelMatch">取消匹配</a-button>
      </div>

      <div v-else-if="matched" class="match-success">
        <div class="success-icon">✓</div>
        <h3>匹配成功！</h3>
        <p>即将进入对战...</p>
      </div>
    </div>

    <div class="stats-row">
      <div class="stat-item">
        <div class="stat-value">{{ stats.levelName || 'Lv1 初学者' }}</div>
        <div class="stat-label">当前等级</div>
      </div>
      <div class="stat-item">
        <div class="stat-value">{{ stats.totalGames }}</div>
        <div class="stat-label">总场次</div>
      </div>
      <div class="stat-item">
        <div class="stat-value">{{ stats.winRate }}%</div>
        <div class="stat-label">胜率</div>
      </div>
      <div class="stat-item">
        <div class="stat-value">#{{ stats.totalRank || '-' }}</div>
        <div class="stat-label">全站排名</div>
      </div>
    </div>

    <div class="rank-section">
      <div class="section-head">
        <h3>今日排行榜</h3>
        <a-button type="link" @click="router.push('/pk/rank')">查看全部</a-button>
      </div>
      <div class="rank-list">
        <div v-for="(item, index) in todayRank" :key="item.userId" class="rank-item">
          <div class="rank-no" :class="{ top3: index < 3 }">{{ index + 1 }}</div>
          <div class="rank-info">
            <div class="rank-avatar">
              <a-avatar v-if="item.avatar" :src="item.avatar" :size="36" />
              <a-avatar v-else :size="36" style="background: linear-gradient(135deg, #4257B2, #364899)">
                {{ (item.nickname || 'U').charAt(0) }}
              </a-avatar>
            </div>
            <div class="rank-detail">
              <div class="rank-name">{{ item.nickname || '用户' + item.userId }}</div>
              <div class="rank-score">{{ item.score }} 积分</div>
            </div>
          </div>
        </div>
        <a-empty v-if="!todayRank.length" description="暂无排行数据" />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import { message } from 'ant-design-vue'
import { ThunderboltFilled } from '@ant-design/icons-vue'
import { apiStartMatch, apiCancelMatch, apiGetPkRank, apiGetPkStats } from '@/api/pk'
import type { PkRankItem, PkStats } from '@/api/pk'
import { usePkWebSocket } from '@/utils/pkWebsocket'

const router = useRouter()
const { connect, disconnect, onMessage } = usePkWebSocket()

const matching = ref(false)
const matched = ref(false)
const matchTime = ref(0)
let matchTimer: ReturnType<typeof setInterval> | null = null

const stats = ref<PkStats>({
  dailyScore: 0,
  dailyRank: 0,
  totalScore: 0,
  totalRank: 0,
  totalGames: 0,
  wins: 0,
  winRate: 0,
  level: 1,
  score: 0,
  levelName: 'Lv1 初学者',
})

const todayRank = ref<PkRankItem[]>([])

onMounted(async () => {
  connect()
  loadData()
})

onUnmounted(() => {
  disconnect()
  if (matchTimer) clearInterval(matchTimer)
})

const loadData = async () => {
  try {
    const [statsRes, rankRes] = await Promise.all([
      apiGetPkStats(),
      apiGetPkRank('daily', 1, 10),
    ])
    if (statsRes.code === 200) stats.value = statsRes.data
    if (rankRes.code === 200) todayRank.value = rankRes.data
  } catch {
    // silent
  }
}

const startMatch = async () => {
  matching.value = true
  matchTime.value = 0
  matchTimer = setInterval(() => matchTime.value++, 1000)

  try {
    await apiStartMatch()
    const stopWatch = onMessage((msg) => {
      if (msg.type === 'MATCH_SUCCESS') {
        matched.value = true
        if (matchTimer) clearInterval(matchTimer)
        message.success('匹配成功！')
        setTimeout(() => {
          router.push(`/pk/battle?roomId=${msg.roomId}`)
        }, 1000)
        stopWatch()
      }
    })
  } catch (e: any) {
    message.error(e.message || '匹配失败')
    matching.value = false
    if (matchTimer) clearInterval(matchTimer)
  }
}

const cancelMatch = async () => {
  try {
    await apiCancelMatch()
    matching.value = false
    matched.value = false
    if (matchTimer) clearInterval(matchTimer)
    matchTime.value = 0
    message.info('已取消匹配')
  } catch {
    message.error('取消失败')
  }
}
</script>

<style scoped lang="scss">
.pk-match-page {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.match-header {
  .page-title {
    font-size: calc(22px + var(--font-offset, 0px));
    font-weight: 800;
    color: var(--text-title);
    display: flex;
    align-items: center;
    gap: 10px;
    margin: 0;
    .title-icon { color: var(--primary); }
  }
  .page-desc {
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-muted);
    margin-top: 6px;
  }
}

.match-card {
  border-radius: var(--radius-lg);
  background: var(--page-bg);
  border: 1px solid var(--border);
  padding: 48px;
  text-align: center;
  box-shadow: var(--shadow-card);

  .match-icon {
    font-size: 64px;
    margin-bottom: 16px;
  }

  h3 {
    font-size: calc(20px + var(--font-offset, 0px));
    font-weight: 700;
    color: var(--text-title);
    margin: 0 0 8px;
  }

  p {
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-muted);
    margin: 0 0 24px;
  }
}

.start-btn {
  height: 48px;
  padding: 0 32px;
  font-size: calc(16px + var(--font-offset, 0px));
  font-weight: 600;
  border-radius: var(--radius-md);
}

.matching-animation {
  .spinner {
    width: 48px;
    height: 48px;
    border: 4px solid var(--border);
    border-top-color: var(--primary);
    border-radius: 50%;
    animation: spin 1s linear infinite;
    margin: 0 auto 16px;
  }
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

.match-success {
  .success-icon {
    width: 64px;
    height: 64px;
    border-radius: 50%;
    background: var(--success);
    color: #fff;
    font-size: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 16px;
  }
}

.stats-row {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;

  .stat-item {
    text-align: center;
    padding: 20px;
    border-radius: var(--radius-lg);
    background: var(--page-bg);
    border: 1px solid var(--border);
    box-shadow: var(--shadow-card);

    .stat-value {
      font-size: calc(24px + var(--font-offset, 0px));
      font-weight: 800;
      color: var(--primary);
    }

    .stat-label {
      font-size: calc(12px + var(--font-offset, 0px));
      color: var(--text-muted);
      margin-top: 4px;
    }
  }
}

.rank-section {
  border-radius: var(--radius-lg);
  background: var(--page-bg);
  border: 1px solid var(--border);
  padding: 20px 24px;
  box-shadow: var(--shadow-card);

  .section-head {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 16px;

    h3 {
      font-size: calc(16px + var(--font-offset, 0px));
      font-weight: 700;
      color: var(--text-title);
      margin: 0;
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
  border-radius: var(--radius-md);
  border: 1px solid var(--border);
  transition: all 0.2s;

  &:hover {
    background: var(--primary-light);
  }

  .rank-no {
    width: 28px;
    height: 28px;
    border-radius: 50%;
    background: var(--border);
    color: var(--text-muted);
    font-size: calc(13px + var(--font-offset, 0px));
    font-weight: 700;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;

    &.top3 {
      background: var(--primary);
      color: #fff;
    }
  }

  .rank-info {
    display: flex;
    align-items: center;
    gap: 10px;
    flex: 1;
  }

  .rank-detail {
    .rank-name {
      font-size: calc(14px + var(--font-offset, 0px));
      font-weight: 600;
      color: var(--text-title);
    }

    .rank-score {
      font-size: calc(12px + var(--font-offset, 0px));
      color: var(--text-muted);
    }
  }
}

@media (max-width: 768px) {
  .stats-row {
    grid-template-columns: repeat(2, 1fr);
  }
}
</style>
