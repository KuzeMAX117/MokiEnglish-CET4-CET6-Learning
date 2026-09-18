<script setup lang="ts">
import { ref, h, watch, onMounted, onBeforeUnmount, nextTick, reactive } from 'vue'
import {
  SearchOutlined,
  PlusOutlined,
  SendOutlined,
  RobotOutlined,
  ApiOutlined,
  AppstoreOutlined,
  PauseCircleOutlined
} from '@ant-design/icons-vue';
import { useUserStore } from '@/stores/modules/user';
import { MdPreview } from 'md-editor-v3'
import 'md-editor-v3/lib/preview.css'
const userStore = useUserStore()
import { useSettingStore } from '@/stores/modules/setting.ts'
import { message } from 'ant-design-vue';
import { v4 as uuidv4 } from 'uuid'; 
import { apiGetManageList, apiGetHistoryDetail, apiRenameHistory, apiDeleteHistory } from '@/api/ai/model/index'
import { Modal } from 'ant-design-vue'
import {
  ExclamationCircleOutlined
} from '@ant-design/icons-vue';
import type { AiHistoryDto } from '@/api/ai/model/type';

const settingStore = useSettingStore()

const inputSearch = ref()

const isSearch = ref(false)

const isReply = ref(true)

const searchValue = ref('')

const createReply = () => {
  
  if (aiId.value === 0) {
    message.success('已是最新对话')
    return
  }
  message.success('创建成功')
  setTimeout(() => {
    
    window.location.reload()
  }, 100)
}

const searchHistory = (event: MouseEvent) => {
  event.stopPropagation(); 
  isSearch.value = true;
  editingId.value = null
  
  setTimeout(() => {
    inputSearch.value?.focus();
  }, 0);
};

const onSearch = () => {
  
  searchValue.value = searchValue.value.trim();
  historyParams.value.title = searchValue.value
  getHistoryList()
};

const clearSearch = () => {
  isSearch.value = false;
};

const historyList = ref<any[]>([])

const historyLoading = ref(false)

const historyParams = ref<AiHistoryDto>({
  pageNum: 1,
  pageSize: 999,
  title: searchValue.value
})

const getHistoryList = async () => {
  historyLoading.value = true
  const res = await apiGetManageList(historyParams.value)
  historyList.value = res.data
  historyLoading.value = false
}
onMounted(() => {
  getHistoryList()
})

const chatLoading = ref(false)

const activeIndex = ref<any>([])

const isSelectHistory = ref(false)

const getHistoryContent = async (id: number, index: number, historyIndex: number) => {
  chatLoading.value = true
  
  restoreDefaultRecord()
  
  activeIndex.value = []
  
  activeIndex.value[historyIndex] = index
  
  const res = await apiGetHistoryDetail(id)
  isSelectHistory.value = true
  aiModeValue.value = res.data[0].mode

  
  const content = res.data.map((item: any) => {
    return {
      prompt: item.title,
      chatId: item.chatId,
      content: item.content
    }
  })
  
  messageList.push(...content)
  
  currentRecordId.value = res.data[0].chatId
  
  localStorage.removeItem('chatId')
  
  aiId.value = res.data.length;
  chatLoading.value = false
  await scrollToBottom()
}

const handleClickOutside = (event: MouseEvent) => {
  const target = event.target as HTMLElement;
  
  if (target.closest('.search')) {
    return;
  }
  if (inputSearch.value && !inputSearch.value.$el.contains(event.target as Node)) {
    if (!searchValue.value) {
      clearSearch();
    }
  }
};

onMounted(() => {
  if (promptInput.value) {
    promptInput.value?.focus();
  }
  document.addEventListener('click', handleClickOutside);
});

onBeforeUnmount(() => {
  document.removeEventListener('click', handleClickOutside);
});

const editingId = ref<number | null>(null);

const editInput = ref()

const editValue = ref('')

const currentTitle = ref('')

const handleEdit = async (record: any) => {
  editingId.value = record.id;
  editValue.value = record.title
  currentTitle.value = record.title
  await nextTick();
  
  const input = document.querySelector('.edit-input');
  if (input) {
    (input as HTMLElement).focus();
  }
}

