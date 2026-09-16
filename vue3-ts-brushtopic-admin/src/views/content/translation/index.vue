<script setup lang="ts">
import { reactive, ref, h, onMounted, createVNode } from 'vue'
import {
  PlusOutlined,
  EditOutlined,
  DeleteOutlined,
  ExclamationCircleOutlined
} from '@ant-design/icons-vue'
import { apiGetTranslationList, apiAddTranslation, apiUpdateTranslation, apiDeleteTranslation } from '@/api/content/translation'
import type { TranslationQueryType } from '@/api/content/translation/type';
import { message, Modal } from 'ant-design-vue';

const params = ref<TranslationQueryType>({
  pageNum: 1,
  pageSize: 5,
  title: '',
  category: '',
  difficulty: null,
  sourceLang: '',
  targetLang: '',
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
  { title: '原文语言', dataIndex: 'sourceLang', key: 'sourceLang', align: 'center', width: 120 },
  { title: '目标语言', dataIndex: 'targetLang', key: 'targetLang', align: 'center', width: 120 },
  { title: '难度', dataIndex: 'difficulty', key: 'difficulty', align: 'center', width: 100 },
  { title: '分类', dataIndex: 'category', key: 'category', align: 'center', width: 120 },
  { title: '浏览量', dataIndex: 'viewCount', key: 'viewCount', align: 'center', width: 100 },
  { title: '会员专属', dataIndex: 'isMember', key: 'isMember', align: 'center', width: 100 },
  { title: '状态', dataIndex: 'status', key: 'status', align: 'center', width: 100 },
  { title: '创建人', dataIndex: 'createBy', key: 'createBy', align: 'center', width: 120 },
  { title: '创建时间', dataIndex: 'createTime', key: 'createTime', align: 'center', width: 180 },
  { title: '操作', dataIndex: 'operation', key: 'operation', align: 'center' }
]

const statusMap: any = { 0: '正常', 1: '停用' }
const memberMap: any = { 0: '否', 1: '是' }
const difficultyMap: any = { 1: '简单', 2: '中等', 3: '困难' }

const getList = async () => {
  tableLoading.value = true
  const res = await apiGetTranslationList(params.value)
  total.value = res.data.total
  tableData.value = res.data.rows
  tableLoading.value = false
}

const handleQuery = () => { getList() }
const handleReset = () => {
  params.value = { pageNum: 1, pageSize: 5, title: '', category: '', difficulty: null, sourceLang: '', targetLang: '', createBy: '', status: null }
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
const drawerTitle = ref('新增翻译')
const formRef = ref<any>(null)
const formData = ref<any>({ title: '', sourceLang: 'en', targetLang: 'zh', sourceText: '', referenceAnswer: '', analysis: '', difficulty: 1, category: '', isMember: 0, id: null })
const rules = ref({
  title: [{ required: true, message: '请输入翻译标题', trigger: 'blur' }],
  sourceText: [{ required: true, message: '请输入原文', trigger: 'blur' }],
})

const clearFormData = () => {
  formData.value = { title: '', sourceLang: 'en', targetLang: 'zh', sourceText: '', referenceAnswer: '', analysis: '', difficulty: 1, category: '', isMember: 0, id: null }
  if (formRef.value) formRef.value.resetFields()
}

const handleAdd = () => { drawer.value = true; drawerTitle.value = '新增翻译' }
const handleEdit = (record: any) => { drawer.value = true; drawerTitle.value = '修改翻译'; formData.value = { ...record } }
const handleDelete = (record: any) => {
  Modal.confirm({
    title: '是否确认删除该翻译?',
    icon: createVNode(ExclamationCircleOutlined),
    async onOk() {
      if (record && record.id) onSelectedRowKeys.value.push(record.id)
      await apiDeleteTranslation(onSelectedRowKeys.value)
      getList()
      clearFormData()
      message.success('删除成功')
    },
  });
}
const onSave = () => {
  formRef.value.validate().then(async () => {
    let mes = ''
    if (formData.value.id) { mes = '修改翻译成功'; await apiUpdateTranslation(formData.value) }
    else { mes = '新增翻译成功'; await apiAddTranslation(formData.value) }
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
        <template v-if="column.key === 'difficulty'"><span>{{ difficultyMap[record.difficulty] }}</span></template>
      </template>
    </a-table>

    <a-drawer :title="drawerTitle" placement="right" v-model:open="drawer" @close="onClose" :width="600">
      <a-form ref="formRef" :model="formData" :rules="rules" :label-col="{ span: 5 }" :wrapper-col="{ span: 18 }">
        <a-form-item label="标题" name="title"><a-input v-model:value="formData.title" placeholder="请输入翻译标题" /></a-form-item>
        <a-form-item label="原文语言" name="sourceLang"><a-input v-model:value="formData.sourceLang" placeholder="如: en" /></a-form-item>
        <a-form-item label="目标语言" name="targetLang"><a-input v-model:value="formData.targetLang" placeholder="如: zh" /></a-form-item>
        <a-form-item label="分类" name="category"><a-input v-model:value="formData.category" placeholder="如: 日常, 商务, 文学" /></a-form-item>
        <a-form-item label="难度" name="difficulty">
          <a-select v-model:value="formData.difficulty">
            <a-select-option :value="1">简单</a-select-option>
            <a-select-option :value="2">中等</a-select-option>
            <a-select-option :value="3">困难</a-select-option>
          </a-select>
        </a-form-item>
        <a-form-item label="会员专属" name="isMember">
          <a-select v-model:value="formData.isMember">
            <a-select-option :value="0">否</a-select-option>
            <a-select-option :value="1">是</a-select-option>
          </a-select>
        </a-form-item>
        <a-form-item label="原文" name="sourceText"><a-textarea v-model:value="formData.sourceText" :rows="5" placeholder="请输入原文" /></a-form-item>
        <a-form-item label="参考译文" name="referenceAnswer"><a-textarea v-model:value="formData.referenceAnswer" :rows="5" placeholder="请输入参考译文" /></a-form-item>
        <a-form-item label="翻译技巧" name="analysis"><a-textarea v-model:value="formData.analysis" :rows="3" placeholder="请输入翻译技巧/解析" /></a-form-item>
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
