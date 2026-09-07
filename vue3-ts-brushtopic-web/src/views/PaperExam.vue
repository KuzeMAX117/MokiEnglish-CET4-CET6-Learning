<template>
  <div class="exam-page">
    <div class="back-bar" @click="router.back()">
      <LeftOutlined />
      <span>返回试卷列表</span>
    </div>

    <a-spin :spinning="loading">
      <div v-if="paperDetail" class="exam-layout">
        
        <div class="exam-head">
          <div class="exam-title">
            <FileTextOutlined class="title-icon" />
            {{ paperDetail.title }}
          </div>
          <div class="exam-progress">
            已做 {{ answeredCount }}/{{ flatTopics.length }}
            <span class="dot">·</span>
            正确 {{ correctCount }}
          </div>
        </div>

        
        <div class="exam-body">
          <div class="question-panel">
            <template v-if="currentTopic">
              <div class="question-tag">
                <span class="section-badge">{{ sectionName(currentTopic.section) }}</span>
                <span class="question-no">第 {{ currentTopic.sorted }} 题</span>
              </div>
              <div class="question-name">{{ currentTopic.topicName }}</div>
              <div class="option-list">
                <div
                  v-for="opt in currentOptions"
                  :key="opt.label"
                  class="option-item"
                  :class="optionClass(opt.label)"
                  @click="selectOption(opt.label)"
                >
                  <span class="option-label">{{ opt.label }}</span>
                  <span class="option-content">{{ opt.content }}</span>
                  <CheckOutlined v-if="resultState === 'correct' && opt.label === answerResult?.correctOption" class="opt-mark correct" />
                  <CloseOutlined v-if="resultState === 'wrong' && opt.label === answerResult?.selected" class="opt-mark wrong" />
                </div>
              </div>
              <div v-if="resultState !== 'none'" class="analysis-box" :class="resultState">
                <div class="analysis-title">
                  <CheckCircleOutlined v-if="resultState === 'correct'" />
                  <CloseCircleOutlined v-else />
                  {{ resultState === 'correct' ? '回答正确' : `回答错误，正确答案是 ${answerResult?.correctOption}` }}
                </div>
                <div v-if="answerResult?.analysis" class="analysis-content">{{ answerResult.analysis }}</div>
              </div>
              <div class="question-nav">
                <a-button :disabled="currentIndex <= 0" @click="prevTopic">上一题</a-button>
                <a-button type="primary" :disabled="currentIndex >= flatTopics.length - 1" @click="nextTopic">
                  下一题
                </a-button>
              </div>
            </template>
            <a-empty v-else-if="!loading" description="该试卷暂无题目～" />
          </div>

          
          <div class="nav-panel">
            <div class="nav-title">答题卡</div>
            <div v-for="section in paperDetail.sections" :key="section.section" class="nav-section">
              <div class="nav-section-name">{{ sectionName(section.section) }}</div>
              <div class="nav-grid">
                <div
                  v-for="topic in section.topics"
                  :key="topic.topicId"
                  class="nav-item"
                  :class="navItemClass(topic)"
                  @click="goTopic(topic)"
                >
                  {{ topic.sorted }}
                </div>
              </div>
            </div>
            <div class="nav-legend">
              <span><i class="dot done" /> 已答对</span>
              <span><i class="dot wrong" /> 已答错</span>
              <span><i class="dot current" /> 当前</span>
            </div>
          </div>
        </div>
      </div>
    </a-spin>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { message } from 'ant-design-vue'
import {
  LeftOutlined,
  RightOutlined,
  FileTextOutlined,
  CheckOutlined,
  CloseOutlined,
  CheckCircleOutlined,
  CloseCircleOutlined,
} from '@ant-design/icons-vue'
import {
  apiQueryPaperDetail,
  apiQueryPaperProgress,
  apiSubmitPaperAnswer,
} from '@/api/paper'
import type { PaperDetail, PaperTopicItem, PaperOption, PaperAnswerResult } from '@/types'

const route = useRoute()
const router = useRouter()
const loading = ref(true)
const paperDetail = ref<PaperDetail>()
const currentIndex = ref(0)

const resultState = ref<'none' | 'correct' | 'wrong'>('none')
const answerResult = ref<PaperAnswerResult>()

const sectionNames: Record<string, string> = {
  writing: '写作',
  listening: '听力',
  reading: '阅读',
  translation: '翻译',
  cloze: '选词填空',
  vocabulary: '词汇',
}

const sectionName = (section: string) => sectionNames[section] || section

const flatTopics = computed(() =>
  (paperDetail.value?.sections || []).flatMap((s) => s.topics),
)

const currentTopic = computed(() => flatTopics.value[currentIndex.value])

const currentOptions = computed<PaperOption[]>(() => {
  if (!currentTopic.value?.options) return []
  try {
    return JSON.parse(currentTopic.value.options)
  } catch {
    return []
  }
})

