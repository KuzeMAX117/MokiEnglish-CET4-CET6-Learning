<template>
  <div class="exam-page" :style="examPageStyle">
    <div v-if="loading" class="loading-wrap">
      <a-spin size="large" />
    </div>
    <div v-else-if="paperDetail" class="exam-layout">
      <!-- 试卷头部 -->
      <div class="exam-head">
        <div class="back-bar" @click="router.back()">
          <LeftOutlined />
          <span>返回</span>
        </div>
        <div class="exam-title">
          <FileTextOutlined class="title-icon" />
          {{ paperDetail.title }}
        </div>
        <div class="exam-head-actions">
          <a-popover
            v-if="revealedAll && scoreList.length"
            trigger="click"
            placement="bottomRight"
            overlay-class-name="score-popover-overlay"
          >
            <template #content>
              <div class="score-panel">
                <div class="score-header-row">
                  <span class="score-panel-title">各板块得分</span>
                  <span class="score-total">{{ totalEarnedScore }} / {{ totalMaxScore }}分</span>
                </div>
                <div v-for="s in scoreList" :key="s.name" class="score-row">
                  <span class="score-name">{{ s.name }}</span>
                  <span class="score-detail">
                    <span class="score-correct" :class="{ full: s.correct === s.total && s.total > 0 }">{{ s.correct }}/{{ s.total }}</span>
                    <span class="score-pts">{{ s.earnedScore }}/{{ s.maxScore }}分</span>
                  </span>
                  <div class="score-bar-bg">
                    <div class="score-bar-fill" :style="{ width: s.maxScore > 0 ? (s.earnedScore / s.maxScore * 100) + '%' : '0%' }" :class="{ full: s.correct === s.total && s.total > 0 }" />
                  </div>
                </div>
              </div>
            </template>
            <a-button class="score-btn" size="small">{{ totalEarnedScore }}分</a-button>
          </a-popover>
          <a-button type="primary" size="small" :disabled="revealedAll" @click="checkAnswers">
            <CheckOutlined />
            {{ checkBtnText }}
          </a-button>
          <a-button size="small" :disabled="revealedAll" @click="revealAllAnswers">
            <ThunderboltOutlined />
            一键对全部
          </a-button>
          <a-button size="small" danger :disabled="resetting" @click="resetAnswers">
            <ReloadOutlined />
            重置答案
          </a-button>
        </div>
        <div class="exam-progress">
          已做 {{ answeredCount }}/{{ flatTopics.length }}
          <span class="dot">·</span>
          正确 {{ correctCount }}
        </div>
        <a-popover
          trigger="click"
          placement="bottomRight"
          overlay-class-name="settings-popover-overlay"
          v-model:open="settingsVisible"
        >
          <template #content>
            <div class="settings-panel">
              <div class="settings-title">显示设置</div>
              <div class="settings-section">
                <div class="settings-label">背景色</div>
                <div class="color-options">
                  <div
                    v-for="c in bgOptions"
                    :key="c.value"
                    class="color-swatch"
                    :class="{ active: displaySettings.bgColor === c.value }"
                    :style="c.value === 'default' ? { background: c.preview, border: '1px dashed var(--border)' } : { background: c.preview }"
                    :title="c.name"
                    @click="displaySettings.bgColor = c.value"
                  />
                </div>
              </div>
              <div class="settings-section">
                <div class="settings-label">字体大小</div>
                <div class="font-size-control">
                  <a-button size="small" @click="changeFontSize(-1)">A-</a-button>
                  <span class="font-size-value">{{ displaySettings.fontSize }}px</span>
                  <a-button size="small" @click="changeFontSize(1)">A+</a-button>
                </div>
                <div class="font-size-presets">
                  <span
                    v-for="p in fontSizePresets"
                    :key="p"
                    class="preset-tag"
                    :class="{ active: displaySettings.fontSize === p }"
                    @click="displaySettings.fontSize = p"
                  >{{ p }}px</span>
                </div>
              </div>
              <div class="settings-footer">
                <a-button size="small" type="link" @click="resetDisplaySettings">重置默认</a-button>
              </div>
            </div>
          </template>
          <div class="settings-btn" :class="{ active: settingsVisible }">
            <SettingOutlined />
          </div>
        </a-popover>
      </div>

      <!-- Section 标签导航 -->
      <div class="section-tabs">
        <div
          v-for="(sec, idx) in paperDetail.sections"
          :key="idx"
          class="section-tab"
          :class="{ active: currentSectionIndex === idx }"
          @click="switchSection(idx)"
        >
          <span class="tab-label">{{ sectionDisplayName(sec) }}</span>
          <span v-if="sectionProgress(sec) > 0" class="tab-badge">
            {{ sectionProgress(sec) }}/{{ sec.topics.length }}
          </span>
        </div>
      </div>

      <!-- 主内容区域：左右分栏 -->
      <div v-if="currentSection" class="exam-body">
        <!-- 左侧：文章/原文（仅在有文章时显示） -->
        <div v-if="currentArticle" class="article-panel" :class="{ expanded: !showQuestions }">
          <div class="article-header">
            <span class="article-badge">{{ sectionDisplayName(currentSection) }}</span>
            <span v-if="currentArticle" class="article-title">文章原文</span>
            <span v-else class="article-title">题目内容</span>
          </div>
          <div class="article-content">
            <div class="article-text" v-html="formatArticle(currentArticle)" />
          </div>
        </div>

        <!-- 右侧：题目面板（可收起） -->
        <div class="question-panel" :class="{ collapsed: !showQuestions }">
          <!-- 收起/展开按钮 -->
          <div class="panel-toggle" @click="toggleQuestions">
            <template v-if="showQuestions">
              <RightOutlined />
              <span>收起</span>
            </template>
            <template v-else>
              <LeftOutlined />
              <span>展开题目</span>
            </template>
          </div>

          <div v-show="showQuestions" class="question-inner">
            <div v-if="poolWords.length" class="word-pool">
              <div class="word-pool-grid">
                <span v-for="(word, i) in poolWords" :key="i" class="word-tag">{{ word }}</span>
              </div>
            </div>
            <div class="question-scroll">
              <div
                v-for="(topic, tIdx) in currentSection.topics"
                :key="topic.topicId"
                class="question-card"
                :class="{ active: currentTopicIndex === tIdx }"
                @click="currentTopicIndex = tIdx"
              >
                <template v-if="currentTopicIndex === tIdx">
                  <div class="question-row-active">
                    <span class="question-no">{{ topic.sorted }}</span>
                    <div v-if="getOptions(topic).length > 0" class="select-wrapper">
                      <a-select
                        :value="selections.get(topic.topicId) || undefined"
                        placeholder="请选择"
                        style="width: 100%"
                        :disabled="revealedIds.has(topic.topicId)"
                        @update:value="v => selectOption(topic, v)"
                      >
                        <a-select-option v-for="opt in getOptions(topic)" :key="opt.label" :value="opt.label">
                          <span class="opt-label">{{ opt.label }}</span> &nbsp; {{ opt.content }}
                        </a-select-option>
                      </a-select>
                    </div>
                  </div>

                  <!-- 解析 -->
                  <div v-if="getResultState(topic) !== 'none'" class="analysis-box" :class="getResultState(topic)">
                    <div class="analysis-title">
                      <CheckCircleOutlined v-if="getResultState(topic) === 'correct'" />
                      <CloseCircleOutlined v-else />
                      {{ getResultState(topic) === 'correct' ? '回答正确' : `回答错误，正确答案是 ${getResult(topic)?.correctOption}` }}
                    </div>
                    <div v-if="getResult(topic)?.analysis" class="analysis-content">{{ getResult(topic).analysis }}</div>
                  </div>

                  <!-- 对答案模式（未作答的题目） -->
                  <div v-if="revealedIds.has(topic.topicId) && getResultState(topic) === 'none'" class="reveal-box">
                    <template v-if="topic.correctOption">
                      <div class="reveal-answer">
                        <span class="reveal-label">正确答案:</span>
                        <span class="reveal-value">{{ topic.correctOption }}</span>
                      </div>
                      <div v-if="topic.analysis" class="reveal-analysis">{{ topic.analysis }}</div>
                    </template>
                    <div v-else class="reveal-empty">暂无参考答案</div>
                  </div>
                </template>
                <template v-else>
                  <div class="question-tag">
                    <span class="question-no">第 {{ topic.sorted }} 题</span>
                    <CheckCircleOutlined v-if="answers.has(topic.topicId) && answers.get(topic.topicId)" class="status-icon correct" />
                    <CloseCircleOutlined v-else-if="answers.has(topic.topicId) && !answers.get(topic.topicId)" class="status-icon wrong" />
                    <span v-else-if="selections.has(topic.topicId)" class="answered-tag">已作答</span>
                  </div>
                  <div class="question-name">{{ topic.topicName }}</div>
                </template>
              </div>
            </div>

            <!-- 底部导航 -->
            <div class="section-nav">
              <a-button :disabled="currentSectionIndex <= 0" @click="prevSection">
                <LeftOutlined /> 上一部分
              </a-button>
              <a-button
                type="primary"
                :disabled="currentSectionIndex >= (paperDetail?.sections?.length || 1) - 1"
                @click="nextSection"
              >
                下一部分 <RightOutlined />
              </a-button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { message, Modal } from 'ant-design-vue'
