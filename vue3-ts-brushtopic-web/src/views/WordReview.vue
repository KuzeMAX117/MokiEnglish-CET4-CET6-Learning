<template>
  <div class="review-page">
    <div class="review-head">
      <div class="back-bar" @click="router.push('/vocabulary')">
        <LeftOutlined />
        <span>返回背单词</span>
      </div>
      <div class="review-progress">
        <span class="progress-text">{{ currentIndex + 1 }} / {{ words.length }}</span>
        <div class="progress-bar">
          <div class="progress-fill" :style="{ width: progressPercent + '%' }"></div>
        </div>
      </div>
    </div>

    <div v-if="words.length" class="card-area">
      <div class="left-col">
        <div class="word-card">
          <div class="card-main">
            <div class="card-word">
              {{ words[currentIndex]?.word }}
              <span class="audio-btn" @click.stop="playAudio(words[currentIndex]?.word)">
                <SoundOutlined />
              </span>
            </div>
            <div class="card-phonetic" v-if="words[currentIndex]?.phonetic">
              {{ words[currentIndex]?.phonetic }}
            </div>
            <div class="card-syllable" v-if="showSyllable && words[currentIndex]?.syllableWord">
              {{ words[currentIndex]?.syllableWord }}
            </div>
          </div>
        </div>

        <div class="card-detail" :class="{ visible: isFlipped }">
          <div class="card-meaning">{{ words[currentIndex]?.meaning }}</div>
          <div class="card-phrase" v-if="words[currentIndex]?.phrase">
            {{ words[currentIndex]?.phrase }}
          </div>
          <div class="card-example" v-if="showExample && words[currentIndex]?.example" v-html="words[currentIndex]?.example"></div>
          <div class="card-example-cn" v-if="words[currentIndex]?.exampleTranslate">
            {{ words[currentIndex]?.exampleTranslate }}
          </div>
        </div>

        <div class="setting-toggle">
          <a-switch v-model:checked="showSyllable" size="small" /> 音节展示
          <a-switch v-model:checked="showExample" size="small" style="margin-left: 16px" /> 例句展示
        </div>
      </div>

      <div class="right-col">
        <div class="action-buttons vertical" v-if="!isFlipped">
          <button class="btn btn-wrong" @click="markWord('wrong')">
            <CloseCircleOutlined />
            不认识
          </button>
          <button class="btn btn-fuzzy" @click="markWord('fuzzy')">
            <QuestionCircleOutlined />
            模糊
          </button>
          <button class="btn btn-correct" @click="markWord('correct')">
            <CheckCircleOutlined />
            认识
          </button>
        </div>
        <div class="action-buttons vertical" v-else>
          <button class="btn btn-primary" @click="nextWord">
            <RightOutlined />
            下一个
          </button>
        </div>
      </div>
    </div>

    <div v-else class="empty-area">
      <a-empty description="暂无待复习单词">
        <template #image>
          <SmileOutlined style="font-size: calc(48px + var(--font-offset, 0px)); color: var(--primary)" />
        </template>
      </a-empty>
      <a-button type="primary" class="neon-btn" @click="router.push('/vocabulary')">
        返回背单词
      </a-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { message } from 'ant-design-vue'
import {
  LeftOutlined,
  CheckCircleOutlined,
  CloseCircleOutlined,
  QuestionCircleOutlined,
  RightOutlined,
  SmileOutlined,
  SoundOutlined,
} from '@ant-design/icons-vue'
import { apiGetTodayWords, apiSubmitWordResult, apiGetWordSetting } from '@/api/word'
import type { WordItem } from '@/api/word'

const router = useRouter()
const currentIndex = ref(0)
const isFlipped = ref(false)
const words = ref<WordItem[]>([])
const wrongWords = ref<WordItem[]>([])
const showSyllable = ref(false)
const showExample = ref(true)

const progressPercent = computed(() =>
  words.value.length > 0 ? ((currentIndex.value + 1) / words.value.length) * 100 : 0
)

onMounted(() => {
  loadData()
})

const loadData = async () => {
  try {
    const [wordsRes, settingRes] = await Promise.all([apiGetTodayWords(), apiGetWordSetting()])
    if (!settingRes.data) {
      message.warning('请先选择词书')
      router.push('/vocabulary')
      return
    }
    words.value = wordsRes.data || []
    currentIndex.value = 0
    isFlipped.value = false
  } catch (e) {
    message.error('加载单词失败')
  }
}

const submitResult = async (known: boolean) => {
  if (!words.value[currentIndex.value]) return
  try {
    await apiSubmitWordResult({
      wordId: words.value[currentIndex.value].id,
      known,
    })
  } catch (e) {
    message.error('提交学习结果失败')
  }
}

const markWord = async (type: 'correct' | 'fuzzy' | 'wrong') => {
  if (!words.value[currentIndex.value]) return
  const known = type === 'correct'
  if (type === 'wrong' || type === 'fuzzy') {
    wrongWords.value.push(words.value[currentIndex.value])
  }
  await submitResult(known)
  isFlipped.value = true
}

const nextWord = () => {
  if (currentIndex.value < words.value.length - 1) {
    currentIndex.value++
    isFlipped.value = false
  } else {
    startNextRound()
  }
}

