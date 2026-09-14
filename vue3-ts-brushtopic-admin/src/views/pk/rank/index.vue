<template>
  <div class="page-container">
    <div class="page-header">
      <h2>PK排行榜</h2>
      <a-space>
        <a-radio-group v-model:value="rankType" @change="loadData">
          <a-radio-button value="daily">今日榜</a-radio-button>
          <a-radio-button value="all">总榜</a-radio-button>
        </a-radio-group>
      </a-space>
    </div>

    <div class="table-card">
      <a-table :dataSource="tableData" :columns="columns" :loading="loading" rowKey="userId" :pagination="false">
        <template #bodyCell="{ column, record, index }">
          <template v-if="column.dataIndex === 'rank'">
            <span :class="['rank-badge', { top1: index === 0, top2: index === 1, top3: index === 2 }]">
              {{ index + 1 }}
            </span>
          </template>
          <template v-if="column.dataIndex === 'level'">
            <a-tag :color="getLevelColor(record.level)">{{ getLevelName(record.level) }}</a-tag>
          </template>
        </template>
      </a-table>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import request from '@/utils/request'

const loading = ref(false)
const tableData = ref<any[]>([])
const rankType = ref('daily')

const columns = [
  { title: '排名', dataIndex: 'rank', width: 80 },
  { title: '用户ID', dataIndex: 'userId', width: 120 },
  { title: '昵称', dataIndex: 'nickname', width: 150 },
  { title: '等级', dataIndex: 'level', width: 120 },
  { title: '积分', dataIndex: 'score', width: 100 },
]

const getLevelName = (level: number) => {
  const map: Record<number, string> = { 1: 'Lv1 初学者', 2: 'Lv2 进阶者', 3: 'Lv3 挑战者', 4: 'Lv4 大师' }
  return map[level] || 'Lv1 初学者'
}

const getLevelColor = (level: number) => {
  const map: Record<number, string> = { 1: 'default', 2: 'blue', 3: 'orange', 4: 'red' }
  return map[level] || 'default'
}

const loadData = async () => {
  loading.value = true
  try {
    const res: any = await request.get(`/topic/pk/rank/${rankType.value}`, { params: { page: 1, size: 50 } })
    if (res.code === 200) {
      tableData.value = res.data || []
    }
  } catch (e) {
    console.error(e)
  } finally {
    loading.value = false
  }
}

onMounted(() => loadData())
</script>

<style scoped lang="scss">
.page-container { padding: 20px; }
.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  h2 { margin: 0; }
}
.table-card {
  background: #fff;
  border-radius: 8px;
  padding: 20px;
}
.rank-badge {
  display: inline-flex;
  width: 28px;
  height: 28px;
  border-radius: 50%;
  background: #f0f0f0;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 13px;
  &.top1 { background: #ffd700; color: #fff; }
  &.top2 { background: #c0c0c0; color: #fff; }
  &.top3 { background: #cd7f32; color: #fff; }
}
</style>
