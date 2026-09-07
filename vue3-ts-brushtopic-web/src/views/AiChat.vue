<template>
  <div class="ai-page">
    
    <div class="history-panel">
      <div class="history-header">
        <div class="history-title">
          <ClockCircleOutlined class="title-icon" />
          <span>历史记录</span>
        </div>
        <a-button type="text" size="small" class="icon-btn" @click="getHistoryList">
          <template #icon><ReloadOutlined /></template>
        </a-button>
      </div>
      <div class="history-list">
        <template v-for="(group, groupIndex) in historyList" :key="groupIndex">
          <div class="history-date">{{ group.date }}</div>
          <div
            v-for="(record, idx) in group.aiHistoryVos"
            :key="record.id"
            class="history-item"
            :class="{ active: activeIndex[groupIndex] === idx }"
            @click="getHistoryContent(record.id, idx, groupIndex, record.title)"
          >
            <span class="item-dot"></span>
            {{ record.title }}
          </div>
        </template>
        <a-empty v-if="!chatLoading && historyList.length === 0" description="暂无历史记录" :image="false" />
      </div>
    </div>

    
    <div class="chat-panel">
      <div class="chat-header">
        <div class="chat-title">
          <RobotOutlined class="title-robot" />
          {{ currentTitle || '新对话' }}
        </div>
        <div class="chat-actions">
          <a-button type="text" class="new-chat-btn" @click="createReply">
            <template #icon><PlusOutlined /></template>
            新对话
          </a-button>
        </div>
      </div>

      
      <div ref="contentRef" class="chat-content">
        <a-spin :spinning="chatLoading">
          <div v-for="(item, index) in messageList" :key="index" class="msg-group">
            
            <div class="msg user">
              <div class="msg-body">
                <MarkdownView :content="item.prompt" />
              </div>
              <a-avatar
                v-if="userStore.userInfo?.avatar"
                :src="userStore.userInfo.avatar"
                :size="36"
                class="avatar"
              />
              <a-avatar v-else :size="36" class="avatar user-avatar">
                {{ userStore.nickname.charAt(0).toUpperCase() }}
              </a-avatar>
            </div>

            
            <div class="msg ai">
              <a-avatar :size="36" class="avatar ai-avatar">AI</a-avatar>
              <div class="msg-body ai-body">
                <div class="ai-name">
                  <span class="ai-dot"></span>
                  HaoAi
                </div>
                <MarkdownView v-if="item.content" :content="item.content" />
                <div v-else class="typing">
                  <a-spin size="small" />
                  <span>HaoAi 思考中...</span>
                </div>
                <div v-if="item.content && index > 0" class="msg-actions">
                  <a-tooltip title="语音朗读">
                    <a-button
                      v-if="!isSpeaking"
                      type="text"
                      size="small"
                      :loading="readAloudLoading"
                      @click="readAloud(item.content)"
                    >
                      <template #icon><SoundOutlined /></template>
                    </a-button>
                    <a-button v-else type="text" size="small" danger @click="cancelReadAloud">
                      <template #icon><PauseCircleOutlined /></template>
                    </a-button>
                  </a-tooltip>
                  <a-tooltip title="复制">
                    <a-button type="text" size="small" @click="copyContent(item.content)">
                      <template #icon><CopyOutlined /></template>
                    </a-button>
                  </a-tooltip>
                </div>
              </div>
            </div>
          </div>
          <a-empty
            v-if="!chatLoading && messageList.length <= 1"
            description="我是 HaoAi，你的面试题 AI 助手，输入专题开始刷题吧"
            :image="false"
          />
        </a-spin>
      </div>

      
      <div class="chat-input">
        <div class="mode-buttons">
          <a-radio-group v-model:value="aiModeValue" button-style="solid" size="small" @change="handleAiModeChange">
            <a-radio-button v-for="m in aiMode" :key="m.value" :value="m.value">
              <a-tooltip :title="m.desc">{{ m.label }}</a-tooltip>
            </a-radio-button>
          </a-radio-group>
        </div>
        <div class="input-row">
          <a-textarea
            v-model:value="prompt"
            :placeholder="placeholder"
            :auto-size="{ minRows: 2, maxRows: 5 }"
            @press-enter="sendPrompt"
          />
          <a-button
            v-if="!isReply"
            danger
            size="large"
            class="send-btn pause-btn"
            @click="pauseReply"
          >
            <template #icon><PauseCircleOutlined /></template>
            暂停
          </a-button>
          <a-button
            v-else
            type="primary"
            size="large"
            class="send-btn"
            :disabled="!prompt"
            @click="sendPrompt"
          >
            <template #icon><SendOutlined /></template>
            发送
          </a-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, nextTick, onMounted, reactive, ref, watch } from 'vue'
