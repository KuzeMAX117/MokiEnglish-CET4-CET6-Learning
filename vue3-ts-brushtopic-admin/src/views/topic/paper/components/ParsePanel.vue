<script setup lang="ts">
import { ref, watch, computed, h } from 'vue'
import { message } from 'ant-design-vue'
import {
  InboxOutlined,
  SnippetsOutlined,
  FileWordOutlined,
  SwapOutlined
} from '@ant-design/icons-vue'
import { apiParsePaperText, apiParsePaperDocx } from '@/api/topic/paper'
import type { PaperSubSectionType, PaperTopicItemType } from '@/api/topic/paper/type'

const props = defineProps<{
  open: boolean
  paperId: number
  /** 当前大板块 */
  section: string
  /** 粘贴模式的目标子板块 */
  subSection?: string
  /** 初始模式 */
  mode: 'text' | 'docx'
}>()

const emit = defineEmits<{
  (e: 'update:open', v: boolean): void
  (e: 'fill', groups: PaperSubSectionType[]): void
}>()

const SECTION_NAME: Record<string, string> = {
  writing: '写作',
  listening: '听力',
  reading: '阅读',
  translation: '翻译'
}

const SUB_SECTION_NAME: Record<string, string> = {
  writing: '写作',
  news: '新闻报道',
  conversation: '长对话',
  passage: '听力篇章',
  cloze: '选词填空',
  matching: '长篇匹配',
  reading_1: '仔细阅读 (一)',
  reading_2: '仔细阅读 (二)',
  translation: '翻译'
}

const localMode = ref<'text' | 'docx'>('text')
const inputText = ref('')
const fileList = ref<any[]>([])
const parsing = ref(false)
const parsed = ref<PaperSubSectionType[]>([])
const warnings = ref<string[]>([])
const rawText = ref('')
const expandedRows = ref<string[]>([])

watch(
  () => props.open,
  (v) => {
    if (v) {
      localMode.value = props.mode
      inputText.value = ''
      fileList.value = []
      parsing.value = false
      parsed.value = []
      warnings.value = []
      rawText.value = ''
      expandedRows.value = []
    }
  }
)

const hasResult = computed(() => parsed.value.length > 0)

/** 全卷连续题号（核对断档用） */
const topicNos = computed(() => {
  const map = new Map<string, number>()
  let n = 0
  parsed.value.forEach((g, gi) => {
    ;(g.topics || []).forEach((t, ti) => {
      map.set(gi + '-' + ti, ++n)
    })
  })
  return map
})

const subSectionName = (key: string) => SUB_SECTION_NAME[key] || key

const sectionName = (key?: string) => (key ? SECTION_NAME[key] || key : '')

/** 判断是否为选词填空类型 */
const isClozeGroup = (group: PaperSubSectionType) => group.subSection === 'cloze'

/** 词汇池操作：更新词库选项内容 */
const updateBankOption = (group: PaperSubSectionType, oi: number, content: string) => {
  if (!group.topics || group.topics.length === 0) return
  const first = group.topics[0]
  if (!first.options || !first.options[oi]) return
  first.options[oi].content = content
  // 同步到所有题目
  for (const t of group.topics) {
    if (t.options && t.options[oi]) {
      t.options[oi].content = content
    }
  }
}

/** 词汇池操作：添加选项 */
const addBankOption = (group: PaperSubSectionType) => {
  if (!group.topics || group.topics.length === 0) return
  const first = group.topics[0]
  if (!first.options) first.options = []
  // 找到下一个字母
  const used = new Set(first.options.map(o => (o.label || '').trim().toUpperCase()))
  let nextLabel = ''
  for (const ch of 'ABCDEFGHIJKLMNO') {
    if (!used.has(ch)) { nextLabel = ch; break }
  }
  if (nextLabel) {
    first.options.push({ label: nextLabel, content: '' })
    // 同步到所有题目
    for (const t of group.topics) {
      if (!t.options) t.options = []
      t.options.push({ label: nextLabel, content: '' })
    }
  }
}

