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
    font-size: calc(24px + var(--font-offset, 0px));
    font-weight: 800;
    color: var(--text-title);

    .head-icon {
      font-size: calc(26px + var(--font-offset, 0px));
      color: var(--warning);
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

.list-wrapper {
  .list-item {
    background: var(--card-bg);
    border: 1px solid var(--border);
    border-radius: 14px;
    padding: 20px 24px;
    margin-bottom: 12px;
    cursor: pointer;
    box-shadow: var(--shadow-card);
    border-left: 4px solid var(--primary);
    transition: all 0.3s;

    &:hover {
      transform: translateY(-3px);
      border-color: var(--primary-hover);
      box-shadow: var(--shadow-hover);

      .q-mark {
        color: var(--primary);
      }
    }

    .item-content {
      .item-right {
        display: flex;
        justify-content: space-between;
        align-items: center;

        .title {
          font-size: calc(16px + var(--font-offset, 0px));
          font-weight: 600;
          color: var(--text-title);

          .q-mark {
            color: var(--primary);
            margin-right: 6px;
            transition: color 0.3s;
          }
        }

        .star-icon {
          color: var(--warning);
          font-size: calc(18px + var(--font-offset, 0px));
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
            background: var(--primary-light);
            border-color: var(--primary);
            color: var(--primary);
            border-radius: 8px;
          }
        }

        .time-box {
          display: flex;
          align-items: center;
          gap: 6px;

          .clock-icon {
            color: var(--text-muted);
          }

          .time {
            font-size: calc(12px + var(--font-offset, 0px));
            color: var(--text-muted);
          }
        }
      }
    }
  }
}

:deep(.ant-empty-description) {
  color: var(--text-muted);
}
</style>