import {
  LeftOutlined,
  RightOutlined,
  FileTextOutlined,
  CheckOutlined,
  CloseOutlined,
  CheckCircleOutlined,
  CloseCircleOutlined,
  SettingOutlined,
  ThunderboltOutlined,
  ReloadOutlined,
} from '@ant-design/icons-vue'
import {
  apiQueryPaperDetail,
  apiQueryPaperProgress,
  apiSubmitPaperAnswer,
  apiResetPaperProgress,
} from '@/api/paper'
import type { PaperDetail, PaperTopicItem, PaperOption, PaperAnswerResult, PaperSection } from '@/types'

const route = useRoute()
const router = useRouter()
const loading = ref(true)
const paperDetail = ref<PaperDetail>()
const currentSectionIndex = ref(0)
const currentTopicIndex = ref(0)
const showQuestions = ref(true)

// 用户选择（对答案前仅记录选项，不显示对错）
const selections = ref(new Map<number, string>())
// 已对答案（揭示答案）的题目集合
const revealedIds = ref(new Set<number>())
// 是否已对完整张试卷答案
const revealedAll = ref(false)

const answers = ref(new Map<number, boolean>())
const resultStates = ref(new Map<number, PaperAnswerResult>())
const correctCount = ref(0)

// 显示设置
const settingsVisible = ref(false)
const displaySettings = ref({
  bgColor: 'default',
  fontSize: 15,
})
const bgOptions = [
  { name: '跟随主题', value: 'default', preview: 'linear-gradient(135deg, #ffffff 50%, #FBF6E9 50%)' },
  { name: '默认白', value: '#ffffff', preview: '#ffffff' },
  { name: '米黄', value: '#fdf6e3', preview: '#fdf6e3' },
  { name: '护眼绿', value: '#e8f5e9', preview: '#e8f5e9' },
  { name: '浅灰', value: '#f5f5f5', preview: '#f5f5f5' },
  { name: '淡蓝', value: '#eef4fc', preview: '#eef4fc' },
  { name: '深灰', value: '#2d2d2d', preview: '#2d2d2d' },
]
const fontSizePresets = [12, 14, 15, 16, 18, 20]
const changeFontSize = (delta: number) => {
  const next = displaySettings.value.fontSize + delta
  if (next >= 10 && next <= 28) displaySettings.value.fontSize = next
}
const resetDisplaySettings = () => {
  displaySettings.value.bgColor = 'default'
  displaySettings.value.fontSize = 15
}