/** 词汇池操作：删除选项 */
const removeBankOption = (group: PaperSubSectionType, oi: number) => {
  if (!group.topics || group.topics.length === 0) return
  const first = group.topics[0]
  if (!first.options) return
  first.options.splice(oi, 1)
  // 同步到所有题目
  for (const t of group.topics) {
    if (t.options) t.options.splice(oi, 1)
  }
}

const applyResult = (data: any) => {
  parsed.value = data?.subSections || []
  warnings.value = data?.warnings || []
  rawText.value = data?.rawText || ''
  expandedRows.value = []
  if (parsed.value.length === 0) {
    message.warning('未解析出题目，请检查文本格式，或改用粘贴方式手工处理')
  }
}

const doParseText = async () => {
  if (!inputText.value.trim()) {
    message.warning('请先粘贴题目文本')
    return
  }
  parsing.value = true
  try {
    const res = await apiParsePaperText({
      section: props.section,
      subSection: props.subSection,
      text: inputText.value
    })
    applyResult(res.data)
  } finally {
    parsing.value = false
  }
}

const handleBeforeUpload = () => false

const doParseDocx = async () => {
  const item = fileList.value[0]
  const file = item?.originFileObj || item
  if (!file) {
    message.warning('请先选择 docx 文件')
    return
  }
  const fd = new FormData()
  fd.append('file', file)
  fd.append('section', props.section)
  fd.append('paperId', String(props.paperId))
  parsing.value = true
  try {
    const res = await apiParsePaperDocx(fd)
    applyResult(res.data)
  } finally {
    parsing.value = false
  }
}

const doParse = () => {
  if (localMode.value === 'text') {
    doParseText()
  } else {
    doParseDocx()
  }
}

/** 把 docx 原始文本转入粘贴模式，供人工处理 */
const switchToText = () => {
  if (!rawText.value) {
    message.warning('没有可用的原始文本')
    return
  }
  localMode.value = 'text'
  inputText.value = rawText.value
  parsed.value = []
  warnings.value = []
}

const isCorrect = (topic: PaperTopicItemType, label: string) =>
  !!topic.correctOption && topic.correctOption.toUpperCase() === (label || '').toUpperCase()

const setCorrect = (topic: PaperTopicItemType, label: string) => {
  if (!label) {
    message.warning('请先填写选项号')
    return
  }
  topic.correctOption = label
}

const nextLabel = (topic: PaperTopicItemType) => {
  const used = new Set((topic.options || []).map((o) => (o.label || '').trim().toUpperCase()))
  for (const ch of 'ABCDEFGHIJKLMNO') {
    if (!used.has(ch)) return ch
  }
  return ''
}

const addOption = (topic: PaperTopicItemType) => {
  if (!topic.options) topic.options = []
  topic.options.push({ label: nextLabel(topic), content: '' })
}

const removeOption = (topic: PaperTopicItemType, oi: number) => {
  topic.options.splice(oi, 1)
}

const removeTopic = (gi: number, ti: number) => {
  parsed.value[gi].topics.splice(ti, 1)
}

const removeGroup = (gi: number) => {
  parsed.value.splice(gi, 1)
}

const close = () => emit('update:open', false)

