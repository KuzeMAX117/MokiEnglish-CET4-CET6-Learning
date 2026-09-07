<template>
  <div class="topic-detail-page">
    <div v-if="topicDetail" class="topic-container">
      <div class="topic-card">
        
        <div class="bg-glow-inner">
          <div class="glow g1"></div>
          <div class="glow g2"></div>
        </div>

        
        <div class="topic-top">
          <div class="topic-title-row">
            <div class="title-wrap">
              <div class="badge">{{ String(currentIndex).padStart(2, '0') }}</div>
              <h2 class="topic-title">{{ topicDetail.topicName }}</h2>
            </div>
            <div
              class="star-box"
              :class="{ collected: isCollected }"
              @click="handleCollect"
              :title="isCollected ? '取消收藏' : '收藏'"
            >
              <StarFilled v-if="isCollected" class="star-icon collected" />
              <StarOutlined v-else class="star-icon" />
            </div>
          </div>
          <div class="tags-row">
            <a-tag v-for="(tag, index) in topicDetail.labelNames" :key="index" class="tag-item">
              <span class="tag-dot"></span>{{ tag }}
            </a-tag>
          </div>
        </div>

        
        <div class="tab-box">
          <a-radio-group v-model:value="isTabs" button-style="solid" @change="handleTabs">
            <a-radio-button :value="true">精简答案</a-radio-button>
            <a-radio-button :value="false">AI 答案</a-radio-button>
          </a-radio-group>
        </div>

        
        <div class="topic-answer">
          <div v-if="!isShowAnswer" class="show-area">
            <div class="lock-tip">
              <LockOutlined v-if="topicDetail.isMember === 1" class="lock-icon" />
              <BulbOutlined v-else class="lock-icon" />
              <p>{{ topicDetail.isMember === 1 ? '此题答案仅会员可见' : '刷完题，查看详细解析' }}</p>
            </div>
            <a-button
              size="large"
              :class="[topicDetail.isMember === 1 ? 'vip-btn' : 'neon-btn']"
              @click="showAnswer"
            >
              {{ topicDetail.isMember === 1 ? '开通会员查看答案' : '点击查看答案' }}
            </a-button>
          </div>
          <div v-else class="answer-box">
            <div class="answer-head">
              <span class="answer-tag">{{ isTabs ? '精简解析' : 'AI 解析' }}</span>
            </div>
            <MarkdownView v-if="markDownContent" :content="markDownContent" />
            <a-empty v-else description="系统正在完善题目答案哦～" />
          </div>
        </div>
      </div>

      
      <div class="operation-bar">
        <div class="operation-inner">
          <div class="operation-top">
            <div class="list-box" @click="openDrawer">
              <div class="list-icon"><UnorderedListOutlined /></div>
              <span class="topic-name">{{ topicDetail.topicName }}</span>
              <span class="topic-weight">({{ currentIndex }}/{{ total }})</span>
            </div>
            <a-progress :percent="progressPercent" :show-info="false" class="bar-progress" />
          </div>
          <div class="operation-bottom">
            <a-button class="control-btn" :disabled="currentIndex <= 1" @click="prevTopic">
              <LeftOutlined /> 上一题
            </a-button>
            <a-button class="control-btn feedback-btn" @click="showFeedback = true">
              <MessageOutlined /> 反馈
            </a-button>
            <a-button class="control-btn next-btn" :disabled="currentIndex >= total" @click="nextTopic">
              下一题 <RightOutlined />
            </a-button>
          </div>
        </div>
      </div>

      
      <a-drawer
        :open="drawerOpen"
        title="题目列表"
        placement="right"
        width="320"
        @close="drawerOpen = false"
      >
        <div class="topic-list">
          <div
            v-for="(item, i) in subjectDetail"
            :key="item.id"
            class="topic-list-item"
            :class="{ active: item.id == currentTopicId }"
            @click="goToTopic(item)"
          >
            <span class="index">{{ String(i + 1).padStart(2, '0') }}</span>
            <span class="title">{{ item.topicName }}</span>
          </div>
        </div>
      </a-drawer>

      
      <a-modal v-model:open="showFeedback" title="意见反馈" @ok="handleFeedbackSubmit" :confirm-loading="feedbackLoading">
        <a-textarea v-model:value="feedbackContent" :rows="4" placeholder="请输入您的反馈意见..." maxlength="200" />
      </a-modal>
    </div>
    <a-empty v-else description="系统正在完善题目信息哦～" />
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { message } from 'ant-design-vue'
import {
  StarFilled,
  StarOutlined,
  LeftOutlined,
  RightOutlined,
  UnorderedListOutlined,
  MessageOutlined,
  LockOutlined,
  BulbOutlined,
} from '@ant-design/icons-vue'
import MarkdownView from '@/components/MarkdownView.vue'
import {
  apiQuerySubjectDetail,
  apiQueryTopicDetail,
  apiCountTopic,
  apiQueryTopicAnswer,
  apiCollectionTopic,
} from '@/api/topic'
import { apiSendFeedback } from '@/api/system'
import { useUserStore } from '@/stores/user'
import type { TopicAnswer, TopicDetail } from '@/types'