import { message } from 'ant-design-vue'
import {
  PlusOutlined,
  ReloadOutlined,
  SoundOutlined,
  PauseCircleOutlined,
  CopyOutlined,
  SendOutlined,
  RobotOutlined,
  ClockCircleOutlined,
} from '@ant-design/icons-vue'
import MarkdownView from '@/components/MarkdownView.vue'
import { apiGetManageList, apiGetHistoryDetail } from '@/api/ai'
import { useUserStore } from '@/stores/user'
import type { AiHistoryGroup } from '@/types'

const uuidv4 = () =>
  'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c) => {
    const r = (Math.random() * 16) | 0
    const v = c === 'x' ? r : (r & 0x3) | 0x8
    return v.toString(16)
  })

const userStore = useUserStore()

const aiModeValue = ref(localStorage.getItem('aiMode') || 'system')
const aiMode = reactive([
  { label: '系统模式', value: 'system', desc: 'AI 从系统题库中随机提取题目，HaoAi 会校验你的回答' },
  { label: '模型模式', value: 'model', desc: '完全使用 AI 生成的题目，HaoAi 会校验你的回答' },
  { label: '混合模式', value: 'mix', desc: 'AI 随机混合系统题库和 AI 生成题目，HaoAi 会校验你的回答' },
])

const placeholder = computed(() => {
  if (aiModeValue.value === 'system') return '请输入题目专题，AI 将自动生成题目'
  return '请输入给 AI 你想刷的题目类型，AI 将自动生成题目'
})

const chatLoading = ref(false)
const activeIndex = ref<number[]>([])
const isSelectHistory = ref(false)

const aiId = ref(0)
const currentRecordId = ref(uuidv4())
const messageList = reactive<any[]>([
  {
    prompt: '我是' + (userStore.nickname || ''),
    chatId: currentRecordId.value,
    model: aiModeValue.value,
    content: '',
    memoryId: aiId.value,
  },
])

const historyList = ref<AiHistoryGroup[]>([])
const currentTitle = ref('')

const getHistoryList = async () => {
  const res = await apiGetManageList({ pageNum: 1, pageSize: 999, title: null })
  historyList.value = res.data || []
}

const getHistoryContent = async (id: number, index: number, historyIndex: number, title: string) => {
  chatLoading.value = true
  currentTitle.value = title
  restoreDefaultRecord()
  activeIndex.value = []
  activeIndex.value[historyIndex] = index

  const res = await apiGetHistoryDetail(id)
  isSelectHistory.value = true
  aiModeValue.value = res.data[0]?.mode || 'system'
  const content = (res.data || []).map((item: any) => ({
    prompt: item.title,
    chatId: item.chatId,
    content: item.content,
  }))
  messageList.push(...content)
  currentRecordId.value = res.data[0]?.chatId || currentRecordId.value
  localStorage.removeItem('chatId')
  aiId.value = res.data.length
  chatLoading.value = false
  await scrollToBottom()
}

const restoreDefaultRecord = () => {
  messageList.splice(0, messageList.length)
  messageList.push({
    prompt: '我是' + (userStore.nickname || ''),
    chatId: currentRecordId.value,
    model: aiModeValue.value,
    content: '',
    memoryId: aiId.value,
  })
}

const contentRef = ref<HTMLElement | null>(null)
const scrollToBottom = async () => {
  await nextTick()
  if (contentRef.value) {
    contentRef.value.scrollTop = contentRef.value.scrollHeight
  }
}

