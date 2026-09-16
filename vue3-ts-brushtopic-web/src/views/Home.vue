<template>
  <div class="home-dashboard">
    <div class="top-row">
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
      <div class="date-display">
        <div class="date-big">{{ todayDate.day }}</div>
        <div class="date-info">
          <div class="date-month">{{ todayDate.monthYear }}</div>
          <div class="date-week">{{ todayDate.week }}</div>
        </div>
      </div>
    </div>

    <div class="stats-row">
      <div class="stat-card" v-for="item in statItems" :key="item.key">
        <div class="stat-icon" :style="{ background: item.bgColor, color: item.color }">
          <component :is="item.icon" />
        </div>
        <div class="stat-body">
          <div class="stat-value">{{ item.value }}</div>
          <div class="stat-label">{{ item.label }}</div>
        </div>
      </div>
    </div>

    <div class="charts-row">
      <div class="chart-card wide">
        <div class="card-header">
          <span class="card-title">
            <span class="title-bar"></span>
            刷题趋势
          </span>
          <a-radio-group v-model:value="trendRange" size="small" button-style="solid">
            <a-radio-button value="7">近7天</a-radio-button>
            <a-radio-button value="14">近14天</a-radio-button>
            <a-radio-button value="30">近30天</a-radio-button>
          </a-radio-group>
        </div>
        <div ref="topicTrendRef" class="chart-box"></div>
      </div>
      <div class="chart-card narrow">
        <div class="card-header">
          <span class="card-title">
            <span class="title-bar"></span>
            题型分布
          </span>
        </div>
        <div ref="categoryChartRef" class="chart-box"></div>
      </div>
    </div>

    <div class="bottom-row">
      <div class="panel today-topics">
        <div class="panel-header">
          <span class="panel-title">
            <span class="title-bar"></span>
            今日推荐
          </span>
          <a-button type="link" @click="router.push('/paper')">查看更多</a-button>
        </div>
        <div class="topic-list">
          <div
            class="topic-item"
            v-for="topic in todayTopics"
            :key="topic.id"
            @click="handleTopicClick(topic)"
          >
            <div class="topic-info">
              <div class="topic-name">{{ topic.topicName }}</div>
              <div class="topic-tags">
                <a-tag v-for="tag in topic.labelNames" :key="tag" size="small" color="blue">
                  {{ tag }}
                </a-tag>
              </div>
            </div>
            <div class="topic-status" :class="topic.status === 1 ? 'done' : 'todo'">
              {{ topic.status === 1 ? '已完成' : '待完成' }}
            </div>
          </div>
          <a-empty v-if="!todayTopics.length" description="暂无今日推荐" />
        </div>
      </div>
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
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, watch, onBeforeUnmount, nextTick } from 'vue'
import { useRouter } from 'vue-router'
import * as echarts from 'echarts'
import {
  ThunderboltOutlined,
  BookOutlined,
  RightOutlined,
  FileTextOutlined,
  TrophyOutlined,
  RobotOutlined,
  ReadOutlined,
  EditOutlined,
  SwapOutlined,
  RiseOutlined,
  TeamOutlined,
  StarOutlined,
} from '@ant-design/icons-vue'
import {
  apiQueryWebHomeCount,
  apiQueryTopicTrend,
  apiQueryAdminHomeCategory,
  apiQueryTopicTodayVo,
  apiQueryRank,
} from '@/api/home'
import { useUserStore } from '@/stores/user'
import type { WebHomeCount, TopicTrendVo, CategoryDataVo, TodayTopicVo, RankItem } from '@/types'

const router = useRouter()
const userStore = useUserStore()

const webHomeCount = ref<WebHomeCount>({})
const topicTrend = ref<TopicTrendVo>({ dateList: [], countUserList: [], countTopicList: [] })
const categoryData = ref<CategoryDataVo[]>([])
const todayTopics = ref<TodayTopicVo[]>([])
const rankList = ref<RankItem[]>([])
const trendRange = ref('7')

const topicTrendRef = ref<HTMLElement>()
const categoryChartRef = ref<HTMLElement>()
let topicTrendChart: echarts.ECharts | null = null
let categoryChart: echarts.ECharts | null = null

