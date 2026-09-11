<script setup lang="ts">
import { ref, h, onMounted, createVNode, watch } from 'vue'
import { useRouter } from 'vue-router'
import {
  PlusOutlined,
  EditOutlined,
  DeleteOutlined,
  CloudUploadOutlined,
  StopOutlined,
  ExclamationCircleOutlined
} from '@ant-design/icons-vue'
import { message, Modal } from 'ant-design-vue'
import {
  apiGetPaperManageList,
  apiAddPaper,
  apiDeletePaper,
  apiPublishPaper,
  apiUnpublishPaper
} from '@/api/topic/paper'
import type { PaperQueryType, PaperListItemType } from '@/api/topic/paper/type'

const router = useRouter()

const params = ref<PaperQueryType>({
  pageNum: 1,
  pageSize: 10,
  level: null,
  status: null,
  examYear: null,
  title: ''
})

const total = ref(0)

const tableLoading = ref(false)

const tableData = ref<PaperListItemType[]>([])

const onSelectedRowKeys = ref<number[]>([])

const levelOptions = [
  { value: 4, label: '四级' },
  { value: 6, label: '六级' }
]

const statusOptions = [
  { value: 0, label: '已发布' },
  { value: 1, label: '已下架' },
  { value: 2, label: '草稿' }
]

const halfOptions = [
  { value: 1, label: '上半年' },
  { value: 2, label: '下半年' }
]

const statusMap: any = {
  0: { text: '已发布', color: 'green' },
  1: { text: '已下架', color: 'red' },
  2: { text: '草稿', color: 'orange' }
}

/** 板块顺序与达标线（与后端 SECTION_TARGET 一致） */
const sectionMeta = [
  { key: 'writing', name: '写作', target: 1 },
  { key: 'listening', name: '听力', target: 25 },
  { key: 'reading', name: '阅读', target: 30 },
  { key: 'translation', name: '翻译', target: 1 }
]

const columns = [
  {
    title: '试卷标题',
    dataIndex: 'title',
    key: 'title',
    align: 'left',
    ellipsis: true,
    width: 280,
  },
  {
    title: '级别',
    dataIndex: 'level',
    key: 'level',
    align: 'center',
    width: 80,
  },
  {
    title: '考试时间',
    dataIndex: 'examYear',
    key: 'examTime',
    align: 'center',
    width: 130,
  },
  {
    title: '板块完成度',
    dataIndex: 'sectionCounts',
    key: 'sectionCounts',
    align: 'center',
    width: 400,
  },
  {
    title: '总题数',
    dataIndex: 'topicCount',
    key: 'topicCount',
    align: 'center',
    width: 80,
  },
  {
    title: '状态',
    dataIndex: 'status',
    key: 'status',
    align: 'center',
    width: 100,
  },
  {
    title: '创建时间',
    dataIndex: 'createTime',
    key: 'createTime',
    align: 'center',
    width: 170,
  },
  {
    title: '操作',
    dataIndex: 'operation',
    key: 'operation',
    align: 'center',
    width: 230,
    fixed: 'right',
  }
]

const getPaperList = async () => {
  tableLoading.value = true
  const res = await apiGetPaperManageList(params.value)
  total.value = res.data.total
  tableData.value = res.data.rows
  tableLoading.value = false
}

const handleQuery = () => {
  params.value.pageNum = 1
  getPaperList()
}

const handleReset = () => {
  params.value = {
    pageNum: 1,
    pageSize: 10,
    level: null,
    status: null,
    examYear: null,
    title: ''
  }
  getPaperList()
}

const handleTableChange = (pagination: any) => {
  params.value.pageNum = pagination.current
  params.value.pageSize = pagination.pageSize
  getPaperList()
}

const onSelectChange = (selectedRowKeys: any) => {
  onSelectedRowKeys.value = selectedRowKeys
}

/* ============ 新建试卷 ============ */

const modal = ref(false)

const saveLoading = ref(false)

const formRef = ref<any>(null)

const formData = ref<any>({
  level: 4,
  examYear: new Date().getFullYear(),
  examHalf: 1,
  setNo: 1,
  title: '',
  totalScore: 710
})

/** 用户手动改过标题后不再自动覆盖 */
const manualTitle = ref(false)

