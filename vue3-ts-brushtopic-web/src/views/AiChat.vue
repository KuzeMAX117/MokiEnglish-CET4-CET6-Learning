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
                  CET备考 AI
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
            description="我是 CET备考 AI 助手，可以帮你练习语法、翻译、写作等四六级内容"
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

const aiModeValue = ref(localStorage.getItem('aiMode') || 'grammar')
const aiMode = reactive([
  { label: '语法练习', value: 'grammar', desc: 'AI 生成四六级语法练习题，帮你巩固语法基础' },
  { label: '翻译练习', value: 'translate', desc: 'AI 生成中英语句翻译练习，提升翻译能力' },
  { label: '自由问答', value: 'free', desc: '自由提问四六级备考相关问题' },
])

const placeholder = computed(() => {
  if (aiModeValue.value === 'grammar') return '请输入想练习的语法点，如“虚拟语气”“定语从句”'
  if (aiModeValue.value === 'translate') return '请输入想翻译的句子或段落'
  return '请输入四六级备考相关问题'
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
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: 16px;
  padding: 16px;
  box-shadow: var(--shadow-card);
  display: flex;
  flex-direction: column;
  flex-shrink: 0;

  .history-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 12px;
    border-bottom: 1px solid var(--border);
    margin-bottom: 12px;

    .history-title {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: calc(15px + var(--font-offset, 0px));
      font-weight: 600;
      color: var(--text-title);

      .title-icon {
        color: var(--primary);
      }
    }

    .icon-btn {
      color: var(--text-muted);

      &:hover {
        color: var(--primary);
      }
    }
  }

  .history-list {
    flex: 1;
    overflow-y: auto;

    .history-date {
      font-size: calc(12px + var(--font-offset, 0px));
      color: var(--text-muted);
      margin: 12px 0 6px;
      letter-spacing: 0.5px;
    }

    .history-item {
      font-size: calc(13px + var(--font-offset, 0px));
      color: var(--text-body);
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
        background: var(--text-muted);
        flex-shrink: 0;
        transition: all 0.2s;
      }

      &:hover {
        background: var(--primary-light);
        color: var(--text-title);
      }

      &.active {
        background: var(--primary-light);
        color: var(--primary);
        border: 1px solid var(--primary);

        .item-dot {
          background: var(--primary);
        }
      }
    }
  }
}

/* 右侧对话区 */
.chat-panel {
  flex: 1;
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: 16px;
  box-shadow: var(--shadow-card);
  display: flex;
  flex-direction: column;
  overflow: hidden;

  .chat-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 14px 24px;
    border-bottom: 1px solid var(--border);

    .chat-title {
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: calc(15px + var(--font-offset, 0px));
      font-weight: 600;
      color: var(--text-title);
      max-width: 60%;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;

      .title-robot {
        color: var(--primary);
        font-size: calc(18px + var(--font-offset, 0px));
      }
    }

    .chat-actions {
      .new-chat-btn {
        border: 1px solid var(--primary);
        border-radius: 10px;
        color: var(--primary);
        background: var(--primary-light);

        &:hover {
          color: #fff;
          border-color: var(--primary-hover);
          background: var(--primary);
        }
      }
    }
  }

  .chat-content {
    flex: 1;
    overflow-y: auto;
    padding: 24px;
    background: var(--page-bg);

    .msg-group {
      margin-bottom: 20px;
    }

    .msg {
      display: flex;
      margin-bottom: 20px;

      &.user {
        justify-content: flex-end;

        .msg-body {
          background: var(--primary-light);
          color: var(--text-title);
          border: 1px solid var(--primary);
        }
      }

      &.ai {
        justify-content: flex-start;

        .msg-body {
          background: var(--card-bg);
          border: 1px solid var(--border);
        }
      }

      .avatar {
        flex-shrink: 0;
        margin: 0 10px;

        &.user-avatar {
          background: var(--primary);
        }

        &.ai-avatar {
          background: var(--primary);
          font-weight: 700;
        }
      }

      .msg-body {
        max-width: 72%;
        padding: 14px 18px;
        border-radius: 14px;
        font-size: calc(14px + var(--font-offset, 0px));
        line-height: 1.7;
        color: var(--text-title);
      }

      .ai-body {
        .ai-name {
          display: flex;
          align-items: center;
          gap: 8px;
          font-size: calc(12px + var(--font-offset, 0px));
          color: var(--primary);
          font-weight: 600;
          margin-bottom: 8px;

          .ai-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: var(--primary);
          }
        }

        .typing {
          display: flex;
          align-items: center;
          gap: 8px;
          color: var(--text-muted);
          font-size: calc(13px + var(--font-offset, 0px));
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
    border-top: 1px solid var(--border);
    background: var(--page-bg);

    .mode-buttons {
      margin-bottom: 12px;

      :deep(.ant-radio-button-wrapper) {
        background: var(--card-bg);
        border-color: var(--border);
        color: var(--text-body);

        &.ant-radio-button-wrapper-checked {
          background: var(--primary);
          color: #fff;
          border-color: var(--primary);
        }
      }
    }

    .input-row {
      display: flex;
      gap: 12px;
      align-items: flex-end;

      :deep(.ant-input) {
        background: var(--card-bg);
        border-color: var(--border);
        border-radius: 10px;
        color: var(--text-title);

        &:hover,
        &:focus {
          border-color: var(--primary);
          box-shadow: 0 0 0 2px var(--primary-light);
        }
      }

      .send-btn {
        height: 40px;
        flex-shrink: 0;
        border: none;
        border-radius: 10px;
        background: var(--primary);
        font-weight: 600;

        &:hover {
          background: var(--primary-hover) !important;
        }

        &:disabled {
          background: var(--card-bg);
          color: var(--text-muted);
        }

        &.pause-btn {
          background: var(--error);
        }
      }
    }
  }
}

:deep(.ant-empty-description) {
  color: var(--text-muted);
}
</style>
