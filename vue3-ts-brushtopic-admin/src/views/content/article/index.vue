<script setup lang="ts">
import { reactive, ref, h, onMounted, createVNode } from 'vue'
import {
  PlusOutlined,
  EditOutlined,
  DeleteOutlined,
  ExclamationCircleOutlined
} from '@ant-design/icons-vue'
import { apiGetArticleList, apiAddArticle, apiUpdateArticle, apiDeleteArticle } from '@/api/content/article'
import type { ArticleQueryType } from '@/api/content/article/type';
import { message, Modal } from 'ant-design-vue';

const params = ref<ArticleQueryType>({
  pageNum: 1,
  pageSize: 5,
  title: '',
  category: '',
  createBy: '',
  status: null
})

const total = ref(0);
const tableLoading = ref(false)
const tableData = ref([])
const onSelectedRowKeys = ref<number[]>([])

const columns = [
  { title: '序号', dataIndex: 'id', key: 'id', align: 'center', width: 80 },
  { title: '标题', dataIndex: 'title', key: 'title', align: 'center', width: 200 },
  { title: '分类', dataIndex: 'category', key: 'category', align: 'center', width: 120 },
  { title: '来源', dataIndex: 'source', key: 'source', align: 'center', width: 120 },
  { title: '浏览量', dataIndex: 'viewCount', key: 'viewCount', align: 'center', width: 100 },
  { title: '会员专属', dataIndex: 'isMember', key: 'isMember', align: 'center', width: 100 },
  { title: '状态', dataIndex: 'status', key: 'status', align: 'center', width: 100 },
  { title: '创建人', dataIndex: 'createBy', key: 'createBy', align: 'center', width: 120 },
  { title: '创建时间', dataIndex: 'createTime', key: 'createTime', align: 'center', width: 180 },
  { title: '操作', dataIndex: 'operation', key: 'operation', align: 'center' }
]

const statusMap: any = { 0: '正常', 1: '停用' }
const memberMap: any = { 0: '否', 1: '是' }

const getList = async () => {
  tableLoading.value = true
  const res = await apiGetArticleList(params.value)
  total.value = res.data.total
  tableData.value = res.data.rows
  tableLoading.value = false
}

const handleQuery = () => { getList() }
const handleReset = () => {
  params.value = { pageNum: 1, pageSize: 5, title: '', category: '', createBy: '', status: null }
  total.value = 0
  getList()
}
const handleTableChange = (pagination: any) => {
  params.value.pageNum = pagination.current;
  params.value.pageSize = pagination.pageSize;
  getList();
}
const onSelectChange = (selectedRowKeys: any) => { onSelectedRowKeys.value = selectedRowKeys }

const drawer = ref(false)
const drawerTitle = ref('新增文章')
const formRef = ref<any>(null)
const formData = ref<any>({ title: '', content: '', summary: '', coverImage: '', category: '', source: '', isMember: 0, id: null })
const rules = ref({
  title: [{ required: true, message: '请输入文章标题', trigger: 'blur' }],
})

const clearFormData = () => {
  formData.value = { title: '', content: '', summary: '', coverImage: '', category: '', source: '', isMember: 0, id: null }
  if (formRef.value) formRef.value.resetFields()
}

const handleAdd = () => { drawer.value = true; drawerTitle.value = '新增文章' }
const handleEdit = (record: any) => { drawer.value = true; drawerTitle.value = '修改文章'; formData.value = { ...record } }
const handleDelete = (record: any) => {
  Modal.confirm({
    title: '是否确认删除该文章?',
    icon: createVNode(ExclamationCircleOutlined),
    async onOk() {
      if (record && record.id) onSelectedRowKeys.value.push(record.id)
      await apiDeleteArticle(onSelectedRowKeys.value)
      getList()
      clearFormData()
      message.success('删除成功')
    },
  });
}
const onSave = () => {
  formRef.value.validate().then(async () => {
    let mes = ''
    if (formData.value.id) { mes = '修改文章成功'; await apiUpdateArticle(formData.value) }
    else { mes = '新增文章成功'; await apiAddArticle(formData.value) }
    drawer.value = false
    getList()
    clearFormData()
    message.success(mes)
  })
}
const onClose = () => { clearFormData(); drawer.value = false }

