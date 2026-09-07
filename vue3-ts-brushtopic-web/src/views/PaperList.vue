<template>
  <div class="paper-page">
    <div class="back-bar" @click="router.back()">
      <LeftOutlined />
      <span>返回</span>
    </div>

    
    <div class="level-tabs">
      <div
        v-for="lv in levelTabs"
        :key="lv.value"
        class="level-tab"
        :class="{ active: level === lv.value }"
        @click="switchLevel(lv.value)"
      >
        {{ lv.label }}
      </div>
    </div>

    <a-spin :spinning="loading">
      
      <div v-if="groupedPapers.length" class="timeline">
        <div v-for="group in groupedPapers" :key="group.year" class="timeline-group">
          <div class="timeline-node">
            <div class="node-dot" />
            <div class="node-year">{{ group.year }} 年</div>
          </div>
          <div class="paper-cards">
            <div v-for="paper in group.papers" :key="paper.id" class="paper-card" @click="goExam(paper)">
              <div class="paper-half">
                <CalendarOutlined />
                {{ paper.examHalf === 1 ? '上半年' : '下半年' }}
              </div>
              <div class="paper-title">{{ paper.title }}</div>
              <div class="paper-meta">
                <span class="meta-item"><FileTextOutlined /> {{ paper.topicCount || 0 }} 题</span>
                <span class="meta-item" :class="{ done: (paper.doneCount || 0) > 0 }">
                  <CheckCircleOutlined /> 已做 {{ paper.doneCount || 0 }}/{{ paper.topicCount || 0 }}
                </span>
              </div>
              <div class="paper-progress">
                <div class="progress-bar">
                  <div
                    class="progress-inner"
                    :style="{ width: progressPercent(paper) + '%' }"
                  />
                </div>
                <span class="percent">{{ progressPercent(paper) }}%</span>
              </div>
              <div class="paper-go">进入答题 <RightOutlined /></div>
            </div>
          </div>
        </div>
      </div>
      <a-empty v-else-if="!loading" description="该级别暂无真题试卷～" />
    </a-spin>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import {
  LeftOutlined,
  RightOutlined,
  CalendarOutlined,
  FileTextOutlined,
  CheckCircleOutlined,
} from '@ant-design/icons-vue'
import { apiQueryPaperList } from '@/api/paper'
import type { Paper } from '@/types'

const route = useRoute()
const router = useRouter()
const loading = ref(true)
const level = ref<number>(Number(route.query.level) === 6 ? 6 : 4)
const papers = ref<Paper[]>([])

const levelTabs = [
  { label: '四级真题', value: 4 },
  { label: '六级真题', value: 6 },
]

const groupedPapers = computed(() => {
  const map = new Map<number, Paper[]>()
  for (const paper of papers.value) {
    const list = map.get(paper.examYear) || []
    list.push(paper)
    map.set(paper.examYear, list)
  }
  
  return Array.from(map.entries()).map(([year, list]) => ({ year, papers: list }))
})

const progressPercent = (paper: Paper) => {
  if (!paper.topicCount) return 0
  return Math.round(((paper.doneCount || 0) / paper.topicCount) * 100)
}

const loadPapers = async () => {
  loading.value = true
  try {
    const res = await apiQueryPaperList(level.value)
    papers.value = res.data || []
  } finally {
    loading.value = false
  }
}

const switchLevel = (value: number) => {
  if (level.value === value) return
  level.value = value
  router.replace({ query: { level: value } })
  loadPapers()
}

const goExam = (paper: Paper) => {
  router.push(`/paper/${paper.id}/exam`)
}

onMounted(() => {
  loadPapers()
})
</script>

<style scoped lang="scss">
.paper-page {
  max-width: 960px;
  margin: 0 auto;
}

.back-bar {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 8px 16px;
  border-radius: 10px;
  font-size: 14px;
  color: #9aa4bd;
  cursor: pointer;
  transition: all 0.25s;
  margin-bottom: 16px;

  &:hover {
    color: #22d3ee;
    background: rgba(255, 255, 255, 0.06);
  }
}

.level-tabs {
  display: flex;
  gap: 12px;
  margin-bottom: 28px;

  .level-tab {
    padding: 10px 28px;
    border-radius: 12px;
    border: 1px solid rgba(255, 255, 255, 0.1);
    background: rgba(18, 24, 40, 0.6);
    color: #9aa4bd;
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.25s;

    &:hover {
      border-color: rgba(139, 92, 246, 0.5);
      color: #e5eaf3;
    }

    &.active {
      background: linear-gradient(135deg, rgba(139, 92, 246, 0.25), rgba(34, 211, 238, 0.25));
      border-color: rgba(139, 92, 246, 0.6);
      color: #fff;
      box-shadow: 0 0 18px rgba(139, 92, 246, 0.35);
    }
  }
}

.timeline {
  .timeline-group {
    position: relative;
    padding-left: 28px;
    padding-bottom: 8px;

    &::before {
      content: '';
      position: absolute;
      left: 7px;
      top: 24px;
      bottom: 0;
      width: 2px;
      background: linear-gradient(180deg, rgba(139, 92, 246, 0.6), rgba(34, 211, 238, 0.15));
      border-radius: 1px;
    }
  }

  .timeline-node {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 16px;

    .node-dot {
      position: absolute;
      left: 2px;
      width: 12px;
      height: 12px;
      border-radius: 50%;
      background: linear-gradient(135deg, #8b5cf6, #22d3ee);
      box-shadow: 0 0 12px rgba(139, 92, 246, 0.8);
    }

    .node-year {
      font-size: 20px;
      font-weight: 700;
      color: #e5eaf3;
    }
  }

  .paper-cards {
    display: flex;
    flex-wrap: wrap;
    gap: 16px;
    margin-bottom: 20px;
  }
}

.paper-card {
  width: 100%;
  max-width: 420px;
  background: rgba(18, 24, 40, 0.6);
  backdrop-filter: blur(14px);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 16px;
  padding: 20px 24px;
  cursor: pointer;
  transition: all 0.25s;

  &:hover {
    border-color: rgba(139, 92, 246, 0.5);
    background: rgba(139, 92, 246, 0.08);
    transform: translateY(-3px);
    box-shadow: 0 12px 32px rgba(0, 0, 0, 0.35);
  }

  .paper-half {
    font-size: 12px;
    color: #a78bfa;
    display: flex;
    align-items: center;
    gap: 6px;
    margin-bottom: 8px;
  }

  .paper-title {
    font-size: 16px;
    font-weight: 600;
    color: #e5eaf3;
    margin-bottom: 12px;
  }

  .paper-meta {
    display: flex;
    gap: 16px;
    font-size: 13px;
    color: #7c86a6;
    margin-bottom: 12px;

    .meta-item {
      display: flex;
      align-items: center;
      gap: 5px;
    }

    .done {
      color: #34d399;
    }
  }

  .paper-progress {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 14px;

    .progress-bar {
      flex: 1;
      height: 6px;
      border-radius: 3px;
      background: rgba(255, 255, 255, 0.08);
      overflow: hidden;
    }

    .progress-inner {
      height: 100%;
      border-radius: 3px;
      background: linear-gradient(90deg, #8b5cf6, #22d3ee);
      transition: width 0.4s;
    }

    .percent {
      font-size: 12px;
      color: #9aa4bd;
      width: 36px;
      text-align: right;
    }
  }

  .paper-go {
    font-size: 13px;
    color: #22d3ee;
    display: flex;
    align-items: center;
    gap: 6px;
  }
}

:deep(.ant-empty-description) {
  color: #7c86a6;
  padding: 20px 0;
}
</style>