const answeredCount = computed(() => answers.value.size)
const correctCount = ref(0)

const answers = ref(new Map<number, boolean>())

const loadExam = async (paperId: number) => {
  loading.value = true
  try {
    const [detailRes, progressRes] = await Promise.all([
      apiQueryPaperDetail(paperId),
      apiQueryPaperProgress(paperId),
    ])
    paperDetail.value = detailRes.data
    const progress = progressRes.data || []
    let correct = 0
    for (const item of progress) {
      answers.value.set(item.topicId, item.correct)
      if (item.correct) correct++
    }
    correctCount.value = correct
    
    const firstUndone = flatTopics.value.findIndex((t) => !answers.value.has(t.topicId))
    currentIndex.value = firstUndone >= 0 ? firstUndone : 0
    syncResultState()
  } finally {
    loading.value = false
  }
}

const syncResultState = () => {
  const topic = currentTopic.value
  if (!topic) return
  const answered = answers.value.has(topic.topicId)
  if (!answered) {
    resultState.value = 'none'
    answerResult.value = undefined
  } else {
    
    resultState.value = answers.value.get(topic.topicId) ? 'correct' : 'wrong'
    answerResult.value = undefined
  }
}

const selectOption = async (label: string) => {
  const topic = currentTopic.value
  if (!topic) return
  try {
    const res = await apiSubmitPaperAnswer({
      paperId: paperDetail.value!.id,
      topicId: topic.topicId,
      selected: label,
    })
    answerResult.value = res.data
    resultState.value = res.data.correct ? 'correct' : 'wrong'
    const wasCorrect = answers.value.get(topic.topicId)
    answers.value.set(topic.topicId, res.data.correct)
    
    if (wasCorrect === true && !res.data.correct) correctCount.value--
    else if (wasCorrect !== true && res.data.correct) correctCount.value++
  } catch (e: any) {
    message.error(e?.message || '提交失败')
  }
}

const goTopic = (topic: PaperTopicItem) => {
  const index = flatTopics.value.findIndex((t) => t.topicId === topic.topicId)
  if (index >= 0) {
    currentIndex.value = index
    syncResultState()
  }
}

const prevTopic = () => {
  if (currentIndex.value > 0) {
    currentIndex.value--
    syncResultState()
  }
}

const nextTopic = () => {
  if (currentIndex.value < flatTopics.value.length - 1) {
    currentIndex.value++
    syncResultState()
  }
}

const optionClass = (label: string) => {
  const cls: Record<string, boolean> = { [label]: true }
  if (resultState.value === 'correct') {
    if (answerResult.value?.correctOption === label) cls.correct = true
  } else if (resultState.value === 'wrong') {
    if (answerResult.value?.selected === label) cls.wrong = true
    if (answerResult.value?.correctOption === label) cls.reveal = true
  }
  return cls
}

const navItemClass = (topic: PaperTopicItem) => {
  const cls: Record<string, boolean> = {}
  if (topic.sorted === currentTopic.value?.sorted) cls.current = true
  const correct = answers.value.get(topic.topicId)
  if (correct === true) cls.done = true
  else if (correct === false) cls.wrong = true
  return cls
}

onMounted(() => {
  loadExam(Number(route.params.id))
})
</script>

<style scoped lang="scss">
.exam-page {
  max-width: 1280px;
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

.exam-layout {
  background: rgba(18, 24, 40, 0.6);
  backdrop-filter: blur(14px);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 18px;
  padding: 24px 28px;
  box-shadow: 0 16px 48px rgba(0, 0, 0, 0.35);
}

.exam-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-bottom: 16px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
  margin-bottom: 20px;

  .exam-title {
    font-size: 18px;
    font-weight: 700;
    color: #e5eaf3;

    .title-icon {
      color: #a78bfa;
      margin-right: 8px;
    }
  }

  .exam-progress {
    font-size: 13px;
    color: #7c86a6;

    .dot {
      margin: 0 8px;
    }
  }
}

