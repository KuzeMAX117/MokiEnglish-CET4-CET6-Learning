<template>
  <div class="editor-page">
    <div class="head-bar">
      <div class="back-bar" @click="router.push('/writing')">
        <LeftOutlined />
        <span>返回题目列表</span>
      </div>
      <div class="topic-title-bar">
        {{ topic.title }}
      </div>
      <div class="word-counter">
        {{ wordCount }} / {{ topic.wordLimit }} 词
      </div>
    </div>

    <div class="editor-layout">
      <div class="write-panel">
        <div class="panel-head">
          <span class="panel-label">
            <EditOutlined /> 写作区
          </span>
          <span class="panel-hint">在左侧撰写你的作文</span>
        </div>
        <div class="topic-desc-box">
          <div class="desc-label">题目要求</div>
          <div class="desc-text">{{ topic.description }}</div>
        </div>
        <textarea
          v-model="essayContent"
          class="write-textarea"
          placeholder="Start writing your essay here..."
          spellcheck="false"
        />
        <div class="write-actions">
          <a-button @click="essayContent = ''">
            <ClearOutlined /> 清空
          </a-button>
          <a-button
            type="primary"
            :loading="submitting"
            :disabled="wordCount < 20"
            class="submit-btn"
            @click="submitEssay"
          >
            <SendOutlined /> 提交批改
          </a-button>
        </div>
      </div>

      <div class="result-panel">
        <div class="panel-head">
          <span class="panel-label">
            <RobotOutlined /> AI 批改
          </span>
          <span v-if="result.score !== null" class="score-badge">
            {{ result.score }}/15
          </span>
        </div>

        <div class="result-body">
          <template v-if="!submitted">
            <div class="empty-hint">
              <RobotOutlined class="hint-icon" />
              <div class="hint-title">AI 批改助手</div>
              <div class="hint-desc">提交作文后，AI 将从以下维度进行批改：</div>
              <div class="dim-list">
                <div class="dim-item"><CheckCircleOutlined class="dim-icon" /> 内容完整性</div>
                <div class="dim-item"><CheckCircleOutlined class="dim-icon" /> 语言准确性</div>
                <div class="dim-item"><CheckCircleOutlined class="dim-icon" /> 词汇丰富度</div>
                <div class="dim-item"><CheckCircleOutlined class="dim-icon" /> 篇章结构</div>
              </div>
            </div>
          </template>

          <template v-else-if="submitting">
            <div class="loading-hint">
              <a-spin size="large" />
              <div class="loading-text">AI 正在批改你的作文...</div>
            </div>
          </template>

          <template v-else>
            <div class="score-section">
              <div class="big-score">{{ result.score }}</div>
              <div class="score-label">/ 15 分</div>
            </div>

            <div class="feedback-section">
              <div class="section-title">总体评价</div>
              <div class="feedback-text">{{ result.overall }}</div>
            </div>

            <div v-if="result.grammarErrors.length" class="grammar-section">
              <div class="section-title">语法错误</div>
              <div v-for="(err, idx) in result.grammarErrors" :key="idx" class="error-card">
                <div class="error-original">
                  <CloseCircleOutlined class="err-icon wrong" />
                  {{ err.original }}
                </div>
                <div class="error-fix">
                  <CheckCircleOutlined class="err-icon correct" />
                  {{ err.correction }}
                </div>
                <div class="error-explain">{{ err.explanation }}</div>
              </div>
            </div>

            <div v-if="result.suggestions.length" class="suggestion-section">
              <div class="section-title">词汇建议</div>
              <div v-for="(s, idx) in result.suggestions" :key="idx" class="sug-card">
                <span class="sug-word">{{ s.original }}</span>
                <span class="sug-arrow">→</span>
                <span class="sug-better">{{ s.suggestion }}</span>
              </div>
            </div>
          </template>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, ref, reactive } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { message } from 'ant-design-vue'
import {
  LeftOutlined,
  EditOutlined,
  RobotOutlined,
  SendOutlined,
  ClearOutlined,
  CheckCircleOutlined,
  CloseCircleOutlined,
} from '@ant-design/icons-vue'

const route = useRoute()
const router = useRouter()

