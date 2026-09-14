<template>
  <div class="home-page">
    
    <div class="welcome-banner">
      <div class="banner-left">
        <div class="greet-row">
          <span class="greet-text">{{ greeting }}，</span>
          <span class="greet-name">{{ userStore.nickname }}</span>
        </div>
        <div class="slogan">今日也要保持备考节奏，每天进步一点点</div>
        <div class="banner-actions">
          <a-button class="btn-primary" @click="router.push('/paper')">
            <ThunderboltFilled class="btn-icon" />
            真题刷题
          </a-button>
          <a-button class="btn-ghost" @click="router.push('/vocabulary')">
            <BookOutlined class="btn-icon" />
            背单词
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

    
    
    <div class="exam-banner" @click="openExamRegistration">
      <div class="exam-left">
        <div class="exam-badge">CET</div>
        <div class="exam-info">
          <div class="exam-title">四六级考试报名</div>
          <div class="exam-desc">官方报名入口 · 中国教育考试网</div>
        </div>
      </div>
      <div class="exam-right">
        <div class="countdown-card">
          <div class="countdown-num">{{ daysToExam }}</div>
          <div class="countdown-text">
            <span>距离考试</span>
            <span>还有 {{ daysToExam }} 天</span>
          </div>
        </div>
        <div class="exam-link">
          前往报名
          <RightOutlined />
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

        <div class="panel article-rec-panel" style="margin-top: 24px;">
          <div class="panel-head">
            <div class="panel-title">
              <ReadOutlined class="t-icon cyan" />
              文章推荐
            </div>
            <a-button type="link" size="small" @click="router.push('/reading')">
              查看更多
              <RightOutlined />
            </a-button>
          </div>
          <div class="article-rec-grid">
            <div
              v-for="article in recommendArticles"
              :key="article.id"
              class="article-rec-card"
              @click="router.push(`/reading/${article.id}`)"
            >
              <div class="article-rec-top">
                <span class="article-difficulty">
                  <span v-for="i in article.difficulty" :key="i" class="diff-dot active"></span>
                  <span v-for="i in (5 - article.difficulty)" :key="'e'+i" class="diff-dot"></span>
                </span>
                <span class="article-source">{{ article.source }}</span>
              </div>
              <h4 class="article-rec-title">{{ article.title }}</h4>
              <p class="article-rec-preview">{{ article.preview }}</p>
              <div class="article-rec-footer">
                <span class="article-words">{{ article.wordCount }} 词</span>
                <span class="article-reads">{{ article.readCount }} 次阅读</span>
              </div>
            </div>
          </div>
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
            <div class="quick-item" @click="router.push('/paper?level=4')">
              <FileTextOutlined class="q-icon q1" />
              <span>四级真题</span>
            </div>
            <div class="quick-item" @click="router.push('/paper?level=6')">
              <FileTextOutlined class="q-icon q2" />
              <span>六级真题</span>
            </div>
            <div class="quick-item" @click="router.push('/vocabulary/review')">
              <BookOutlined class="q-icon q3" />
              <span>背单词</span>
            </div>
            <div class="quick-item" @click="router.push('/reading')">
              <ReadOutlined class="q-icon q4" />
              <span>文章阅读</span>
            </div>
            <div class="quick-item" @click="router.push('/writing')">
              <EditOutlined class="q-icon q1" />
              <span>作文批改</span>
            </div>
            <div class="quick-item" @click="router.push('/translation')">
              <SwapOutlined class="q-icon q2" />
              <span>翻译练习</span>
            </div>
            <div class="quick-item" @click="router.push('/pk')">
              <ThunderboltFilled class="q-icon q1" />
              <span>词汇量PK</span>
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
  DatabaseOutlined,
  UserOutlined,
  FileTextOutlined,
  AppstoreOutlined,
  CheckCircleFilled,
  BookOutlined,
  ReadOutlined,
  EditOutlined,
  SwapOutlined,
  CalendarOutlined,
} from '@ant-design/icons-vue'
import { apiQueryWebHomeCount, apiQueryTopicTodayVo, apiFlushTopic } from '@/api/home'
import { useUserStore } from '@/stores/user'
import type { TodayTopicVo, WebHomeCount } from '@/types'

const router = useRouter()
const userStore = useUserStore()

const loading = ref(true)
const webHomeCount = ref<WebHomeCount>({})
const topicTodayVo = ref<TodayTopicVo[]>([])

