<template>
  <div class="home-page">
    
    <div class="welcome-banner">
      <div class="banner-left">
        <div class="greet-row">
          <span class="greet-text">{{ greeting }}，</span>
          <span class="greet-name">{{ userStore.nickname }}</span>
        </div>
        <div class="slogan">今日也要保持刷题节奏，每天进步一点点</div>
        <div class="banner-actions">
          <a-button class="btn-primary" @click="router.push('/database')">
            <ThunderboltFilled class="btn-icon" />
            开始刷题
          </a-button>
          <a-button class="btn-ghost" @click="router.push('/ai')">
            <RobotOutlined class="btn-icon" />
            AI 答疑
          </a-button>
        </div>
      </div>
      <div class="banner-right">
        <div class="date-card">
          <div class="date-day">{{ dayNum }}</div>
          <div class="date-line">
            <div class="date-month">{{ monthYear }}</div>
            <div class="date-week">星期{{ weekCn }}</div>
          </div>
        </div>
      </div>
    </div>

    
    <div class="stats-grid">
      <div class="stat-card" v-for="s in statCards" :key="s.key">
        <div class="stat-icon" :class="s.color">
          <component :is="s.icon" />
        </div>
        <div class="stat-info">
          <div class="stat-value" :class="s.color">{{ s.value }}</div>
          <div class="stat-label">{{ s.label }}</div>
        </div>
      </div>
    </div>

    
    <div class="content-grid">
      
      <div class="main-col">
        <div class="panel">
          <div class="panel-head">
            <div class="panel-title">
              <FireOutlined class="t-icon orange" />
              每日必刷
            </div>
            <div class="panel-meta">
              {{ currentDate }} · {{ topicTodayVo.length }} 道题目
            </div>
          </div>

          <a-spin :spinning="loading">
            <a-empty v-if="!loading && topicTodayVo.length === 0" description="今日暂无推荐题目" />
            <div v-for="(item, i) in topicTodayVo" :key="item.id" class="topic-card" @click="handleQuestion(item)">
              <div class="topic-no" :class="{ done: item.status == 1 }">{{ String(i + 1).padStart(2, '0') }}</div>
              <div class="topic-body">
                <div class="topic-title">{{ item.topicName }}</div>
                <div class="topic-tags">
                  <a-tag v-for="tag in item.labelNames" :key="tag" class="tag-item">{{ tag }}</a-tag>
                </div>
              </div>
              <div class="topic-status" :class="{ done: item.status == 1 }">
                <component :is="item.status == 1 ? CheckCircleFilled : RightOutlined" class="status-icon" />
                {{ item.status == 1 ? '已完成' : '去练习' }}
              </div>
            </div>
          </a-spin>
        </div>
      </div>

      
      <div class="side-col">
        <div class="panel rank-panel">
          <div class="panel-head">
            <div class="panel-title">
              <TrophyFilled class="t-icon gold" />
              我的排名
            </div>
          </div>
          <div class="rank-big">{{ webHomeCount.rank || 0 }}</div>
          <div class="rank-sub">全站共 {{ webHomeCount.userCount || 0 }} 位用户</div>
          <a-button class="btn-primary full" @click="router.push('/ranking')">
            查看排行榜
            <RightOutlined class="btn-icon" />
          </a-button>
        </div>

        <div class="panel quick-panel">
          <div class="panel-head">
            <div class="panel-title">
              <AppstoreOutlined class="t-icon purple" />
              快捷入口
            </div>
          </div>
          <div class="quick-grid">
            <div class="quick-item" @click="router.push('/database')">
              <DatabaseOutlined class="q-icon q1" />
              <span>去刷题</span>
            </div>
            <div class="quick-item" @click="router.push('/ai')">
              <RobotOutlined class="q-icon q2" />
              <span>AI 问答</span>
            </div>
            <div class="quick-item" @click="router.push('/paper?level=4')">
              <FileTextOutlined class="q-icon q1" />
              <span>四级真题</span>
            </div>
            <div class="quick-item" @click="router.push('/paper?level=6')">
              <FileTextOutlined class="q-icon q2" />
              <span>六级真题</span>
            </div>
            <div class="quick-item" @click="router.push('/ranking')">
              <TrophyOutlined class="q-icon q3" />
              <span>排行榜</span>
            </div>
            <div class="quick-item" @click="router.push('/user')">
              <UserOutlined class="q-icon q4" />
              <span>个人中心</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { message } from 'ant-design-vue'