const topic = ref({
  id: Number(route.params.id),
  title: 'The Importance of Reading in the Digital Age',
  description: 'Write an essay on the importance of reading, discussing why reading remains essential despite the prevalence of digital media. You should write at least 150 words but no more than 200 words.',
  wordLimit: 200,
})

const essayContent = ref('')
const submitted = ref(false)
const submitting = ref(false)

const wordCount = computed(() => {
  const text = essayContent.value.trim()
  if (!text) return 0
  return text.split(/\s+/).length
})

const result = reactive({
  score: null as number | null,
  overall: '',
  grammarErrors: [] as { original: string; correction: string; explanation: string }[],
  suggestions: [] as { original: string; suggestion: string }[],
})

const submitEssay = async () => {
  if (wordCount.value < 20) {
    message.warning('作文至少需要 20 个词')
    return
  }
  submitting.value = true
  submitted.value = true

  setTimeout(() => {
    result.score = 11.5
    result.overall = 'Your essay demonstrates a good understanding of the topic with clear arguments. The structure is logical, moving from introduction to body paragraphs and conclusion. However, there are some grammatical errors and areas where vocabulary could be more varied.'
    result.grammarErrors = [
      {
        original: 'Reading is very importance in our life.',
        correction: 'Reading is very important in our lives.',
        explanation: '"importance" is a noun; use the adjective "important" after "is". Also, "life" should be plural "lives" when referring to people in general.',
      },
      {
        original: 'Digital media have change the way we get information.',
        correction: 'Digital media has changed the way we obtain information.',
        explanation: 'Use present perfect "has changed" for actions that started in the past and continue. "Obtain" is more formal than "get".',
      },
    ]
    result.suggestions = [
      { original: 'very important', suggestion: 'crucial / essential / vital' },
      { original: 'get information', suggestion: 'obtain / acquire information' },
      { original: 'a lot of', suggestion: 'numerous / a multitude of' },
    ]
    submitting.value = false
    message.success('批改完成！')
  }, 2000)
}
</script>

<style scoped lang="scss">
.editor-page {
  display: flex;
  flex-direction: column;
  gap: 12px;
  height: calc(100vh - 64px - 56px);
}

.head-bar {
  display: flex;
  align-items: center;
  gap: 16px;

  .back-bar {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 6px 12px;
    border-radius: var(--radius-sm);
    font-size: calc(13px + var(--font-offset, 0px));
    color: var(--text-muted);
    cursor: pointer;
    transition: all 0.25s;
    flex-shrink: 0;

    &:hover {
      color: var(--primary);
      background: var(--primary-light);
    }
  }

  .topic-title-bar {
    flex: 1;
    font-size: calc(16px + var(--font-offset, 0px));
    font-weight: 700;
    color: var(--text-title);
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }

  .word-counter {
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-muted);
    flex-shrink: 0;
    background: var(--card-bg);
    border: 1px solid var(--border);
    padding: 5px 14px;
    border-radius: var(--radius-sm);
  }
}

.editor-layout {
  flex: 1;
  display: flex;
  gap: 16px;
  min-height: 0;
}

.write-panel,
.result-panel {
  flex: 1;
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  display: flex;
  flex-direction: column;
  overflow: hidden;
  box-shadow: var(--shadow-card);

  .panel-head {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 14px 20px;
    border-bottom: 1px solid var(--border);

    .panel-label {
      font-size: calc(15px + var(--font-offset, 0px));
      font-weight: 600;
      color: var(--text-title);
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .panel-hint {
      font-size: calc(12px + var(--font-offset, 0px));
      color: var(--text-muted);
    }

    .score-badge {
      font-size: calc(14px + var(--font-offset, 0px));
      font-weight: 700;
      color: var(--success);
      background: var(--success-light);
      border: 1px solid var(--success);
      padding: 3px 12px;
      border-radius: var(--radius-sm);
    }
  }
}

.topic-desc-box {
  padding: 14px 20px;
  border-bottom: 1px solid var(--border);
  background: var(--primary-light);

  .desc-label {
    font-size: calc(12px + var(--font-offset, 0px));
    color: var(--primary);
    font-weight: 600;
    margin-bottom: 6px;
  }

  .desc-text {
    font-size: calc(13px + var(--font-offset, 0px));
    color: var(--text-body);
    line-height: 1.6;
  }
}

.write-textarea {
  flex: 1;
  width: 100%;
  padding: 20px;
  background: transparent;
  border: none;
  outline: none;
  color: var(--text-title);
  font-size: calc(15px + var(--font-offset, 0px));
  line-height: 1.9;
  resize: none;
  font-family: inherit;

  &::placeholder {
    color: var(--text-muted);
  }
}

.write-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 20px;
  border-top: 1px solid var(--border);

  .submit-btn {
    height: 38px;
    border-radius: var(--radius-sm);
    border: none;
    background: var(--primary);
    font-weight: 600;

    &:hover {
      background: var(--primary-hover) !important;
    }

    &:disabled {
      background: var(--border);
      color: var(--text-muted);
    }
  }
}