const sectionNameMap: Record<string, string> = {
  writing: '写作',
  listening: '听力',
  reading: '阅读',
  translation: '翻译',
  cloze: '选词填空',
  vocabulary: '词汇',
}

const subSectionNameMap: Record<string, string> = {
  writing: '写作',
  news: '新闻报道',
  conversation: '长对话',
  passage: '听力篇章',
  cloze: '选词填空',
  matching: '长篇匹配',
  reading_1: '仔细阅读 (一)',
  reading_2: '仔细阅读 (二)',
  translation: '翻译',
}

const sectionDisplayName = (sec: PaperSection) => {
  if (sec.subSection && subSectionNameMap[sec.subSection]) {
    return subSectionNameMap[sec.subSection]
  }
  return sectionNameMap[sec.section] || sec.section
}

const currentSection = computed(() => paperDetail.value?.sections?.[currentSectionIndex.value])

const currentArticle = computed(() => {
  if (!currentSection.value) return ''
  const topics = currentSection.value.topics
  // 优先找第一个有完整文章内容的题目
  for (const t of topics) {
    if (t.article && t.article.trim().length > 0) return t.article
  }
  return ''
})

const poolWords = computed(() => {
  if (!currentSection.value) return []
  const words = new Set<string>()
  for (const topic of currentSection.value.topics) {
    for (const opt of getOptions(topic)) {
      if (opt.content) words.add(opt.content)
    }
  }
  return Array.from(words).slice(0, 15)
})

const flatTopics = computed(() =>
  (paperDetail.value?.sections || []).flatMap((s) => s.topics),
)

const answeredCount = computed(() => {
  let n = 0
  for (const t of flatTopics.value) {
    if (selections.value.has(t.topicId) || answers.value.has(t.topicId)) n++
  }
  return n
})

const scoreList = computed(() => {
  if (!paperDetail.value?.sections) return []
  return paperDetail.value.sections
    .map((sec) => {
      const topics = sec.topics
      const total = topics.length
      const correct = topics.filter((t) => answers.value.get(t.topicId) === true).length
      const maxScore = Math.round(total * 7.1 * 10) / 10
      const earnedScore = Math.round(correct * 7.1 * 10) / 10
      return { name: sectionDisplayName(sec), correct, total, maxScore, earnedScore }
    })
    .filter((s) => s.total > 0)
})

