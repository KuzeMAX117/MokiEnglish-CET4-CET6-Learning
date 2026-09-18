<script setup lang="ts">
import { reactive, ref, h, onMounted, createVNode } from 'vue'
import {
  PlusOutlined,
  EditOutlined,
  DeleteOutlined,
  DownloadOutlined,
  UploadOutlined,
  LoadingOutlined,
  ExclamationCircleOutlined
} from '@ant-design/icons-vue'
import { apiGetCategoryList, apiAddCategory, apiGetExportTemplate, apiUpdateCategory, apiDeleteCategory, apiExportCategory } from '@/api/topic/category'
import type { TopicCatgoryQueryType } from '@/api/topic/category/type';
import { addDateRange, clearDateRange } from '@/utils/date';
import { message, Modal } from 'ant-design-vue';
import FileSaver from 'file-saver'
import type { UploadChangeParam } from 'ant-design-vue';
import { useUserStore } from '@/stores/modules/user';
const userStore = useUserStore()

const { VITE_SERVE } = import.meta.env

const params = ref<TopicCatgoryQueryType>({
  pageNum: 1,
  pageSize: 5,
  categoryName: '',
  createBy: '',
  params: {},
  status: null
})

const getTopicCategoryList = async () => {
  tableLoading.value = true
  const res = await apiGetCategoryList(params.value)
  total.value = res.data.total
  tableData.value = res.data.rows
  tableLoading.value = false
}

const identity = userStore.userInfo.identity
console.log('身份', identity);

const total = ref(0);

const createTimeDateRange = ref([]);

const tableLoading = ref(false)

const tableData = ref([])

const isDangerHover = ref(false)

const columns = [
  {
    title: '序号',
    dataIndex: 'id',
    key: 'id',
    align: 'center',
    width: 100,
  },
  {
    title: '分类名称',
    dataIndex: 'categoryName',
    key: 'categoryName',
    align: 'center',
    width: 200,
  },
  {
    title: '专题数量',
    dataIndex: 'subjectCount',
    key: 'subjectCount',
    align: 'center',
    width: 120,
    sorter: (a: any, b: any) => a.subjectCount - b.subjectCount,
  },
  {
    title: '状态',
    dataIndex: 'status',
    key: 'status',
    align: 'center',
    width: 140,
  },
  {
    title: '失败原因',
    dataIndex: 'failMsg',
    key: 'failMsg',
    align: 'center',
    width: 140,
  },
  {
    title: '创建时间',
    dataIndex: 'createTime',
    key: 'createTime',
    align: 'center',
    width: 190,
  },
  {
    title: '修改时间',
    dataIndex: 'updateTime',
    key: 'updateTime',
    align: 'center',
    width: 190,
  },
  {
    title: '操作',
    dataIndex: 'operation',
    key: 'operation',
    align: 'center',
  }
]

if (identity !== 1) {
  columns.splice(3, 0, {
    title: '创建人',
    dataIndex: 'createBy',
    key: 'createBy',
    align: 'center',
    width: 150,
  });
}

const handleQuery = () => {
  if (createTimeDateRange.value && createTimeDateRange.value.length > 0) {
    params.value = addDateRange(params.value, createTimeDateRange.value, 'CreateTime')
  } else {
    params.value = clearDateRange(params.value, 'CreateTime')
  }
  getTopicCategoryList()
}

const handleReset = () => {
  params.value = {
    pageNum: 1,
    pageSize: 5,
    categoryName: '',
    createBy: '',
    params: null,
    status: null
  }
  createTimeDateRange.value = []
  total.value = 0
  getTopicCategoryList()
}

const onSelectedRowKeys = ref<number[]>([])

const onSelectChange = (selectedRowKeys: any) => {
  onSelectedRowKeys.value = selectedRowKeys
}

const handleAdd = () => {
  drawer.value = true
  drawerTitle.value = '新增题目分类'
}

const handleEdit = (record: any) => {
  drawer.value = true
  drawerTitle.value = '修改题目分类'
  formData.value = {
    ...record
  }
}

const handleDelete = (record: any) => {
  Modal.confirm({
    title: '是否确认删除该题目分类?',
    icon: createVNode(ExclamationCircleOutlined),
    content: createVNode('div', { style: 'color:red;' }, '删除分类会导致相关题目分类丢失，请慎重考虑!'),
    async onOk() {
      if (record && record.id) {
        onSelectedRowKeys.value.push(record.id)
      }
      await apiDeleteCategory(onSelectedRowKeys.value)
      getTopicCategoryList()
      clearFormData()
      message.success('删除成功')
    },
    onCancel() {
      console.log('Cancel');
    },
  });
}