const copyContent = (content: string) => {
  const plainText = content
    .replace(/```[\s\S]*?```/g, '')
    .replace(/\*\*/g, '')
    .replace(/\*/g, '')
    .replace(/\[([^\]]+)\]\([^)]+\)/g, '$1')
    .trim()
  navigator.clipboard.writeText(plainText).then(() => message.success('复制成功'))
}

const isPaused = ref(false)
let currentController: AbortController | null = null
const isReply = ref(true)

const pauseReply = () => {
  if (currentController) {
    currentController.abort()
    currentController = null
    isPaused.value = false
    isReply.value = true
  }
}

const prompt = ref('')

const sendPrompt = async () => {
  if (!prompt.value) return
  isReply.value = false
  isSelectHistory.value = true

  if (aiId.value === 0) {
    localStorage.setItem('chatId', currentRecordId.value)
  }
  aiId.value++

  messageList.push({
    prompt: prompt.value,
    memoryId: aiId.value,
    chatId: localStorage.getItem('chatId') || currentRecordId.value,
    model: aiModeValue.value,
    content: '',
    nickname: userStore.nickname,
  })
  prompt.value = ''
  await scrollToBottom()

  const currentRecord = messageList[messageList.length - 1]
  try {
    currentController = new AbortController()
    const response = await fetch(`${import.meta.env.VITE_SERVE}/api/ai/model/chat`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: userStore.token,
      },
      signal: currentController.signal,
      body: JSON.stringify(currentRecord),
    })
    if (!response.ok) {
      message.error('HaoAi 回复出现点问题请稍后再试！')
      isReply.value = true
      return
    }
    const body = response.body
    if (!body) {
      message.error('HaoAi 回复出现点问题请稍后再试！')
      isReply.value = true
      return
    }
    const reader = body.getReader()
    const decoder = new TextDecoder('utf-8')
    while (true) {
      try {
        const { value, done } = await reader.read()
        if (done) {
          message.success('回复成功')
          isReply.value = true
          if (aiId.value === 1) {
            getHistoryList()
            activeIndex.value[0] = 0
          }
          break
        }
        currentRecord.content += decoder.decode(value)
        await nextTick()
        await scrollToBottom()
      } catch (readError: any) {
        if (readError.name === 'AbortError') {
          message.info('已暂停回复')
          isReply.value = true
        } else {
          message.error('回复失败' + readError)
          isReply.value = true
        }
        break
      }
    }
  } catch (error: any) {
    if (error.name === 'AbortError') {
      message.info('已暂停回复')
    } else {
      message.error('发送失败' + error)
    }
    isReply.value = true
  }
}

const createReply = () => {
  if (!isReply.value) {
    message.warning('当前正在回复中')
    return
  }
  if (aiId.value === 0) {
    message.info('已是最新对话')
    return
  }
  message.success('创建对话成功')
  setTimeout(() => {
    window.location.reload()
  }, 100)
}

const handleAiModeChange = () => {
  if (isSelectHistory.value) {
    localStorage.setItem('aiMode', aiModeValue.value)
    message.success('切换模式，开启新的对话')
    setTimeout(() => {
      window.location.reload()
    }, 100)
  }
}

const isSpeaking = ref(false)
const readAloudLoading = ref(false)
let currentAudio: HTMLAudioElement | null = null