const handleFill = () => {
  const cleaned: PaperSubSectionType[] = []
  let total = 0
  for (const g of parsed.value) {
    const topics = (g.topics || []).filter(
      (t) => (t.topicName || '').trim() || (t.options && t.options.length > 0)
    )
    if (topics.length === 0 && !(g.article || '').trim()) {
      continue
    }
    cleaned.push({
      section: g.section || props.section,
      subSection: g.subSection,
      article: g.article || '',
      topics
    })
    total += topics.length
  }
  if (cleaned.length === 0) {
    message.warning('没有可填入的内容，请先解析或录入题目')
    return
  }
  emit('fill', cleaned)
  message.success(`已填入 ${total} 题，请在编辑器中核对后保存`)
  emit('update:open', false)
}
</script>
<template>
  <a-modal :open="open" :width="960" :footer="null" title="解析题目（结果仅作为草稿填入编辑器，不直接入库）"
    @cancel="close" :mask-closable="false">
    <div class="parse-panel">
      <!-- 步骤一：选择解析方式 -->
      <div class="parse-step">
        <a-radio-group v-model:value="localMode" :disabled="parsing" button-style="solid">
          <a-radio-button value="text">
            <SnippetsOutlined /> 粘贴文本
          </a-radio-button>
          <a-radio-button value="docx">
            <FileWordOutlined /> 上传 docx
          </a-radio-button>
        </a-radio-group>
        <span class="target-tip">
          目标板块：{{ sectionName(section) }}<template v-if="subSection"> / {{ subSectionName(subSection) }}</template>
          <template v-if="localMode === 'docx'">（解析整个文档，结果会自动分配到对应板块）</template>
        </span>
      </div>

      <!-- 输入区 -->
      <div class="parse-input">
        <template v-if="localMode === 'text'">
          <a-textarea v-model:value="inputText" :rows="7" :disabled="parsing"
            placeholder="将题目文本粘贴到这里（支持题干、选项、答案区，如参考答案 / 【1-5】CBDAA / 1-5:CBDAA）" />
        </template>
        <template v-else>
          <a-upload-dragger v-model:file-list="fileList" :max-count="1" accept=".docx" :before-upload="handleBeforeUpload"
            :disabled="parsing">
            <p class="ant-upload-drag-icon"><InboxOutlined /></p>
            <p class="ant-upload-text">点击或拖拽 docx 文件到此处</p>
            <p class="ant-upload-hint">仅支持 .docx 格式（旧版 .doc 请先另存为 .docx）</p>
          </a-upload-dragger>
        </template>
        <div class="parse-actions">
          <a-button type="primary" :loading="parsing" @click="doParse">
            {{ parsing ? '解析中...' : '开始解析' }}
          </a-button>
          <a-button v-if="rawText" :icon="h(SwapOutlined)" @click="switchToText">原始文本转粘贴模式</a-button>
        </div>
      </div>

      <!-- 警告清单 -->
      <a-alert v-if="warnings.length > 0" type="warning" show-icon class="warn-alert">
        <template #message>解析完成，但有 {{ warnings.length }} 条提示需要核对</template>
        <template #description>
          <div class="warn-list">
            <div v-for="(w, i) in warnings" :key="i">· {{ w }}</div>
          </div>
        </template>
      </a-alert>

      <!-- 解析结果 -->
      <div v-if="hasResult" class="parse-result">
        <div v-for="(group, gi) in parsed" :key="gi" class="group-block">
          <div class="group-head">
            <span class="group-title">
              {{ sectionName(group.section || section) }} / {{ subSectionName(group.subSection) }}
            </span>
            <span class="group-count">{{ group.topics.length }} 题</span>
            <a-button size="small" type="text" danger @click="removeGroup(gi)">删除该组</a-button>
          </div>

          <div v-if="group.article" class="group-article">
            <div class="field-tip">文章原文（{{ group.article.length }} 字）</div>
            <a-textarea v-model:value="group.article" :auto-size="{ minRows: 2, maxRows: 6 }" />
          </div>

          <!-- ========== 选词填空：词汇池模式 ========== -->
          <template v-if="isClozeGroup(group)">
            <!-- 词汇池：统一展示A-O选项 -->
            <div class="word-bank-pool">
              <div class="field-tip">词汇池（公共选项池，编辑后自动同步到所有题目）</div>
              <div class="word-bank-grid">
                <div v-for="(opt, oi) in (group.topics[0]?.options || [])" :key="oi" class="wb-cell">
                  <span class="wb-label-tag">{{ opt.label }}</span>
                  <a-input class="wb-input" :value="opt.content" placeholder="选项内容" size="small"
                    @input="(e: any) => updateBankOption(group, oi, e.target.value)" />
                  <a-button size="small" type="text" danger @click="removeBankOption(group, oi)">删</a-button>
                </div>
              </div>
              <a-button size="small" type="dashed" @click="addBankOption(group)" style="margin-top: 8px">
                + 添加选项
              </a-button>
            </div>

            <!-- 题目列表：每题用下拉框选答案 -->
            <div v-for="(topic, ti) in group.topics" :key="ti" class="topic-block">
              <div class="topic-head" @click="expandedRows.includes(gi + '-' + ti)
                ? (expandedRows = expandedRows.filter((k) => k !== gi + '-' + ti))
                : expandedRows.push(gi + '-' + ti)">
                <span class="topic-no">第 {{ topicNos.get(gi + '-' + ti) }} 题</span>
                <span class="topic-brief">{{ (topic.topicName || '（题干为空）').slice(0, 60) }}</span>
                <a-tag v-if="topic.warning" color="orange">{{ topic.warning }}</a-tag>
                <a-tag v-else-if="topic.correctOption" color="green">有答案</a-tag>
                <a-tag v-else color="red">缺答案</a-tag>
                <a-button size="small" type="text" danger class="del-btn" @click.stop="removeTopic(gi, ti)">删除</a-button>
              </div>

              <div v-if="expandedRows.includes(gi + '-' + ti)" class="topic-body">
                <div class="field-tip">题干</div>
                <a-textarea v-model:value="topic.topicName" :auto-size="{ minRows: 2, maxRows: 6 }" />

                <div class="field-tip">选择正确答案</div>
                <a-select
                  :value="topic.correctOption || undefined"
                  placeholder="请选择正确答案"
                  style="width: 100%"
                  @update:value="(v: any) => { topic.correctOption = v }"
                  allowClear
                >
                  <a-select-option v-for="opt in (group.topics[0]?.options || [])" :key="opt.label" :value="opt.label">
                    <b>{{ opt.label }}</b> &nbsp; {{ opt.content }}
                  </a-select-option>
                </a-select>

                <div class="field-tip">解析（可选）</div>
                <a-textarea v-model:value="topic.analysis" :auto-size="{ minRows: 1, maxRows: 4 }" />
              </div>
            </div>
          </template>

          <!-- ========== 其他题型：普通选项模式 ========== -->
          <template v-else>
            <div v-for="(topic, ti) in group.topics" :key="ti" class="topic-block">
              <div class="topic-head" @click="expandedRows.includes(gi + '-' + ti)
                ? (expandedRows = expandedRows.filter((k) => k !== gi + '-' + ti))
                : expandedRows.push(gi + '-' + ti)">
                <span class="topic-no">第 {{ topicNos.get(gi + '-' + ti) }} 题</span>
                <span class="topic-brief">{{ (topic.topicName || '（题干为空）').slice(0, 60) }}</span>
                <a-tag v-if="topic.warning" color="orange">{{ topic.warning }}</a-tag>
                <a-tag v-else-if="topic.options && topic.options.length" color="green">{{ topic.correctOption ?
                  '有答案' : '缺答案' }}</a-tag>
                <a-button size="small" type="text" danger class="del-btn" @click.stop="removeTopic(gi, ti)">删除</a-button>
              </div>

              <div v-if="expandedRows.includes(gi + '-' + ti)" class="topic-body">
                <div class="field-tip">题干</div>
                <a-textarea v-model:value="topic.topicName" :auto-size="{ minRows: 2, maxRows: 6 }" />

                <div class="field-tip">选项（点"答案"按钮设为正确答案）</div>
                <div v-for="(opt, oi) in topic.options" :key="oi" class="opt-row">
                  <a-input v-model:value="opt.label" class="opt-label" placeholder="A" />
                  <a-input v-model:value="opt.content" placeholder="选项内容" />
                  <a-button size="small" :type="isCorrect(topic, opt.label) ? 'primary' : 'default'"
                    @click="setCorrect(topic, opt.label)">答案</a-button>
                  <a-button size="small" type="text" danger @click="removeOption(topic, oi)">删</a-button>
                </div>
                <a-button size="small" type="dashed" @click="addOption(topic)">+ 添加选项</a-button>

                <div class="field-tip">正确答案（如 A / AB / JGOKB，最多 5 字符）</div>
                <a-input v-model:value="topic.correctOption" style="width: 220px" :maxlength="5" />

                <div class="field-tip">解析（可选）</div>
                <a-textarea v-model:value="topic.analysis" :auto-size="{ minRows: 1, maxRows: 4 }" />
              </div>
            </div>
          </template>
        </div>
      </div>

      <div v-else-if="!parsing" class="empty-result">
        解析结果将显示在这里，逐条核对（可展开修改）后点击"填入编辑器"
      </div>

      <div class="panel-footer">
        <a-space>
          <a-button @click="close">取消</a-button>
          <a-button type="primary" :disabled="!hasResult" @click="handleFill">填入编辑器</a-button>
        </a-space>
      </div>
    </div>
  </a-modal>