const handleEditBlur = async () => {
  editValue.value = editValue.value.trim();
  
  if (!editValue.value) {
    editingId.value = null;
    return;
  }
  
  if (currentTitle.value === editValue.value) {
    editingId.value = null;
    return;
  }
  
  await apiRenameHistory({
    id: editingId.value,
    title: editValue.value
  })
  editingId.value = null
  message.success('修改成功')
  
  getHistoryList()
}

const aiMode = reactive([
  {
    label: '系统模式',
    value: 'system',
    icon: RobotOutlined,
    desc: userStore.userInfo.identity === 1 ? 'AI从系统题库和会员自定义题库中随机提取题目HaoAi会校验你的回答' : 'AI从系统题库中随机提取题目HaoAi会校验你的回答'
  }, {
    label: '模型模式',
    value: 'model',
    icon: ApiOutlined,
    desc: '完全使用AI生成的题目HaoAi会校验你的回答'
  }, {
    label: '混合模式',
    value: 'mix',
    icon: AppstoreOutlined,
    desc: 'AI随机混合系统题库和AI生成题目HaoAi会校验你的回答'
  },
])

const aiModeValue = ref(localStorage.getItem('aiMode') || 'system')

const promptInput = ref()

const prompt = ref('')

const placeholder = ref(userStore.userInfo.identity === 1 ? '请输入系统中和会员自定义的正确的题目专题，AI将自动生成题目' : '请输入系统中的正确的题目专题，AI将自动生成题目')

const initPlaceholder = () => {
  if (aiModeValue.value === 'system') {
    placeholder.value = '请输入题目专题，AI将自动生成题目'
    return
  } else if (aiModeValue.value === 'model' || aiModeValue.value === 'mix') {
    placeholder.value = '请输入给AI你想刷的题目类型，AI将自动生成题目'
    return
  }
}
watch(() => aiModeValue.value, () => {
  initPlaceholder()
})
const { VITE_SERVE, VITE_APP_BASE_API } = import.meta.env

const sendPrompt = async () => {
  isReply.value = false
  isSelectHistory.value = true
  if (prompt.value) {
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
      nickname: userStore.userInfo.nickname,
    })
    prompt.value = ''
    await scrollToBottom()

    
    const currentRecord = messageList[messageList.length - 1]
    try {
      
      currentController = new AbortController()
      
      fetch(`${VITE_SERVE}${VITE_APP_BASE_API}/ai/model/chat`, {
        method: "POST",
        
        
        headers: {
          "Content-Type": "application/json",
          "Authorization": userStore.token || '',
        },
        
        signal: currentController.signal,
        body: JSON.stringify({
          ...currentRecord
        }),
      }).then(response => {
        
        if (!response.ok) {
          message.error("HaoAi回复出现点问题请稍后再试！")
        }
        
        return response.body;
      }).then(async body => {
        if (!body) {
          message.error("HaoAi回复出现点问题请稍后再试！")
          return
        }
        
        const reader = body.getReader();
        
        const decoder = new TextDecoder('utf-8')
        
        while (true) {
          try {
            if (reader) {
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
              await nextTick(() => {
                
                currentRecord.content += decoder.decode(value)
              })
              await scrollToBottom()
            }
          } catch (readError: any) {
            if (readError.name === 'AbortError') {
              message.info('已暂停回复')
              isReply.value = true
            } else {
              message.error('回复失败' + readError)
            }
            break
          }
        }
      })
    } catch (error: any) {
      console.log(error);
      if (error.name === 'AbortError') {
        message.info('已暂停回复')
      } else {
        message.error('发送失败' + error)
      }
    }
  }
}

const contentRef = ref<any>(null)

const scrollToBottom = async () => {
  await nextTick()
  if (contentRef.value) {
    
    contentRef.value.scrollTo({
      top: contentRef.value.scrollHeight,
      behavior: 'smooth'
    })
  }
}

const aiId = ref(0)

const currentRecordId = ref(uuidv4())