const totalEarnedScore = computed(() =>
  Math.round(scoreList.value.reduce((sum, s) => sum + s.earnedScore, 0) * 10) / 10,
)

const totalMaxScore = computed(() =>
  Math.round(scoreList.value.reduce((sum, s) => sum + s.maxScore, 0) * 10) / 10,
)

const sectionProgress = (sec: PaperSection) =>
  sec.topics.filter((t) => selections.value.has(t.topicId) || answers.value.has(t.topicId)).length

const toggleQuestions = () => {
  showQuestions.value = !showQuestions.value
}

const switchSection = (idx: number) => {
  currentSectionIndex.value = idx
  currentTopicIndex.value = 0
}

const prevSection = () => {
  if (currentSectionIndex.value > 0) {
    currentSectionIndex.value--
    currentTopicIndex.value = 0
  }
}

const nextSection = () => {
  if (paperDetail.value && currentSectionIndex.value < paperDetail.value.sections.length - 1) {
    currentSectionIndex.value++
    currentTopicIndex.value = 0
  }
}

const getOptions = (topic: PaperTopicItem): PaperOption[] => {
  if (!topic.options) return []
  try {
    return JSON.parse(topic.options)
  } catch {
    return []
  }
}

// 需要对答案的选择题（写作/翻译等无选项的题目不计入）
const answerableTopics = computed(() =>
  flatTopics.value.filter((t) => getOptions(t).length > 0),
)

// 是否所有选择题都已作答
const allAnswered = computed(
  () =>
    answerableTopics.value.length > 0 &&
    answerableTopics.value.every(
      (t) => selections.value.has(t.topicId) || answers.value.has(t.topicId),
    ),
)

const checkBtnText = computed(() => {
  if (revealedAll.value) return '已对答案'
  return allAnswered.value ? '对答案（整卷）' : '对本题答案'
})

const getResult = (topic: PaperTopicItem): PaperAnswerResult | undefined =>
  resultStates.value.get(topic.topicId)

const getResultState = (topic: PaperTopicItem): 'none' | 'correct' | 'wrong' => {
  const r = resultStates.value.get(topic.topicId)
  if (r) return r.correct ? 'correct' : 'wrong'
  const answered = answers.value.get(topic.topicId)
  if (answered === true) return 'correct'
  if (answered === false) return 'wrong'
  return 'none'
}

const optionClass = (topic: PaperTopicItem, label: string) => {
  const cls: Record<string, boolean> = {}
  const r = getResult(topic)
  const state = getResultState(topic)
  if (state === 'correct' && r?.correctOption === label) cls.correct = true
  else if (state === 'wrong') {
    if (r?.selected === label) cls.wrong = true
    if (r?.correctOption === label) cls.reveal = true
  } else if (state === 'none') {
    if (revealedIds.value.has(topic.topicId) && topic.correctOption === label) {
      cls['reveal-answer'] = true
    } else if (selections.value.get(topic.topicId) === label) {
      cls.selected = true
    }
  }
  return cls
}

// 点击选项仅记录选择，不立即显示答案；对答案后才揭示
const selectOption = (topic: PaperTopicItem, label: string) => {
  if (revealedIds.value.has(topic.topicId)) return
  selections.value.set(topic.topicId, label)
}

// 揭示单题答案：已选择则提交批改，未选择则仅展示正确答案
const revealTopic = async (topic: PaperTopicItem) => {
  if (revealedIds.value.has(topic.topicId)) return
  if (getOptions(topic).length === 0) return
  revealedIds.value.add(topic.topicId)
  const selected = selections.value.get(topic.topicId)
  if (!selected) return
  try {
    const res = await apiSubmitPaperAnswer({
      paperId: paperDetail.value!.id,
      topicId: topic.topicId,
      selected,
    })
    resultStates.value.set(topic.topicId, res.data)
    answers.value.set(topic.topicId, res.data.correct)
    if (res.data.correct) correctCount.value++
  } catch (e: any) {
    message.error(e?.message || '提交失败')
  }
}

// 对答案：整卷已作答则揭示全卷答案，否则仅揭示当前停留的题目
const checkAnswers = async () => {
  if (revealedAll.value) return
  if (allAnswered.value) {
    await revealAllAnswers()
    return
  }
  const cur = currentSection.value?.topics[currentTopicIndex.value]
  if (!cur) return
  if (getOptions(cur).length === 0) {
    message.info('当前题目无需对答案')
    return
  }
  if (!selections.value.has(cur.topicId)) {
    message.warning('请先作答当前题目')
    return
  }
  await revealTopic(cur)
}