.exam-body {
  display: flex;
  gap: 24px;

  
  .question-panel {
    flex: 7;
    min-width: 0;

    .question-tag {
      display: flex;
      align-items: center;
      gap: 12px;
      margin-bottom: 16px;

      .section-badge {
        font-size: 12px;
        color: #22d3ee;
        border: 1px solid rgba(34, 211, 238, 0.4);
        background: rgba(34, 211, 238, 0.08);
        border-radius: 8px;
        padding: 2px 12px;
      }

      .question-no {
        font-size: 13px;
        color: #7c86a6;
      }
    }

    .question-name {
      font-size: 16px;
      color: #e5eaf3;
      line-height: 1.7;
      margin-bottom: 20px;
    }

    .option-list {
      .option-item {
        display: flex;
        align-items: center;
        gap: 14px;
        padding: 14px 18px;
        border-radius: 12px;
        border: 1px solid rgba(255, 255, 255, 0.08);
        background: rgba(255, 255, 255, 0.02);
        margin-bottom: 12px;
        cursor: pointer;
        transition: all 0.2s;

        &:hover {
          border-color: rgba(139, 92, 246, 0.5);
          background: rgba(139, 92, 246, 0.08);
        }

        &.correct {
          border-color: rgba(52, 211, 153, 0.7);
          background: rgba(52, 211, 153, 0.1);
        }

        &.wrong {
          border-color: rgba(248, 113, 113, 0.7);
          background: rgba(248, 113, 113, 0.1);
        }

        &.reveal {
          border-color: rgba(52, 211, 153, 0.7);
          background: rgba(52, 211, 153, 0.06);
        }

        .option-label {
          width: 28px;
          height: 28px;
          border-radius: 50%;
          border: 1px solid rgba(255, 255, 255, 0.15);
          display: flex;
          align-items: center;
          justify-content: center;
          font-size: 13px;
          font-weight: 700;
          color: #9aa4bd;
          flex-shrink: 0;
        }

        .option-content {
          flex: 1;
          font-size: 14px;
          color: #cdd5e4;
          line-height: 1.6;
        }

        .opt-mark {
          &.correct {
            color: #34d399;
          }

          &.wrong {
            color: #f87171;
          }
        }
      }
    }

    .analysis-box {
      border-radius: 12px;
      padding: 14px 18px;
      margin-bottom: 20px;

      &.correct {
        background: rgba(52, 211, 153, 0.08);
        border: 1px solid rgba(52, 211, 153, 0.35);
      }

      &.wrong {
        background: rgba(248, 113, 113, 0.08);
        border: 1px solid rgba(248, 113, 113, 0.35);
      }

      .analysis-title {
        font-size: 14px;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 8px;

        .anticon-check-circle {
          color: #34d399;
        }

        .anticon-close-circle {
          color: #f87171;
        }
      }

      &.correct .analysis-title {
        color: #34d399;
      }

      &.wrong .analysis-title {
        color: #f87171;
      }

      .analysis-content {
        margin-top: 8px;
        font-size: 13px;
        color: #9aa4bd;
        line-height: 1.7;
      }
    }

    .question-nav {
      display: flex;
      gap: 12px;

      :deep(.ant-btn) {
        background: rgba(255, 255, 255, 0.06);
        border-color: rgba(255, 255, 255, 0.12);
        color: #cdd5e4;

        &.ant-btn-primary {
          background: linear-gradient(135deg, #8b5cf6, #22d3ee);
          border-color: transparent;
          color: #fff;
        }

        &:disabled {
          opacity: 0.4;
        }
      }
    }
  }

  
  .nav-panel {
    flex: 3;
    min-width: 0;
    background: rgba(255, 255, 255, 0.02);
    border: 1px solid rgba(255, 255, 255, 0.06);
    border-radius: 14px;
    padding: 18px;
    align-self: flex-start;
    position: sticky;
    top: 16px;
    max-height: calc(100vh - 220px);
    overflow-y: auto;

    .nav-title {
      font-size: 15px;
      font-weight: 600;
      color: #e5eaf3;
      margin-bottom: 16px;
    }

    .nav-section {
      margin-bottom: 16px;

      .nav-section-name {
        font-size: 12px;
        color: #a78bfa;
        margin-bottom: 10px;
      }

      .nav-grid {
        display: grid;
        grid-template-columns: repeat(5, 1fr);
        gap: 8px;

        .nav-item {
          aspect-ratio: 1;
          border-radius: 8px;
          border: 1px solid rgba(255, 255, 255, 0.1);
          display: flex;
          align-items: center;
          justify-content: center;
          font-size: 13px;
          color: #9aa4bd;
          cursor: pointer;
          transition: all 0.2s;

          &:hover {
            border-color: rgba(139, 92, 246, 0.6);
            color: #fff;
          }

          &.done {
            background: rgba(52, 211, 153, 0.15);
            border-color: rgba(52, 211, 153, 0.5);
            color: #34d399;
          }

          &.wrong {
            background: rgba(248, 113, 113, 0.15);
            border-color: rgba(248, 113, 113, 0.5);
            color: #f87171;
          }

          &.current {
            border-color: #22d3ee;
            color: #22d3ee;
            box-shadow: 0 0 10px rgba(34, 211, 238, 0.4);
          }
        }
      }
    }

    .nav-legend {
      display: flex;
      gap: 14px;
      font-size: 12px;
      color: #7c86a6;
      padding-top: 4px;

      span {
        display: flex;
        align-items: center;
        gap: 5px;
      }

      .dot {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        display: inline-block;

        &.done {
          background: #34d399;
        }

        &.wrong {
          background: #f87171;
        }

        &.current {
          background: #22d3ee;
        }
      }
    }
  }
}

:deep(.ant-empty-description) {
  color: #7c86a6;
  padding: 20px 0;
}
</style>