const rules = {
  level: [{ required: true, message: '请选择级别' }],
  examYear: [{ required: true, message: '请输入考试年份' }],
  examHalf: [{ required: true, message: '请选择上/下半年' }],
  title: [{ required: true, message: '请输入试卷标题' }]
}

const generateTitle = () => {
  const levelName = formData.value.level === 6 ? '六级' : '四级'
  const halfName = formData.value.examHalf === 2 ? '下' : '上'
  formData.value.title = `${formData.value.examYear}年${halfName}半年大学英语${levelName}真题（第${formData.value.setNo}套）`
}

watch(
  () => [formData.value.level, formData.value.examYear, formData.value.examHalf, formData.value.setNo],
  () => {
    if (!manualTitle.value) {
      generateTitle()
    }
  }
)

const handleAdd = () => {
  formData.value = {
    level: 4,
    examYear: new Date().getFullYear(),
    examHalf: 1,
    setNo: 1,
    title: '',
    totalScore: 710
  }
  manualTitle.value = false
  generateTitle()
  modal.value = true
}

const onSave = () => {
  formRef.value.validate().then(async () => {
    saveLoading.value = true
    try {
      const res = await apiAddPaper({
        level: formData.value.level,
        examYear: formData.value.examYear,
        examHalf: formData.value.examHalf,
        title: formData.value.title,
        totalScore: formData.value.totalScore
      })
      modal.value = false
      message.success('创建成功，正在进入编辑器')
      router.push(`/topic/paper/editor/${res.data}`)
    } finally {
      saveLoading.value = false
    }
  })
}

/* ============ 行操作 ============ */

const handleEdit = (record: PaperListItemType) => {
  router.push(`/topic/paper/editor/${record.id}`)
}

const handlePublish = (record: PaperListItemType) => {
  Modal.confirm({
    title: `确认发布《${record.title}》?`,
    icon: createVNode(ExclamationCircleOutlined),
    content: '发布后用户前台立即可见',
    async onOk() {
      const res = await apiPublishPaper(record.id)
      const warnings: string[] = res.data?.warnings || []
      getPaperList()
      if (warnings.length > 0) {
        Modal.info({
          title: '发布成功，但存在以下问题建议核对',
          width: 560,
          content: () => h('div', warnings.map((w: string) => h('div', { style: 'margin-bottom: 4px;' }, w)))
        })
      } else {
        message.success('发布成功')
      }
    },
  })
}

const handleUnpublish = (record: PaperListItemType) => {
  Modal.confirm({
    title: `确认下架《${record.title}》?`,
    icon: createVNode(ExclamationCircleOutlined),
    content: '下架后用户前台不可见，已有答题记录不受影响',
    async onOk() {
      await apiUnpublishPaper(record.id)
      getPaperList()
      message.success('已下架')
    },
  })
}

const handleDelete = (record: PaperListItemType | null) => {
  Modal.confirm({
    title: record
      ? `确认删除《${record.title}》?`
      : `确认删除选中的 ${onSelectedRowKeys.value.length} 套试卷?`,
    icon: createVNode(ExclamationCircleOutlined),
    content: createVNode('div', { style: 'color:red;' }, '无作答记录的题目将一并删除；已有作答记录的题目会保留停用，不破坏用户数据。'),
    async onOk() {
      if (record && record.id && !onSelectedRowKeys.value.includes(record.id)) {
        onSelectedRowKeys.value.push(record.id)
      }
      await apiDeletePaper(onSelectedRowKeys.value)
      onSelectedRowKeys.value = []
      getPaperList()
      message.success('删除成功')
    },
  })
}