const handleImport = () => {
  upload.open = true
}

const handleExport = async () => {
  tableLoading.value = true
  let response: any = null
  
  if (onSelectedRowKeys.value.length > 0) {
    
    response = await apiExportCategory(params.value, onSelectedRowKeys.value)
  } else {
    
    response = await apiExportCategory(params.value, [0])
  }
  FileSaver.saveAs(response, `英语学习cet4-6题目分类数据_${new Date().getTime()}.xlsx`) 
  message.success('导出成功')
  onSelectedRowKeys.value = []
  tableLoading.value = false
}

const handleTableChange = (pagination: any) => {
  params.value.pageNum = pagination.current;
  params.value.pageSize = pagination.pageSize;
  getTopicCategoryList();
}

const upload = reactive({
  
  open: false,
  
  updateSupport: 0,
  
  headers: {
    authorization: userStore.token
  },
  
  uploadLoading: false,
  
  url: VITE_SERVE + "/api/topic/category/import",
  
  uploadFileList: [],
  
  oepnResult: false,
  
  result: ""
});

const handleCancel = () => {
  upload.open = false
  upload.uploadFileList = []

}

const importTemplate = async () => {
  let response: any = null
  const res = await apiGetExportTemplate()
  response = res
  FileSaver.saveAs(response, `英语学习cet4-6题目分类数据模板_${new Date().getTime()}.xlsx`)
}

const handleBeforeUpload = (file: any) => {
  
  const type = file.name.split('.').pop()
  const isExcel = type === 'xls' || type === 'xlsx';
  if (!isExcel) {
    message.error('上传excel文件格式错误');
  }
  const isLt5M = file.size / 1024 / 1024 < 5;
  if (!isLt5M) {
    message.error('excel文件不能超过2M');
  }
  return isExcel && isLt5M;
}

const handleUploadChange = (info: UploadChangeParam) => {
  
  if (info.file.status === 'uploading') {
    upload.uploadLoading = true;
    return;
  }
  
  if (info.file.status === 'done') {
    upload.uploadLoading = false;
    upload.oepnResult = true
    handleCancel()
    upload.result = info.file.response.data
    if (info.file.response.code === 200) {
      message.success('导入成功');
      getTopicCategoryList()
    } else {
      message.error("导入失败");
    }
  }
  
  if (info.file.status === 'error') {
    upload.uploadLoading = false;
    upload.oepnResult = true
    handleCancel()
    upload.result = info.file.response.data
    message.error(info.file.response.data);
  }
}

const drawerTitle = ref('新增')

const drawer = ref(false)

const onClose = () => {
  clearFormData()
  drawer.value = false
}

const formRef = ref<any>(null)

const formData = ref({
  categoryName: '',
  id: null,
})

const rules = ref({
  categoryName: [
    {
      required: true,
      message: '请输入分类名称',
      trigger: 'blur',
    },
  ],
})

const clearFormData = () => {
  formData.value = {
    categoryName: '',
    id: null,
  }
  if (formRef.value) {
    formRef.value.resetFields()
  }
  createTimeDateRange.value = []
}

const onSave = () => {
  formRef.value.validate().then(async () => {
    let mes = ''
    
    if (formData.value.id) {
      mes = '修改题目分类成功'
      await apiUpdateCategory(formData.value)
    } else {
      mes = '新增题目分类成功'
      await apiAddCategory(formData.value)
    }
    drawer.value = false
    getTopicCategoryList()
    clearFormData()

    message.success(mes)
  })
}

const statusMap: any = {
  0: '正常',
  1: '停用',
  2: '待审核',
  3: '审核失败',
}

