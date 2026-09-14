<template>
  <div class="page-container">
    <div class="page-header">
      <h2>文章管理</h2>
      <a-space>
        <a-input-search v-model:value="searchKeyword" placeholder="搜索文章标题" style="width: 250px" @search="loadData" />
      </a-space>
    </div>

    <div class="table-card">
      <a-table :dataSource="tableData" :columns="columns" :loading="loading" rowKey="id" :pagination="pagination" @change="handleTableChange">
        <template #bodyCell="{ column, record }">
          <template v-if="column.dataIndex === 'status'">
            <a-tag :color="record.status === 1 ? 'green' : 'default'">
              {{ record.status === 1 ? '已发布' : '草稿' }}
            </a-tag>
          </template>
          <template v-if="column.dataIndex === 'difficulty'">
            <a-tag :color="getDifficultyColor(record.difficulty)">{{ record.difficulty || '中等' }}</a-tag>
          </template>
          <template v-if="column.dataIndex === 'action'">
            <a-space>
              <a-button type="link" size="small" @click="viewArticle(record)">查看</a-button>
              <a-popconfirm title="确定删除？" @confirm="handleDelete(record.id)">
                <a-button type="link" size="small" danger>删除</a-button>
              </a-popconfirm>
            </a-space>
          </template>
        </template>
      </a-table>
    </div>

    <a-modal v-model:open="previewVisible" title="文章预览" :footer="null" width="800px">
      <div v-if="currentArticle" class="article-preview">
        <h3>{{ currentArticle.title }}</h3>
        <div class="article-meta">
          <a-tag>{{ currentArticle.difficulty || '中等' }}</a-tag>
          <span>词汇量: {{ currentArticle.wordCount || '-' }}</span>
          <span>创建时间: {{ currentArticle.createTime }}</span>
        </div>
        <a-divider />
        <div class="article-content" v-html="currentArticle.content"></div>
      </div>
    </a-modal>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { message } from 'ant-design-vue'
import request from '@/utils/request'

const loading = ref(false)
const tableData = ref<any[]>([])
const searchKeyword = ref('')
const previewVisible = ref(false)
const currentArticle = ref<any>(null)

const pagination = reactive({
  current: 1,
  pageSize: 10,
  total: 0,
})

const columns = [
  { title: 'ID', dataIndex: 'id', width: 80 },
  { title: '标题', dataIndex: 'title', ellipsis: true },
  { title: '难度', dataIndex: 'difficulty', width: 100 },
  { title: '词汇量', dataIndex: 'wordCount', width: 100 },
  { title: '状态', dataIndex: 'status', width: 100 },
  { title: '创建时间', dataIndex: 'createTime', width: 180 },
  { title: '操作', dataIndex: 'action', width: 150, fixed: 'right' as const },
]

const getDifficultyColor = (d: string) => {
  const map: Record<string, string> = { 'easy': 'green', 'medium': 'orange', 'hard': 'red', '简单': 'green', '中等': 'orange', '困难': 'red' }
  return map[d] || 'default'
}

const loadData = async () => {
  loading.value = true
  try {
    const res: any = await request.get('/ai/article/list', { params: { page: pagination.current, size: pagination.pageSize, keyword: searchKeyword.value } })
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

const viewArticle = (record: any) => {
  currentArticle.value = record
  previewVisible.value = true
}

const handleDelete = async (id: number) => {
  try {
    await request.delete(`/ai/article/${id}`)
    message.success('删除成功')
    loadData()
  } catch (e) {
    message.error('删除失败')
  }
}

onMounted(() => {
  loadData()
})
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
.article-preview {
  h3 { margin: 0 0 12px; }
  .article-meta {
    display: flex;
    gap: 16px;
    align-items: center;
    color: #666;
    font-size: 13px;
  }
  .article-content {
    line-height: 1.8;
    max-height: 500px;
    overflow-y: auto;
  }
}
</style>
