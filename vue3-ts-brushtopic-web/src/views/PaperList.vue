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
  margin: 0;
}

.back-bar {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 8px 16px;
  border-radius: var(--radius-sm);
  font-size: calc(14px + var(--font-offset, 0px));
  color: var(--text-muted);
  cursor: pointer;
  transition: all 0.25s;
  margin-bottom: 16px;

  &:hover {
    color: var(--primary);
    background: var(--primary-light);
  }
}

.level-tabs {
  display: flex;
  gap: 12px;
  margin-bottom: 28px;

  .level-tab {
    padding: 10px 28px;
    border-radius: var(--radius-md);
    border: 1px solid var(--border);
    background: var(--page-bg);
    color: var(--text-muted);
    font-size: calc(15px + var(--font-offset, 0px));
    font-weight: 600;
    cursor: pointer;
    transition: all 0.25s;

    &:hover {
      border-color: rgba(66, 87, 178, 0.35);
      color: var(--text-title);
    }

    &.active {
      background: var(--primary-light);
      border-color: var(--primary);
      color: var(--primary);
      box-shadow: var(--shadow-card);
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
      background: linear-gradient(180deg, var(--primary), rgba(66, 87, 178, 0.1));
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
      background: var(--primary);
      box-shadow: 0 0 0 4px rgba(66, 87, 178, 0.15);
    }

    .node-year {
      font-size: calc(20px + var(--font-offset, 0px));
      font-weight: 700;
      color: var(--text-title);
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
  background: var(--page-bg);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  padding: 20px 24px;
  cursor: pointer;
  transition: all 0.25s;
  box-shadow: var(--shadow-card);

  &:hover {
    border-color: rgba(66, 87, 178, 0.4);
    background: var(--primary-light);
    transform: translateY(-3px);
    box-shadow: var(--shadow-hover);
  }

  .paper-half {
    font-size: calc(12px + var(--font-offset, 0px));
    color: var(--primary);
    display: flex;
    align-items: center;
    gap: 6px;
    margin-bottom: 8px;
  }

  .paper-title {
    font-size: calc(16px + var(--font-offset, 0px));
    font-weight: 600;
    color: var(--text-title);
    margin-bottom: 12px;
  }

  .paper-meta {
    display: flex;
    gap: 16px;
    font-size: calc(13px + var(--font-offset, 0px));
    color: var(--text-muted);
    margin-bottom: 12px;

    .meta-item {
      display: flex;
      align-items: center;
      gap: 5px;
    }

    .done {
      color: var(--success);
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
      background: var(--card-bg);
      overflow: hidden;
    }

    .progress-inner {
      height: 100%;
      border-radius: 3px;
      background: var(--primary);
      transition: width 0.4s;
    }

    .percent {
      font-size: calc(12px + var(--font-offset, 0px));
      color: var(--text-muted);
      width: 36px;
      text-align: right;
    }
  }

  .paper-go {
    font-size: calc(13px + var(--font-offset, 0px));
    color: var(--primary);
    display: flex;
    align-items: center;
    gap: 6px;
    font-weight: 600;
  }
}

:deep(.ant-empty-description) {
  color: var(--text-muted);
  padding: 20px 0;
}
</style>