onMounted(() => {
  getTopicCategoryList()
})
</script>
<template>
  <div class="user-body">
    <a-space class="space-box">
      <div class="query-box">
        <a-space :size="23">
          
          <a-form-item label="分类名称">
            <a-input class="input" placeholder="请输入分类名称" v-model:value="params.categoryName"></a-input>
          </a-form-item>
          <a-form-item label="创建人">
            <a-input class="input" placeholder="请输入创建人" v-model:value="params.createBy"></a-input>
          </a-form-item>
          <a-form-item label="创建时间">
            <a-range-picker class="range-picker" v-model:value="createTimeDateRange" />
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
    
    <a-form-item v-if="!tableLoading">
      <a-space>
        <a-button type="primary" :icon="h(PlusOutlined)" @click="handleAdd">新增</a-button>
        <a-button :disabled="onSelectedRowKeys.length == 0" @mouseenter="isDangerHover = true"
          @mouseleave="isDangerHover = false" :danger="isDangerHover" :icon="h(DeleteOutlined)"
          @click="handleDelete(null)">删除</a-button>
        <a-button :icon="h(UploadOutlined)" @click="handleImport">导入</a-button>
        <a-button :disabled="tableData.length == 0" :icon="h(DownloadOutlined)" @click="handleExport">导出</a-button>
      </a-space>
    </a-form-item>

    
    <a-table :pagination="{
      current: params.pageNum,
      pageSize: params.pageSize,
      total: total,
      showTotal: (total: any) => `共 ${total} 条`,
      showSizeChanger: true,
    }" @change="handleTableChange" :loading="tableLoading" :dataSource="tableData" :columns="columns" rowKey="id"
      :row-selection="{ selectedRowKeys: onSelectedRowKeys, onChange: onSelectChange, fixed: true }">
      <template #bodyCell="{ column, record }">
        <template v-if="column.key === 'operation'">
          <a-button type="link" size="small" :icon="h(EditOutlined)" @click="handleEdit(record)">修改</a-button>
          <a-button type="link" size="small" :icon="h(DeleteOutlined)" @click="handleDelete(record)">删除</a-button>
        </template>
        <template v-if="column.key === 'status'">
          <span>{{ statusMap[record.status] }}</span>
        </template>
        
        <template v-if="column.key === 'failMsg'">
          <a-tooltip>
            <template #title>{{ record?.failMsg }}</template>
            
            {{ record?.failMsg?.slice(0, 7) }}
          </a-tooltip>
        </template>
      </template>
    </a-table>

    
    <a-drawer :title="drawerTitle" placement="right" v-model:open="drawer" @close="onClose">
      <a-form ref="formRef" :model="formData" :rules="rules" :label-col="{ span: 6 }" :wrapper-col="{ span: 18 }">
        <a-form-item label="分类名称" name="categoryName">
          <a-input v-model:value="formData.categoryName" placeholder="请输入分类名称" />
        </a-form-item>
      </a-form>
      
      <template #footer>
        <a-space class="space-footer-box">
          <a-button @click="onClose">取消</a-button>
          <a-button type="primary" @click="onSave">保存</a-button>
        </a-space>
      </template>
    </a-drawer>

    
    <a-modal @cancel="handleCancel" :footer="null"
      bodyStyle="display: flex; flex-direction: column; align-items: center; text-align: center;"
      v-model:open="upload.open" title="导入题目分类数据">
      <a-upload-dragger :maxCount="1" style="width: 100%;" v-model:fileList="upload.uploadFileList" name="file"
        :multiple="true" :headers="upload.headers" :action="upload.url + '?updateSupport=' + upload.updateSupport"
        :before-upload="handleBeforeUpload" @change="handleUploadChange">
        <p class="ant-upload-drag-icon">
          <loading-outlined v-if="upload.uploadLoading"></loading-outlined>
          <inbox-outlined v-else></inbox-outlined>
        </p>
        <p class="ant-upload-text">将文件拖到此处或点击上传</p>
      </a-upload-dragger>
      <a-checkbox class="checkbox" v-model:checked="upload.updateSupport">是否更新已经存在的题目分类数据</a-checkbox>
      <p>仅允许导入xls、xlsx格式文件<a-button type="link" @click="importTemplate">下载模板</a-button></p>
    </a-modal>

    
    <a-modal :footer="null" v-model:open="upload.oepnResult" title="导入结果">
      <div v-html="upload.result"></div>
    </a-modal>
  </div>
</template>
<style lang="scss" scoped>
.space-box {
  display: flex;
  justify-content: space-between;

  .query-box {
    display: flex;
    justify-content: flex-end;

    .range-picker {
      width: 240px;
    }
  }
}

.checkbox {
  margin-top: 10px;
}

.space-footer-box {
  display: flex;
  justify-content: flex-end;
}

.input {
  width: 130px;
}
</style>
