<template>
  <div class="pk-rank-page">
    <div class="page-header">
      <h2 class="page-title">
        <TrophyFilled class="title-icon" />
        PK 排行榜
      </h2>
    </div>

    <div class="tab-bar">
      <div
        class="tab-item"
        :class="{ active: activeTab === 'daily' }"
        @click="activeTab = 'daily'"
      >
        每日榜
      </div>
      <div
        class="tab-item"
        :class="{ active: activeTab === 'all' }"
        @click="activeTab = 'all'"
      >
        总榜
      </div>
    </div>

    <div class="rank-list">
      <div v-for="(item, index) in rankList" :key="item.userId" class="rank-item">
        <div class="rank-no" :class="rankClass(index)">
          <span v-if="index === 0">🥇</span>
          <span v-else-if="index === 1">🥈</span>
          <span v-else-if="index === 2">🥉</span>
          <span v-else>{{ index + 1 }}</span>
        </div>
        <div class="rank-avatar">
          <a-avatar v-if="item.avatar" :src="item.avatar" :size="40" />
          <a-avatar v-else :size="40" style="background: linear-gradient(135deg, #4257B2, #364899)">
            {{ (item.nickname || 'U').charAt(0) }}
          </a-avatar>
        </div>
        <div class="rank-info">
          <div class="rank-name">{{ item.nickname || '用户' + item.userId }}</div>
        </div>
        <div class="rank-score">{{ item.score }} {{ activeTab === 'daily' ? '胜' : '分' }}</div>
      </div>
      <a-empty v-if="!rankList.length" description="暂无排行数据" />
    </div>

    <div v-if="rankList.length >= 20" class="load-more">
      <a-button @click="loadMore">加载更多</a-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch, onMounted } from 'vue'
import { TrophyFilled } from '@ant-design/icons-vue'
import { apiGetPkRank } from '@/api/pk'
import type { PkRankItem } from '@/api/pk'

const activeTab = ref('daily')
const rankList = ref<PkRankItem[]>([])
const page = ref(1)
const loading = ref(false)

onMounted(() => {
  loadRank()
})

watch(activeTab, () => {
  page.value = 1
  rankList.value = []
  loadRank()
})

const loadRank = async () => {
  loading.value = true
  try {
    const res = await apiGetPkRank(activeTab.value, page.value, 20)
    if (res.code === 200) {
      if (page.value === 1) {
        rankList.value = res.data
      } else {
        rankList.value.push(...res.data)
      }
    }
  } catch {
    // silent
  } finally {
    loading.value = false
  }
}

const loadMore = () => {
  page.value++
  loadRank()
}

const rankClass = (index: number) => {
  if (index === 0) return 'gold'
  if (index === 1) return 'silver'
  if (index === 2) return 'bronze'
  return ''
}
</script>

<style scoped lang="scss">
.pk-rank-page {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.page-header {
  .page-title {
    font-size: calc(22px + var(--font-offset, 0px));
    font-weight: 800;
    color: var(--text-title);
    display: flex;
    align-items: center;
    gap: 10px;
    margin: 0;
    .title-icon { color: var(--warning); }
  }
}

.tab-bar {
  display: flex;
  gap: 8px;
  padding: 4px;
  border-radius: var(--radius-md);
  background: var(--border);

  .tab-item {
    flex: 1;
    text-align: center;
    padding: 10px;
    border-radius: var(--radius-sm);
    font-size: calc(14px + var(--font-offset, 0px));
    font-weight: 600;
    color: var(--text-muted);
    cursor: pointer;
    transition: all 0.2s;

    &.active {
      background: var(--page-bg);
      color: var(--primary);
      box-shadow: var(--shadow-card);
    }
  }
}

.rank-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.rank-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 14px 16px;
  border-radius: var(--radius-md);
  background: var(--page-bg);
  border: 1px solid var(--border);
  transition: all 0.2s;

  &:hover {
    border-color: var(--primary);
    transform: translateX(4px);
  }

  .rank-no {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    background: var(--border);
    color: var(--text-muted);
    font-size: calc(14px + var(--font-offset, 0px));
    font-weight: 700;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;

    &.gold { background: #ffd700; color: #fff; font-size: 20px; }
    &.silver { background: #c0c0c0; color: #fff; font-size: 20px; }
    &.bronze { background: #cd7f32; color: #fff; font-size: 20px; }
  }

  .rank-info {
    flex: 1;
    min-width: 0;

    .rank-name {
      font-size: calc(15px + var(--font-offset, 0px));
      font-weight: 600;
      color: var(--text-title);
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }
  }

  .rank-score {
    font-size: calc(16px + var(--font-offset, 0px));
    font-weight: 700;
    color: var(--primary);
    flex-shrink: 0;
  }
}

.load-more {
  text-align: center;
  padding: 16px;
}
</style>
