<template>
  <div class="favorite-page">
    <div class="page-head">
      <div class="head-title">
        <StarFilled class="head-icon" />
        <span>我的收藏</span>
      </div>
      <div class="back-bar" @click="router.back()">
        <LeftOutlined />
        <span>返回</span>
      </div>
    </div>

    <a-spin :spinning="loading">
      <a-empty v-if="!loading && favoriteList.length === 0" description="还没有收藏题目哦～" />
      <div v-else class="list-wrapper">
        <div v-for="item in favoriteList" :key="item.id" class="list-item" @click="handleQuestion(item)">
          <div class="item-content">
            <div class="item-right">
              <span class="title">
                <span class="q-mark">#</span>
                {{ item.topicName }}
              </span>
              <StarFilled class="star-icon" />
            </div>
            <div class="info-row">
              <div class="tags-row">
                <a-tag v-for="(tag, index) in item.labelNames" :key="index" class="tag-item">{{ tag }}</a-tag>
              </div>
              <div class="time-box">
                <ClockCircleOutlined class="clock-icon" />
                <span class="time">{{ item.collectionTime }}</span>
              </div>
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
import { message } from 'ant-design-vue'
import { StarFilled, ClockCircleOutlined, LeftOutlined } from '@ant-design/icons-vue'
import { apiQueryCollectionTopicList } from '@/api/topic'

const router = useRouter()
const loading = ref(false)
const favoriteList = ref<any[]>([])

const getFavoriteList = async () => {
  loading.value = true
  try {
    const res = await apiQueryCollectionTopicList()
    favoriteList.value = res.data || []
  } finally {
    loading.value = false
  }
}

const handleQuestion = (item: any) => {
  if (!item.subjectId) {
    message.warning('该专题不存在或被禁用了')
    return
  }
  router.push(`/topic/${item.id}?subjectId=${item.subjectId}`)
}

onMounted(getFavoriteList)
</script>

<style scoped lang="scss">
.favorite-page {
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
      color: #fbbf24;
      filter: drop-shadow(0 0 12px rgba(251, 191, 36, 0.6));
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

.list-wrapper {
  .list-item {
    background: rgba(18, 24, 40, 0.6);
    backdrop-filter: blur(12px);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 14px;
    padding: 20px 24px;
    margin-bottom: 12px;
    cursor: pointer;
    box-shadow: 0 12px 36px rgba(0, 0, 0, 0.25);
    border-left: 4px solid;
    border-image: linear-gradient(180deg, #8b5cf6, #22d3ee) 1;
    transition: all 0.3s;

    &:hover {
      transform: translateY(-3px);
      border-color: rgba(139, 92, 246, 0.6);
      box-shadow: 0 14px 40px rgba(139, 92, 246, 0.18);

      .q-mark {
        color: #22d3ee;
      }

      .star-icon {
        filter: drop-shadow(0 0 8px rgba(251, 191, 36, 0.6));
      }
    }

    .item-content {
      .item-right {
        display: flex;
        justify-content: space-between;
        align-items: center;

        .title {
          font-size: 16px;
          font-weight: 600;
          color: #e5eaf3;

          .q-mark {
            color: #8b5cf6;
            margin-right: 6px;
            transition: color 0.3s;
          }
        }

        .star-icon {
          color: #fbbf24;
          font-size: 18px;
          transition: all 0.3s;
        }
      }

      .info-row {
        margin-top: 14px;
        display: flex;
        justify-content: space-between;
        align-items: center;

        .tags-row {
          display: flex;
          flex-wrap: wrap;
          gap: 8px;

          .tag-item {
            background: rgba(139, 92, 246, 0.12);
            border-color: rgba(139, 92, 246, 0.3);
            color: #a78bfa;
            border-radius: 8px;
          }
        }

        .time-box {
          display: flex;
          align-items: center;
          gap: 6px;

          .clock-icon {
            color: #4b5678;
          }

          .time {
            font-size: 12px;
            color: #7c86a6;
          }
        }
      }
    }
  }
}

:deep(.ant-empty-description) {
  color: #7c86a6;
}
</style>