</template>
<style lang="scss" scoped>
.parse-panel {
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.parse-step {
  display: flex;
  align-items: center;
  gap: 16px;
  flex-wrap: wrap;

  .target-tip {
    font-size: 13px;
    color: #70757a;
  }
}

.parse-input {
  display: flex;
  flex-direction: column;
  gap: 10px;

  .parse-actions {
    display: flex;
    gap: 10px;
  }
}

.warn-alert {
  .warn-list {
    max-height: 120px;
    overflow-y: auto;
    font-size: 12px;
    line-height: 1.8;
  }
}

.parse-result {
  max-height: 46vh;
  overflow-y: auto;
  border: 1px solid #e8eaed;
  border-radius: 10px;
  padding: 12px;

  .group-block {
    margin-bottom: 16px;

    &:last-child {
      margin-bottom: 0;
    }

    .group-head {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 6px 0 10px;
      border-bottom: 1px solid #e8eaed;

      .group-title {
        font-weight: 600;
        color: #1a1a1a;
      }

      .group-count {
        font-size: 12px;
        color: #70757a;
      }
    }

    .group-article {
      margin-top: 8px;
    }
  }

  .topic-block {
    border: 1px solid #e8eaed;
    border-radius: 8px;
    margin-top: 10px;
    overflow: hidden;

    .topic-head {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 8px 12px;
      cursor: pointer;
      background: #f7f8fa;

      &:hover {
        background: #f0f2f7;
      }

      .topic-no {
        font-size: 12px;
        color: #70757a;
        flex-shrink: 0;
      }

      .topic-brief {
        flex: 1;
        font-size: 13px;
        color: #444;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }

      .del-btn {
        flex-shrink: 0;
      }
    }

    .topic-body {
      padding: 12px;
      display: flex;
      flex-direction: column;
      gap: 6px;

      .field-tip {
        font-size: 12px;
        color: #70757a;
        margin-top: 4px;
      }

      .opt-row {
        display: flex;
        gap: 8px;
        align-items: center;

        .opt-label {
          width: 56px;
          flex-shrink: 0;
        }
      }
    }
  }
}

.empty-result {
  text-align: center;
  color: #b0b4bb;
  font-size: 13px;
  padding: 28px 0;
  border: 1px dashed #e8eaed;
  border-radius: 10px;
}

.panel-footer {
  display: flex;
  justify-content: flex-end;
  padding-top: 6px;
  border-top: 1px solid #f0f0f0;
}

/* 选词填空：词汇池样式 */
.word-bank-pool {
  margin: 10px 0;
  padding: 10px;
  background: #f6f8fa;
  border: 1px dashed #d0d7de;
  border-radius: 8px;

  .field-tip {
    font-size: 12px;
    color: #70757a;
    margin-bottom: 8px;
  }
}

.word-bank-grid {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 8px;

  .wb-cell {
    display: flex;
    align-items: center;
    gap: 4px;

    .wb-label-tag {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      width: 22px;
      height: 22px;
      background: #e6f7ff;
      border: 1px solid #91d5ff;
      border-radius: 4px;
      font-size: 12px;
      font-weight: 600;
      color: #1890ff;
      flex-shrink: 0;
    }

    .wb-input {
      flex: 1;
      min-width: 0;
    }
  }
}
</style>