onMounted(() => { getList() })
</script>
<template>
  <div class="user-body">
    <a-space class="space-box">
      <div class="query-box">
        <a-space :size="23">
          <a-form-item label="标题"><a-input class="input" placeholder="请输入标题" v-model:value="params.title"></a-input></a-form-item>
          <a-form-item label="分类"><a-input class="input" placeholder="请输入分类" v-model:value="params.category"></a-input></a-form-item>
          <a-form-item label="创建人"><a-input class="input" placeholder="请输入创建人" v-model:value="params.createBy"></a-input></a-form-item>
          <a-form-item>
            <a-space>
              <a-button type='primary' @click="handleQuery">搜索</a-button>
              <a-button @click="handleReset">重置</a-button>
            </a-space>
          </a-form-item>
        </a-space>
      </div>
    </a-space>

    <a-form-item>
      <a-space>
        <a-button type="primary" :icon="h(PlusOutlined)" @click="handleAdd">新增</a-button>
        <a-button :disabled="onSelectedRowKeys.length == 0" :icon="h(DeleteOutlined)" @click="handleDelete(null)">删除</a-button>
      </a-space>
    </a-form-item>

    <a-table :pagination="{
      current: params.pageNum, pageSize: params.pageSize, total: total,
      showTotal: (total: any) => `共 ${total} 条`, showSizeChanger: true,
    }" @change="handleTableChange" :loading="tableLoading" :dataSource="tableData" :columns="columns" rowKey="id"
      :row-selection="{ selectedRowKeys: onSelectedRowKeys, onChange: onSelectChange, fixed: true }">
      <template #bodyCell="{ column, record }">
        <template v-if="column.key === 'operation'">
          <a-button type="link" size="small" :icon="h(EditOutlined)" @click="handleEdit(record)">修改</a-button>
          <a-button type="link" size="small" :icon="h(DeleteOutlined)" @click="handleDelete(record)">删除</a-button>
        </template>
        <template v-if="column.key === 'status'"><span>{{ statusMap[record.status] }}</span></template>
        <template v-if="column.key === 'isMember'"><span>{{ memberMap[record.isMember] }}</span></template>
      </template>
    </a-table>

    <a-drawer :title="drawerTitle" placement="right" v-model:open="drawer" @close="onClose" :width="600">
      <a-form ref="formRef" :model="formData" :rules="rules" :label-col="{ span: 5 }" :wrapper-col="{ span: 18 }">
        <a-form-item label="标题" name="title"><a-input v-model:value="formData.title" placeholder="请输入文章标题" /></a-form-item>
        <a-form-item label="分类" name="category"><a-input v-model:value="formData.category" placeholder="请输入分类" /></a-form-item>
        <a-form-item label="来源" name="source"><a-input v-model:value="formData.source" placeholder="请输入来源" /></a-form-item>
        <a-form-item label="摘要" name="summary"><a-textarea v-model:value="formData.summary" :rows="3" placeholder="请输入摘要" /></a-form-item>
        <a-form-item label="封面图" name="coverImage"><a-input v-model:value="formData.coverImage" placeholder="请输入封面图URL" /></a-form-item>
        <a-form-item label="会员专属" name="isMember">
          <a-select v-model:value="formData.isMember">
            <a-select-option :value="0">否</a-select-option>
            <a-select-option :value="1">是</a-select-option>
          </a-select>
        </a-form-item>
        <a-form-item label="内容" name="content"><a-textarea v-model:value="formData.content" :rows="10" placeholder="请输入文章内容" /></a-form-item>
      </a-form>
      <template #footer>
        <a-space class="space-footer-box">
          <a-button @click="onClose">取消</a-button>
          <a-button type="primary" @click="onSave">保存</a-button>
        </a-space>
      </template>
    </a-drawer>
  </div>
</template>
<style lang="scss" scoped>
.space-box { display: flex; justify-content: space-between; .query-box { display: flex; justify-content: flex-end; } }
.checkbox { margin-top: 10px; }
.space-footer-box { display: flex; justify-content: flex-end; }
.input { width: 150px; }
</style>