// 一键对全部：不论是否做完，直接揭示整张试卷的答案与得分
const revealAllAnswers = async () => {
  if (revealedAll.value) return
  for (const t of answerableTopics.value) {
    await revealTopic(t)
  }
  revealedAll.value = true
}

// 重置答案：清空本地作答状态并删除后端已保存的作答记录
const resetting = ref(false)
const resetAnswers = () => {
  Modal.confirm({
    title: '重置答案',
    content: '将清空本试卷的全部作答记录与已揭示的答案，且不可恢复，确定重置吗？',
    okText: '确定重置',
    okType: 'danger',
    cancelText: '取消',
    onOk: async () => {
      resetting.value = true
      try {
        await apiResetPaperProgress(paperDetail.value!.id)
        selections.value.clear()
        revealedIds.value.clear()
        answers.value.clear()
        resultStates.value.clear()
        correctCount.value = 0
        revealedAll.value = false
        message.success('已重置，可重新作答')
      } catch (e: any) {
        message.error(e?.message || '重置失败')
      } finally {
        resetting.value = false
      }
    },
  })
}

const formatArticle = (text: string) =>
  text.replace(/\n/g, '<br>')

const examPageStyle = computed(() => {
  const s = displaySettings.value
  const isDark = s.bgColor === '#2d2d2d'
  return {
    ...(s.bgColor !== 'default' ? { background: s.bgColor } : {}),
    color: isDark ? '#e0e0e0' : undefined,
    '--exam-font-size': s.fontSize + 'px',
  }
})

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
      revealedIds.value.add(item.topicId)
      if (item.selected) selections.value.set(item.topicId, item.selected)
      if (item.correct) correct++
    }
    correctCount.value = correct
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  loadExam(Number(route.params.id))
})
</script>

<style scoped lang="scss">
.exam-page {
  position: fixed;
  inset: 0;
  background: var(--page-bg);
  display: flex;
  flex-direction: column;
  padding: 16px 28px 20px;
  gap: 12px;
  overflow: hidden;
  box-sizing: border-box;
  z-index: 100;
}

.loading-wrap {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
}

.back-bar {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 4px 10px;
  border-radius: 8px;
  font-size: calc(13px + var(--font-offset, 0px));
  color: var(--text-muted);
  cursor: pointer;
  transition: all 0.25s;
  flex-shrink: 0;

  &:hover {
    color: var(--primary);
    background: rgba(66, 87, 178, 0.06);
  }
}

.exam-layout {
  flex: 1;
  display: flex;
  flex-direction: column;
  min-height: 0;
  overflow: hidden;
}

.exam-head {
  display: flex;
  align-items: center;
  gap: 16px;
  padding-bottom: 12px;
  border-bottom: 1px solid var(--border);
  margin-bottom: 16px;
  max-width: 1400px;

  .exam-title {
    flex: 1;
    font-size: calc(18px + var(--font-offset, 0px));
    font-weight: 700;
    color: var(--text-title);

    .title-icon {
      color: var(--primary);
      margin-right: 8px;
    }
  }

  .exam-head-actions {
    display: flex;
    align-items: center;
    gap: 8px;
    flex-shrink: 0;

    .score-btn {
      font-size: calc(12px + var(--font-offset, 0px));
      border-radius: 8px;
      background: var(--card-bg);
      border-color: var(--border);
      color: var(--primary);
      font-weight: 600;
    }

    .ant-btn-primary {
      background: var(--primary);
      border-color: transparent;
      border-radius: 8px;
      font-size: calc(12px + var(--font-offset, 0px));
    }

    .ant-btn-default {
      border-radius: 8px;
      font-size: calc(12px + var(--font-offset, 0px));
    }
  }

  .exam-progress {
    font-size: calc(13px + var(--font-offset, 0px));
    color: var(--text-muted);
    flex-shrink: 0;

    .dot {
      margin: 0 8px;
    }
  }

  .settings-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 34px;
    height: 34px;
    border-radius: 8px;
    color: var(--text-muted);
    cursor: pointer;
    transition: all 0.25s;
    flex-shrink: 0;
    font-size: calc(16px + var(--font-offset, 0px));

    &:hover,
    &.active {
      color: var(--primary);
      background: rgba(66, 87, 178, 0.08);
    }
  }
}