const route = useRoute()
const router = useRouter()
const userStore = useUserStore()

const currentTopicId = ref(Number(route.params.id))
const currentSubjectId = ref(Number(route.query.subjectId))

const subjectDetail = ref<any[]>([])
const topicDetail = ref<TopicDetail>({})
const currentIndex = ref(0)
const total = ref(0)
const progressPercent = ref(0)

const isTabs = ref(true)
const isShowAnswer = ref(false)
const answer = ref<TopicAnswer>({ answer: '', aiAnswer: '' })
const markDownContent = ref('')
const isCollected = ref(false)

const drawerOpen = ref(false)
const showFeedback = ref(false)
const feedbackContent = ref('')
const feedbackLoading = ref(false)

const getTopicList = async (subjectId: number) => {
  const res = await apiQuerySubjectDetail(subjectId)
  if (res.data?.topicNameVos) {
    subjectDetail.value = res.data.topicNameVos
    total.value = res.data.topicNameVos.length
    const idx = res.data.topicNameVos.findIndex((item: any) => item.id == currentTopicId.value)
    currentIndex.value = idx === -1 ? 0 : idx + 1
    progressPercent.value = Math.floor((currentIndex.value / total.value) * 100)
  }
}

const getTopicDetail = async (id: number) => {
  const res = await apiQueryTopicDetail(id)
  topicDetail.value = res.data
  isCollected.value = res.data.isCollected
}

const countTopic = async () => {
  await apiCountTopic({
    topicId: currentTopicId.value,
    subjectId: currentSubjectId.value,
    nickname: userStore.userInfo?.nickname,
    avatar: userStore.userInfo?.avatar,
  })
}

onMounted(async () => {
  try {
    await Promise.all([getTopicList(currentSubjectId.value), getTopicDetail(currentTopicId.value), countTopic()])
  } catch (e) {
    message.error('加载失败，请重试')
  }
})

const showAnswer = async () => {
  if (topicDetail.value.isMember === 1 && userStore.role === 0) {
    message.error('该题目答案需要会员才能查看哦')
    return
  }
  const res = await apiQueryTopicAnswer(currentTopicId.value)
  answer.value = res.data
  markDownContent.value = isTabs.value ? res.data.answer : res.data.aiAnswer
  isShowAnswer.value = true
}

const handleTabs = () => {
  if (!isShowAnswer.value) return
  markDownContent.value = isTabs.value ? answer.value.answer : answer.value.aiAnswer
}

const handleCollect = async () => {
  try {
    const res = await apiCollectionTopic(currentTopicId.value)
    if (res.code === 200) {
      isCollected.value = !isCollected.value
      message.success(isCollected.value ? '收藏成功' : '取消收藏')
    }
  } catch (e) {
    message.error('操作失败，请重试')
  }
}

const openDrawer = () => {
  drawerOpen.value = true
}

const prevTopic = () => {
  if (currentIndex.value <= 1) {
    message.warning('已经是第一题了')
    return
  }
  const item = subjectDetail.value[currentIndex.value - 2]
  router.replace(`/topic/${item.id}?subjectId=${currentSubjectId.value}`)
  reloadTopic(item.id)
}

const nextTopic = () => {
  if (currentIndex.value >= subjectDetail.value.length) {
    message.warning('已经是最后一题了')
    return
  }
  const item = subjectDetail.value[currentIndex.value]
  router.replace(`/topic/${item.id}?subjectId=${currentSubjectId.value}`)
  reloadTopic(item.id)
}

const goToTopic = (item: any) => {
  drawerOpen.value = false
  router.replace(`/topic/${item.id}?subjectId=${currentSubjectId.value}`)
  reloadTopic(item.id)
}

const reloadTopic = (id: number) => {
  currentTopicId.value = id
  isShowAnswer.value = false
  answer.value = { answer: '', aiAnswer: '' }
  markDownContent.value = ''
  Promise.all([getTopicList(currentSubjectId.value), getTopicDetail(id), countTopic()])
}

