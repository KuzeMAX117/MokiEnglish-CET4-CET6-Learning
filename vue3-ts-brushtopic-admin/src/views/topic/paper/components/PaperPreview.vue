<script setup lang="ts">
import { computed } from 'vue'
import { FileTextOutlined, CheckOutlined } from '@ant-design/icons-vue'
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
  news: '新闻报道',
  conversation: '长对话',
  passage: '听力篇章',
  cloze: '选词填空',
  matching: '长篇匹配',
  reading_1: '仔细阅读 (一)',
  reading_2: '仔细阅读 (二)',
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
</script>
<template>
  <div class="paper-preview">
    <div class="preview-head">
      <FileTextOutlined class="title-icon" />
      <span class="preview-title">{{ paperTitle || '试卷预览' }}</span>
    </div>

    <!-- Section 标签导航（与前台同款） -->
    <div class="section-tabs">
      <div v-for="(sec, idx) in sections" :key="idx" class="section-tab" :class="{ active: activeIndex === idx }"
        @click="switchSection(idx)">
        <span class="tab-label">{{ sectionDisplayName(sec) }}</span>
        <span class="tab-badge">{{ sec.topics.length }}</span>
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

      <!-- 题目面板 -->
      <div class="question-panel">
        <div class="question-scroll">
          <div v-if="currentSection.topics.length === 0" class="empty-tip">该板块暂无题目</div>
          <div v-for="(topic, tIdx) in currentSection.topics" :key="tIdx" class="question-card">
            <div class="question-tag">
              <span class="question-no">第 {{ startNo + tIdx + 1 }} 题</span>
              <span v-if="topic.questionType" class="type-tag">{{ typeNameMap[topic.questionType] || topic.questionType
                }}</span>
            </div>
            <div class="question-name" v-html="formatArticle(topic.topicName || '（题干为空）')"></div>

            <!-- 选项列表 -->
            <div v-if="topic.options && topic.options.length > 0" class="option-list">
              <div v-for="opt in topic.options" :key="opt.label" class="option-item"
                :class="isCorrectOpt(topic, opt.label) ? 'reveal-answer' : ''">
                <span class="option-label">{{ opt.label }}</span>
                <span class="option-content">{{ opt.content }}</span>
                <CheckOutlined v-if="isCorrectOpt(topic, opt.label)" class="opt-mark correct" />
              </div>
            </div>

            <!-- 答案与解析（预览显示，方便录入核对） -->
            <div class="reveal-box">
              <div class="reveal-answer">
                <span class="reveal-label">正确答案:</span>
                <span v-if="topic.correctOption" class="reveal-value">{{ topic.correctOption }}</span>
                <span v-else class="reveal-missing">未填写</span>
              </div>
              <div v-if="topic.answer" class="reveal-analysis">
                <span class="reveal-label">参考答案:</span>
                <span class="answer-text" v-html="formatArticle(topic.answer)"></span>
              </div>
              <div v-if="topic.analysis" class="reveal-analysis">
                <span class="reveal-label">解析:</span>
                <span class="answer-text" v-html="formatArticle(topic.analysis)"></span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<style lang="scss" scoped>
/* 局部复刻前台 global.css 设计变量，保证样式与 PaperExam.vue 一致 */
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
    min-height: 0;

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
    height: 100%;

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

      .type-tag {
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

  .option-list {
    .option-item {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 10px 14px;
      border-radius: 10px;
      border: 1px solid var(--border);
      background: var(--page-bg);
      margin-bottom: 8px;

      &.reveal-answer {
        border-color: rgba(40, 167, 69, 0.3);
        background: rgba(40, 167, 69, 0.06);

        .option-label {
          border-color: var(--success);
          color: var(--success);
          background: rgba(40, 167, 69, 0.1);
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
        word-break: break-word;
      }

      .opt-mark {
        &.correct {
          color: var(--success);
        }
      }
    }
  }

  .reveal-box {
    margin-top: 12px;
    padding: 10px 14px;
    border-radius: 10px;
    background: var(--card-bg);
    border: 1px dashed var(--border);

    .reveal-answer {
      display: flex;
      align-items: center;
      gap: 6px;
      margin-bottom: 4px;

      .reveal-label {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--text-muted);
      }

      .reveal-value {
        font-size: calc(13px + var(--font-offset, 0px));
        font-weight: 700;
        color: var(--success);
      }

      .reveal-missing {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--error);
      }
    }

    .reveal-analysis {
      font-size: calc(12px + var(--font-offset, 0px));
      color: var(--text-body);
      line-height: 1.7;
      word-break: break-word;

      .reveal-label {
        color: var(--text-muted);
        margin-right: 4px;
      }
    }
  }
}
</style>
