<script setup lang="ts">
import { computed } from 'vue'
import { FileTextOutlined, CheckCircleOutlined, CloseCircleOutlined } from '@ant-design/icons-vue'
import type { PaperManageSectionType, PaperTopicItemType } from '@/api/topic/paper/type'

const props = defineProps<{
  /** 子板块分组（编辑器实时状态，article 已填充到每题） */
  sections: PaperManageSectionType[]
  /** 当前预览的板块下标 */
  activeIndex: number
  /** 试卷标题 */
  paperTitle?: string
}>()

const emit = defineEmits<{
  (e: 'update:activeIndex', index: number): void
}>()

const sectionNameMap: Record<string, string> = {
  writing: '写作',
  listening: '听力',
  reading: '阅读',
  translation: '翻译'
}

const subSectionNameMap: Record<string, string> = {
  writing: '写作',
  news: 'Section A 新闻报道',
  conversation: 'Section B 长对话',
  passage: 'Section C 听力篇章',
  cloze: 'Section A 选词填空',
  matching: 'Section B 段落匹配',
  reading_1: 'Section C Passage One',
  reading_2: 'Section C Passage Two',
  translation: '翻译'
}

const typeNameMap: Record<string, string> = {
  writing: '写作',
  listening: '听力',
  reading: '阅读',
  cloze: '选词填空',
  translation: '翻译',
  matching: '匹配'
}

/** 显示名称与前台 PaperExam 一致：子板块优先 */
const sectionDisplayName = (sec: PaperManageSectionType) => {
  if (sec.subSection && subSectionNameMap[sec.subSection]) {
    return subSectionNameMap[sec.subSection]
  }
  return sectionNameMap[sec.section] || sec.section
}

const currentSection = computed(() => props.sections[props.activeIndex])

const isCloze = computed(() => currentSection.value?.subSection === 'cloze')

const currentArticle = computed(() => {
  if (!currentSection.value) return ''
  for (const t of currentSection.value.topics) {
    if (t.article && t.article.trim().length > 0) return t.article
  }
  return ''
})

/** 当前板块第一题的全卷题号起点（对应保存后的 sorted） */
const startNo = computed(() => {
  let n = 0
  for (let i = 0; i < props.activeIndex; i++) {
    n += props.sections[i]?.topics.length || 0
  }
  return n
})

const switchSection = (idx: number) => {
  emit('update:activeIndex', idx)
}

const formatArticle = (text: string) =>
  text.replace(/\n/g, '<br>')

const isCorrectOpt = (topic: PaperTopicItemType, label: string) =>
  !!topic.correctOption && topic.correctOption.toUpperCase() === label.toUpperCase()

/** 解析选项 JSON 字符串 */
const parseOptions = (optStr: string): Array<{ label: string; content: string }> => {
  try {
    return JSON.parse(optStr)
  } catch {
    return []
  }
}

/** 选词填空：词库标记 */
const CLOZE_BANK_MARKER = '__CLOZE_WORD_BANK__'

/** 选词填空：从 topics 中提取词库（bank marker topic 的 options） */
const clozeWordBank = computed(() => {
  if (!isCloze.value || !currentSection.value) return []
  const bankTopic = currentSection.value.topics.find((t) => t.topicName === CLOZE_BANK_MARKER)
  return bankTopic?.options || []
})

/** 选词填空：空位列表（排除 bank marker） */
const clozeBlanks = computed(() => {
  if (!isCloze.value || !currentSection.value) return []
  return currentSection.value.topics.filter((t) => t.topicName !== CLOZE_BANK_MARKER)
})