.result-body {
  flex: 1;
  overflow-y: auto;
  padding: 20px;

  .empty-hint {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100%;
    text-align: center;

    .hint-icon {
      font-size: calc(48px + var(--font-offset, 0px));
      color: var(--text-muted);
      margin-bottom: 16px;
    }

    .hint-title {
      font-size: calc(18px + var(--font-offset, 0px));
      font-weight: 700;
      color: var(--text-title);
      margin-bottom: 8px;
    }

    .hint-desc {
      font-size: calc(14px + var(--font-offset, 0px));
      color: var(--text-muted);
      margin-bottom: 20px;
    }

    .dim-list {
      display: flex;
      flex-direction: column;
      gap: 10px;

      .dim-item {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: calc(14px + var(--font-offset, 0px));
        color: var(--text-body);

        .dim-icon { color: var(--success); }
      }
    }
  }

  .loading-hint {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100%;
    gap: 16px;

    .loading-text {
      font-size: calc(15px + var(--font-offset, 0px));
      color: var(--text-muted);
    }
  }

  .score-section {
    text-align: center;
    padding: 20px 0 24px;

    .big-score {
      font-size: calc(56px + var(--font-offset, 0px));
      font-weight: 800;
      color: var(--success);
      line-height: 1;
    }

    .score-label {
      font-size: calc(14px + var(--font-offset, 0px));
      color: var(--text-muted);
      margin-top: 6px;
    }
  }

  .section-title {
    font-size: calc(15px + var(--font-offset, 0px));
    font-weight: 700;
    color: var(--text-title);
    margin-bottom: 12px;
    padding-bottom: 8px;
    border-bottom: 1px solid var(--border);
  }

  .feedback-section {
    margin-bottom: 24px;

    .feedback-text {
      font-size: calc(14px + var(--font-offset, 0px));
      color: var(--text-body);
      line-height: 1.7;
    }
  }

  .grammar-section {
    margin-bottom: 24px;

    .error-card {
      background: var(--page-bg);
      border: 1px solid var(--border);
      border-radius: var(--radius-sm);
      padding: 14px 16px;
      margin-bottom: 10px;

      .error-original,
      .error-fix {
        display: flex;
        align-items: flex-start;
        gap: 8px;
        font-size: calc(14px + var(--font-offset, 0px));
        line-height: 1.6;

        .err-icon {
          flex-shrink: 0;
          margin-top: 3px;

          &.wrong { color: var(--error); }
          &.correct { color: var(--success); }
        }
      }

      .error-original {
        color: var(--error);
        text-decoration: line-through;
        opacity: 0.8;
      }

      .error-fix {
        color: var(--success);
        margin-top: 6px;
      }

      .error-explain {
        margin-top: 8px;
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--text-muted);
        line-height: 1.6;
      }
    }
  }

  .suggestion-section {
    .sug-card {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 10px 14px;
      background: var(--page-bg);
      border: 1px solid var(--border);
      border-radius: var(--radius-sm);
      margin-bottom: 8px;

      .sug-word {
        font-size: calc(14px + var(--font-offset, 0px));
        color: var(--error);
        text-decoration: line-through;
        opacity: 0.7;
      }

      .sug-arrow {
        color: var(--text-muted);
      }

      .sug-better {
        font-size: calc(14px + var(--font-offset, 0px));
        color: var(--success);
        font-weight: 600;
      }
    }
  }
}

@media (max-width: 900px) {
  .editor-layout {
    flex-direction: column;
  }
}
</style>