.section-tabs {
  display: flex;
  gap: 8px;
  margin-bottom: 20px;
  flex-wrap: wrap;

  .section-tab {
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 8px 16px;
    border-radius: 10px;
    border: 1px solid var(--border);
    background: var(--card-bg);
    color: var(--text-muted);
    font-size: calc(13px + var(--font-offset, 0px));
    cursor: pointer;
    transition: all 0.2s;
    white-space: nowrap;

    &:hover {
      border-color: rgba(66, 87, 178, 0.35);
      color: var(--text-title);
    }

    &.active {
      background: linear-gradient(135deg, rgba(66, 87, 178, 0.08), rgba(251, 146, 60, 0.08));
      border-color: var(--primary);
      color: var(--primary);
      box-shadow: 0 0 12px rgba(66, 87, 178, 0.1);
    }

    .tab-badge {
      font-size: calc(11px + var(--font-offset, 0px));
      background: rgba(66, 87, 178, 0.1);
      color: var(--primary);
      padding: 1px 6px;
      border-radius: 6px;
    }
  }
}

.exam-body {
  display: flex;
  gap: 20px;
  flex: 1;
  min-height: 0;
  width: 100%;
}

.article-panel {
  flex: 7 1 0%;
  min-width: 0;
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: 14px;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  transition: flex 0.3s ease;

  &.expanded {
    flex: 7 1 0%;
  }

  .article-header {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 14px 20px;
    border-bottom: 1px solid var(--border);

    .article-badge {
      font-size: calc(12px + var(--font-offset, 0px));
      color: var(--primary);
      border: 1px solid rgba(66, 87, 178, 0.4);
      background: rgba(66, 87, 178, 0.06);
      border-radius: 8px;
      padding: 2px 12px;
    }

    .article-title {
      font-size: calc(14px + var(--font-offset, 0px));
      font-weight: 600;
      color: var(--text-title);
    }
  }

  .article-content {
    flex: 1;
    padding: 20px;
    overflow-y: auto;
    min-height: 0;

    .article-text {
      font-size: var(--exam-font-size, 15px);
      color: var(--text-body);
      line-height: 2;
      letter-spacing: 0.3px;
    }

    .topic-block {
      margin-bottom: 24px;

      .topic-no {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--primary);
        margin-bottom: 8px;
      }

      .topic-name {
        font-size: calc(15px + var(--font-offset, 0px));
        color: var(--text-title);
        line-height: 1.8;
        white-space: pre-wrap;
      }
    }
  }
}