const greeting = computed(() => {
  const h = new Date().getHours()
  if (h < 6) return '凌晨好'
  if (h < 12) return '上午好'
  if (h < 14) return '中午好'
  if (h < 18) return '下午好'
  return '晚上好'
})

const todayDate = computed(() => {
  const d = new Date()
  return {
    day: d.getDate(),
    monthYear: `${d.getFullYear()}年${d.getMonth() + 1}月`,
    week: '星期' + ['日', '一', '二', '三', '四', '五', '六'][d.getDay()],
  }
})

const statItems = computed(() => [
  { key: 'today', icon: ThunderboltOutlined, label: '今日已刷', value: webHomeCount.value.todayTopicCount || 0, bgColor: 'rgba(64, 169, 255, 0.1)', color: '#40A9FF' },
  { key: 'times', icon: RiseOutlined, label: '今日次数', value: webHomeCount.value.todayCount || 0, bgColor: 'rgba(115, 46, 209, 0.1)', color: '#722ED1' },
  { key: 'progress', icon: FileTextOutlined, label: '累计进度', value: `${webHomeCount.value.totalTopicRecordCount || 0}/${webHomeCount.value.totalTopicCount || 0}`, bgColor: 'rgba(82, 196, 26, 0.1)', color: '#52C41A' },
  { key: 'rank', icon: TrophyOutlined, label: '我的排名', value: `第 ${webHomeCount.value.rank || 0} 名`, bgColor: 'rgba(250, 173, 20, 0.1)', color: '#FAAD14' },
  { key: 'users', icon: TeamOutlined, label: '总用户数', value: webHomeCount.value.userCount || 0, bgColor: 'rgba(19, 194, 194, 0.1)', color: '#13C2C2' },
])

const entries = [
  { name: '四级真题', desc: 'CET-4 历年真题', icon: FileTextOutlined, path: '/paper?level=4', bgColor: 'rgba(64, 169, 255, 0.1)', color: '#40A9FF' },
  { name: '六级真题', desc: 'CET-6 历年真题', icon: FileTextOutlined, path: '/paper?level=6', bgColor: 'rgba(115, 46, 209, 0.1)', color: '#722ED1' },
  { name: '作文批改', desc: 'AI 智能批改', icon: EditOutlined, path: '/writing', bgColor: 'rgba(250, 173, 20, 0.1)', color: '#FAAD14' },
  { name: '翻译练习', desc: '中英互译训练', icon: SwapOutlined, path: '/translation', bgColor: 'rgba(82, 196, 26, 0.1)', color: '#52C41A' },
  { name: '文章阅读', desc: '阅读理解提升', icon: ReadOutlined, path: '/reading', bgColor: 'rgba(22, 119, 255, 0.1)', color: '#1677FF' },
  { name: 'AI 练习', desc: '智能个性化学习', icon: RobotOutlined, path: '/ai', bgColor: 'rgba(19, 194, 194, 0.1)', color: '#13C2C2' },
  { name: '背单词', desc: 'CET 核心词汇', icon: BookOutlined, path: '/vocabulary', bgColor: 'rgba(255, 77, 79, 0.1)', color: '#FF4D4F' },
  { name: '排行榜', desc: '学习排行', icon: TrophyOutlined, path: '/ranking', bgColor: 'rgba(250, 173, 20, 0.1)', color: '#FAAD14' },
]