import {
  TrophyFilled,
  TrophyOutlined,
  RightOutlined,
  FireOutlined,
  ClockCircleOutlined,
  RiseOutlined,
  ThunderboltFilled,
  RobotOutlined,
  DatabaseOutlined,
  UserOutlined,
  FileTextOutlined,
  AppstoreOutlined,
  CheckCircleFilled,
} from '@ant-design/icons-vue'
import { apiQueryWebHomeCount, apiQueryTopicTodayVo, apiFlushTopic } from '@/api/home'
import { useUserStore } from '@/stores/user'
import type { TodayTopicVo, WebHomeCount } from '@/types'

const router = useRouter()
const userStore = useUserStore()

const loading = ref(true)
const webHomeCount = ref<WebHomeCount>({})
const topicTodayVo = ref<TodayTopicVo[]>([])

const initData = async () => {
  loading.value = true
  try {
    const [resCount, resTopic] = await Promise.all([apiQueryWebHomeCount(), apiQueryTopicTodayVo()])
    if (resCount.code === 200) webHomeCount.value = resCount.data
    if (resTopic.code === 200) topicTodayVo.value = resTopic.data
  } finally {
    loading.value = false
  }
}

onMounted(initData)

const greeting = computed(() => {
  const h = new Date().getHours()
  if (h < 6) return '凌晨好'
  if (h < 12) return '上午好'
  if (h < 14) return '中午好'
  if (h < 18) return '下午好'
  return '晚上好'
})

const dayNum = new Date().getDate()
const monthYear = `${new Date().getFullYear()}年${new Date().getMonth() + 1}月`
const weekCn = ['日', '一', '二', '三', '四', '五', '六'][new Date().getDay()]
const currentDate = computed(() => {
  const d = new Date()
  return `${d.getMonth() + 1}月${d.getDate()}日`
})

const statCards = computed(() => [
  {
    key: 'today',
    icon: FireOutlined,
    color: 'purple',
    label: '今日已刷',
    value: webHomeCount.value.todayTopicCount || 0,
  },
  {
    key: 'times',
    icon: ClockCircleOutlined,
    color: 'cyan',
    label: '今日次数',
    value: webHomeCount.value.todayCount || 0,
  },
  {
    key: 'progress',
    icon: RiseOutlined,
    color: 'green',
    label: '累计进度',
    value: `${webHomeCount.value.totalTopicRecordCount || 0} / ${webHomeCount.value.totalTopicCount || 0}`,
  },
  {
    key: 'rank',
    icon: TrophyFilled,
    color: 'gold',
    label: '我的排名',
    value: `第 ${webHomeCount.value.rank || 0} 名`,
  },
])

const handleQuestion = async (item: TodayTopicVo) => {
  if (!item.subjectId) {
    message.warning('专题不可用')
    return
  }
  await apiFlushTopic(item.id)
  router.push(`/topic/${item.topicId}?subjectId=${item.subjectId}`)
}
</script>