.question-panel {
  flex: 3 1 0%;
  min-width: 0;
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: 14px;
  display: flex;
  flex-direction: column;
  position: relative;
  transition: all 0.3s ease;
  overflow: hidden;

  &.collapsed {
    flex: 0 0 48px;
    min-width: 48px;

    .panel-toggle {
      writing-mode: vertical-rl;
      padding: 20px 12px;
      justify-content: center;
    }
  }

  .panel-toggle {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 8px;
    padding: 10px 16px;
    border-bottom: 1px solid var(--border);
    color: var(--text-muted);
    font-size: calc(13px + var(--font-offset, 0px));
    cursor: pointer;
    transition: all 0.2s;

    &:hover {
      color: var(--primary);
      background: rgba(66, 87, 178, 0.04);
    }
  }

  .question-inner {
    flex: 1;
    display: flex;
    flex-direction: column;
    overflow: hidden;
  }

  .word-pool {
    padding: 12px 16px;
    border-bottom: 1px solid var(--border);
    background: rgba(66, 87, 178, 0.04);
    flex-shrink: 0;

    .word-pool-grid {
      display: grid;
      grid-template-columns: repeat(5, 1fr);
      gap: 8px;

      .word-tag {
        text-align: center;
        padding: 6px 4px;
        border-radius: 6px;
        background: rgba(66, 87, 178, 0.08);
        color: var(--primary);
        font-size: calc(12px + var(--font-offset, 0px));
        font-weight: 500;
        opacity: 0.55;
        border: 1px dashed rgba(66, 87, 178, 0.2);
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
      }
    }
  }

  .question-scroll {
    flex: 1;
    overflow-y: auto;
    padding: 16px;
    min-height: 0;
  }

  .question-card {
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 16px;
    margin-bottom: 14px;
    cursor: pointer;
    transition: all 0.2s;
    background: var(--page-bg);

    &:hover {
      border-color: rgba(66, 87, 178, 0.35);
    }

    &.active {
      border-color: var(--primary);
      background: rgba(66, 87, 178, 0.03);
      padding: 10px 14px;
      margin-bottom: 8px;
    }

    .question-row-active {
      display: flex;
      align-items: center;
      gap: 10px;

      .question-no {
        font-size: calc(14px + var(--font-offset, 0px));
        font-weight: 600;
        color: var(--primary);
        flex-shrink: 0;
      }

      .select-wrapper {
        flex: 1;
        min-width: 0;
      }
    }

    .question-tag {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 10px;

      .question-no {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--text-muted);
      }

      .status-icon {
        font-size: calc(14px + var(--font-offset, 0px));

        &.correct {
          color: var(--success);
        }

        &.wrong {
          color: var(--error);
        }
      }

      .answered-tag {
        font-size: calc(11px + var(--font-offset, 0px));
        color: var(--primary);
        background: rgba(66, 87, 178, 0.1);
        padding: 1px 8px;
        border-radius: 6px;
      }
    }

    .question-name {
      font-size: var(--exam-font-size, 14px);
      color: var(--text-title);
      line-height: 1.7;
      margin-bottom: 14px;
      display: -webkit-box;
      -webkit-line-clamp: 3;
      -webkit-box-orient: vertical;
      overflow: hidden;
      text-overflow: ellipsis;
    }
  }

  .option-list {
    .select-wrapper {
      padding: 4px 0;
    }

    .option-item {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 10px 14px;
      border-radius: 10px;
      border: 1px solid var(--border);
      background: var(--page-bg);
      margin-bottom: 8px;
      cursor: pointer;
      transition: all 0.2s;

      &:hover {
        border-color: rgba(66, 87, 178, 0.35);
        background: rgba(66, 87, 178, 0.04);
      }

      &.correct {
        border-color: rgba(40, 167, 69, 0.3);
        background: rgba(40, 167, 69, 0.06);
      }

      &.wrong {
        border-color: rgba(220, 53, 69, 0.3);
        background: rgba(220, 53, 69, 0.06);
      }

      &.reveal {
        border-color: rgba(40, 167, 69, 0.3);
        background: rgba(40, 167, 69, 0.04);
      }

      &.reveal-answer {
        border-color: rgba(40, 167, 69, 0.3);
        background: rgba(40, 167, 69, 0.06);

        .option-label {
          border-color: var(--success);
          color: var(--success);
          background: rgba(40, 167, 69, 0.1);
        }
      }

      &.selected {
        border-color: var(--primary);
        background: rgba(66, 87, 178, 0.06);

        .option-label {
          border-color: var(--primary);
          color: #fff;
          background: var(--primary);
        }
      }

      .option-label {
        width: 26px;
        height: 26px;
        border-radius: 50%;
        border: 1px solid var(--border);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: calc(12px + var(--font-offset, 0px));
        font-weight: 700;
        color: var(--text-muted);
        flex-shrink: 0;
      }

      .option-content {
        flex: 1;
        font-size: var(--exam-font-size, 13px);
        color: var(--text-body);
        line-height: 1.5;
      }

      .opt-mark {
        &.correct {
          color: var(--success);
        }

        &.wrong {
          color: var(--error);
        }

        &.reveal-correct {
          color: var(--success);
        }
      }
    }
  }

  .analysis-box {
    border-radius: 10px;
    padding: 12px 14px;
    margin-top: 12px;

    &.correct {
      background: rgba(40, 167, 69, 0.06);
      border: 1px solid rgba(40, 167, 69, 0.3);
    }

    &.wrong {
      background: rgba(220, 53, 69, 0.06);
      border: 1px solid rgba(220, 53, 69, 0.3);
    }

    .analysis-title {
      font-size: calc(13px + var(--font-offset, 0px));
      font-weight: 600;
      display: flex;
      align-items: center;
      gap: 6px;
    }

    &.correct .analysis-title {
      color: var(--success);
    }

    &.wrong .analysis-title {
      color: var(--error);
    }

    .analysis-content {
      margin-top: 6px;
      font-size: calc(12px + var(--font-offset, 0px));
      color: var(--text-muted);
      line-height: 1.7;
    }
  }

  .reveal-box {
    border-radius: 10px;
    padding: 12px 14px;
    margin-top: 12px;
    background: rgba(66, 87, 178, 0.05);
    border: 1px solid rgba(66, 87, 178, 0.25);

    .reveal-answer {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: calc(13px + var(--font-offset, 0px));
      font-weight: 600;

      .reveal-label {
        color: var(--primary);
      }

      .reveal-value {
        color: var(--success);
        background: rgba(40, 167, 69, 0.1);
        padding: 2px 10px;
        border-radius: 6px;
        font-size: calc(14px + var(--font-offset, 0px));
      }
    }

    .reveal-analysis {
      margin-top: 8px;
      font-size: calc(12px + var(--font-offset, 0px));
      color: var(--text-muted);
      line-height: 1.7;
    }

    .reveal-empty {
      font-size: calc(12px + var(--font-offset, 0px));
      color: var(--text-muted);
      font-style: italic;
    }
  }

  .section-nav {
    display: flex;
    gap: 10px;
    padding: 14px 16px;
    border-top: 1px solid var(--border);

    :deep(.ant-btn) {
      flex: 1;
      background: var(--card-bg);
      border-color: var(--border);
      color: var(--text-body);
      font-size: calc(13px + var(--font-offset, 0px));

      &.ant-btn-primary {
        background: var(--primary);
        border-color: transparent;
        color: #fff;
      }

      &:disabled {
        opacity: 0.4;
      }
    }
  }
}