/** 根据答案字母查找词库中对应的单词 */
const clozeWordByLabel = (label: string) => {
  const w = clozeWordBank.value.find((w) => w.label === label)
  return w?.content || ''
}
</script>
<template>
  <div class="paper-preview">
    <div class="preview-head">
      <FileTextOutlined class="title-icon" />
      <span class="preview-title">{{ paperTitle || '试卷预览' }}</span>
    </div>

    <!-- Section 标签导航 -->
    <div class="section-tabs">
      <div v-for="(sec, idx) in sections" :key="idx" class="section-tab" :class="{ active: activeIndex === idx }"
        @click="switchSection(idx)">
        <span class="tab-label">{{ sectionDisplayName(sec) }}</span>
        <span class="tab-badge">{{ sec.subSection === 'cloze' ? clozeBlanks.length : sec.topics.length }}</span>
      </div>
      <div v-if="sections.length === 0" class="empty-tabs">暂无题目，右侧录入后这里会实时显示</div>
    </div>

    <div v-if="currentSection" class="preview-body">
      <!-- 文章原文面板 -->
      <div v-if="currentArticle" class="article-panel">
        <div class="article-header">
          <span class="article-badge">{{ sectionDisplayName(currentSection) }}</span>
          <span class="article-title">文章原文</span>
        </div>
        <div class="article-content">
          <div class="article-text" v-html="formatArticle(currentArticle)"></div>
        </div>
      </div>

      <!-- ====== 选词填空预览 ====== -->
      <template v-if="isCloze">
        <div class="question-panel">
          <div class="question-scroll">
            <!-- 词库展示 -->
            <div v-if="clozeWordBank.length > 0" class="cloze-word-bank-preview">
              <div class="bank-title">Word Bank</div>
              <div class="bank-grid">
                <div v-for="w in clozeWordBank" :key="w.label" class="bank-item">
                  <span class="bank-label">{{ w.label }}</span>
                  <span class="bank-word">{{ w.content }}</span>
                </div>
              </div>
            </div>
            <div v-else class="empty-tip">暂无词库</div>

            <!-- 空位答案列表 -->
            <div v-if="clozeBlanks.length > 0" class="cloze-blanks-preview">
              <div class="blanks-title">答案</div>
              <div class="blanks-grid">
                <div v-for="(blank, bi) in clozeBlanks" :key="bi" class="blank-answer-item">
                  <span class="blank-no">{{ startNo + bi + 1 }}</span>
                  <span class="blank-answer-label">{{ blank.correctOption || '—' }}</span>
                  <span v-if="blank.correctOption" class="blank-answer-word">{{ clozeWordByLabel(blank.correctOption) }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </template>

      <!-- ====== 其他题型：下拉框预览 ====== -->
      <template v-else>
        <div class="question-panel">
          <div class="question-scroll">
            <div v-if="currentSection.topics.length === 0" class="empty-tip">该板块暂无题目</div>
            <div v-for="(topic, tIdx) in currentSection.topics" :key="tIdx" class="question-card">
              <div class="question-tag">
                <span class="question-no">第 {{ startNo + tIdx + 1 }} 题</span>
                <CheckCircleOutlined v-if="topic.correctOption" class="status-icon correct" />
                <span v-else class="answered-tag">未作答</span>
              </div>
              <div class="question-name" v-html="formatArticle(topic.topicName || '（题干为空）')"></div>

              <!-- 下拉框预览区 -->
              <div v-if="topic.options && topic.options.length > 0" class="topic-selector-preview">
                <a-select
                  :value="topic.correctOption"
                  disabled
                  style="width: 280px"
                >
                  <a-select-option v-for="opt in topic.options" :key="opt.label" :value="opt.label">
                    {{ opt.label }}. {{ opt.content }}
                  </a-select-option>
                </a-select>
              </div>

              <!-- 解析 -->
              <div v-if="topic.analysis" class="analysis-box">
                <div class="reveal-label">解析:</div>
                <div class="answer-text" v-html="formatArticle(topic.analysis)"></div>
              </div>
            </div>
          </div>
        </div>
      </template>
    </div>
  </div>
</template>
  <style lang="scss" scoped>
.paper-preview {
  --primary: #4257B2;
  --primary-hover: #364899;
  --page-bg: #ffffff;
  --card-bg: #F7F8FA;
  --text-title: #1A1A1A;
  --text-body: #444444;
  --text-muted: #70757A;
  --border: #E8EAED;
  --success: #28A745;
  --error: #DC3545;
  --exam-font-size: 15px;
  --font-offset: 0px;

  display: flex;
  flex-direction: column;
  height: 100%;
  min-height: 0;
  background: var(--page-bg);
  border-left: 1px solid var(--border);
  overflow: hidden;
}

.preview-head {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 12px 16px 0;

  .title-icon {
    color: var(--primary);
  }

  .preview-title {
    font-size: calc(15px + var(--font-offset, 0px));
    font-weight: 700;
    color: var(--text-title);
  }
}

.section-tabs {
  display: flex;
  gap: 8px;
  padding: 12px 16px;
  flex-wrap: wrap;
  border-bottom: 1px solid var(--border);

  .section-tab {
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 6px 12px;
    border-radius: 10px;
    border: 1px solid var(--border);
    background: var(--card-bg);
    color: var(--text-muted);
    font-size: calc(12px + var(--font-offset, 0px));
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

  .empty-tabs {
    font-size: calc(12px + var(--font-offset, 0px));
    color: var(--text-muted);
    padding: 4px 0;
  }
}

.preview-body {
  flex: 1;
  min-height: 0;
  display: flex;
  flex-direction: column;
  gap: 12px;
  padding: 12px 16px;
  overflow-y: auto;
}

.article-panel {
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: 14px;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  flex-shrink: 0;
  max-height: 38%;

  .article-header {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 10px 16px;
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
    padding: 16px;
    overflow-y: auto;
    overflow-x: hidden;
    min-height: 0;
    // 隐藏滚动条但保持滚动功能
    scrollbar-width: none; // Firefox
    -ms-overflow-style: none; // IE and Edge
    -webkit-overflow-scrolling: touch; // iOS惯性滚动
    &::-webkit-scrollbar {
      display: none; // Chrome, Safari, Opera
    }
    // 启用触摸滑动
    touch-action: pan-y;

    .article-text {
      font-size: var(--exam-font-size, 15px);
      color: var(--text-body);
      line-height: 2;
      letter-spacing: 0.3px;
      word-break: break-word;
    }
  }
}

.question-panel {
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: 14px;
  overflow: hidden;
  flex: 1;
  min-height: 0;

  .question-scroll {
    padding: 16px;
    overflow-y: auto;
    overflow-x: hidden;
    height: 100%;
    // 隐藏滚动条但保持滚动功能
    scrollbar-width: none; // Firefox
    -ms-overflow-style: none; // IE and Edge
    -webkit-overflow-scrolling: touch; // iOS惯性滚动
    &::-webkit-scrollbar {
      display: none; // Chrome, Safari, Opera
    }
    // 启用触摸滑动
    touch-action: pan-y;

    .empty-tip {
      text-align: center;
      color: var(--text-muted);
      font-size: calc(13px + var(--font-offset, 0px));
      padding: 40px 0;
    }
  }

  .question-card {
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 16px;
    margin-bottom: 14px;
    background: var(--page-bg);
    transition: all 0.2s;

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
      word-break: break-word;
    }
  }

  /* 下拉框预览区 */
  .topic-selector-preview {
    display: flex;
    align-items: center;
    gap: 12px;

    :deep(.ant-select) {
      .ant-select-selector {
        background: var(--card-bg);
        border-color: var(--border);
        border-radius: 8px;
      }

      .ant-select-selection-item {
        font-weight: 600;
        color: var(--primary);
      }
    }
  }

  .analysis-box {
    margin-top: 12px;
    padding: 10px 14px;
    border-radius: 10px;
    background: var(--card-bg);
    border: 1px dashed var(--border);

    .reveal-label {
      font-size: calc(12px + var(--font-offset, 0px));
      color: var(--text-muted);
      margin-bottom: 4px;
    }

    .answer-text {
      font-size: calc(12px + var(--font-offset, 0px));
      color: var(--text-body);
      line-height: 1.7;
      word-break: break-word;
    }
  }

  /* 选词填空预览样式 */
  .cloze-word-bank-preview {
    margin-bottom: 16px;

    .bank-title {
      font-size: calc(13px + var(--font-offset, 0px));
      font-weight: 700;
      color: var(--primary);
      margin-bottom: 10px;
    }

    .bank-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
      gap: 6px;

      .bank-item {
        display: flex;
        align-items: center;
        gap: 6px;
        padding: 4px 10px;
        border-radius: 8px;
        background: var(--page-bg);
        border: 1px solid var(--border);

        .bank-label {
          font-size: calc(12px + var(--font-offset, 0px));
          font-weight: 700;
          color: var(--primary);
          min-width: 16px;
        }

        .bank-word {
          font-size: calc(13px + var(--font-offset, 0px));
          color: var(--text-body);
        }
      }
    }
  }

  .cloze-blanks-preview {
    .blanks-title {
      font-size: calc(13px + var(--font-offset, 0px));
      font-weight: 700;
      color: var(--text-title);
      margin-bottom: 10px;
    }

    .blanks-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
      gap: 8px;

      .blank-answer-item {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 8px 12px;
        border-radius: 10px;
        background: var(--page-bg);
        border: 1px solid var(--border);

        .blank-no {
          font-size: calc(12px + var(--font-offset, 0px));
          font-weight: 700;
          color: var(--text-muted);
          min-width: 20px;
        }

        .blank-answer-label {
          font-size: calc(14px + var(--font-offset, 0px));
          font-weight: 700;
          color: var(--success);
        }

        .blank-answer-word {
          font-size: calc(12px + var(--font-offset, 0px));
          color: var(--text-body);
        }
      }
    }
  }
}
</style>
