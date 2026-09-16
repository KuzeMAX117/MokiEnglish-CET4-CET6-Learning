<script setup lang="ts">
import { reactive, ref, h, onMounted, createVNode } from 'vue'
import {
  PlusOutlined,
  EditOutlined,
  DeleteOutlined,
  ExclamationCircleOutlined
} from '@ant-design/icons-vue'
import { apiGetWordBookList, apiAddWordBook, apiUpdateWordBook, apiDeleteWordBook } from '@/api/content/wordbook'
import type { WordBookQueryType } from '@/api/content/wordbook/type';
import { message, Modal } from 'ant-design-vue';

const params = ref<WordBookQueryType>({
  pageNum: 1,
  pageSize: 5,
  name: '',
  type: null
})

const total = ref(0);
const tableLoading = ref(false)
const tableData = ref([])
const onSelectedRowKeys = ref<number[]>([])

const columns = [
  { title: '序号', dataIndex: 'id', key: 'id', align: 'center', width: 80 },
  { title: '词书名称', dataIndex: 'name', key: 'name', align: 'center', width: 200 },
  { title: '类型', dataIndex: 'type', key: 'type', align: 'center', width: 150 },
  { title: '单词总数', dataIndex: 'totalCount', key: 'totalCount', align: 'center', width: 120 },
  { title: '创建时间', dataIndex: 'createTime', key: 'createTime', align: 'center', width: 180 },
  { title: '操作', dataIndex: 'operation', key: 'operation', align: 'center' }
]

const typeMap: any = { 1: '四级单词', 2: '六级单词', 3: '四级词组', 4: '六级词组', 5: '初中', 6: '高中', 7: '考研', 8: '托福', 9: 'SAT' }

const getList = async () => {
  tableLoading.value = true
  const res = await apiGetWordBookList(params.value)
  total.value = res.data.total
  tableData.value = res.data.rows
  tableLoading.value = false
}

const handleQuery = () => { getList() }
const handleReset = () => {
  params.value = { pageNum: 1, pageSize: 5, name: '', type: null }
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
const drawerTitle = ref('新增词书')
const formRef = ref<any>(null)
const formData = ref<any>({ name: '', type: 1, id: null })
const rules = ref({
  name: [{ required: true, message: '请输入词书名称', trigger: 'blur' }],
  type: [{ required: true, message: '请选择类型', trigger: 'change' }],
})

const clearFormData = () => {
  formData.value = { name: '', type: 1, id: null }
  if (formRef.value) formRef.value.resetFields()
}

const handleAdd = () => { drawer.value = true; drawerTitle.value = '新增词书' }
const handleEdit = (record: any) => { drawer.value = true; drawerTitle.value = '修改词书'; formData.value = { ...record } }
const handleDelete = (record: any) => {
  Modal.confirm({
    title: '是否确认删除该词书?',
    icon: createVNode(ExclamationCircleOutlined),
    content: createVNode('div', { style: 'color:red;' }, '删除词书会导致相关单词数据丢失，请慎重考虑!'),
    async onOk() {
      if (record && record.id) onSelectedRowKeys.value.push(record.id)
      await apiDeleteWordBook(onSelectedRowKeys.value)
      getList()
      clearFormData()
      message.success('删除成功')
    },
  });
}
const onSave = () => {
  formRef.value.validate().then(async () => {
    let mes = ''
    if (formData.value.id) { mes = '修改词书成功'; await apiUpdateWordBook(formData.value) }
    else { mes = '新增词书成功'; await apiAddWordBook(formData.value) }
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
          <a-form-item label="词书名称"><a-input class="input" placeholder="请输入词书名称" v-model:value="params.name"></a-input></a-form-item>
          <a-form-item label="类型">
            <a-select class="input" placeholder="请选择类型" v-model:value="params.type" allowClear>
              <a-select-option :value="1">四级单词</a-select-option>
              <a-select-option :value="2">六级单词</a-select-option>
              <a-select-option :value="3">四级词组</a-select-option>
              <a-select-option :value="4">六级词组</a-select-option>
              <a-select-option :value="5">初中</a-select-option>
              <a-select-option :value="6">高中</a-select-option>
              <a-select-option :value="7">考研</a-select-option>
              <a-select-option :value="8">托福</a-select-option>
              <a-select-option :value="9">SAT</a-select-option>
            </a-select>
          </a-form-item>
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
        <template v-if="column.key === 'type'"><span>{{ typeMap[record.type] || record.type }}</span></template>
      </template>
    </a-table>

    <a-drawer :title="drawerTitle" placement="right" v-model:open="drawer" @close="onClose">
      <a-form ref="formRef" :model="formData" :rules="rules" :label-col="{ span: 6 }" :wrapper-col="{ span: 18 }">
        <a-form-item label="词书名称" name="name"><a-input v-model:value="formData.name" placeholder="请输入词书名称" /></a-form-item>
        <a-form-item label="类型" name="type">
          <a-select v-model:value="formData.type">
            <a-select-option :value="1">四级单词</a-select-option>
            <a-select-option :value="2">六级单词</a-select-option>
            <a-select-option :value="3">四级词组</a-select-option>
            <a-select-option :value="4">六级词组</a-select-option>
            <a-select-option :value="5">初中</a-select-option>
            <a-select-option :value="6">高中</a-select-option>
            <a-select-option :value="7">考研</a-select-option>
            <a-select-option :value="8">托福</a-select-option>
            <a-select-option :value="9">SAT</a-select-option>
          </a-select>
        </a-form-item>
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
.space-footer-box { display: flex; justify-content: flex-end; }
.input { width: 150px; }
</style>
