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
    font-size: calc(24px + var(--font-offset, 0px));
    font-weight: 800;
    color: var(--text-title);

    .head-icon {
      font-size: calc(26px + var(--font-offset, 0px));
      color: var(--primary);
    }
  }

  .back-bar {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 8px 16px;
    border-radius: 10px;
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-muted);
    cursor: pointer;
    transition: all 0.25s;

    &:hover {
      color: var(--primary);
      background: var(--primary-light);
    }
  }
}

.feedback-list {
  .feedback-item {
    background: var(--card-bg);
    border: 1px solid var(--border);
    border-radius: 14px;
    padding: 20px 24px;
    margin-bottom: 14px;
    box-shadow: var(--shadow-card);
    border-left: 4px solid var(--primary);
    transition: all 0.3s;

    &:hover {
      transform: translateY(-3px);
      border-color: var(--primary-hover);
      box-shadow: var(--shadow-hover);
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
          font-size: calc(12px + var(--font-offset, 0px));
          font-weight: 700;
          color: var(--primary);
          padding: 2px 10px;
          border-radius: 8px;
          background: var(--primary-light);
          border: 1px solid var(--primary);
        }

        .time {
          font-size: calc(13px + var(--font-offset, 0px));
          color: var(--text-muted);
        }
      }

      .status-tag {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 4px 14px;
        border-radius: 999px;
        font-size: calc(12px + var(--font-offset, 0px));
        font-weight: 600;
        background: var(--warning-light);
        border: 1px solid var(--warning);
        color: var(--warning);

        .status-icon {
          font-size: calc(13px + var(--font-offset, 0px));
        }

        &.replied {
          background: var(--success-light);
          border: 1px solid var(--success);
          color: var(--success);
        }
      }
    }

    .feedback-body {
      margin-top: 14px;

      .content {
        font-size: calc(14px + var(--font-offset, 0px));
        color: var(--text-body);
        line-height: 1.7;
        white-space: pre-wrap;
      }

      .reply {
        margin-top: 14px;
        padding: 16px 18px;
        background: var(--primary-light);
        border: 1px solid var(--primary);
        border-radius: 12px;
        border-left: 3px solid var(--primary);

        .reply-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 8px;

          .admin {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: calc(13px + var(--font-offset, 0px));
            color: var(--primary);
            font-weight: 600;

            .admin-badge {
              width: 24px;
              height: 24px;
              display: flex;
              align-items: center;
              justify-content: center;
              border-radius: 50%;
              background: var(--primary-light);
              color: var(--primary);
              font-size: calc(12px + var(--font-offset, 0px));
            }
          }

          .time {
            font-size: calc(12px + var(--font-offset, 0px));
            color: var(--text-muted);
          }
        }

        .reply-content {
          font-size: calc(14px + var(--font-offset, 0px));
          color: var(--text-body);
          line-height: 1.7;
          white-space: pre-wrap;
        }
      }
    }
  }
}
</style>
