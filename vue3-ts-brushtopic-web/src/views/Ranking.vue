<template>
  <div class="ranking-page">
    
    <div class="page-head">
      <div class="head-title">
        <TrophyFilled class="head-icon" />
        <span>实力排行榜</span>
      </div>
      <div class="head-sub">看看谁才是刷题之王</div>
    </div>

    
    <div class="header-tab">
      <div class="tab-pill">
        <div class="tab-btn" :class="{ active: type === 1 }" @click="switchType(1)">🔥 日榜</div>
        <div class="tab-btn" :class="{ active: type === 2 }" @click="switchType(2)">🏆 总榜</div>
      </div>
    </div>

    
    <div class="podium-box">
      <div class="podium-col">
        <div v-if="top3[1]" class="podium-item silver">
          <div class="avatar-wrap">
            <div class="podium-base base-2">2</div>
            <a-avatar v-if="top3[1].avatar" :src="top3[1].avatar" :size="64" />
            <a-avatar v-else :size="64" class="avatar-fallback silver-fb">
              {{ (top3[1].nickname || '?').charAt(0) }}
            </a-avatar>
          </div>
          <div class="nickname">{{ top3[1].nickname }}</div>
          <div class="score-tag">{{ top3[1].scope }} 分</div>
        </div>
      </div>

      <div class="podium-col">
        <div v-if="top3[0]" class="podium-item gold">
          <div class="crown">👑</div>
          <div class="avatar-wrap">
            <div class="podium-base base-1">1</div>
            <a-avatar v-if="top3[0].avatar" :src="top3[0].avatar" :size="88" />
            <a-avatar v-else :size="88" class="avatar-fallback gold-fb">
              {{ (top3[0].nickname || '?').charAt(0) }}
            </a-avatar>
          </div>
          <div class="nickname main">{{ top3[0].nickname }}</div>
          <div class="score-tag main">{{ top3[0].scope }} 分</div>
        </div>
      </div>

      <div class="podium-col">
        <div v-if="top3[2]" class="podium-item bronze">
          <div class="avatar-wrap">
            <div class="podium-base base-3">3</div>
            <a-avatar v-if="top3[2].avatar" :src="top3[2].avatar" :size="64" />
            <a-avatar v-else :size="64" class="avatar-fallback bronze-fb">
              {{ (top3[2].nickname || '?').charAt(0) }}
            </a-avatar>
          </div>
          <div class="nickname">{{ top3[2].nickname }}</div>
          <div class="score-tag">{{ top3[2].scope }} 分</div>
        </div>
      </div>
    </div>

    
    <div class="rank-list-card">
      <div class="list-head">
        <span>排名</span>
        <span>用户</span>
        <span>积分</span>
      </div>
      <a-spin :spinning="loading">
        <a-empty v-if="!loading && rankList.length === 0" description="暂无排名" />
        <div v-for="(item, index) in rankList" :key="index" class="rank-row">
          <div class="rank-index">{{ index + 4 }}</div>
          <div class="user-cell">
            <a-avatar v-if="item.avatar" :src="item.avatar" :size="40" />
            <a-avatar v-else :size="40" class="avatar-fallback">{{ (item.nickname || '?').charAt(0) }}</a-avatar>
            <span class="u-name">{{ item.nickname }}</span>
          </div>
          <div class="u-score">
            <span class="val">{{ item.scope }}</span>
          </div>
        </div>
      </a-spin>
    </div>

    
    <div v-if="currentRank" class="my-status-fixed">
      <div class="my-card">
        <div class="my-left">
          <div class="my-no">{{ currentRank.rank || '-' }}</div>
          <a-avatar
            v-if="userStore.userInfo?.avatar || currentRank.avatar"
            :src="userStore.userInfo?.avatar || currentRank.avatar"
            :size="40"
          />
          <a-avatar v-else :size="40" class="avatar-fallback">
            {{ (currentRank.nickname || userStore.nickname).charAt(0) }}
          </a-avatar>
          <div class="my-info">
            <div class="my-name">{{ currentRank.nickname }}</div>
            <div class="my-label">当前我的排名</div>
          </div>
        </div>
        <div class="my-right">
          <span class="my-val">{{ currentRank.scope || 0 }}</span>
          <span class="my-unit">分</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { TrophyFilled } from '@ant-design/icons-vue'