const initTopicTrendChart = () => {
  if (!topicTrendRef.value) return
  if (topicTrendChart) topicTrendChart.dispose()
  topicTrendChart = echarts.init(topicTrendRef.value)
  const data = topicTrend.value
  topicTrendChart.setOption({
    tooltip: { trigger: 'axis' },
    legend: { data: ['刷题人数', '题目数量'], right: 20, top: 0, textStyle: { color: '#8c8c8c', fontSize: 12 } },
    grid: { top: 40, left: 10, right: 20, bottom: 10, containLabel: true },
    xAxis: {
      type: 'category',
      boundaryGap: false,
      data: data.dateList,
      axisLine: { lineStyle: { color: '#E0E6F1' } },
      axisLabel: { color: '#999', fontSize: 11 },
    },
    yAxis: {
      type: 'value',
      axisLine: { show: false },
      axisTick: { show: false },
      axisLabel: { color: '#999', fontSize: 11 },
      splitLine: { lineStyle: { color: '#F0F0F0', type: 'dashed' } },
    },
    series: [
      {
        name: '刷题人数',
        type: 'line',
        smooth: true,
        symbol: 'circle',
        symbolSize: 6,
        showSymbol: false,
        lineStyle: { width: 3, color: '#40A9FF' },
        itemStyle: { color: '#40A9FF', borderColor: '#fff', borderWidth: 2 },
        areaStyle: { color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{ offset: 0, color: 'rgba(64, 169, 255, 0.25)' }, { offset: 1, color: 'rgba(64, 169, 255, 0.02)' }]) },
        data: data.countUserList,
      },
      {
        name: '题目数量',
        type: 'line',
        smooth: true,
        symbol: 'circle',
        symbolSize: 6,
        showSymbol: false,
        lineStyle: { width: 3, color: '#722ED1' },
        itemStyle: { color: '#722ED1', borderColor: '#fff', borderWidth: 2 },
        areaStyle: { color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{ offset: 0, color: 'rgba(115, 46, 209, 0.2)' }, { offset: 1, color: 'rgba(115, 46, 209, 0.02)' }]) },
        data: data.countTopicList,
      },
    ],
  })
}

const initCategoryChart = () => {
  if (!categoryChartRef.value) return
  if (categoryChart) categoryChart.dispose()
  categoryChart = echarts.init(categoryChartRef.value)
  const colors = ['#40A9FF', '#722ED1', '#52C41A', '#FAAD14', '#13C2C2', '#FF4D4F', '#EB2F96', '#2F54EB']
  categoryChart.setOption({
    tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
    legend: {
      orient: 'vertical',
      right: 10,
      top: 'center',
      textStyle: { color: '#666', fontSize: 11 },
      itemWidth: 10,
      itemHeight: 10,
    },
    color: colors,
    series: [
      {
        type: 'pie',
        radius: ['40%', '70%'],
        center: ['35%', '50%'],
        avoidLabelOverlap: false,
        itemStyle: { borderRadius: 6, borderColor: '#fff', borderWidth: 2 },
        label: { show: false },
        emphasis: { label: { show: true, fontSize: 14, fontWeight: 'bold' } },
        labelLine: { show: false },
        data: categoryData.value.map((item, i) => ({
          name: item.categoryName,
          value: item.count,
          itemStyle: { color: colors[i % colors.length] },
        })),
      },
    ],
  })
}

const handleResize = () => {
  topicTrendChart?.resize()
  categoryChart?.resize()
}

const fetchData = async () => {
  try {
    const [homeRes, trendRes, catRes, topicRes, rankRes] = await Promise.all([
      apiQueryWebHomeCount(),
      apiQueryTopicTrend(),
      apiQueryAdminHomeCategory(),
      apiQueryTopicTodayVo(),
      apiQueryRank('today'),
    ])
    if (homeRes.code === 200) webHomeCount.value = homeRes.data
    if (trendRes.code === 200) topicTrend.value = trendRes.data
    if (catRes.code === 200) categoryData.value = catRes.data
    if (topicRes.code === 200) todayTopics.value = topicRes.data
    if (rankRes.code === 200) rankList.value = (rankRes.data || []).slice(0, 8)
  } catch (e) {
    // ignore
  }
}

const initCharts = () => {
  nextTick(() => {
    initTopicTrendChart()
    initCategoryChart()
  })
}

const handleTopicClick = (topic: TodayTopicVo) => {
  router.push(`/paper?level=${topic.subjectId}`)
}

watch(trendRange, () => {
  // future: filter trend data by range
})

onMounted(async () => {
  await fetchData()
  initCharts()
  window.addEventListener('resize', handleResize)
})

onBeforeUnmount(() => {
  window.removeEventListener('resize', handleResize)
  topicTrendChart?.dispose()
  categoryChart?.dispose()
})
</script>

