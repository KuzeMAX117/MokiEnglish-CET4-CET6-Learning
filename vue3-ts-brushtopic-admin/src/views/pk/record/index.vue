<template>
  <div class="page-container">
    <div class="page-header">
      <h2>对战记录</h2>
      <a-input-search v-model:value="searchKeyword" placeholder="搜索房间号" style="width: 250px" @search="loadData" />
    </div>

    <div class="table-card">
      <a-table :dataSource="tableData" :columns="columns" :loading="loading" rowKey="id" :pagination="pagination" @change="handleTableChange">
        <template #bodyCell="{ column, record }">
          <template v-if="column.dataIndex === 'winnerId'">
            <a-tag :color="record.winnerId ? 'green' : 'default'">
              {{ record.winnerId ? (record.winnerId === record.userAId ? 'A胜' : 'B胜') : '平局' }}
            </a-tag>
          </template>
          <template v-if="column.dataIndex === 'score'">
            {{ record.userAScore }} : {{ record.userBScore }}
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
const searchKeyword = ref('')

const pagination = reactive({ current: 1, pageSize: 10, total: 0 })

const columns = [
  { title: 'ID', dataIndex: 'id', width: 80 },
  { title: '房间号', dataIndex: 'roomId', width: 160 },
  { title: '用户A', dataIndex: 'userAId', width: 100 },
  { title: '用户B', dataIndex: 'userBId', width: 100 },
  { title: '比分', dataIndex: 'score', width: 120 },
  { title: '胜者', dataIndex: 'winnerId', width: 100 },
  { title: '题目数', dataIndex: 'totalQuestions', width: 80 },
  { title: '结束时间', dataIndex: 'endTime', width: 180 },
]

const loadData = async () => {
  loading.value = true
  try {
    const res: any = await request.get('/topic/pk/records', { params: { page: pagination.current, size: pagination.pageSize, keyword: searchKeyword.value } })
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
</style>