import { apiQueryRank, apiQueryUserRank } from '@/api/home'
import { useUserStore } from '@/stores/user'
import type { RankItem } from '@/types'

const userStore = useUserStore()
const type = ref(1)
const loading = ref(false)
const rankList = ref<RankItem[]>([])
const top3 = ref<RankItem[]>([])
const currentRank = ref<RankItem | null>(null)

const fetchData = async (t: number) => {
  loading.value = true
  try {
    const [resRank, resUser] = await Promise.all([apiQueryRank(String(t)), apiQueryUserRank(String(t))])
    if (resRank.data) {
      const raw = resRank.data
      top3.value = raw.slice(0, 3)
      rankList.value = raw.slice(3)
    }
    if (resUser.data) currentRank.value = resUser.data
  } finally {
    loading.value = false
  }
}

const switchType = (t: number) => {
  if (type.value === t) return
  type.value = t
  fetchData(t)
}

onMounted(() => fetchData(1))
</script>

<style scoped lang="scss">
.ranking-page {
  min-height: 100%;
  padding-bottom: 110px;
}

.page-head {
  text-align: center;
  margin-bottom: 28px;

  .head-title {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 12px;
    font-size: calc(28px + var(--font-offset, 0px));
    font-weight: 800;
    color: var(--text-title);

    .head-icon {
      font-size: calc(30px + var(--font-offset, 0px));
      color: var(--warning);
    }
  }

  .head-sub {
    margin-top: 8px;
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-muted);
    letter-spacing: 1px;
  }
}

.header-tab {
  display: flex;
  justify-content: center;
  margin-bottom: 32px;

  .tab-pill {
    display: flex;
    background: var(--card-bg);
    border: 1px solid var(--border);
    padding: 4px;
    border-radius: 26px;

    .tab-btn {
      padding: 9px 40px;
      border-radius: 22px;
      font-size: calc(14px + var(--font-offset, 0px));
      color: var(--text-body);
      cursor: pointer;
      transition: all 0.25s;

      &.active {
        background: var(--primary);
        color: #fff;
        font-weight: 600;
      }
    }
  }
}