const handleFeedbackSubmit = async () => {
  if (!feedbackContent.value) {
    message.warning('请输入反馈内容')
    return
  }
  feedbackLoading.value = true
  try {
    await apiSendFeedback({
      feedbackContent: '题目' + currentTopicId.value + ':' + feedbackContent.value,
      status: 3,
    })
    message.success('反馈成功，可在我的反馈中查看')
    showFeedback.value = false
    feedbackContent.value = ''
  } finally {
    feedbackLoading.value = false
  }
}
</script>

<style scoped lang="scss">
.topic-detail-page {
  max-width: 960px;
  margin: 0 auto;
  padding-bottom: 140px;
}

.topic-card {
  position: relative;
  background: rgba(18, 24, 40, 0.6);
  backdrop-filter: blur(14px);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 18px;
  padding: 28px 36px;
  box-shadow: 0 16px 48px rgba(0, 0, 0, 0.35);
  min-height: 480px;
  overflow: hidden;

  .bg-glow-inner {
    position: absolute;
    inset: 0;
    pointer-events: none;

    .glow {
      position: absolute;
      border-radius: 50%;
      filter: blur(80px);
      opacity: 0.3;
    }

    .g1 {
      width: 320px;
      height: 320px;
      top: -140px;
      right: -60px;
      background: radial-gradient(circle, #8b5cf6, transparent 70%);
    }

    .g2 {
      width: 280px;
      height: 280px;
      bottom: -120px;
      left: -60px;
      background: radial-gradient(circle, #22d3ee, transparent 70%);
    }
  }

  .topic-top {
    position: relative;
    z-index: 2;

    .topic-title-row {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;

      .title-wrap {
        display: flex;
        align-items: flex-start;
        gap: 14px;

        .badge {
          width: 40px;
          height: 40px;
          border-radius: 11px;
          background: linear-gradient(135deg, rgba(139, 92, 246, 0.3), rgba(34, 211, 238, 0.25));
          border: 1px solid rgba(139, 92, 246, 0.4);
          color: #22d3ee;
          font-weight: 800;
          font-size: 16px;
          display: flex;
          align-items: center;
          justify-content: center;
          flex-shrink: 0;
        }

        .topic-title {
          font-size: 22px;
          color: #e5eaf3;
          line-height: 1.5;
          font-weight: 700;
        }
      }

      .star-box {
        cursor: pointer;
        padding: 8px;
        transition: all 0.25s;
        flex-shrink: 0;
        border-radius: 10px;

        &:hover {
          transform: scale(1.12);
        }

        .star-icon {
          font-size: 24px;
          color: #7c86a6;
          transition: all 0.25s;

          &.collected {
            color: #fbbf24;
            filter: drop-shadow(0 0 10px rgba(251, 191, 36, 0.7));
          }
        }
      }
    }

    .tags-row {
      margin-top: 16px;
      display: flex;
      flex-wrap: wrap;
      gap: 8px;

      .tag-item {
        background: rgba(139, 92, 246, 0.12);
        border-color: rgba(139, 92, 246, 0.3);
        color: #a78bfa;
        border-radius: 8px;
        display: inline-flex;
        align-items: center;
        gap: 6px;

        .tag-dot {
          width: 6px;
          height: 6px;
          border-radius: 50%;
          background: #22d3ee;
          box-shadow: 0 0 6px #22d3ee;
        }
      }
    }
  }

  .tab-box {
    position: relative;
    z-index: 2;
    margin: 20px 0;

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

  .topic-answer {
    position: relative;
    z-index: 2;
    min-height: 260px;

    .show-area {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding-top: 60px;
      gap: 22px;

      .lock-tip {
        text-align: center;

        .lock-icon {
          font-size: 40px;
          color: #a78bfa;
          filter: drop-shadow(0 0 16px rgba(139, 92, 246, 0.6));
        }

        p {
          margin-top: 12px;
          color: #7c86a6;
          font-size: 14px;
        }
      }

      .neon-btn {
        height: 46px;
        padding: 0 36px;
        border: none;
        background: linear-gradient(135deg, #8b5cf6, #06b6d4);
        color: #fff;
        font-weight: 600;
        letter-spacing: 2px;
        border-radius: 12px;
        box-shadow: 0 8px 30px rgba(139, 92, 246, 0.4);

        &:hover,
        &:focus {
          background: linear-gradient(135deg, #a78bfa, #22d3ee) !important;
        }
      }

      .vip-btn {
        height: 46px;
        padding: 0 36px;
        background: linear-gradient(to right, #fbbf24, #f59e0b);
        border-color: #f59e0b;
        color: #7c4b00;
        font-weight: 700;
        border-radius: 12px;
        box-shadow: 0 8px 30px rgba(251, 191, 36, 0.4);

        &:hover {
          background: linear-gradient(to right, #fcd34d, #fbbf24) !important;
          border-color: #fbbf24;
        }
      }
    }

    .answer-box {
      line-height: 1.8;
      color: #e5eaf3;

      .answer-head {
        margin-bottom: 14px;

        .answer-tag {
          display: inline-block;
          padding: 3px 14px;
          border-radius: 8px;
          font-size: 12px;
          background: linear-gradient(135deg, rgba(139, 92, 246, 0.25), rgba(34, 211, 238, 0.2));
          border: 1px solid rgba(139, 92, 246, 0.4);
          color: #22d3ee;
          font-weight: 600;
        }
      }
    }
  }
}

.operation-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(11, 15, 26, 0.85);
  backdrop-filter: blur(20px);
  border-top: 1px solid rgba(255, 255, 255, 0.08);
  padding: 12px 24px;
  z-index: 99;

  .operation-inner {
    max-width: 960px;
    margin: 0 auto;

    .operation-top {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 12px;
      gap: 20px;

      .list-box {
        display: flex;
        align-items: center;
        gap: 10px;
        color: #22d3ee;
        cursor: pointer;
        max-width: 55%;
        overflow: hidden;
        padding: 4px 12px 4px 4px;
        border-radius: 10px;
        transition: background 0.25s;

        &:hover {
          background: rgba(139, 92, 246, 0.12);
        }

        .list-icon {
          width: 30px;
          height: 30px;
          border-radius: 8px;
          background: linear-gradient(135deg, rgba(139, 92, 246, 0.3), rgba(34, 211, 238, 0.25));
          display: flex;
          align-items: center;
          justify-content: center;
          color: #a78bfa;
          flex-shrink: 0;
        }

        .topic-name {
          font-size: 14px;
          color: #e5eaf3;
          overflow: hidden;
          text-overflow: ellipsis;
          white-space: nowrap;
        }

        .topic-weight {
          font-weight: 700;
          color: #7c86a6;
          flex-shrink: 0;
        }
      }

      .bar-progress {
        flex: 1;
        :deep(.ant-progress-bg) {
          background: linear-gradient(90deg, #8b5cf6, #22d3ee);
        }
        :deep(.ant-progress-inner) {
          background: rgba(255, 255, 255, 0.08);
        }
      }
    }

    .operation-bottom {
      display: flex;
      justify-content: space-between;
      gap: 16px;

      .control-btn {
        flex: 1;
        height: 42px;
        border-radius: 10px;
        background: rgba(255, 255, 255, 0.05);
        border-color: rgba(255, 255, 255, 0.12);
        color: #e5eaf3;

        &:hover {
          border-color: rgba(139, 92, 246, 0.5);
          color: #a78bfa;
        }

        &:disabled {
          color: #4b5678;
          background: rgba(255, 255, 255, 0.02);
        }
      }

      .feedback-btn {
        background: rgba(34, 211, 238, 0.1);
        border-color: rgba(34, 211, 238, 0.35);
        color: #22d3ee;

        &:hover {
          background: rgba(34, 211, 238, 0.2);
          border-color: rgba(34, 211, 238, 0.5);
          color: #67e8f9;
        }
      }

      .next-btn {
        border: none;
        background: linear-gradient(135deg, #8b5cf6, #06b6d4);
        color: #fff;
        font-weight: 600;

        &:hover {
          background: linear-gradient(135deg, #a78bfa, #22d3ee) !important;
          color: #fff;
        }

        &:disabled {
          background: rgba(255, 255, 255, 0.08);
          color: #4b5678;
        }
      }
    }
  }
}

.topic-list {
  .topic-list-item {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 12px 16px;
    border-radius: 10px;
    cursor: pointer;
    margin-bottom: 6px;
    transition: all 0.2s;
    border: 1px solid transparent;

    &:hover {
      background: rgba(255, 255, 255, 0.05);
    }

    &.active {
      background: linear-gradient(135deg, rgba(139, 92, 246, 0.2), rgba(34, 211, 238, 0.15));
      border-color: rgba(139, 92, 246, 0.4);

      .title {
        color: #22d3ee;
        font-weight: 600;
      }

      .index {
        color: #a78bfa;
      }
    }

    .index {
      font-size: 12px;
      color: #4b5678;
      font-weight: 700;
      flex-shrink: 0;
    }

    .title {
      font-size: 14px;
      color: #c3cadf;
      display: block;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }
  }
}

:deep(.ant-empty-description) {
  color: #7c86a6;
}
</style>