<style scoped lang="scss">
.home-dashboard {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.top-row {
  display: flex;
  justify-content: space-between;
  align-items: stretch;
  gap: 20px;
}

.welcome-section {
  flex: 1;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 28px 32px;
  border-radius: 12px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;

  .greeting {
    font-size: 26px;
    font-weight: 700;
  }

  .subtitle {
    margin-top: 8px;
    font-size: 14px;
    opacity: 0.85;
  }

  .quick-actions {
    display: flex;
    gap: 12px;
  }
}

.date-display {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 20px 28px;
  border-radius: 12px;
  background: var(--page-bg);
  border: 1px solid var(--border);

  .date-big {
    font-size: 48px;
    font-weight: 800;
    line-height: 1;
    color: var(--primary, #40A9FF);
  }

  .date-info {
    .date-month {
      font-size: 15px;
      font-weight: 600;
      color: var(--text-title);
    }

    .date-week {
      margin-top: 4px;
      font-size: 13px;
      color: var(--text-muted);
    }
  }
}

.stats-row {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 16px;
}

.stat-card {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 18px 20px;
  border-radius: 10px;
  background: var(--page-bg);
  border: 1px solid var(--border);
  transition: box-shadow 0.2s, transform 0.2s;

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
  }

  .stat-icon {
    width: 48px;
    height: 48px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 22px;
    flex-shrink: 0;
  }

  .stat-body {
    .stat-value {
      font-size: 24px;
      font-weight: 700;
      color: var(--text-title);
      line-height: 1.2;
    }

    .stat-label {
      margin-top: 4px;
      font-size: 13px;
      color: var(--text-muted);
    }
  }
}

.charts-row {
  display: flex;
  gap: 20px;

  .chart-card {
    background: var(--page-bg);
    border-radius: 12px;
    border: 1px solid var(--border);
    padding: 20px;
    overflow: hidden;

    &.wide {
      flex: 3;
    }

    &.narrow {
      flex: 2;
    }
  }

  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 16px;

    .card-title {
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

  .chart-box {
    width: 100%;
    height: 300px;
  }
}

.bottom-row {
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

.topic-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
  max-height: 320px;
  overflow-y: auto;
}

.topic-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 14px;
  border-radius: 8px;
  background: var(--card-bg);
  border: 1px solid var(--border);
  cursor: pointer;
  transition: border-color 0.2s;

  &:hover {
    border-color: var(--primary, #40A9FF);
  }

  .topic-info {
    flex: 1;
    min-width: 0;

    .topic-name {
      font-size: 14px;
      font-weight: 500;
      color: var(--text-title);
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }

    .topic-tags {
      margin-top: 6px;
      display: flex;
      gap: 4px;
      flex-wrap: wrap;
    }
  }

  .topic-status {
    margin-left: 12px;
    font-size: 12px;
    padding: 2px 10px;
    border-radius: 10px;
    flex-shrink: 0;

    &.done {
      background: rgba(82, 196, 26, 0.1);
      color: #52C41A;
    }

    &.todo {
      background: rgba(250, 173, 20, 0.1);
      color: #FAAD14;
    }
  }
}

.rank-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
  max-height: 320px;
  overflow-y: auto;
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

.entry-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
}

.entry-card {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 18px 20px;
  border-radius: 10px;
  background: var(--page-bg);
  border: 1px solid var(--border);
  cursor: pointer;
  transition: box-shadow 0.2s, transform 0.2s;

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
  }

  .entry-icon {
    width: 44px;
    height: 44px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    flex-shrink: 0;
  }

  .entry-text {
    flex: 1;
    min-width: 0;

    .entry-name {
      font-size: 14px;
      font-weight: 600;
      color: var(--text-title);
    }

    .entry-desc {
      margin-top: 4px;
      font-size: 12px;
      color: var(--text-muted);
    }
  }

  .entry-arrow {
    color: var(--text-muted);
    font-size: 12px;
    flex-shrink: 0;
  }
}

@media (max-width: 1200px) {
  .stats-row { grid-template-columns: repeat(3, 1fr); }
  .charts-row { flex-direction: column; }
  .bottom-row { flex-direction: column; }
  .entry-grid { grid-template-columns: repeat(2, 1fr); }
}

@media (max-width: 768px) {
  .top-row { flex-direction: column; }
  .stats-row { grid-template-columns: repeat(2, 1fr); }
  .entry-grid { grid-template-columns: 1fr; }
}
</style>
