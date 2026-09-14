<template>
  <div class="page-container">
    <div class="page-header">
      <h2>翻译记录</h2>
      <a-input-search v-model:value="searchKeyword" placeholder="搜索用户" style="width: 250px" @search="loadData" />
    </div>

    <div class="table-card">
      <a-table :dataSource="tableData" :columns="columns" :loading="loading" rowKey="id" :pagination="pagination" @change="handleTableChange">
        <template #bodyCell="{ column, record }">
          <template v-if="column.dataIndex === 'score'">
            <span :style="{ color: record.score >= 12 ? '#52c41a' : record.score >= 8 ? '#faad14' : '#ff4d4f', fontWeight: 'bold' }">
              {{ record.score || '-' }} / 15
            </span>
          </template>
          <template v-if="column.dataIndex === 'action'">
            <a-button type="link" size="small" @click="viewDetail(record)">查看</a-button>
          </template>
        </template>
      </a-table>
    </div>

    <a-modal v-model:open="detailVisible" title="翻译详情" :footer="null" width="800px">
      <div v-if="currentRecord" class="detail-content">
        <a-descriptions :column="2" bordered size="small">
          <a-descriptions-item label="用户ID">{{ currentRecord.userId }}</a-descriptions-item>
          <a-descriptions-item label="分数">{{ currentRecord.score }} / 15</a-descriptions-item>
          <a-descriptions-item label="考试类型">{{ currentRecord.examType || 'CET-4' }}</a-descriptions-item>
          <a-descriptions-item label="提交时间">{{ currentRecord.createTime }}</a-descriptions-item>
          <a-descriptions-item label="原文" :span="2">{{ currentRecord.originalText }}</a-descriptions-item>
          <a-descriptions-item label="用户翻译" :span="2">{{ currentRecord.userTranslation }}</a-descriptions-item>
          <a-descriptions-item label="AI批改结果" :span="2">
            <div v-html="currentRecord.aiResult"></div>
          </a-descriptions-item>
        </a-descriptions>
      </div>
    </a-modal>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import request from '@/utils/request'

const loading = ref(false)
const tableData = ref<any[]>([])
const searchKeyword = ref('')
const detailVisible = ref(false)
const currentRecord = ref<any>(null)

const pagination = reactive({ current: 1, pageSize: 10, total: 0 })

const columns = [
  { title: 'ID', dataIndex: 'id', width: 80 },
  { title: '用户ID', dataIndex: 'userId', width: 100 },
  { title: '考试类型', dataIndex: 'examType', width: 100 },
  { title: '分数', dataIndex: 'score', width: 100 },
  { title: '提交时间', dataIndex: 'createTime', width: 180 },
  { title: '操作', dataIndex: 'action', width: 100, fixed: 'right' as const },
]

const loadData = async () => {
  loading.value = true
  try {
    const res: any = await request.get('/ai/translation/list', { params: { page: pagination.current, size: pagination.pageSize, keyword: searchKeyword.value } })
    if (res.code === 200) {
      tableData.value = res.data?.records || res.data || []
      pagination.total = res.data?.total || 0
    }
  } catch (e) {
    console.error(e)
  } finally {
    loading.value = false
  }
}

const handleTableChange = (pag: any) => {
  pagination.current = pag.current
  pagination.pageSize = pag.pageSize
  loadData()
}

const viewDetail = (record: any) => {
  currentRecord.value = record
  detailVisible.value = true
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
.detail-content { line-height: 1.8; }
</style>