const openExamRegistration = () => {
  window.open('https://cet.neea.edu.cn/', '_blank')
}

const daysToExam = computed(() => {
  const now = new Date()
  const year = now.getFullYear()
  const examDates = [
    new Date(year, 5, 13),
    new Date(year, 11, 12),
    new Date(year + 1, 5, 12),
    new Date(year + 1, 11, 11),
  ]
  const future = examDates.filter(d => d > now)
  if (future.length === 0) return 180
  const diff = future[0].getTime() - now.getTime()
  return Math.ceil(diff / (1000 * 60 * 60 * 24))
})

const recommendArticles = ref([
  {
    id: 1,
    title: 'The Rise of Artificial Intelligence in Healthcare',
    preview: 'Artificial intelligence is transforming the healthcare industry in ways that were unimaginable a decade ago...',
    source: 'The Guardian',
    difficulty: 3,
    wordCount: 520,
    readCount: 128,
  },
  {
    id: 2,
    title: 'Climate Change and Its Impact on Global Agriculture',
    preview: 'As global temperatures continue to rise, farmers around the world are facing unprecedented challenges...',
    source: 'BBC News',
    difficulty: 4,
    wordCount: 680,
    readCount: 95,
  },
  {
    id: 3,
    title: 'The Future of Remote Work After the Pandemic',
    preview: 'The COVID-19 pandemic forced millions of people to work from home, fundamentally changing how we think about the workplace...',
    source: 'NYT',
    difficulty: 2,
    wordCount: 450,
    readCount: 210,
  },
])

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
  border-radius: var(--radius-lg);
  padding: 34px 40px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 32px;
  background: linear-gradient(135deg, rgba(66, 87, 178, 0.06), var(--card-bg) 60%);
  border: 1px solid var(--border);
  box-shadow: var(--shadow-card);

  &::before {
    content: '';
    position: absolute;
    inset: 0;
    background-image:
      linear-gradient(rgba(66, 87, 178, 0.05) 1px, transparent 1px),
      linear-gradient(90deg, rgba(66, 87, 178, 0.05) 1px, transparent 1px);
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
        font-size: calc(18px + var(--font-offset, 0px));
        color: var(--text-body);
      }

      .greet-name {
        font-size: calc(30px + var(--font-offset, 0px));
        font-weight: 800;
        color: var(--text-title);
      }
    }

    .slogan {
      margin-top: 10px;
      font-size: calc(14px + var(--font-offset, 0px));
      color: var(--text-muted);
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
        border-radius: var(--radius-md);
        background: var(--primary);
        color: #fff;
        font-weight: 600;
        font-size: calc(14px + var(--font-offset, 0px));
        display: inline-flex;
        align-items: center;
        gap: 8px;
        box-shadow: 0 6px 18px rgba(66, 87, 178, 0.25);
        transition: all 0.3s;

        &:hover {
          transform: translateY(-2px);
          background: var(--primary-hover);
          box-shadow: 0 10px 24px rgba(66, 87, 178, 0.35);
          color: #fff;
        }

        .btn-icon {
          font-size: calc(15px + var(--font-offset, 0px));
        }
      }

      .btn-ghost {
        height: 42px;
        padding: 0 22px;
        border-radius: var(--radius-md);
        border: 1px solid var(--border);
        background: transparent;
        color: var(--text-body);
        font-weight: 500;
        font-size: calc(14px + var(--font-offset, 0px));
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s;

        &:hover {
          border-color: rgba(66, 87, 178, 0.4);
          color: var(--primary);
        }

        .btn-icon {
          font-size: calc(15px + var(--font-offset, 0px));
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
      border-radius: var(--radius-lg);
      background: var(--page-bg);
      border: 1px solid var(--border);
      box-shadow: var(--shadow-card);

      .date-day {
        font-size: calc(44px + var(--font-offset, 0px));
        font-weight: 800;
        line-height: 1;
        color: var(--primary);
      }

      .date-line {
        display: flex;
        flex-direction: column;
        gap: 4px;

        .date-month {
          font-size: calc(14px + var(--font-offset, 0px));
          color: var(--text-title);
          font-weight: 600;
        }

        .date-week {
          font-size: calc(12px + var(--font-offset, 0px));
          color: var(--text-muted);
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
    border-radius: var(--radius-lg);
    background: var(--page-bg);
    border: 1px solid var(--border);
    box-shadow: var(--shadow-card);
    transition: all 0.3s;

    &:hover {
      transform: translateY(-3px);
      box-shadow: var(--shadow-hover);
    }

    .stat-icon {
      width: 48px;
      height: 48px;
      border-radius: 13px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: calc(22px + var(--font-offset, 0px));
      flex-shrink: 0;

      &.purple {
        background: var(--tag-2);
        color: var(--primary);
      }

      &.cyan {
        background: var(--tag-1);
        color: var(--primary);
      }

      &.green {
        background: var(--tag-4);
        color: var(--success);
      }

      &.gold {
        background: var(--tag-3);
        color: var(--warning);
      }
    }

    .stat-info {
      min-width: 0;

      .stat-value {
        font-size: calc(24px + var(--font-offset, 0px));
        font-weight: 800;
        line-height: 1.15;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;

        &.purple,
        &.cyan {
          color: var(--primary);
        }

        &.green {
          color: var(--success);
        }

        &.gold {
          color: var(--warning);
        }
      }

      .stat-label {
        margin-top: 6px;
        font-size: calc(13px + var(--font-offset, 0px));
        color: var(--text-muted);
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
  border-radius: var(--radius-lg);
  background: var(--page-bg);
  border: 1px solid var(--border);
  padding: 22px 24px;
  box-shadow: var(--shadow-card);

  .panel-head {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 18px;

    .panel-title {
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: calc(17px + var(--font-offset, 0px));
      font-weight: 700;
      color: var(--text-title);

      .t-icon {
        font-size: calc(18px + var(--font-offset, 0px));

        &.orange {
          color: var(--warning);
        }

        &.gold {
          color: var(--warning);
        }

        &.purple {
          color: var(--primary);
        }
      }
    }

    .panel-meta {
      font-size: calc(13px + var(--font-offset, 0px));
      color: var(--text-muted);
    }
  }
}

.topic-card {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px 18px;
  border-radius: var(--radius-md);
  background: transparent;
  border: 1px solid var(--border);
  margin-bottom: 10px;
  cursor: pointer;
  transition: all 0.28s;

  &:last-child {
    margin-bottom: 0;
  }

  &:hover {
    background: var(--primary-light);
    border-color: rgba(66, 87, 178, 0.3);
    transform: translateX(4px);

    .topic-no {
      color: var(--primary);
      border-color: rgba(66, 87, 178, 0.4);
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
    font-size: calc(15px + var(--font-offset, 0px));
    font-weight: 800;
    color: var(--primary);
    background: var(--primary-light);
    border: 1px solid rgba(66, 87, 178, 0.2);
    transition: all 0.28s;

    &.done {
      color: var(--success);
      background: var(--success-light);
      border-color: rgba(40, 167, 69, 0.3);
    }
  }

  .topic-body {
    flex: 1;
    min-width: 0;

    .topic-title {
      font-size: calc(15px + var(--font-offset, 0px));
      font-weight: 600;
      color: var(--text-title);
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
        background: var(--primary-light);
        border-color: rgba(66, 87, 178, 0.2);
        color: var(--primary);
        border-radius: 8px;
        font-size: calc(12px + var(--font-offset, 0px));
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
    border-radius: var(--radius-sm);
    font-size: calc(13px + var(--font-offset, 0px));
    font-weight: 600;
    color: #fff;
    background: var(--primary);
    box-shadow: 0 4px 12px rgba(66, 87, 178, 0.25);
    transition: all 0.3s;

    .status-icon {
      font-size: calc(13px + var(--font-offset, 0px));
    }

    &.done {
      background: var(--success-light);
      color: var(--success);
      border: 1px solid rgba(40, 167, 69, 0.3);
      box-shadow: none;
    }
  }
}

.rank-panel {
  text-align: center;

  .rank-big {
    font-size: calc(48px + var(--font-offset, 0px));
    font-weight: 800;
    line-height: 1.1;
    color: var(--warning);
  }

  .rank-sub {
    margin-top: 8px;
    font-size: calc(13px + var(--font-offset, 0px));
    color: var(--text-muted);
  }

  .btn-primary.full {
    margin-top: 20px;
    width: 100%;
    height: 42px;
    border: none;
    border-radius: var(--radius-md);
    background: var(--primary);
    color: #fff;
    font-weight: 600;
    font-size: calc(14px + var(--font-offset, 0px));
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    box-shadow: 0 6px 18px rgba(66, 87, 178, 0.25);
    transition: all 0.3s;

    &:hover {
      transform: translateY(-2px);
      background: var(--primary-hover);
      box-shadow: 0 10px 24px rgba(66, 87, 178, 0.35);
      color: #fff;
    }

    .btn-icon {
      font-size: calc(14px + var(--font-offset, 0px));
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
      border-radius: var(--radius-md);
      background: var(--card-bg);
      border: 1px solid var(--border);
      cursor: pointer;
      transition: all 0.28s;

      &:hover {
        transform: translateY(-3px);
        background: var(--primary-light);
        border-color: rgba(66, 87, 178, 0.3);
      }

      .q-icon {
        font-size: calc(22px + var(--font-offset, 0px));

        &.q1 {
          color: var(--primary);
        }

        &.q2 {
          color: var(--primary-hover);
        }

        &.q3 {
          color: var(--warning);
        }

        &.q4 {
          color: var(--success);
        }
      }

      span {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--text-muted);
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

  .exam-banner {
    flex-direction: column;
    gap: 16px;

    .exam-right {
      width: 100%;
      justify-content: space-between;
    }
  }
}

:deep(.ant-empty-description) {
  color: var(--text-muted);
}

.exam-banner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 18px 28px;
  border-radius: var(--radius-lg);
  background: linear-gradient(135deg, rgba(66, 87, 178, 0.08), rgba(66, 87, 178, 0.02));
  border: 1px solid rgba(66, 87, 178, 0.2);
  cursor: pointer;
  transition: all 0.3s;

  &:hover {
    border-color: var(--primary);
    box-shadow: 0 6px 20px rgba(66, 87, 178, 0.15);
    transform: translateY(-2px);
  }

  .exam-left {
    display: flex;
    align-items: center;
    gap: 16px;

    .exam-badge {
      width: 48px;
      height: 48px;
      border-radius: 12px;
      background: var(--primary);
      color: #fff;
      font-size: calc(16px + var(--font-offset, 0px));
      font-weight: 800;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
    }

    .exam-info {
      .exam-title {
        font-size: calc(16px + var(--font-offset, 0px));
        font-weight: 700;
        color: var(--text-title);
      }

      .exam-desc {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--text-muted);
        margin-top: 2px;
      }
    }
  }

  .exam-right {
    display: flex;
    align-items: center;
    gap: 24px;

    .countdown-card {
      display: flex;
      align-items: center;
      gap: 10px;

      .countdown-num {
        font-size: calc(28px + var(--font-offset, 0px));
        font-weight: 800;
        color: var(--primary);
        line-height: 1;
      }

      .countdown-text {
        display: flex;
        flex-direction: column;
        gap: 2px;

        span {
          font-size: calc(12px + var(--font-offset, 0px));
          color: var(--text-muted);
          line-height: 1.3;
        }
      }
    }

    .exam-link {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 8px 18px;
      border-radius: var(--radius-md);
      background: var(--primary);
      color: #fff;
      font-size: calc(13px + var(--font-offset, 0px));
      font-weight: 600;
      transition: all 0.3s;

      &:hover {
        background: var(--primary-hover);
      }
    }
  }
}

.article-rec-panel {
  .article-rec-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 14px;

    .article-rec-card {
      padding: 18px;
      border-radius: var(--radius-md);
      border: 1px solid var(--border);
      background: var(--card-bg);
      cursor: pointer;
      transition: all 0.28s;
      display: flex;
      flex-direction: column;

      &:hover {
        border-color: var(--primary);
        background: var(--primary-light);
        transform: translateY(-3px);
        box-shadow: var(--shadow-hover);
      }

      .article-rec-top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;

        .article-difficulty {
          display: flex;
          gap: 3px;

          .diff-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: var(--border);
            transition: background 0.2s;

            &.active {
              background: var(--primary);
            }
          }
        }

        .article-source {
          font-size: calc(11px + var(--font-offset, 0px));
          color: var(--text-muted);
          padding: 2px 8px;
          border-radius: 10px;
          background: var(--primary-light);
          color: var(--primary);
        }
      }

      .article-rec-title {
        font-size: calc(14px + var(--font-offset, 0px));
        font-weight: 700;
        color: var(--text-title);
        margin: 0 0 8px;
        line-height: 1.4;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
      }

      .article-rec-preview {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--text-muted);
        line-height: 1.6;
        margin: 0 0 12px;
        flex: 1;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
      }

      .article-rec-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-top: 10px;
        border-top: 1px solid var(--border);

        span {
          font-size: calc(11px + var(--font-offset, 0px));
          color: var(--text-muted);
        }
      }
    }
  }
}
</style>
