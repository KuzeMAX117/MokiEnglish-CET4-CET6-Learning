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
              <FileTextOutlined /> {{ subjectDetail.topicNameVos?.length || 0 }} 个面试题
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
  font-size: 14px;
  color: #9aa4bd;
  cursor: pointer;
  transition: all 0.25s;
  margin-bottom: 16px;

  &:hover {
    color: #22d3ee;
    background: rgba(255, 255, 255, 0.06);
  }
}

.subject-box {
  background: rgba(18, 24, 40, 0.6);
  backdrop-filter: blur(14px);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 18px;
  padding: 28px 32px;
  box-shadow: 0 16px 48px rgba(0, 0, 0, 0.35);

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
        background: radial-gradient(circle, #8b5cf6, transparent 70%);
      }

      .g2 {
        width: 220px;
        height: 220px;
        bottom: -120px;
        left: 20%;
        background: radial-gradient(circle, #22d3ee, transparent 70%);
      }

      .grid-overlay {
        position: absolute;
        inset: 0;
        background-image:
          linear-gradient(rgba(255, 255, 255, 0.035) 1px, transparent 1px),
          linear-gradient(90deg, rgba(255, 255, 255, 0.035) 1px, transparent 1px);
        background-size: 32px 32px;
        mask-image: radial-gradient(circle at 80% 20%, #000 0%, transparent 70%);
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
        border: 2px solid rgba(255, 255, 255, 0.12);
        box-shadow: 0 8px 28px rgba(0, 0, 0, 0.35);
      }

      .avatar-none {
        background: linear-gradient(135deg, #8b5cf6, #22d3ee);
        color: #fff;
        font-size: 38px;
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
          color: #a78bfa;
          font-size: 18px;
        }

        .title {
          font-size: 22px;
          color: #e5eaf3;
          margin: 0;
          font-weight: 700;
        }
      }

      .desc {
        font-size: 14px;
        color: #9aa4bd;
        margin: 10px 0 14px;
        line-height: 1.6;
      }

      .count {
        font-size: 13px;
        color: #7c86a6;
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
        background: linear-gradient(180deg, #8b5cf6, #22d3ee);
        box-shadow: 0 0 10px rgba(139, 92, 246, 0.6);
      }

      span {
        font-size: 16px;
        font-weight: 600;
        color: #e5eaf3;
      }

      .head-count {
        font-size: 12px;
        color: #7c86a6;
        font-weight: 400;
        border: 1px solid rgba(255, 255, 255, 0.1);
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
        border: 1px solid rgba(255, 255, 255, 0.06);
        margin-bottom: 10px;
        cursor: pointer;
        transition: all 0.25s;
        background: rgba(255, 255, 255, 0.02);

        &:hover {
          border-color: rgba(139, 92, 246, 0.5);
          background: rgba(139, 92, 246, 0.08);
          transform: translateX(4px);

          .topic-go {
            background: linear-gradient(135deg, #8b5cf6, #22d3ee);
            color: #fff;
            border-color: transparent;
          }
        }

        .topic-no {
          width: 44px;
          font-size: 15px;
          color: #6b7693;
          font-weight: 700;
        }

        .topic-name {
          flex: 1;
          font-size: 14px;
          color: #e5eaf3;

          .file-icon {
            color: #a78bfa;
            margin-right: 10px;
          }
        }

        .topic-go {
          width: 28px;
          height: 28px;
          border-radius: 8px;
          border: 1px solid rgba(255, 255, 255, 0.1);
          display: flex;
          align-items: center;
          justify-content: center;
          color: #7c86a6;
          transition: all 0.25s;
        }
      }
    }
  }
}

:deep(.ant-empty-description) {
  color: #7c86a6;
  padding: 20px 0;
}
</style>
