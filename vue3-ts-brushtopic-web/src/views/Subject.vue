<template>
  <div class="subject-page">
    <div class="back-bar" @click="router.back()">
      <LeftOutlined />
      <span>返回</span>
    </div>

    <a-spin :spinning="loading">
      <div v-if="subjectDetail" class="subject-box">
        
        <div class="subject-top">
          <div class="bg-glow-inner">
            <div class="glow g1"></div>
            <div class="glow g2"></div>
            <div class="grid-overlay"></div>
          </div>
          <div class="top-left">
            <img v-if="subjectDetail.imageUrl" class="avatar" :src="subjectDetail.imageUrl" alt="" />
            <div v-else class="avatar avatar-none">
              {{ subjectDetail.subjectName?.charAt(0) }}
            </div>
          </div>
          <div class="top-center">
            <div class="title-wrap">
              <BookOutlined class="title-icon" />
              <h3 class="title">{{ subjectDetail.subjectName }}</h3>
            </div>
            <div class="desc">{{ subjectDetail.subjectDesc }}</div>
            <div class="count">
              <EyeOutlined /> {{ subjectDetail.viewCount || 0 }} 次浏览
              <span class="dot">·</span>
              <FileTextOutlined /> {{ subjectDetail.topicNameVos?.length || 0 }} 个题目
            </div>
          </div>
        </div>

        
        <div class="list-section">
          <div class="section-head">
            <div class="indicator" />
            <span>题目列表</span>
            <span class="head-count">{{ subjectDetail.topicNameVos?.length || 0 }} 题</span>
          </div>
          <div v-if="subjectDetail.topicNameVos && subjectDetail.topicNameVos.length !== 0" class="topic-list">
            <div v-for="(item, i) in subjectDetail.topicNameVos" :key="item.id" class="topic-item" @click="goToTopic(item)">
              <div class="topic-no">{{ String(i + 1).padStart(2, '0') }}</div>
              <div class="topic-name">
                <FileTextOutlined class="file-icon" />
                {{ item.topicName }}
              </div>
              <div class="topic-go"><RightOutlined /></div>
            </div>
          </div>
          <a-empty v-else description="系统正在收录题目数据哦～" />
        </div>
      </div>
      <a-empty v-else-if="!loading" description="系统正在完善专题信息哦～" />
    </a-spin>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import {
  FileTextOutlined,
  RightOutlined,
  LeftOutlined,
  BookOutlined,
  EyeOutlined,
} from '@ant-design/icons-vue'
import { apiQuerySubjectDetail } from '@/api/topic'
import type { Subject } from '@/types'

const route = useRoute()
const router = useRouter()
const loading = ref(true)
const subjectDetail = ref<Subject>({})

const getSubjectDetail = async (id: number) => {
  loading.value = true
  try {
    const res = await apiQuerySubjectDetail(id)
    subjectDetail.value = res.data || {}
  } finally {
    loading.value = false
  }
}

const goToTopic = (item: any) => {
  router.push(`/topic/${item.id}?subjectId=${route.params.id}`)
}

onMounted(() => {
  getSubjectDetail(Number(route.params.id))
})
</script>

<style scoped lang="scss">
.subject-page {
  max-width: 960px;
  margin: 0 auto;
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
  margin-bottom: 16px;

  &:hover {
    color: var(--primary);
    background: var(--primary-light);
  }
}

.subject-box {
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: 18px;
  padding: 28px 32px;
  box-shadow: var(--shadow-card);

  .subject-top {
    position: relative;
    display: flex;
    align-items: flex-start;
    overflow: hidden;
    padding: 8px;
    border-radius: 14px;

    .bg-glow-inner {
      position: absolute;
      inset: 0;
      pointer-events: none;

      .glow {
        position: absolute;
        border-radius: 50%;
        filter: blur(60px);
        opacity: 0.4;
      }

      .g1 {
        width: 260px;
        height: 260px;
        top: -120px;
        right: 0;
        background: radial-gradient(circle, var(--primary-light), transparent 70%);
      }

      .g2 {
        width: 220px;
        height: 220px;
        bottom: -120px;
        left: 20%;
        background: radial-gradient(circle, var(--primary-light), transparent 70%);
      }

      .grid-overlay {
        display: none;
      }
    }

    .top-left {
      position: relative;
      z-index: 2;

      .avatar {
        width: 96px;
        height: 96px;
        border-radius: 16px;
        object-fit: cover;
        margin-right: 20px;
        border: 2px solid var(--border);
        box-shadow: var(--shadow-card);
      }

      .avatar-none {
        background: var(--primary);
        color: #fff;
        font-size: calc(38px + var(--font-offset, 0px));
        font-weight: 700;
        display: flex;
        align-items: center;
        justify-content: center;
      }
    }

    .top-center {
      position: relative;
      z-index: 2;
      flex: 1;

      .title-wrap {
        display: flex;
        align-items: center;
        gap: 10px;

        .title-icon {
          color: var(--primary);
          font-size: calc(18px + var(--font-offset, 0px));
        }

        .title {
          font-size: calc(22px + var(--font-offset, 0px));
          color: var(--text-title);
          margin: 0;
          font-weight: 700;
        }
      }

      .desc {
        font-size: calc(14px + var(--font-offset, 0px));
        color: var(--text-muted);
        margin: 10px 0 14px;
        line-height: 1.6;
      }

      .count {
        font-size: calc(13px + var(--font-offset, 0px));
        color: var(--text-muted);
        display: flex;
        align-items: center;
        gap: 6px;

        .dot {
          margin: 0 4px;
        }
      }
    }
  }

  .list-section {
    margin-top: 28px;

    .section-head {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 16px;

      .indicator {
        width: 4px;
        height: 18px;
        border-radius: 2px;
        background: var(--primary);
      }

      span {
        font-size: calc(16px + var(--font-offset, 0px));
        font-weight: 600;
        color: var(--text-title);
      }

      .head-count {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--text-muted);
        font-weight: 400;
        border: 1px solid var(--border);
        border-radius: 8px;
        padding: 1px 10px;
      }
    }

    .topic-list {
      .topic-item {
        display: flex;
        align-items: center;
        padding: 15px 18px;
        border-radius: 12px;
        border: 1px solid var(--border);
        margin-bottom: 10px;
        cursor: pointer;
        transition: all 0.25s;
        background: var(--card-bg);

        &:hover {
          border-color: var(--primary);
          background: var(--primary-light);
          transform: translateX(4px);

          .topic-go {
            background: var(--primary);
            color: #fff;
            border-color: transparent;
          }
        }

        .topic-no {
          width: 44px;
          font-size: calc(15px + var(--font-offset, 0px));
          color: var(--text-muted);
          font-weight: 700;
        }

        .topic-name {
          flex: 1;
          font-size: calc(14px + var(--font-offset, 0px));
          color: var(--text-title);

          .file-icon {
            color: var(--primary);
            margin-right: 10px;
          }
        }

        .topic-go {
          width: 28px;
          height: 28px;
          border-radius: 8px;
          border: 1px solid var(--border);
          display: flex;
          align-items: center;
          justify-content: center;
          color: var(--text-muted);
          transition: all 0.25s;
        }
      }
    }
  }
}

:deep(.ant-empty-description) {
  color: var(--text-muted);
  padding: 20px 0;
}
</style>