onMounted(() => {
  getPaperList()
})
</script>
<template>
  <div class="user-body">
    <a-space class="space-box">
      <div class="query-box">
        <a-space :size="23">
          <a-form-item label="试卷标题">
            <a-input class="input" placeholder="请输入试卷标题" v-model:value="params.title" allow-clear
              @press-enter="handleQuery"></a-input>
          </a-form-item>
          <a-form-item label="级别">
            <a-select class="select" placeholder="全部" v-model:value="params.level" allow-clear
              :options="levelOptions"></a-select>
          </a-form-item>
          <a-form-item label="状态">
            <a-select class="select" placeholder="全部" v-model:value="params.status" allow-clear
              :options="statusOptions"></a-select>
          </a-form-item>
          <a-form-item label="年份">
            <a-input-number class="input" placeholder="如 2016" v-model:value="params.examYear" :min="2000"
              :max="2100"></a-input-number>
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
        <a-button type="primary" :icon="h(PlusOutlined)" @click="handleAdd">新建试卷</a-button>
        <a-button :disabled="onSelectedRowKeys.length == 0" danger :icon="h(DeleteOutlined)"
          @click="handleDelete(null)">删除</a-button>
      </a-space>
    </a-form-item>

    <a-table :pagination="{
      current: params.pageNum,
      pageSize: params.pageSize,
      total: total,
      showTotal: (total: any) => `共 ${total} 条`,
      showSizeChanger: true,
    }" @change="handleTableChange" :loading="tableLoading" :dataSource="tableData" :columns="columns" rowKey="id"
      :scroll="{ x: 1450 }"
      :row-selection="{ selectedRowKeys: onSelectedRowKeys, onChange: onSelectChange, fixed: true }">
      <template #bodyCell="{ column, record }">
        <template v-if="column.key === 'level'">
          <a-tag :color="record.level === 6 ? 'purple' : 'blue'">{{ record.level === 6 ? '六级' : '四级' }}</a-tag>
        </template>
        <template v-if="column.key === 'examTime'">
          <span>{{ record.examYear }}年{{ record.examHalf === 2 ? '下' : '上' }}半年</span>
        </template>
        <template v-if="column.key === 'sectionCounts'">
          <a-space :size="4">
            <a-tag v-for="s in sectionMeta" :key="s.key"
              :color="(record.sectionCounts?.[s.key] || 0) >= s.target ? 'green' : 'orange'">
              {{ s.name }} {{ record.sectionCounts?.[s.key] || 0 }}/{{ s.target }}
            </a-tag>
          </a-space>
        </template>
        <template v-if="column.key === 'status'">
          <a-tag :color="statusMap[record.status]?.color">{{ statusMap[record.status]?.text || record.status }}</a-tag>
        </template>
        <template v-if="column.key === 'operation'">
          <a-button type="link" size="small" :icon="h(EditOutlined)" @click="handleEdit(record)">编辑</a-button>
          <a-button v-if="record.status !== 0" type="link" size="small" :icon="h(CloudUploadOutlined)"
            @click="handlePublish(record)">发布</a-button>
          <a-button v-else type="link" size="small" :icon="h(StopOutlined)"
            @click="handleUnpublish(record)">下架</a-button>
          <a-button type="link" size="small" danger :icon="h(DeleteOutlined)"
            @click="handleDelete(record)">删除</a-button>
        </template>
      </template>
    </a-table>

    <a-modal v-model:open="modal" title="新建试卷" :confirm-loading="saveLoading" @ok="onSave" :width="600">
      <a-form ref="formRef" :model="formData" :rules="rules" :label-col="{ span: 5 }" :wrapper-col="{ span: 18 }">
        <a-form-item label="级别" name="level">
          <a-select v-model:value="formData.level" :options="levelOptions"></a-select>
        </a-form-item>
        <a-form-item label="考试年份" name="examYear">
          <a-input-number v-model:value="formData.examYear" :min="2000" :max="2100" style="width: 100%"></a-input-number>
        </a-form-item>
        <a-form-item label="上/下半年" name="examHalf">
          <a-select v-model:value="formData.examHalf" :options="halfOptions"></a-select>
        </a-form-item>
        <a-form-item label="第几套">
          <a-input-number v-model:value="formData.setNo" :min="1" :max="10" style="width: 100%"></a-input-number>
        </a-form-item>
        <a-form-item label="试卷标题" name="title">
          <a-input v-model:value="formData.title" placeholder="请输入试卷标题" @input="manualTitle = true"></a-input>
        </a-form-item>
        <a-form-item label="试卷总分">
          <a-input-number v-model:value="formData.totalScore" :min="0" :max="1000" style="width: 100%"></a-input-number>
        </a-form-item>
        <a-alert type="info" show-icon message="创建后为草稿状态，录入题目并发布后用户前台才可见" />
      </a-form>
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
  }
}

.input {
  width: 130px;
}

.select {
  width: 110px;
}
</style>