const plainText = (content: string) =>
  content
    .replace(/#{1,6}\s/g, '')
    .replace(/\*\*|__|\*|_/g, '')
    .replace(/\$|\$|\$|\$|!\[/g, '')
    .replace(/`/g, '')
    .split('```')
    .filter((_, index) => index % 2 === 0)
    .join('')
    .replace(/^\s*>/gm, '')
    .replace(/^\s*[-*+]\s/gm, '')
    .replace(/^\s*\d+\.\s/gm, '')
    .replace(/\n+/g, ' ')
    .replace(/\s+/g, ' ')
    .trim()

const readAloud = (content: string) => {
  const text = plainText(content)
  if (currentAudio) {
    currentAudio.pause()
    currentAudio.currentTime = 0
    currentAudio = null
  }
  readAloudLoading.value = true
  isSpeaking.value = true

  fetch(`${import.meta.env.VITE_SERVE}/api/ai/model/tts`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: userStore.token,
    },
    body: JSON.stringify({ text }),
  })
    .then((res) => {
      if (!res.ok) throw new Error('语音合成请求失败')
      return res.blob()
    })
    .then((blob) => {
      readAloudLoading.value = false
      const url = URL.createObjectURL(blob)
      const audio = new Audio(url)
      currentAudio = audio
      audio.play()
      audio.onended = () => {
        isSpeaking.value = false
        currentAudio = null
        URL.revokeObjectURL(url)
      }
    })
    .catch(() => {
      console.warn('后端语音合成失败，切换到浏览器原生语音')
      readAloudLoading.value = false
      readAloudWeb(text)
    })
}

const readAloudWeb = (content: string) => {
  const utterance = new SpeechSynthesisUtterance(content)
  utterance.lang = 'zh-CN'
  utterance.rate = 1.4
  utterance.pitch = 2.5
  utterance.volume = 1
  window.speechSynthesis.speak(utterance)
  isSpeaking.value = true
  utterance.onend = () => {
    isSpeaking.value = false
  }
}

const cancelReadAloud = () => {
  isSpeaking.value = false
  window.speechSynthesis.cancel()
  if (currentAudio) {
    currentAudio.pause()
    currentAudio.currentTime = 0
    currentAudio = null
  }
}

onMounted(() => {
  getHistoryList()
})
</script>

<style scoped lang="scss">
.ai-page {
  display: flex;
  gap: 16px;
  height: calc(100vh - 64px - 56px);
  min-height: 600px;
}

/* 左侧历史记录 */
.history-panel {
  width: 260px;
  background: rgba(18, 24, 40, 0.6);
  backdrop-filter: blur(14px);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 16px;
  padding: 16px;
  box-shadow: 0 16px 48px rgba(0, 0, 0, 0.3);
  display: flex;
  flex-direction: column;
  flex-shrink: 0;

  .history-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 12px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.07);
    margin-bottom: 12px;

    .history-title {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 15px;
      font-weight: 600;
      color: #e5eaf3;

      .title-icon {
        color: #a78bfa;
      }
    }

    .icon-btn {
      color: #7c86a6;

      &:hover {
        color: #22d3ee;
      }
    }
  }

  .history-list {
    flex: 1;
    overflow-y: auto;

    .history-date {
      font-size: 12px;
      color: #6b7693;
      margin: 12px 0 6px;
      letter-spacing: 0.5px;
    }

    .history-item {
      font-size: 13px;
      color: #c3cadf;
      padding: 10px 12px;
      border-radius: 10px;
      margin-bottom: 6px;
      cursor: pointer;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      transition: all 0.2s;
      display: flex;
      align-items: center;
      gap: 8px;

      .item-dot {
        width: 5px;
        height: 5px;
        border-radius: 50%;
        background: #4b5678;
        flex-shrink: 0;
        transition: all 0.2s;
      }

      &:hover {
        background: rgba(255, 255, 255, 0.05);
        color: #e5eaf3;
      }

      &.active {
        background: linear-gradient(135deg, rgba(139, 92, 246, 0.2), rgba(34, 211, 238, 0.15));
        color: #22d3ee;
        border: 1px solid rgba(139, 92, 246, 0.35);

        .item-dot {
          background: #22d3ee;
          box-shadow: 0 0 6px #22d3ee;
        }
      }
    }
  }
}