.podium-box {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  max-width: 760px;
  margin: 0 auto;
  padding: 0 40px 40px;

  .podium-col {
    flex: 1;
    display: flex;
    justify-content: center;
  }

  .podium-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    position: relative;

    .crown {
      font-size: calc(30px + var(--font-offset, 0px));
      margin-bottom: 6px;
      animation: float 3s infinite ease-in-out;
    }

    .avatar-wrap {
      position: relative;

      .podium-base {
        position: absolute;
        bottom: -6px;
        left: 50%;
        transform: translateX(-50%);
        width: 30px;
        height: 30px;
        border-radius: 50%;
        color: #fff;
        font-size: calc(15px + var(--font-offset, 0px));
        font-weight: 800;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 4px 14px rgba(0, 0, 0, 0.4);
        z-index: 2;

        &.base-1 {
          background: linear-gradient(135deg, #fbbf24, #f59e0b);
          box-shadow: 0 0 22px rgba(251, 191, 36, 0.7);
        }

        &.base-2 {
          background: linear-gradient(135deg, #cbd5e1, #94a3b8);
        }

        &.base-3 {
          background: linear-gradient(135deg, #d97706, #b45309);
        }
      }
    }

    .avatar-fallback {
      background: var(--primary);
      font-size: calc(22px + var(--font-offset, 0px));
      font-weight: 700;
      border: 3px solid var(--border);

      &.gold-fb {
        font-size: calc(32px + var(--font-offset, 0px));
        background: linear-gradient(135deg, #fbbf24, #f59e0b);
        color: #7c4b00;
        box-shadow: 0 0 36px rgba(251, 191, 36, 0.55);
      }

      &.silver-fb {
        background: linear-gradient(135deg, #cbd5e1, #94a3b8);
      }

      &.bronze-fb {
        background: linear-gradient(135deg, #d97706, #b45309);
      }
    }

    .nickname {
      font-size: calc(14px + var(--font-offset, 0px));
      color: var(--text-body);
      margin-top: 14px;
      max-width: 160px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;

      &.main {
        font-size: calc(17px + var(--font-offset, 0px));
        font-weight: 700;
        color: var(--text-title);
      }
    }

    .score-tag {
      margin-top: 8px;
      padding: 3px 18px;
      background: var(--card-bg);
      border: 1px solid var(--border);
      border-radius: 14px;
      font-size: calc(13px + var(--font-offset, 0px));
      color: var(--text-muted);

      &.main {
        background: var(--warning-light);
        border-color: var(--warning);
        color: var(--warning);
        font-weight: 600;
      }
    }
  }
}

@keyframes float {
  0%,
  100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-8px);
  }
}

.rank-list-card {
  max-width: 1000px;
  margin: 0 auto;
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: 16px;
  padding: 8px 32px;
  box-shadow: var(--shadow-card);

  .list-head {
    display: flex;
    padding: 12px 0 8px;
    font-size: calc(12px + var(--font-offset, 0px));
    color: var(--text-muted);
    border-bottom: 1px solid var(--border);
    letter-spacing: 1px;

    span:nth-child(1) {
      width: 44px;
      text-align: center;
    }

    span:nth-child(2) {
      flex: 1;
    }

    span:nth-child(3) {
      width: 80px;
      text-align: right;
    }
  }

  .rank-row {
    display: flex;
    align-items: center;
    padding: 15px 0;
    border-bottom: 1px solid var(--border);
    transition: background 0.25s;

    &:last-child {
      border-bottom: none;
    }

    &:hover {
      background: var(--primary-light);
    }

    .rank-index {
      width: 44px;
      font-size: calc(18px + var(--font-offset, 0px));
      color: var(--text-muted);
      font-style: italic;
      font-weight: 700;
      text-align: center;
    }

    .user-cell {
      flex: 1;
      display: flex;
      align-items: center;
      gap: 12px;

      .avatar-fallback {
        background: var(--primary);
      }

      .u-name {
        font-size: calc(14px + var(--font-offset, 0px));
        font-weight: 500;
        color: var(--text-title);
      }
    }

    .u-score {
      width: 80px;
      text-align: right;

      .val {
        font-size: calc(19px + var(--font-offset, 0px));
        font-weight: 700;
        color: var(--primary);
      }
    }
  }
}

.my-status-fixed {
  position: sticky;
  bottom: 0;
  width: 100%;
  max-width: 1000px;
  margin: 20px auto 0;
  padding: 8px 0 0;

  .my-card {
    background: var(--primary);
    border-radius: 16px;
    padding: 16px 24px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: var(--shadow-card);
    border: 1px solid var(--border);

    .my-left {
      display: flex;
      align-items: center;

      .my-no {
        font-size: calc(26px + var(--font-offset, 0px));
        color: #fff;
        font-weight: 800;
        font-style: italic;
        margin-right: 16px;
      }

      .my-info {
        margin-left: 12px;

        .my-name {
          font-size: calc(15px + var(--font-offset, 0px));
          color: #fff;
          font-weight: 600;
        }

        .my-label {
          font-size: calc(12px + var(--font-offset, 0px));
          color: rgba(255, 255, 255, 0.85);
          margin-top: 2px;
        }
      }
    }

    .my-right {
      color: #fff;

      .my-val {
        font-size: calc(28px + var(--font-offset, 0px));
        font-weight: 800;
      }

      .my-unit {
        font-size: calc(13px + var(--font-offset, 0px));
        margin-left: 2px;
        opacity: 0.85;
      }
    }
  }
}

:deep(.ant-empty-description) {
  color: var(--text-muted);
}
</style>