const startNextRound = () => {
  if (wrongWords.value.length > 0) {
    words.value = [...wrongWords.value]
    wrongWords.value = []
    currentIndex.value = 0
    isFlipped.value = false
    message.info('继续复习本轮不会的单词')
  } else {
    words.value = []
    message.success('本轮复习完成！')
  }
}

const playAudio = (word: string | undefined) => {
  if (!word) return
  if (!window.speechSynthesis) {
    message.warning('当前浏览器不支持发音')
    return
  }
  const utterance = new SpeechSynthesisUtterance(word)
  utterance.lang = 'en-US'
  utterance.rate = 0.9
  window.speechSynthesis.speak(utterance)
}
</script>

<style scoped lang="scss">
.review-page {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 28px;
  padding: 0 20px;
}

.review-head {
  width: 100%;
  max-width: 600px;

  .back-bar {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 8px 14px;
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

  .review-progress {
    .progress-text {
      font-size: calc(14px + var(--font-offset, 0px));
      color: var(--text-body);
      margin-bottom: 8px;
      display: block;
    }

    .progress-bar {
      height: 6px;
      background: var(--border);
      border-radius: 3px;
      overflow: hidden;

      .progress-fill {
        height: 100%;
        border-radius: 3px;
        background: var(--primary);
        transition: width 0.4s;
      }
    }
  }
}

.card-area {
  width: 100%;
  max-width: 720px;
  display: flex;
  flex-direction: row;
  align-items: flex-start;
  gap: 20px;
}

.left-col {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 20px;
  min-width: 0;
}

.right-col {
  width: 120px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  min-height: 280px;
}

.word-card {
  width: 100%;
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-card);
  overflow: hidden;

  .card-main {
    padding: 40px 36px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
    min-height: 280px;
  }
}

.card-detail {
  padding: 28px 36px;
  border-top: 1px solid var(--border);
  background: var(--card-bg);
  border-radius: var(--radius-lg);
  text-align: center;
  word-break: break-word;
  min-height: 120px;
  transition: all 0.3s ease;

  & > * {
    opacity: 0;
    transition: opacity 0.3s ease;
  }

  &.visible {
    background: var(--card-bg);

    & > * {
      opacity: 1;
    }
  }

  .card-meaning {
    font-size: calc(28px + var(--font-offset, 0px));
    font-weight: 700;
    color: var(--text-title);
    line-height: 1.4;
  }

  .card-phrase {
    font-size: calc(16px + var(--font-offset, 0px));
    color: var(--text-body);
    margin-top: 12px;
  }

  .card-example,
  .card-example-cn {
    font-size: calc(15px + var(--font-offset, 0px));
    color: var(--text-body);
    margin-top: 20px;
    line-height: 1.6;
    font-style: italic;
  }

  .card-example-cn {
    color: var(--text-muted);
  }
}

.word-card {
  .card-word {
    font-size: calc(42px + var(--font-offset, 0px));
    font-weight: 800;
    color: var(--primary);
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 12px;

    .audio-btn {
      font-size: calc(20px + var(--font-offset, 0px));
      color: var(--text-muted);
      cursor: pointer;
      transition: color 0.2s;
      -webkit-text-fill-color: var(--text-muted);

      &:hover {
        color: var(--primary);
        -webkit-text-fill-color: var(--primary);
      }
    }
  }

  .card-phonetic {
    font-size: calc(18px + var(--font-offset, 0px));
    color: var(--text-muted);
    margin-top: 10px;
  }

  .card-syllable {
    font-size: calc(24px + var(--font-offset, 0px));
    color: var(--primary);
    margin-top: 16px;
    letter-spacing: 2px;
  }
}

.setting-toggle {
  font-size: calc(14px + var(--font-offset, 0px));
  color: var(--text-body);
  display: flex;
  align-items: center;
  gap: 8px;
}

.action-buttons {
  display: flex;
  gap: 16px;
  width: 100%;

  &.vertical {
    flex-direction: column;
    gap: 12px;

    .btn {
      width: 100%;
      padding: 14px 0;
    }
  }

  .btn {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    padding: 14px 0;
    border-radius: 14px;
    font-size: calc(15px + var(--font-offset, 0px));
    font-weight: 600;
    border: 1px solid;
    cursor: pointer;
    transition: all 0.25s;
    background: transparent;

    &.btn-wrong {
      border-color: var(--error);
      color: var(--error);

      &:hover {
        background: var(--error-light);
        border-color: var(--error);
      }
    }

    &.btn-fuzzy {
      border-color: var(--warning);
      color: var(--warning);

      &:hover {
        background: var(--warning-light);
        border-color: var(--warning);
      }
    }

    &.btn-correct {
      border-color: var(--success);
      color: var(--success);

      &:hover {
        background: var(--success-light);
        border-color: var(--success);
      }
    }

    &.btn-primary {
      border-color: var(--primary);
      color: var(--primary);
      background: var(--primary-light);

      &:hover {
        background: var(--primary-light);
        border-color: var(--primary-hover);
      }
    }
  }
}

.empty-area {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 24px;
  padding: 60px 0;
}

.neon-btn {
  height: 42px;
  border-radius: var(--radius-md);
  border: none;
  background: var(--primary);
  font-weight: 600;
  box-shadow: var(--shadow-card);

  &:hover {
    background: var(--primary-hover) !important;
  }
}

:deep(.ant-empty-description) {
  color: var(--text-muted);
}
</style>
