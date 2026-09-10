<template>
  <div class="database-page">
    
    <div class="page-head">
      <div class="head-title">
        <DatabaseOutlined class="head-icon" />
        <span>题库中心</span>
      </div>
      <div class="head-sub">海量面试题，按需挑选</div>
    </div>

    
    <div class="search-box">
      <a-input-search
        v-model:value="searchValue"
        placeholder="搜索专题..."
        size="large"
        allow-clear
        class="glass-search"
        @search="handleSearch"
        @change="handleChange"
      >
        <template #prefix><SearchOutlined /></template>
      </a-input-search>
    </div>

    
    <div class="category-tabs">
      <a-tabs v-model:activeKey="activeKey" @change="handleMenuChange">
        <a-tab-pane v-for="item in category" :key="String(item.id)" :tab="item.categoryName" />
      </a-tabs>
    </div>

    
    <a-spin :spinning="loading">
      <a-empty v-if="!loading && subject.length === 0" description="暂无相关专题" />
      <div class="subject-grid">
        <div v-for="(item, i) in subject" :key="item.id" class="subject-card" @click="goToSubject(item)">
          <div class="card-main">
            <div class="icon-box" :class="'grad-' + (i % 4)">
              <img v-if="item.imageUrl" :src="item.imageUrl" class="img" alt="" />
              <div v-else class="img-none">
                {{ item.subjectName.charAt(0) }}
              </div>
            </div>
            <div class="content">
              <div class="title">{{ item.subjectName }}</div>
              <div class="info">
                <EyeOutlined />
                {{ item.viewCount || 0 }} 次浏览
              </div>
            </div>
          </div>
          <div class="enter-icon"><RightOutlined /></div>
        </div>
      </div>
    </a-spin>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { SearchOutlined, RightOutlined, DatabaseOutlined, EyeOutlined } from '@ant-design/icons-vue'
import { apiQueryCategoryList, apiQuerySubjectList } from '@/api/topic'
import type { Category, Subject } from '@/types'

const router = useRouter()

const activeKey = ref('')
const searchValue = ref('')
const category = ref<Category[]>([])
const subject = ref<Subject[]>([])
const loading = ref(false)
let categoryId = 0

const getCategory = async () => {
  const res = await apiQueryCategoryList(true)
  category.value = res.data || []
  if (category.value.length > 0) {
    activeKey.value = String(category.value[0].id)
    getSubject(category.value[0].id)
  }
}

const getSubject = async (id: number) => {
  categoryId = id
  loading.value = true
  try {
    const res = await apiQuerySubjectList(id)
    subject.value = res.data || []
  } finally {
    loading.value = false
  }
}

const handleMenuChange = (key: string) => {
  searchValue.value = ''
  getSubject(Number(key))
}

const handleSearch = () => {
  if (!searchValue.value || searchValue.value.trim() === '') {
    getSubject(categoryId)
    return
  }
  subject.value = subject.value.filter((item) =>
    item.subjectName.toLowerCase().includes(searchValue.value.toLowerCase().trim())
  )
}

const handleChange = () => {
  if (!searchValue.value || searchValue.value.trim() === '') {
    getSubject(categoryId)
  }
}

const goToSubject = (item: Subject) => {
  router.push(`/subject/${item.id}`)
}

onMounted(getCategory)
</script>

<style scoped lang="scss">
.database-page {
  max-width: 1500px;
  margin: 0 auto;
}

.page-head {
  text-align: center;
  margin-bottom: 20px;

  .head-title {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 12px;
    font-size: calc(28px + var(--font-offset, 0px));
    font-weight: 800;
    color: var(--text-title);

    .head-icon {
      font-size: calc(30px + var(--font-offset, 0px));
      color: var(--primary);
    }
  }

  .head-sub {
    margin-top: 8px;
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-muted);
    letter-spacing: 1px;
  }
}

.search-box {
  display: flex;
  justify-content: center;
  padding: 24px 0 24px;

  .glass-search {
    max-width: 520px;
    width: 100%;
    border-radius: 12px;

    :deep(.ant-input-affix-wrapper) {
      background: var(--card-bg);
      border-color: var(--border);
      border-radius: 12px;
      box-shadow: var(--shadow-card);

      &:hover,
      &:focus-within {
        border-color: var(--primary);
        box-shadow: 0 0 0 2px var(--primary-light);
      }
    }

    :deep(.ant-input) {
      background: transparent;
      color: var(--text-title);
    }

    :deep(.ant-btn) {
      background: var(--primary);
      border: none;
      border-radius: 0 12px 12px 0;
    }
  }
}

.category-tabs {
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: 14px;
  padding: 8px 24px 0;
  margin-bottom: 24px;

  :deep(.ant-tabs-nav) {
    margin-bottom: 0;

    &::before {
      border-bottom-color: var(--border);
    }
  }

  :deep(.ant-tabs-tab) {
    color: var(--text-body);
    font-size: calc(14px + var(--font-offset, 0px));
    padding: 14px 18px;

    &:hover {
      color: var(--primary-hover);
    }
  }

  :deep(.ant-tabs-tab-active .ant-tabs-tab-btn) {
    color: var(--primary);
    font-weight: 600;
  }
}

.subject-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 16px;
}

.subject-card {
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: 14px;
  padding: 18px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  cursor: pointer;
  transition: all 0.3s;

  &:hover {
    transform: translateY(-4px);
    border-color: var(--primary);
    box-shadow: var(--shadow-hover);

    .enter-icon {
      background: var(--primary);
      color: #fff;
      border-color: transparent;
    }
  }

  .card-main {
    display: flex;
    align-items: center;

    .icon-box {
      width: 56px;
      height: 56px;
      margin-right: 16px;
      flex-shrink: 0;

      .img {
        width: 100%;
        height: 100%;
        border-radius: 12px;
        object-fit: cover;
      }

      .img-none {
        width: 100%;
        height: 100%;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #fff;
        font-size: calc(22px + var(--font-offset, 0px));
        font-weight: 700;
      }

      &.grad-0 .img-none {
        background: linear-gradient(135deg, #8b5cf6, #6d28d9);
        box-shadow: 0 6px 18px rgba(139, 92, 246, 0.4);
      }

      &.grad-1 .img-none {
        background: linear-gradient(135deg, #22d3ee, #0891b2);
        box-shadow: 0 6px 18px rgba(34, 211, 238, 0.4);
      }

      &.grad-2 .img-none {
        background: linear-gradient(135deg, #34d399, #059669);
        box-shadow: 0 6px 18px rgba(52, 211, 153, 0.35);
      }

      &.grad-3 .img-none {
        background: linear-gradient(135deg, #f472b6, #db2777);
        box-shadow: 0 6px 18px rgba(244, 114, 182, 0.35);
      }
    }

    .content {
      .title {
        font-size: calc(16px + var(--font-offset, 0px));
        color: var(--text-title);
        font-weight: 600;
        margin-bottom: 6px;
      }

      .info {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--text-muted);
        display: flex;
        align-items: center;
        gap: 5px;
      }
    }
  }

  .enter-icon {
    width: 30px;
    height: 30px;
    border-radius: 9px;
    border: 1px solid var(--border);
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--text-muted);
    transition: all 0.3s;
  }
}

:deep(.ant-empty-description) {
  color: var(--text-muted);
}
</style>