const messageList = reactive<any>([
  {
    prompt: "我是" + userStore.userInfo.account,
    chatId: currentRecordId.value, 
    model: aiModeValue.value,
    content: '你好，我是HaoAi 1.0，你的面试题AI助手！',
    memoryId: aiId.value
  }
])

const restoreDefaultRecord = () => {
  
  messageList.splice(0, messageList.length)
  
  messageList.push({
    prompt: "我是" + userStore.userInfo.account,
    chatId: currentRecordId.value, 
    model: aiModeValue.value,
    content: '你好，我是HaoAi 1.0，你的面试题AI助手！',
  })
}

const isSpeaking = ref(false);

let currentAudio: HTMLAudioElement | null = null;

const loadingTextArr = [
  "正在召唤HaoAi发声中...",
  "HaoAi正在努力变声，请稍等~",
  "语音合成中，马上就能听到啦！",
  "HaoAi正在认真朗读你的内容...",
  "别着急，精彩马上开始！"
];

const loadingText = ref(loadingTextArr[Math.floor(Math.random() * loadingTextArr.length)]);

const readAloudLoading = ref(false)

const readAloud = (content: any) => {
  content = plainText(content)
  
  if (currentAudio) {
    currentAudio.pause();
    currentAudio.currentTime = 0;
    currentAudio = null;
  }
  readAloudLoading.value = true
  
  isSpeaking.value = true

  
  fetch(`${VITE_SERVE}${VITE_APP_BASE_API}/ai/model/tts`, {
    method: "post",
    
    
    headers: {
      "Content-Type": "application/json",
      "Authorization": userStore.token || '',
    },
    body: JSON.stringify({
      text: content
    }),
  })
    .then(res => {
      if (!res.ok) {
        throw new Error('语音合成请求失败');
      }
      return res.blob()
    })
    .then((blob: any) => {
      readAloudLoading.value = false
      
      const url = URL.createObjectURL(blob);
      
      const audio = new Audio(url);
      currentAudio = audio
      
      audio.play();
      
      audio.onended = () => {
        isSpeaking.value = false;

        currentAudio = null;
        URL.revokeObjectURL(url);
      };
    }).catch(() => {
      console.warn('后端语音合成失败，切换到浏览器原生语音:');
      readAloudLoading.value = false;
      
      readAloudWeb(content);
    })
}