:deep(.ant-empty-description) {
  color: var(--text-muted);
  padding: 20px 0;
}
</style>

<style lang="scss">
.score-popover-overlay {
  .ant-popover-inner {
    border-radius: 14px;
    padding: 0;
  }
}

.score-panel {
  width: 300px;
  padding: 16px;

  .score-header-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 14px;
    padding-bottom: 10px;
    border-bottom: 1px solid var(--card-bg);

    .score-panel-title {
      font-size: calc(14px + var(--font-offset, 0px));
      font-weight: 700;
      color: var(--text-title);
    }

    .score-total {
      font-size: calc(13px + var(--font-offset, 0px));
      font-weight: 600;
      color: var(--primary);
    }
  }

  .score-row {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 8px 0;

    .score-name {
      font-size: calc(13px + var(--font-offset, 0px));
      color: var(--text-body);
      width: 90px;
      flex-shrink: 0;
    }

    .score-detail {
      display: flex;
      flex-direction: column;
      align-items: flex-end;
      width: 70px;
      flex-shrink: 0;

      .score-correct {
        font-size: calc(13px + var(--font-offset, 0px));
        font-weight: 700;
        color: var(--text-muted);

        &.full {
          color: var(--success);
        }
      }

      .score-pts {
        font-size: calc(11px + var(--font-offset, 0px));
        color: var(--text-muted);
      }
    }

    .score-bar-bg {
      flex: 1;
      height: 6px;
      background: var(--card-bg);
      border-radius: 3px;
      overflow: hidden;

      .score-bar-fill {
        height: 100%;
        background: var(--primary);
        border-radius: 3px;
        transition: width 0.4s ease;

        &.full {
          background: var(--success);
        }
      }
    }
  }
}

.settings-popover-overlay {
  .ant-popover-inner {
    border-radius: 14px;
    padding: 0;
  }
}

.settings-panel {
  width: 260px;
  padding: 16px;

  .settings-title {
    font-size: calc(14px + var(--font-offset, 0px));
    font-weight: 700;
    color: var(--text-title);
    margin-bottom: 16px;
    padding-bottom: 10px;
    border-bottom: 1px solid var(--card-bg);
  }

  .settings-section {
    margin-bottom: 16px;

    .settings-label {
      font-size: calc(12px + var(--font-offset, 0px));
      font-weight: 600;
      color: var(--text-muted);
      margin-bottom: 8px;
    }

    .color-options {
      display: flex;
      gap: 8px;
      flex-wrap: wrap;

      .color-swatch {
        width: 34px;
        height: 34px;
        border-radius: 8px;
        border: 2px solid var(--border);
        cursor: pointer;
        transition: all 0.2s;
        position: relative;

        &:hover {
          transform: scale(1.1);
          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        }

        &.active {
          border-color: var(--primary);
          box-shadow: 0 0 0 2px rgba(66, 87, 178, 0.25);

          &::after {
            content: '✓';
            position: absolute;
            inset: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: calc(14px + var(--font-offset, 0px));
            font-weight: 700;
            color: var(--primary);
          }
        }
      }
    }

    .font-size-control {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 8px;

      .font-size-value {
        flex: 1;
        text-align: center;
        font-size: calc(14px + var(--font-offset, 0px));
        font-weight: 600;
        color: var(--text-title);
      }

      .ant-btn {
        font-size: calc(12px + var(--font-offset, 0px));
        font-weight: 700;
        border-radius: 6px;
        min-width: 36px;
      }
    }

    .font-size-presets {
      display: flex;
      gap: 6px;
      flex-wrap: wrap;

      .preset-tag {
        font-size: calc(11px + var(--font-offset, 0px));
        padding: 2px 10px;
        border-radius: 6px;
        background: var(--card-bg);
        color: var(--text-muted);
        cursor: pointer;
        transition: all 0.2s;
        border: 1px solid transparent;

        &:hover {
          color: var(--primary);
          border-color: rgba(66, 87, 178, 0.35);
        }

        &.active {
          background: rgba(66, 87, 178, 0.1);
          color: var(--primary);
          border-color: var(--primary);
          font-weight: 600;
        }
      }
    }
  }

  .settings-footer {
    padding-top: 10px;
    border-top: 1px solid var(--card-bg);
    text-align: right;
  }
}
</style>