<style scoped lang="scss">
.home-page {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.welcome-banner {
  position: relative;
  overflow: hidden;
  border-radius: 18px;
  padding: 34px 40px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 32px;
  background: linear-gradient(120deg, rgba(139, 92, 246, 0.26), rgba(34, 211, 238, 0.12) 60%, rgba(11, 15, 26, 0.2));
  border: 1px solid rgba(255, 255, 255, 0.1);
  box-shadow: 0 18px 50px rgba(0, 0, 0, 0.35);

  &::before {
    content: '';
    position: absolute;
    inset: 0;
    background-image:
      linear-gradient(rgba(255, 255, 255, 0.035) 1px, transparent 1px),
      linear-gradient(90deg, rgba(255, 255, 255, 0.035) 1px, transparent 1px);
    background-size: 40px 40px;
    mask-image: radial-gradient(circle at 80% 20%, #000 0%, transparent 70%);
    pointer-events: none;
  }

  .banner-left {
    position: relative;
    z-index: 2;

    .greet-row {
      display: flex;
      align-items: baseline;
      gap: 10px;

      .greet-text {
        font-size: 18px;
        color: #c3cadf;
      }

      .greet-name {
        font-size: 30px;
        font-weight: 800;
        background: linear-gradient(90deg, #a78bfa, #22d3ee);
        -webkit-background-clip: text;
        background-clip: text;
        -webkit-text-fill-color: transparent;
      }
    }

    .slogan {
      margin-top: 10px;
      font-size: 14px;
      color: #9aa4bd;
      letter-spacing: 0.5px;
    }

    .banner-actions {
      margin-top: 22px;
      display: flex;
      gap: 14px;

      .btn-primary {
        height: 42px;
        padding: 0 22px;
        border: none;
        border-radius: 12px;
        background: linear-gradient(135deg, #8b5cf6, #06b6d4);
        color: #fff;
        font-weight: 600;
        font-size: 14px;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        box-shadow: 0 8px 24px rgba(139, 92, 246, 0.4);
        transition: all 0.3s;

        &:hover {
          transform: translateY(-2px);
          box-shadow: 0 12px 30px rgba(139, 92, 246, 0.55);
          color: #fff;
        }

        .btn-icon {
          font-size: 15px;
        }
      }

      .btn-ghost {
        height: 42px;
        padding: 0 22px;
        border-radius: 12px;
        border: 1px solid rgba(255, 255, 255, 0.16);
        background: rgba(255, 255, 255, 0.05);
        color: #c3cadf;
        font-weight: 500;
        font-size: 14px;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s;

        &:hover {
          border-color: rgba(34, 211, 238, 0.5);
          color: #22d3ee;
        }

        .btn-icon {
          font-size: 15px;
        }
      }
    }
  }

  .banner-right {
    position: relative;
    z-index: 2;
    flex-shrink: 0;

    .date-card {
      display: flex;
      align-items: center;
      gap: 16px;
      padding: 14px 24px;
      border-radius: 16px;
      background: rgba(11, 15, 26, 0.45);
      border: 1px solid rgba(255, 255, 255, 0.1);
      backdrop-filter: blur(10px);

      .date-day {
        font-size: 44px;
        font-weight: 800;
        line-height: 1;
        background: linear-gradient(180deg, #a78bfa, #22d3ee);
        -webkit-background-clip: text;
        background-clip: text;
        -webkit-text-fill-color: transparent;
      }

      .date-line {
        display: flex;
        flex-direction: column;
        gap: 4px;

        .date-month {
          font-size: 14px;
          color: #e5eaf3;
          font-weight: 600;
        }

        .date-week {
          font-size: 12px;
          color: #8b95b5;
        }
      }
    }
  }
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;

  .stat-card {
    display: flex;
    align-items: center;
    gap: 16px;
    padding: 22px 24px;
    border-radius: 16px;
    background: rgba(18, 24, 40, 0.6);
    backdrop-filter: blur(14px);
    border: 1px solid rgba(255, 255, 255, 0.08);
    transition: all 0.3s;

    &:hover {
      transform: translateY(-3px);
      box-shadow: 0 12px 34px rgba(0, 0, 0, 0.35);
    }

    .stat-icon {
      width: 48px;
      height: 48px;
      border-radius: 13px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 22px;
      flex-shrink: 0;

      &.purple {
        background: rgba(139, 92, 246, 0.16);
        color: #a78bfa;
        box-shadow: 0 0 18px rgba(139, 92, 246, 0.25);
      }

      &.cyan {
        background: rgba(34, 211, 238, 0.14);
        color: #22d3ee;
        box-shadow: 0 0 18px rgba(34, 211, 238, 0.22);
      }

      &.green {
        background: rgba(52, 211, 153, 0.14);
        color: #34d399;
        box-shadow: 0 0 18px rgba(52, 211, 153, 0.22);
      }

      &.gold {
        background: rgba(251, 191, 36, 0.14);
        color: #fbbf24;
        box-shadow: 0 0 18px rgba(251, 191, 36, 0.22);
      }
    }

    .stat-info {
      min-width: 0;

      .stat-value {
        font-size: 24px;
        font-weight: 800;
        line-height: 1.15;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;

        &.purple {
          color: #c4b5fd;
        }

        &.cyan {
          color: #67e8f9;
        }

        &.green {
          color: #6ee7b7;
        }

        &.gold {
          color: #fcd34d;
        }
      }

      .stat-label {
        margin-top: 6px;
        font-size: 13px;
        color: #9aa4bd;
      }
    }
  }
}

.content-grid {
  display: grid;
  grid-template-columns: 1fr 320px;
  gap: 24px;
  align-items: start;
}

.panel {
  border-radius: 16px;
  background: rgba(18, 24, 40, 0.6);
  backdrop-filter: blur(14px);
  border: 1px solid rgba(255, 255, 255, 0.08);
  padding: 22px 24px;
  box-shadow: 0 16px 44px rgba(0, 0, 0, 0.3);

  .panel-head {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 18px;

    .panel-title {
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: 17px;
      font-weight: 700;
      color: #e5eaf3;

      .t-icon {
        font-size: 18px;

        &.orange {
          color: #fb923c;
          filter: drop-shadow(0 0 8px rgba(251, 146, 60, 0.6));
        }

        &.gold {
          color: #fbbf24;
          filter: drop-shadow(0 0 8px rgba(251, 191, 36, 0.6));
        }

        &.purple {
          color: #a78bfa;
          filter: drop-shadow(0 0 8px rgba(139, 92, 246, 0.6));
        }
      }
    }

    .panel-meta {
      font-size: 13px;
      color: #7c86a6;
    }
  }
}

.topic-card {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px 18px;
  border-radius: 13px;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.06);
  margin-bottom: 10px;
  cursor: pointer;
  transition: all 0.28s;

  &:last-child {
    margin-bottom: 0;
  }

  &:hover {
    background: rgba(139, 92, 246, 0.08);
    border-color: rgba(139, 92, 246, 0.4);
    transform: translateX(4px);

    .topic-no {
      color: #22d3ee;
      border-color: rgba(34, 211, 238, 0.5);
    }
  }

  .topic-no {
    width: 40px;
    height: 40px;
    flex-shrink: 0;
    border-radius: 11px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 15px;
    font-weight: 800;
    color: #a78bfa;
    background: rgba(139, 92, 246, 0.12);
    border: 1px solid rgba(139, 92, 246, 0.3);
    transition: all 0.28s;

    &.done {
      color: #34d399;
      background: rgba(52, 211, 153, 0.12);
      border-color: rgba(52, 211, 153, 0.3);
    }
  }

  .topic-body {
    flex: 1;
    min-width: 0;

    .topic-title {
      font-size: 15px;
      font-weight: 600;
      color: #e5eaf3;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .topic-tags {
      margin-top: 8px;
      display: flex;
      flex-wrap: wrap;
      gap: 6px;

      .tag-item {
        background: rgba(139, 92, 246, 0.12);
        border-color: rgba(139, 92, 246, 0.3);
        color: #a78bfa;
        border-radius: 8px;
        font-size: 12px;
        margin-inline-end: 0;
      }
    }
  }

  .topic-status {
    flex-shrink: 0;
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 7px 16px;
    border-radius: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #fff;
    background: linear-gradient(135deg, #8b5cf6, #06b6d4);
    box-shadow: 0 6px 18px rgba(139, 92, 246, 0.3);
    transition: all 0.3s;

    .status-icon {
      font-size: 13px;
    }

    &.done {
      background: rgba(52, 211, 153, 0.12);
      color: #34d399;
      border: 1px solid rgba(52, 211, 153, 0.4);
      box-shadow: none;
    }
  }
}

.rank-panel {
  text-align: center;

  .rank-big {
    font-size: 48px;
    font-weight: 800;
    line-height: 1.1;
    background: linear-gradient(180deg, #fcd34d, #f59e0b);
    -webkit-background-clip: text;
    background-clip: text;
    -webkit-text-fill-color: transparent;
    text-shadow: 0 0 30px rgba(251, 191, 36, 0.3);
  }

  .rank-sub {
    margin-top: 8px;
    font-size: 13px;
    color: #8b95b5;
  }

  .btn-primary.full {
    margin-top: 20px;
    width: 100%;
    height: 42px;
    border: none;
    border-radius: 12px;
    background: linear-gradient(135deg, #8b5cf6, #06b6d4);
    color: #fff;
    font-weight: 600;
    font-size: 14px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    box-shadow: 0 8px 24px rgba(139, 92, 246, 0.4);
    transition: all 0.3s;

    &:hover {
      transform: translateY(-2px);
      box-shadow: 0 12px 30px rgba(139, 92, 246, 0.55);
      color: #fff;
    }

    .btn-icon {
      font-size: 14px;
    }
  }
}

.quick-panel {
  margin-top: 24px;

  .quick-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 12px;

    .quick-item {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 8px;
      padding: 16px 6px;
      border-radius: 12px;
      background: rgba(255, 255, 255, 0.04);
      border: 1px solid rgba(255, 255, 255, 0.06);
      cursor: pointer;
      transition: all 0.28s;

      &:hover {
        transform: translateY(-3px);
        background: rgba(255, 255, 255, 0.07);
        border-color: rgba(139, 92, 246, 0.45);
      }

      .q-icon {
        font-size: 22px;

        &.q1 {
          color: #a78bfa;
        }

        &.q2 {
          color: #22d3ee;
        }

        &.q3 {
          color: #fbbf24;
        }

        &.q4 {
          color: #34d399;
        }
      }

      span {
        font-size: 12px;
        color: #9aa4bd;
      }
    }
  }
}

@media (max-width: 1200px) {
  .content-grid {
    grid-template-columns: 1fr;
  }

  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

:deep(.ant-empty-description) {
  color: #7c86a6;
}
</style>