const plainText = (content: any) => {
  
  const plainText = content
    
    .replace(/#{1,6}\s/g, '')
    
    .replace(/\*\*|__|\*|_/g, '')
    
    .replace(/$|$|$|$|!\[/g, '')
    
    .replace(/`/g, '')
    // 移除代码块标记（```)
    .split('```').filter((_: any, index: any) => index % 2 === 0).join('')
    
    .replace(/^\s*>/gm, '')
    
    .replace(/^\s*[-*+]\s/gm, '')
    
    .replace(/^\s*\d+\.\s/gm, '')
    
    .replace(/\n+/g, ' ')
    
    .replace(/\s+/g, ' ').trim();

  return plainText;
};

const readAloudWeb = (content: string) => {
  content = plainText(content)
  const utterance = new SpeechSynthesisUtterance(content);
  utterance.lang = 'zh-CN'; 
  utterance.rate = 1.4; 
  utterance.pitch = 2.5; 
  utterance.volume = 1; 

  
  window.speechSynthesis.speak(utterance);

  
  isSpeaking.value = true;

  
  utterance.onend = () => {
    isSpeaking.value = false;
  };
}

const cancelReadAloud = () => {
  isSpeaking.value = false;
  window.speechSynthesis.cancel();

  if (currentAudio) {
    currentAudio.pause();
    currentAudio.currentTime = 0;
    currentAudio = null;
  }
}

const handleDel = (id: number) => {
  Modal.confirm({
    title: '确认删除这条对话记录吗？',
    content: '删除后对话记录无法恢复和找回，请谨慎操作。',
    okText: '确认删除',
    okType: 'danger',
    cancelText: '取消',
    async onOk() {
      await apiDeleteHistory(id)
      message.success('删除成功')
      setTimeout(() => {
        
        window.location.reload()
      }, 500)
    }
  })
}

const copyContent = async (content: string) => {
  try {
    await navigator.clipboard.writeText(content)
    message.success('复制成功')
  } catch {
    message.error('复制失败，请手动复制')
  }
}

const isPaused = ref(false)

let currentController: AbortController | null

const pauseReply = () => {
  if (currentController) {
    
    currentController.abort()
    currentController = null
    isPaused.value = false
    isReply.value = true
  }
}

const handleAiModeChange = (ev: any) => {
  if (isSelectHistory.value) {
    
    Modal.confirm({
      title: '切换对话模式',
      icon: h(ExclamationCircleOutlined),
      content: '当前已经开启对话，切换对话模式将会开启新的对话！',
      okText: '确定',
      cancelText: '取消',
      async onOk() {
        message.success('创建成功')
        setTimeout(() => {
          
          window.location.reload()
        }, 100)
        
        localStorage.setItem('aiMode', ev.target.value)
      },
      onCancel() {
        console.log('Cancel');
      },
    });
  } else {
    
    aiModeValue.value = ev.target.value
  }
}
</script>
<template>
  <div class="model-body">
    
    <div class="model-history" v-if="!settingStore.fold">
      
      <div class="btn-search">
        <template v-if="!isSearch">
          
          <a-button class="btn" shape="round" :disabled="!isReply" @click="createReply" type="primary"
            :icon="h(PlusOutlined)">新建对话</a-button>
          
          <a-button class="search" :disabled="!isReply" shape="circle" :icon="h(SearchOutlined)"
            @click="searchHistory"></a-button>
        </template>
        
        <a-input v-if="isSearch" @blur="onSearch" allowClear v-model:value="searchValue" ref="inputSearch"
          placeholder="搜索历史刷题记录">
          <template #prefix>
            <SearchOutlined />
          </template>
        </a-input>
      </div>
      
      <ul class="infinite-list" style="overflow: auto" v-if="!historyLoading">
        
        <div class="list-box" v-for="(history, historyIndex) in historyList" :key="historyIndex">
          
          <span class="date">{{ history.date }}</span>
          
          
          <li @click="getHistoryContent(record.id, index, historyIndex)" v-for="(record, index) in history.aiHistoryVos"
            :key="index"
            :style="{ 'background-color': activeIndex[historyIndex] === index ? '#f2f3f4' : '', 'pointer-events': isReply ? 'auto' : 'none' }"
            :class="{ 'infinite-list-item': true, 'no-hover': editingId === record.id, 'hover': editingId !== record.id }">
            
            <template v-if="editingId === record.id">
              
              <a-input class="edit-input" v-model:value="editValue" @blur="handleEditBlur" ref="editInput" />
            </template>
            <div class="history" v-if="editingId !== record.id">
              {{ record.title }}
            </div>
            <template v-if="editingId !== record.id">
              
              <EditOutlined class="edit" @click.stop="handleEdit(record)" />
              <DeleteOutlined class="del" @click.stop="handleDel(record.id)" />
            </template>
          </li>
        </div>
      </ul>
      
      <a-spin tip="HaoAi正在搜寻你的历史记录哦" v-else></a-spin>
    </div>

    
    <div class="model-print">
      
      <h2 class="title">HaoAi<i class="version">1.0</i></h2>
      
      <div class="reply-box">
        <ul class="infinite-list-reply" ref="contentRef" v-if="!chatLoading">
          
          <template v-if="aiId >= 0">
            <div v-for="(item, index) in messageList" class="box" :key="index">
              
              <div class="prompt-box">
                <div class="user-message">
                  <div class="message-content" :class="{ 'prompt': true, 'first-prompt': index === 0 }">
                    <MdPreview v-model="item.prompt" class="prompt-preview">
                    </MdPreview>
                  </div>
                  <template v-if="userStore.userInfo.avatar">
                    <a-avatar class="avatar" :src="userStore.userInfo.avatar" />
                  </template>
                  <template v-else>
                    <a-avatar class="avatar" :style="{ backgroundColor: '#1677ff', fontSize: '20px' }">
                      {{ userStore.userInfo.account?.charAt(0)?.toUpperCase() }}
                    </a-avatar>
                  </template>
                </div>
                <div class="message-actions">
                  <a-tooltip title="朗读" placement="bottom" v-if="!isSpeaking">
                    <SoundOutlined class="action-icon" @click="readAloud(item.prompt)" />
                  </a-tooltip>
                  <a-tooltip title="暂停" placement="bottom" v-else>
                    <PauseOutlined class="action-icon" @click="cancelReadAloud" />
                  </a-tooltip>
                  <a-tooltip title="复制" placement="bottom" @click="copyContent(item.prompt)">
                    <CopyOutlined class="action-icon" />
                  </a-tooltip>
                </div>
              </div>
              
              <div class="content-avatar">
                
                <img class="avatar" src="../../../assets/images/128.png" alt="">
                
                <LoadingOutlined v-if="!item.content" />
                <div class="message-wrapper" v-else>
                  <MdPreview v-model="item.content" class="md-preview" style="max-height: 100%;"></MdPreview>
                  <div class="message-actions" v-if="aiId !== 0">
                    <a-tooltip title="朗读" placement="bottom" v-if="!isSpeaking">
                      <SoundOutlined class="action-icon" @click="readAloud(item.content)" />
                    </a-tooltip>
                    <a-tooltip title="暂停" placement="bottom" v-else>
                      <PauseOutlined class="action-icon" @click="cancelReadAloud" />
                    </a-tooltip>
                    <a-tooltip title="复制" placement="bottom" @click="copyContent(item.content)">
                      <CopyOutlined class="action-icon" />
                    </a-tooltip>
                  </div>
                </div>
              </div>
            </div>
          </template>
        </ul>
        
        <a-spin tip="HaoAi正在查询对话记录" v-else></a-spin>
        
        <a-spin :tip="loadingText" v-if="readAloudLoading"></a-spin>
        
        <div class="search-box">
          <a-textarea type="textarea" ref="promptInput" v-model:value="prompt" :auto-size="{ minRows: 1, maxRows: 1 }"
            :placeholder="placeholder" />
          <div class="action-icons">
            <div class="left-icons">
              <a-radio-group @change="handleAiModeChange" :value="aiModeValue" button-style="solid">
                <a-tooltip v-for="(tag, index) in aiMode" :key="index" :title="tag.desc" placement="top">
                  <a-radio-button :value="tag.value">
                    <component :is="tag.icon" class="mode-icon" />
                    {{ tag.label }}
                  </a-radio-button>
                </a-tooltip>
              </a-radio-group>
            </div>
            <div class="right-icons">
              <template v-if="!isReply">
                <PauseCircleOutlined class="pause-icon" @click="pauseReply" />
              </template>
              <template v-else>
                <SendOutlined class="send-icon" :class="{ 'disabled': !prompt }" @click="prompt && sendPrompt()" />
              </template>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<style lang="scss" scoped>
.model-body {
  display: flex;

  .model-history {
    width: 230px;

    .btn-search {
      margin-bottom: 18px;
    }

    .btn {
      width: 180px;
    }

    .search {
      margin-left: 8px;
    }
  }

  .model-print {
    margin-left: 3px;
    flex: 1;

    .title {
      font-weight: bold;

      .version {
        color: #8f91a8;
        margin-left: 3px;
      }
    }

    .search-box {
      position: relative;
      background: #f9f9f9;
      border-radius: 8px;
      padding: 5px;

      .left-icons {
        :deep(.ant-radio-group) {
          display: flex;
          gap: 8px;

          .ant-radio-button-wrapper {
            display: flex;
            align-items: center;
            font-size: 12px;
            padding: 0 6px; 
            height: 24px; 
            border-radius: 4px; 
            border: 1px solid #d9d9d9;

            &:first-child {
              border-radius: 6px;
            }

            &:last-child {
              border-radius: 6px;
            }

            &::before {
              display: none;
            }

            .mode-icon {
              margin-right: 4px;
              font-size: 12px;
            }

            &.ant-radio-button-wrapper-checked {
              border-color: #1677ff;
              background: #e6f4ff;
              color: #1677ff;
            }
          }
        }
      }

      :deep(.ant-input) {
        background: transparent;
        border: none;
        box-shadow: none;
        resize: none;
        padding: 8px 12px;
        font-size: 14px;

        &:focus {
          box-shadow: none;
        }
      }

      .action-icons {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 8px 12px 0px 12px;

        .left-icons {
          .icon {
            margin-right: 15px;
            font-size: 16px;
            color: #666;
            cursor: pointer;

            &:hover {
              color: #1677ff;
            }
          }
        }

        .right-icons {
          .send-icon {
            font-size: 25px;
            color: #1677ff;
            cursor: pointer;

            &.disabled {
              color: #d6dee8;
              cursor: not-allowed;
            }

            &:not(.disabled):hover {
              color: #4096ff;
            }

            &:hover {
              color: #4096ff;
            }
          }

          .pause-icon {
            font-size: 25px;
            color: #ff4d4f;
            cursor: pointer;

            &:hover {
              color: #ff7875;
            }
          }
        }
      }
    }
  }
}

.infinite-list {
  height: calc(100vh - 185px);

  .date {
    color: #666666;
    font-size: 12px;
    cursor: pointer;
  }

  
  &::-webkit-scrollbar {
    display: none;
  }

  &:hover {
    &::-webkit-scrollbar {
      display: block;
    }
  }

  .hover {
    &:hover {
      background-color: #f2f3f4;

      .del {
        color: red;
        opacity: 1;
        margin-left: 10px;
      }

      .edit {
        margin-left: 5px;
        opacity: 1;
      }
    }
  }

  .infinite-list-item {
    .del {
      opacity: 0;

    }

    .edit {
      opacity: 0;
    }

    margin-top: 10px;
    width: 220px;
    display: flex;
    justify-content: space-between;
    height: 40px;
    color: #26244c;
    margin-bottom: 4px;
    font-size: 14px;
    cursor: pointer;
    border-radius: 40px;
    padding: 10px;

    .history {
      width: 100%;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
  }
}

.reply-box {
  flex: 1;
  display: flex;
  flex-direction: column;
  height: calc(100vh - 165px);

  .infinite-list-reply {
    flex: 1;
    overflow-y: auto;
    padding: 10px;

    .prompt-box {
      display: flex;
      flex-direction: column;

      .message-actions {
        display: flex;
        justify-content: flex-end;
        gap: 16px;
        margin-right: 40px;
        opacity: 0;
        transition: opacity 0.3s;

        .action-icon {
          margin-top: 5px;
          font-size: 16px;
          color: #666;
          cursor: pointer;

          &:hover {
            color: #1677ff;
          }

        }

      }

      &:hover {
        .message-actions {
          opacity: 1;
        }
      }

      .user-message {
        display: flex;
        justify-content: flex-end;
        align-items: flex-start;
        gap: 2px;

        .message-content {
          max-width: calc(100% - 100px);

          .prompt-preview {
            background-color: #eff6ff;
            border-radius: 10px;
            padding: 8px 12px;

            :deep(.md-preview-wrapper) {
              background: transparent;
              padding: 0;
              margin: 0;
            }
          }

          .prompt {
            margin: 10px 0 5px 0 !important;
          }

          .first-prompt {
            margin-top: 0 !important;
          }
        }
      }
    }

    .content-avatar {
      font-size: 16px !important;
      display: flex;
      margin-top: 20px;
      margin-bottom: 10px;

      .avatar {
        width: 31px;
        height: 31px;
        border-radius: 50%;
        object-fit: cover;
        margin-right: 5px;
      }

      .message-wrapper {
        flex: 1;

        .message-actions {
          display: flex;
          gap: 16px;
          padding: 8px 0;
          opacity: 0;
          transition: opacity 0.3s;

          .action-icon {
            font-size: 16px;
            color: #666;
            cursor: pointer;

            &:hover {
              color: #1677ff;
            }
          }
        }

        &:hover {
          .message-actions {
            opacity: 1;
          }
        }
      }
    }
  }

}
</style>