/* 右侧对话区 */
.chat-panel {
  flex: 1;
  background: rgba(18, 24, 40, 0.6);
  backdrop-filter: blur(14px);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 16px;
  box-shadow: 0 16px 48px rgba(0, 0, 0, 0.3);
  display: flex;
  flex-direction: column;
  overflow: hidden;

  .chat-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 14px 24px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.07);

    .chat-title {
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: 15px;
      font-weight: 600;
      color: #e5eaf3;
      max-width: 60%;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;

      .title-robot {
        color: #a78bfa;
        font-size: 18px;
      }
    }

    .chat-actions {
      .new-chat-btn {
        border: 1px solid rgba(139, 92, 246, 0.4);
        border-radius: 10px;
        color: #a78bfa;
        background: rgba(139, 92, 246, 0.12);

        &:hover {
          color: #fff;
          border-color: rgba(139, 92, 246, 0.6);
          background: rgba(139, 92, 246, 0.25);
        }
      }
    }
  }

  .chat-content {
    flex: 1;
    overflow-y: auto;
    padding: 24px;
    background: rgba(0, 0, 0, 0.15);

    .msg-group {
      margin-bottom: 20px;
    }

    .msg {
      display: flex;
      margin-bottom: 20px;

      &.user {
        justify-content: flex-end;

        .msg-body {
          background: linear-gradient(135deg, rgba(139, 92, 246, 0.3), rgba(34, 211, 238, 0.2));
          color: #e5eaf3;
          border: 1px solid rgba(139, 92, 246, 0.4);
        }
      }

      &.ai {
        justify-content: flex-start;

        .msg-body {
          background: rgba(255, 255, 255, 0.04);
          border: 1px solid rgba(255, 255, 255, 0.1);
        }
      }

      .avatar {
        flex-shrink: 0;
        margin: 0 10px;

        &.user-avatar {
          background: linear-gradient(135deg, #8b5cf6, #22d3ee);
        }

        &.ai-avatar {
          background: linear-gradient(135deg, #06b6d4, #8b5cf6);
          font-weight: 700;
        }
      }

      .msg-body {
        max-width: 72%;
        padding: 14px 18px;
        border-radius: 14px;
        font-size: 14px;
        line-height: 1.7;
        color: #e5eaf3;
      }

      .ai-body {
        .ai-name {
          display: flex;
          align-items: center;
          gap: 8px;
          font-size: 12px;
          color: #a78bfa;
          font-weight: 600;
          margin-bottom: 8px;

          .ai-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: #22d3ee;
            box-shadow: 0 0 6px #22d3ee;
          }
        }

        .typing {
          display: flex;
          align-items: center;
          gap: 8px;
          color: #7c86a6;
          font-size: 13px;
        }

        .msg-actions {
          display: flex;
          gap: 4px;
          margin-top: 8px;
        }
      }
    }
  }

  .chat-input {
    padding: 16px 24px;
    border-top: 1px solid rgba(255, 255, 255, 0.07);
    background: rgba(11, 15, 26, 0.5);

    .mode-buttons {
      margin-bottom: 12px;

      :deep(.ant-radio-button-wrapper) {
        background: rgba(255, 255, 255, 0.04);
        border-color: rgba(255, 255, 255, 0.1);
        color: #9aa4bd;

        &.ant-radio-button-wrapper-checked {
          background: linear-gradient(135deg, rgba(139, 92, 246, 0.35), rgba(34, 211, 238, 0.25));
          color: #fff;
          border-color: rgba(139, 92, 246, 0.5);
        }
      }
    }

    .input-row {
      display: flex;
      gap: 12px;
      align-items: flex-end;

      :deep(.ant-input) {
        background: rgba(255, 255, 255, 0.05);
        border-color: rgba(255, 255, 255, 0.12);
        border-radius: 10px;
        color: #e5eaf3;

        &:hover,
        &:focus {
          border-color: rgba(139, 92, 246, 0.6);
          box-shadow: 0 0 0 2px rgba(139, 92, 246, 0.15);
        }
      }

      .send-btn {
        height: 40px;
        flex-shrink: 0;
        border: none;
        border-radius: 10px;
        background: linear-gradient(135deg, #8b5cf6, #06b6d4);
        font-weight: 600;

        &:hover {
          background: linear-gradient(135deg, #a78bfa, #22d3ee) !important;
        }

        &:disabled {
          background: rgba(255, 255, 255, 0.1);
          color: #4b5678;
        }

        &.pause-btn {
          background: rgba(239, 68, 68, 0.8);
        }
      }
    }
  }
}

:deep(.ant-empty-description) {
  color: #7c86a6;
}
</style>
