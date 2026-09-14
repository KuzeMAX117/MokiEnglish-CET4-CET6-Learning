<template>
  <div class="page-container">
    <div class="page-header">
      <h2>词书管理</h2>
      <a-button type="primary" @click="showAddModal">
        <PlusOutlined /> 新增词书
      </a-button>
    </div>

    <div class="table-card">
      <a-table :dataSource="tableData" :columns="columns" :loading="loading" rowKey="id" :pagination="pagination" @change="handleTableChange">
        <template #bodyCell="{ column, record }">
          <template v-if="column.dataIndex === 'type'">
            <a-tag :color="getTypeColor(record.type)">{{ getTypeName(record.type) }}</a-tag>
          </template>
          <template v-if="column.dataIndex === 'action'">
            <a-space>
              <a-button type="link" size="small" @click="showEditModal(record)">编辑</a-button>
              <a-popconfirm title="确定删除？" @confirm="handleDelete(record.id)">
                <a-button type="link" size="small" danger>删除</a-button>
              </a-popconfirm>
            </a-space>
          </template>
        </template>
      </a-table>
    </div>

    <a-modal v-model:open="modalVisible" :title="isEdit ? '编辑词书' : '新增词书'" @ok="handleSubmit" :confirmLoading="submitting">
      <a-form :model="formData" :label-col="{ span: 5 }">
        <a-form-item label="词书名称" required>
          <a-input v-model:value="formData.name" placeholder="请输入词书名称" />
        </a-form-item>
        <a-form-item label="词书类型" required>
          <a-select v-model:value="formData.type" placeholder="请选择类型">
            <a-select-option :value="1">初中</a-select-option>
            <a-select-option :value="2">高中</a-select-option>
            <a-select-option :value="3">四级</a-select-option>
            <a-select-option :value="4">六级</a-select-option>
            <a-select-option :value="5">考研</a-select-option>
            <a-select-option :value="6">托福</a-select-option>
            <a-select-option :value="7">SAT</a-select-option>
          </a-select>
        </a-form-item>
        <a-form-item label="单词总数">
          <a-input-number v-model:value="formData.totalCount" :min="0" style="width: 100%" disabled />
        </a-form-item>
      </a-form>
    </a-modal>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { message } from 'ant-design-vue'
import { PlusOutlined } from '@ant-design/icons-vue'
import request from '@/utils/request'

const loading = ref(false)
const submitting = ref(false)
const tableData = ref<any[]>([])
const modalVisible = ref(false)
const isEdit = ref(false)

const pagination = reactive({
  current: 1,
  pageSize: 10,
  total: 0,
})

const formData = reactive({
  id: null as number | null,
  name: '',
  type: null as number | null,
  totalCount: 0,
})

const columns = [
  { title: 'ID', dataIndex: 'id', width: 80 },
  { title: '词书名称', dataIndex: 'name' },
  { title: '类型', dataIndex: 'type', width: 120 },
  { title: '单词总数', dataIndex: 'totalCount', width: 120 },
  { title: '操作', dataIndex: 'action', width: 150, fixed: 'right' as const },
]

const getTypeName = (type: number) => {
  const map: Record<number, string> = { 1: '初中', 2: '高中', 3: '四级', 4: '六级', 5: '考研', 6: '托福', 7: 'SAT' }
  return map[type] || '未知'
}

const getTypeColor = (type: number) => {
  const map: Record<number, string> = { 1: 'green', 2: 'blue', 3: 'orange', 4: 'red', 5: 'purple', 6: 'cyan', 7: 'magenta' }
  return map[type] || 'default'
}

const loadData = async () => {
  loading.value = true
  try {
    const res: any = await request.get('/system/word/books', { params: { pageNum: pagination.current, pageSize: pagination.pageSize } })
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

const showAddModal = () => {
  isEdit.value = false
  formData.id = null
  formData.name = ''
  formData.type = null
  formData.totalCount = 0
  modalVisible.value = true
}

const showEditModal = (record: any) => {
  isEdit.value = true
  formData.id = record.id
  formData.name = record.name
  formData.type = record.type
  formData.totalCount = record.totalCount
  modalVisible.value = true
}

const handleSubmit = async () => {
  if (!formData.name || !formData.type) {
    message.warning('请填写完整信息')
    return
  }
  submitting.value = true
  try {
    if (isEdit.value) {
      await request.put('/system/word/book', formData)
      message.success('更新成功')
    } else {
      await request.post('/system/word/book', formData)
      message.success('新增成功')
    }
    modalVisible.value = false
    loadData()
  } catch (e) {
    message.error('操作失败')
  } finally {
    submitting.value = false
  }
}

const handleDelete = async (id: number) => {
  try {
    await request.delete(`/system/word/book/${id}`)
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
.page-container {
  padding: 20px;
}
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
