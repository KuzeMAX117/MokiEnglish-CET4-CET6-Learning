<template>
  <div class="feedback-page">
    <div class="page-head">
      <div class="head-title">
        <MessageOutlined class="head-icon" />
        <span>我的反馈</span>
      </div>
      <div class="back-bar" @click="router.back()">
        <LeftOutlined />
        <span>返回</span>
      </div>
    </div>

    <a-spin :spinning="loading">
      <a-empty v-if="!loading && feedbackList.length === 0" description="还没有反馈哦～有啥意见可以反馈哦！" />
      <div v-else class="feedback-list">
        <div v-for="item in feedbackList" :key="item.id" class="feedback-item">
          <div class="feedback-header">
            <div class="left">
              <span class="index-tag">#{{ String(item.id).padStart(2, '0') }}</span>
              <span class="time">{{ item.createTime }}</span>
            </div>
            <div class="status-tag" :class="{ replied: item.status == 1 }">
              <CheckCircleFilled v-if="item.status == 1" class="status-icon" />
              <ClockCircleFilled v-else class="status-icon" />
              <span>{{ item.status == 1 ? '已回复' : '待回复' }}</span>
            </div>
          </div>

          <div class="feedback-body">
            <div class="content">{{ item.feedbackContent }}</div>

            <div v-if="item.status == 1" class="reply">
              <div class="reply-header">
                <div class="admin">
                  <div class="admin-badge"><UserOutlined /></div>
                  <span>{{ item.replyAccount }} 回复</span>
                </div>
                <span class="time">{{ item.replyTime }}</span>
              </div>
              <div class="reply-content">{{ item.replyContent }}</div>
            </div>
          </div>
        </div>
      </div>
    </a-spin>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { MessageOutlined, CheckCircleFilled, ClockCircleFilled, UserOutlined, LeftOutlined } from '@ant-design/icons-vue'
import { apiQueryFeedbackList } from '@/api/system'

const router = useRouter()
const loading = ref(false)
const feedbackList = ref<any[]>([])

const getFeedbackList = async () => {
  loading.value = true
  try {
    const res = await apiQueryFeedbackList()
    feedbackList.value = res.data || []
  } finally {
    loading.value = false
  }
}

onMounted(getFeedbackList)
</script>

<style scoped lang="scss">
.feedback-page {
  max-width: 1000px;
  margin: 0 auto;
}

.page-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;

  .head-title {
    display: flex;
    align-items: center;
    gap: 12px;
    font-size: 24px;
    font-weight: 800;
    color: #e5eaf3;

    .head-icon {
      font-size: 26px;
      color: #8b5cf6;
      filter: drop-shadow(0 0 12px rgba(139, 92, 246, 0.6));
    }
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

    &:hover {
      color: #22d3ee;
      background: rgba(255, 255, 255, 0.06);
    }
  }
}

.feedback-list {
  .feedback-item {
    background: rgba(18, 24, 40, 0.6);
    backdrop-filter: blur(12px);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 14px;
    padding: 20px 24px;
    margin-bottom: 14px;
    box-shadow: 0 12px 36px rgba(0, 0, 0, 0.25);
    border-left: 4px solid;
    border-image: linear-gradient(180deg, #8b5cf6, #22d3ee) 1;
    transition: all 0.3s;

    &:hover {
      transform: translateY(-3px);
      border-color: rgba(139, 92, 246, 0.6);
      box-shadow: 0 14px 44px rgba(0, 0, 0, 0.35);
    }

    .feedback-header {
      display: flex;
      justify-content: space-between;
      align-items: center;

      .left {
        display: flex;
        align-items: center;
        gap: 10px;

        .index-tag {
          font-size: 12px;
          font-weight: 700;
          color: #22d3ee;
          padding: 2px 10px;
          border-radius: 8px;
          background: rgba(34, 211, 238, 0.1);
          border: 1px solid rgba(34, 211, 238, 0.25);
        }

        .time {
          font-size: 13px;
          color: #9aa4bd;
        }
      }

      .status-tag {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 4px 14px;
        border-radius: 999px;
        font-size: 12px;
        font-weight: 600;
        background: rgba(251, 191, 36, 0.1);
        border: 1px solid rgba(251, 191, 36, 0.3);
        color: #fbbf24;
        box-shadow: 0 0 14px rgba(251, 191, 36, 0.15);

        .status-icon {
          font-size: 13px;
        }

        &.replied {
          background: rgba(52, 211, 153, 0.1);
          border: 1px solid rgba(52, 211, 153, 0.3);
          color: #34d399;
          box-shadow: 0 0 14px rgba(52, 211, 153, 0.15);
        }
      }
    }

    .feedback-body {
      margin-top: 14px;

      .content {
        font-size: 14px;
        color: #c9d2e3;
        line-height: 1.7;
        white-space: pre-wrap;
      }

      .reply {
        margin-top: 14px;
        padding: 16px 18px;
        background: rgba(139, 92, 246, 0.08);
        border: 1px solid rgba(139, 92, 246, 0.2);
        border-radius: 12px;
        border-left: 3px solid #8b5cf6;

        .reply-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 8px;

          .admin {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            color: #a78bfa;
            font-weight: 600;

            .admin-badge {
              width: 24px;
              height: 24px;
              display: flex;
              align-items: center;
              justify-content: center;
              border-radius: 50%;
              background: rgba(139, 92, 246, 0.2);
              color: #c4b5fd;
              font-size: 12px;
            }
          }

          .time {
            font-size: 12px;
            color: #7c869e;
          }
        }

        .reply-content {
          font-size: 14px;
          color: #b9c2d6;
          line-height: 1.7;
          white-space: pre-wrap;
        }
      }
    }
  }
}
</style>
