<script setup lang="ts">
import { ref, computed, onMounted, watch, h, createVNode } from 'vue'
import { useRoute, useRouter, onBeforeRouteLeave } from 'vue-router'
import { message, Modal } from 'ant-design-vue'
import {
  LeftOutlined,
  SaveOutlined,
  CloudUploadOutlined,
  StopOutlined,
  EyeOutlined,
  EyeInvisibleOutlined,
  PlusOutlined,
  DeleteOutlined,
  ArrowUpOutlined,
  ArrowDownOutlined,
  EditOutlined,
  CheckOutlined,
  SnippetsOutlined,
  FileWordOutlined,
  WarningOutlined,
  ExclamationCircleOutlined
} from '@ant-design/icons-vue'
import PaperPreview from './components/PaperPreview.vue'
import ParsePanel from './components/ParsePanel.vue'
import {
  apiGetPaperManageDetail,
  apiSavePaperSection,
  apiPublishPaper,
  apiUnpublishPaper,
  apiUpdatePaper
} from '@/api/topic/paper'
import type {
  PaperSubSectionType,
  PaperTopicItemType,
  PaperManageSectionType
} from '@/api/topic/paper/type'

const route = useRoute()
const router = useRouter()
const paperId = Number(route.params.id)

/* ============ 板块元数据 ============ */

const SECTION_LIST = [
  { key: 'writing', name: '写作', target: 1 },
  { key: 'listening', name: '听力', target: 25 },
  { key: 'reading', name: '阅读', target: 30 },
  { key: 'translation', name: '翻译', target: 1 }
]

const SUB_SECTION_MAP: Record<string, { key: string; name: string }[]> = {
  writing: [{ key: 'writing', name: '写作' }],
  listening: [
    { key: 'news', name: '新闻报道' },
    { key: 'conversation', name: '长对话' },
    { key: 'passage', name: '听力篇章' }
  ],
  reading: [
    { key: 'cloze', name: '选词填空' },
    { key: 'matching', name: '长篇匹配' },
    { key: 'reading_1', name: '仔细阅读 (一)' },
    { key: 'reading_2', name: '仔细阅读 (二)' }
  ],
  translation: [{ key: 'translation', name: '翻译' }]
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

const GROUP_ARTICLE_SECTIONS = new Set(['cloze', 'matching', 'reading_1', 'reading_2'])
const TOPIC_ARTICLE_SECTIONS = new Set(['news', 'conversation', 'passage'])

/** 选词填空 / 长篇匹配 */
const useWordBank = (group: PaperSubSectionType) => {
  return group.subSection === 'cloze' || group.subSection === 'matching'
}

const statusMap: any = {
  0: { text: '已发布', color: 'green' },
  1: { text: '已下架', color: 'red' },
  2: { text: '草稿', color: 'orange' }
}

/* ============ 页面状态 ============ */

const loading = ref(true)
const saving = ref(false)
const detail = ref<any>(null)
const activeSection = ref('writing')
const previewOpen = ref(true)
const previewIndex = ref(0)
const lastWarnings = ref<string[]>([])

const sectionGroups = ref<Record<string, PaperSubSectionType[]>>({})
const dirtyMap = ref<Record<string, boolean>>({})

const dirtySections = computed(() =>
  SECTION_LIST.filter((s) => dirtyMap.value[s.key])
)

const currentGroups = computed<PaperSubSectionType[]>(
  () => sectionGroups.value[activeSection.value] || []
)

const activeSectionMeta = computed(
  () => SECTION_LIST.find((s) => s.key === activeSection.value)!
)

/* ============ 数据装载 ============ */

const createEmptyGroups = (): Record<string, PaperSubSectionType[]> => {
  const groups: Record<string, PaperSubSectionType[]> = {}
  for (const s of SECTION_LIST) {
    groups[s.key] = SUB_SECTION_MAP[s.key].map((sub) => ({
      subSection: sub.key,
      article: '',
      topics: []
    }))
  }
  return groups
}

const buildGroupsFromDetail = (data: any): Record<string, PaperSubSectionType[]> => {
  const groups = createEmptyGroups()
  for (const sec of data.sections || []) {
    const key = sec.section
    if (!groups[key]) groups[key] = []
    let g = groups[key].find((x) => x.subSection === (sec.subSection || ''))
    if (!g) {
      g = { subSection: sec.subSection || '', article: '', topics: [] }
      groups[key].push(g)
    }
    const isGroupArticle = GROUP_ARTICLE_SECTIONS.has(g.subSection)
    g.topics = (sec.topics || []).map((t: any) => ({
      topicId: t.topicId,
      topicName: t.topicName || '',
      options: (t.options || []).map((o: any) => ({ label: o.label || '', content: o.content || '' })),
      correctOption: t.correctOption || '',
      answer: t.answer || '',
      analysis: t.analysis || '',
      article: isGroupArticle ? '' : t.article || ''
    }))
    if (isGroupArticle && !g.article) {
      const first = (sec.topics || []).find((t: any) => t.article && t.article.trim())
      if (first) g.article = first.article
    }
  }
  return groups
}

const loadDetail = async () => {
  loading.value = true
  try {
    const res = await apiGetPaperManageDetail(paperId)
    detail.value = res.data
    sectionGroups.value = buildGroupsFromDetail(res.data)
    dirtyMap.value = { writing: false, listening: false, reading: false, translation: false }
    lastWarnings.value = []
    locatePreview()
  } finally {
    loading.value = false
  }
}

/* ============ 编辑操作 ============ */

const markDirty = () => {
  dirtyMap.value[activeSection.value] = true
}

const topicNo = (gi: number, ti: number) => {
  let n = ti + 1
  for (let i = 0; i < gi; i++) {
    n += currentGroups.value[i].topics.length
  }
  return n
}

const addTopic = (gi: number) => {
  currentGroups.value[gi].topics.push({
    topicId: null,
    topicName: '',
    options: [],
    correctOption: '',
    answer: '',
    analysis: '',
    article: ''
  })
  markDirty()
}

const removeTopic = (gi: number, ti: number) => {
  currentGroups.value[gi].topics.splice(ti, 1)
  markDirty()
}

const moveTopic = (gi: number, ti: number, delta: number) => {
  const topics = currentGroups.value[gi].topics
  const target = ti + delta
  if (target < 0 || target >= topics.length) return
  const tmp = topics[ti]
  topics[ti] = topics[target]
  topics[target] = tmp
  markDirty()
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
  markDirty()
}

const removeOption = (topic: PaperTopicItemType, oi: number) => {
  topic.options.splice(oi, 1)
  markDirty()
}

const isCorrectOpt = (topic: PaperTopicItemType, optLabel: string) =>
  !!topic.correctOption &&
  !!optLabel &&
  topic.correctOption.trim().toUpperCase() === optLabel.trim().toUpperCase()

const setCorrect = (topic: PaperTopicItemType, optLabel: string) => {
  if (!optLabel || !optLabel.trim()) {
    message.warning('请先填写选项号')
    return
  }
  topic.correctOption = optLabel.trim().toUpperCase()
  markDirty()
}

/* ============ 词库操作 ============ */

const syncWordBankToTopics = (group: PaperSubSectionType) => {
  if (!useWordBank(group) || group.topics.length === 0) return
  const bankOpts = group.topics[0].options || []
  for (const t of group.topics) {
    t.options = bankOpts.map((o) => ({ ...o }))
  }
}

const addWordBankOption = (group: PaperSubSectionType) => {
  if (group.topics.length === 0) return
  const first = group.topics[0]
  if (!first.options) first.options = []
  const label = nextLabel(first)
  if (label) {
    first.options.push({ label, content: '' })
    syncWordBankToTopics(group)
    markDirty()
  }
}

const removeWordBankOption = (group: PaperSubSectionType, oi: number) => {
  if (group.topics.length === 0) return
  const first = group.topics[0]
  if (!first.options) return
  first.options.splice(oi, 1)
  syncWordBankToTopics(group)
  markDirty()
}

const updateWordBankOption = (group: PaperSubSectionType, oi: number, content: string) => {
  if (group.topics.length === 0) return
  const first = group.topics[0]
  if (!first.options || !first.options[oi]) return
  first.options[oi].content = content
  syncWordBankToTopics(group)
  markDirty()
}

const updateWordBankLabel = (group: PaperSubSectionType, oi: number, label: string) => {
  if (group.topics.length === 0) return
  const first = group.topics[0]
  if (!first.options || !first.options[oi]) return
  first.options[oi].label = label.trim().toUpperCase()
  syncWordBankToTopics(group)
  markDirty()
}

const sectionCount = (key: string) =>
  (sectionGroups.value[key] || []).reduce((n, g) => n + g.topics.length, 0)

const topicNamePlaceholder = (subSection: string) => {
  if (subSection === 'writing') return '写作题目要求（Directions），如：For this part, you are allowed 30 minutes to write an essay...'
  if (subSection === 'translation') return '翻译题目原文（中文段落）'
  if (TOPIC_ARTICLE_SECTIONS.has(subSection)) return '题干'
  return '题干'
}

/* ============ 板块切换 ============ */

const switchSection = (key: string) => {
  if (key === activeSection.value) return
  if (dirtyMap.value[activeSection.value]) {
    Modal.confirm({
      title: '当前板块有未保存的修改',
      icon: createVNode(ExclamationCircleOutlined),
      content: '修改仍保留在本地，随时可以回来保存。确定切换到其他板块吗？',
      okText: '确定切换',
      cancelText: '留在本板块',
      onOk() {
        activeSection.value = key
      }
    })
    return
  }
  activeSection.value = key
}

/* ============ 保存 ============ */

const deepClone = <T,>(v: T): T => JSON.parse(JSON.stringify(v))

const reloadKeepOthers = async (savedSection: string) => {
  const res = await apiGetPaperManageDetail(paperId)
  detail.value = res.data
  const fresh = buildGroupsFromDetail(res.data)
  const merged: Record<string, PaperSubSectionType[]> = { ...fresh }
  for (const s of SECTION_LIST) {
    if (s.key !== savedSection && dirtyMap.value[s.key]) {
      merged[s.key] = sectionGroups.value[s.key]
    }
  }
  sectionGroups.value = merged
}

const handleSave = () => {
  const sec = activeSection.value
  const groups = sectionGroups.value[sec] || []
  const subSections: PaperSubSectionType[] = []
  let skippedEmpty = 0

  for (const g of groups) {
    const topics: PaperTopicItemType[] = []
    for (const t of g.topics) {
      const isEmpty =
        !(t.topicName || '').trim() &&
        (!t.options || t.options.length === 0) &&
        !(t.correctOption || '').trim() &&
        !(t.answer || '').trim() &&
        !(t.analysis || '').trim() &&
        !(t.article || '').trim()
      if (isEmpty) {
        skippedEmpty++
        continue
      }
      topics.push({
        topicName: (t.topicName || '').trim(),
        options: (t.options || []).filter(
          (o) => (o.label || '').trim() !== '' || (o.content || '').trim() !== ''
        ),
        correctOption: (t.correctOption || '').trim(),
        answer: t.answer || '',
        analysis: t.analysis || '',
        article: TOPIC_ARTICLE_SECTIONS.has(g.subSection) ? t.article || '' : ''
      })
    }
    if (topics.length === 0 && !(g.article || '').trim()) {
      continue
    }
    subSections.push({
      subSection: g.subSection,
      article: GROUP_ARTICLE_SECTIONS.has(g.subSection) ? g.article || '' : '',
      topics
    })
  }

  if (subSections.every((s) => s.topics.length === 0)) {
    Modal.confirm({
      title: `确定清空【${activeSectionMeta.value.name}】板块吗?`,
      icon: createVNode(ExclamationCircleOutlined),
      content: createVNode('div', { style: 'color:red;' }, '保存后将删除该板块已录入的所有题目；已有用户作答记录的题目会保留停用，不影响用户数据。'),
      okText: '确定清空',
      okType: 'danger',
      onOk: () => doSave(subSections, skippedEmpty)
    })
    return
  }
  doSave(subSections, skippedEmpty)
}

const doSave = async (subSections: PaperSubSectionType[], skippedEmpty: number) => {
  const sec = activeSection.value
  saving.value = true
  try {
    const res = await apiSavePaperSection({ paperId, section: sec, subSections })
    const warnings: string[] = res.data?.warnings || []
    lastWarnings.value = warnings
    dirtyMap.value[sec] = false
    const savedCount = res.data?.savedCount ?? 0
    message.success(`已保存 ${savedCount} 题${skippedEmpty > 0 ? `，忽略 ${skippedEmpty} 道空白题` : ''}`)
    await reloadKeepOthers(sec)
    locatePreview()
  } finally {
    saving.value = false
  }
}

/* ============ 发布 / 下架 ============ */

const doPublish = async () => {
  const res = await apiPublishPaper(paperId)
  const warnings: string[] = res.data?.warnings || []
  if (detail.value) detail.value.status = 0
  if (warnings.length > 0) {
    Modal.info({
      title: '发布成功，但存在以下问题建议核对',
      width: 560,
      content: () => h('div', warnings.map((w: string) => h('div', { style: 'margin-bottom: 4px;' }, w)))
    })
  } else {
    message.success('发布成功，用户前台已可见')
  }
}

const handlePublish = () => {
  if (dirtySections.value.length > 0) {
    Modal.confirm({
      title: '有未保存的板块',
      icon: createVNode(ExclamationCircleOutlined),
      content: `以下板块有未保存修改：${dirtySections.value.map((s) => s.name).join('、')}。未保存的内容不会被发布，建议先保存。仍要发布吗？`,
      okText: '仍要发布',
      cancelText: '返回保存',
      onOk() {
        doPublish()
      }
    })
    return
  }
  doPublish()
}

const handleUnpublish = () => {
  Modal.confirm({
    title: '确认下架该试卷?',
    icon: createVNode(ExclamationCircleOutlined),
    content: '下架后用户前台不可见，已有答题记录不受影响',
    async onOk() {
      await apiUnpublishPaper(paperId)
      if (detail.value) detail.value.status = 1
      message.success('已下架')
    }
  })
}

/* ============ 修改基本信息 ============ */

const infoModal = ref(false)
const infoSaving = ref(false)
const infoForm = ref<any>({
  level: 4,
  examYear: new Date().getFullYear(),
  examHalf: 1,
  title: '',
  totalScore: 710
})

const openInfoModal = () => {
  infoForm.value = {
    level: detail.value.level,
    examYear: detail.value.examYear,
    examHalf: detail.value.examHalf,
    title: detail.value.title,
    totalScore: detail.value.totalScore
  }
  infoModal.value = true
}

const saveInfo = async () => {
  if (!infoForm.value.title || !infoForm.value.title.trim()) {
    message.warning('试卷标题不能为空')
    return
  }
  infoSaving.value = true
  try {
    await apiUpdatePaper({ id: paperId, ...infoForm.value, title: infoForm.value.title.trim() })
    detail.value = { ...detail.value, ...infoForm.value }
    infoModal.value = false
    message.success('基本信息已更新')
  } finally {
    infoSaving.value = false
  }
}

/* ============ 解析面板 ============ */

const parseVisible = ref(false)
const parseMode = ref<'text' | 'docx'>('text')
const parseSubSection = ref('')

const openParse = (subSection: string, mode: 'text' | 'docx') => {
  parseSubSection.value = subSection
  parseMode.value = mode
  parseVisible.value = true
}

const handleParseFill = (groups: PaperSubSectionType[]) => {
  const applyFill = (replace: boolean) => {
    let added = 0
    const affected = new Set<string>()
    for (const sub of groups) {
      const secKey = sub.section || activeSection.value
      const list = sectionGroups.value[secKey]
      if (!list) continue
      let g = list.find((x) => x.subSection === sub.subSection)
      if (!g) {
        g = { subSection: sub.subSection, article: '', topics: [] }
        list.push(g)
      }
      if (replace) {
        g.topics = []
        g.article = sub.article || ''
      } else if (sub.article && !g.article) {
        g.article = sub.article
      }
      for (const t of sub.topics) {
        g.topics.push({
          ...t,
          options: (t.options || []).map((o) => ({ ...o }))
        })
        added++
      }
      affected.add(secKey)
    }
    affected.forEach((k) => (dirtyMap.value[k] = true))
    message.success(`解析内容已填入编辑器（共 ${added} 题），请核对后点击"保存本板块"`)
  }

  const targetSubs = new Set(groups.map((g) => g.subSection))
  const conflict = SECTION_LIST.some((s) =>
    (sectionGroups.value[s.key] || []).some(
      (g) => targetSubs.has(g.subSection) && g.topics.length > 0
    )
  )
  if (conflict) {
    Modal.confirm({
      title: '目标子板块已有题目',
      icon: createVNode(ExclamationCircleOutlined),
      content: '解析结果如何填入？"追加"保留现有题目并在末尾添加；"清空替换"将清空目标子板块现有题目后填入。',
      okText: '追加',
      cancelText: '清空替换',
      onOk() {
        applyFill(false)
      },
      onCancel() {
        applyFill(true)
      }
    })
  } else {
    applyFill(false)
  }
}

/* ============ 预览联动 ============ */

const previewSections = computed<PaperManageSectionType[]>(() => {
  const result: PaperManageSectionType[] = []
  for (const s of SECTION_LIST) {
    for (const g of sectionGroups.value[s.key] || []) {
      const topics = g.topics.filter(
        (t) => (t.topicName || '').trim() !== '' || (t.options && t.options.length > 0)
      )
      if (topics.length === 0 && !(g.article || '').trim()) continue
      const isGroupArticle = GROUP_ARTICLE_SECTIONS.has(g.subSection)
      result.push({
        section: s.key,
        subSection: g.subSection,
        topics: topics.map((t) => ({
          ...t,
          article: isGroupArticle ? g.article || '' : t.article || ''
        }))
      })
    }
  }
  return result
})

const locatePreview = () => {
  const idx = previewSections.value.findIndex((s) => s.section === activeSection.value)
  previewIndex.value = idx >= 0 ? idx : 0
}

watch(activeSection, () => {
  locatePreview()
})

/* ============ 离开确认 ============ */

const onBack = () => {
  router.push('/topic/paper')
}

onBeforeRouteLeave(() => {
  if (dirtySections.value.length === 0) {
    return true
  }
  return new Promise<boolean>((resolve) => {
    Modal.confirm({
      title: '有未保存的修改',
      icon: createVNode(ExclamationCircleOutlined),
      content: `以下板块尚未保存：${dirtySections.value.map((s) => s.name).join('、')}。离开将丢失这些修改，确定离开吗？`,
      okText: '确定离开',
      okType: 'danger',
      cancelText: '继续编辑',
      onOk() {
        resolve(true)
      },
      onCancel() {
        resolve(false)
      }
    })
  })
})

onMounted(() => {
  loadDetail()
})
</script>
<template>
  <div class="editor-page">
    <a-spin :spinning="loading" wrapper-class-name="editor-spin">
      <div class="editor-head">
        <a-button size="small" @click="onBack">
          <LeftOutlined /> 返回列表
        </a-button>
        <template v-if="detail">
          <a-tag :color="statusMap[detail.status]?.color">{{ statusMap[detail.status]?.text }}</a-tag>
          <span class="paper-title" :title="detail.title">{{ detail.title }}</span>
          <span class="paper-meta">
            {{ detail.level === 6 ? '六级' : '四级' }} · {{ detail.examYear }}年{{ detail.examHalf === 2 ? '下' : '上' }}半年
          </span>
        </template>
        <div class="head-actions">
          <a-button :icon="h(EditOutlined)" @click="openInfoModal">修改信息</a-button>
          <a-button @click="previewOpen = !previewOpen">
            <EyeInvisibleOutlined v-if="previewOpen" />
            <EyeOutlined v-else />
            {{ previewOpen ? '关闭预览' : '打开预览' }}
          </a-button>
          <a-button type="primary" :loading="saving" :icon="h(SaveOutlined)" @click="handleSave">保存本板块</a-button>
          <a-button v-if="detail?.status === 0" danger :icon="h(StopOutlined)" @click="handleUnpublish">下架</a-button>
          <a-button v-else type="primary" ghost :icon="h(CloudUploadOutlined)" @click="handlePublish">发布</a-button>
        </div>
      </div>

      <div class="editor-main">
        <div class="section-nav">
          <div v-for="s in SECTION_LIST" :key="s.key" class="nav-item"
            :class="{ active: activeSection === s.key }" @click="switchSection(s.key)">
            <div class="nav-name">
              {{ s.name }}
              <span v-if="dirtyMap[s.key]" class="dirty-dot" title="有未保存的修改"></span>
            </div>
            <div class="nav-count"
              :class="sectionCount(s.key) >= s.target ? 'ok' : (sectionCount(s.key) > 0 ? 'part' : '')">
              {{ sectionCount(s.key) }}/{{ s.target }}
            </div>
          </div>
          <div class="nav-tip">达标线：写作1 / 听力25 / 阅读30 / 翻译1</div>
        </div>

        <div class="edit-area">
          <div v-if="lastWarnings.length > 0" class="warn-bar">
            <WarningOutlined class="warn-icon" />
            <div class="warn-list">
              <div v-for="(w, i) in lastWarnings" :key="i">{{ w }}</div>
            </div>
            <a-button type="text" size="small" @click="lastWarnings = []">关闭</a-button>
          </div>

          <div v-for="(group, gi) in currentGroups" :key="group.subSection" class="sub-group">
            <div class="group-head">
              <span class="group-name">{{ SUB_SECTION_NAME[group.subSection] || group.subSection }}</span>
              <span class="group-count">{{ group.topics.length }} 题</span>
            </div>

            <!-- 组级文章 -->
            <div v-if="GROUP_ARTICLE_SECTIONS.has(group.subSection)" class="group-article">
              <div class="field-label">文章原文（本子板块所有题目共用）</div>
              <a-textarea v-model:value="group.article" :auto-size="{ minRows: 3, maxRows: 10 }" @input="markDirty()"
                placeholder="粘贴文章原文，保存后前台左侧文章面板显示" />
            </div>

            <!-- ========== 选词填空 / 长篇匹配：question-scroll 模式 ========== -->
            <div v-if="useWordBank(group)" class="question-scroll">

              <!-- 选项池：半透明固定展示，5个一行 -->
              <div class="word-bank-pool">
                <div class="field-label">选项词库（公共选项池，编辑后自动同步到所有题目）</div>
                <div class="word-bank-grid">
                  <div v-for="(opt, oi) in (group.topics[0]?.options || [])" :key="oi" class="wb-cell">
                    <span class="wb-label-tag">{{ opt.label }}</span>
                    <a-input class="wb-input" :value="opt.content" placeholder="选项内容" size="small"
                      @input="(e: any) => updateWordBankOption(group, oi, e.target.value)" />
                  </div>
                </div>
                <a-button size="small" type="dashed" :icon="h(PlusOutlined)" @click="addWordBankOption(group)"
                  style="margin-top: 8px">
                  添加选项
                </a-button>
              </div>

              <!-- 题目列表：每题用下拉框选答案 -->
              <div v-for="(topic, ti) in group.topics" :key="ti" class="topic-card">
                <div class="topic-head">
                  <span class="topic-no">第 {{ topicNo(gi, ti) }} 题</span>
                  <a-space :size="2">
                    <a-button size="small" type="text" :icon="h(ArrowUpOutlined)" :disabled="ti === 0"
                      @click="moveTopic(gi, ti, -1)" />
                    <a-button size="small" type="text" :icon="h(ArrowDownOutlined)"
                      :disabled="ti === group.topics.length - 1" @click="moveTopic(gi, ti, 1)" />
                    <a-button size="small" type="text" danger :icon="h(DeleteOutlined)"
                      @click="removeTopic(gi, ti)" />
                  </a-space>
                </div>

                <a-textarea v-model:value="topic.topicName" :auto-size="{ minRows: 2, maxRows: 6 }" @input="markDirty()"
                  placeholder="题干" />

                <!-- 下拉框选答案 -->
                <div class="word-bank-select">
                  <div class="field-label">选择正确答案</div>
                  <a-select
                    :value="topic.correctOption || undefined"
                    placeholder="请选择正确答案"
                    style="width: 100%"
                    @update:value="(v: any) => { topic.correctOption = v; markDirty() }"
                    allowClear
                  >
                    <a-select-option v-for="opt in (group.topics[0]?.options || [])" :key="opt.label" :value="opt.label">
                      <b>{{ opt.label }}</b> &nbsp; {{ opt.content }}
                    </a-select-option>
                  </a-select>
                </div>

                <div class="answer-textarea-row">
                  <div class="field-label">参考答案（可选）</div>
                  <a-textarea v-model:value="topic.answer" :auto-size="{ minRows: 2, maxRows: 6 }" @input="markDirty()"
                    placeholder="主观题参考答案，支持多行输入" />
                </div>
                <div class="analysis-row">
                  <div class="field-label">解析（可选）</div>
                  <a-textarea v-model:value="topic.analysis" :auto-size="{ minRows: 1, maxRows: 4 }" @input="markDirty()"
                    placeholder="题目解析" />
                </div>
              </div>
            </div>

            <!-- ========== 其他板块：普通模式 ========== -->
            <template v-else>
              <div v-for="(topic, ti) in group.topics" :key="ti" class="topic-card">
                <div class="topic-head">
                  <span class="topic-no">第 {{ topicNo(gi, ti) }} 题</span>
                  <a-space :size="2">
                    <a-button size="small" type="text" :icon="h(ArrowUpOutlined)" :disabled="ti === 0"
                      @click="moveTopic(gi, ti, -1)" />
                    <a-button size="small" type="text" :icon="h(ArrowDownOutlined)"
                      :disabled="ti === group.topics.length - 1" @click="moveTopic(gi, ti, 1)" />
                    <a-button size="small" type="text" danger :icon="h(DeleteOutlined)"
                      @click="removeTopic(gi, ti)" />
                  </a-space>
                </div>

                <a-textarea v-model:value="topic.topicName" :auto-size="{ minRows: 2, maxRows: 6 }" @input="markDirty()"
                  :placeholder="topicNamePlaceholder(group.subSection)" />

                <!-- 题级文章 -->
                <div v-if="TOPIC_ARTICLE_SECTIONS.has(group.subSection)" class="topic-article">
                  <div class="field-label">听力材料（本题对应的原文）</div>
                  <a-textarea v-model:value="topic.article" :auto-size="{ minRows: 2, maxRows: 8 }"
                    @input="markDirty()" placeholder="该题对应的听力材料原文（对话题/新闻稿/篇章）" />
                </div>

                <!-- 选项编辑 -->
                <div class="options-editor">
                  <div v-for="(opt, oi) in topic.options" :key="oi" class="option-row">
                    <a-input class="opt-label" v-model:value="opt.label" @input="markDirty()" placeholder="A" />
                    <a-input class="opt-content" v-model:value="opt.content" @input="markDirty()" placeholder="选项内容" />
                    <a-button size="small" class="opt-ans"
                      :type="isCorrectOpt(topic, opt.label) ? 'primary' : 'default'" @click="setCorrect(topic, opt.label)">
                      <CheckOutlined v-if="isCorrectOpt(topic, opt.label)" />
                      <span v-else>设答案</span>
                    </a-button>
                    <a-button size="small" type="text" danger :icon="h(DeleteOutlined)"
                      @click="removeOption(topic, oi)" />
                  </div>
                  <a-button size="small" type="dashed" :icon="h(PlusOutlined)" @click="addOption(topic)">添加选项</a-button>
                </div>

                <!-- 答案与解析 -->
                <div class="answer-row">
                  <span class="field-label">正确答案</span>
                  <a-input v-model:value="topic.correctOption" @input="markDirty()"
                    placeholder="如 A / AB / JGOKB，最多5个字符" style="width: 230px" />
                </div>
                <div class="answer-textarea-row">
                  <div class="field-label">参考答案（可选）</div>
                  <a-textarea v-model:value="topic.answer" :auto-size="{ minRows: 2, maxRows: 6 }" @input="markDirty()"
                    placeholder="主观题参考答案，支持多行输入" />
                </div>
                <div class="analysis-row">
                  <div class="field-label">解析（可选）</div>
                  <a-textarea v-model:value="topic.analysis" :auto-size="{ minRows: 1, maxRows: 4 }" @input="markDirty()"
                    placeholder="题目解析" />
                </div>
              </div>
            </template>

            <!-- 组操作 -->
            <div class="group-actions">
              <a-button size="small" :icon="h(PlusOutlined)" @click="addTopic(gi)">加题</a-button>
              <a-button size="small" :icon="h(SnippetsOutlined)" @click="openParse(group.subSection, 'text')">批量粘贴</a-button>
              <a-button size="small" :icon="h(FileWordOutlined)" @click="openParse(group.subSection, 'docx')">上传
                docx</a-button>
            </div>
          </div>
        </div>

        <div v-if="previewOpen" class="preview-area">
          <PaperPreview :sections="previewSections" v-model:active-index="previewIndex" :paper-title="detail?.title" />
        </div>
      </div>

      <ParsePanel v-model:open="parseVisible" :paper-id="paperId" :section="activeSection" :sub-section="parseSubSection"
        :mode="parseMode" @fill="handleParseFill" />

      <a-modal v-model:open="infoModal" title="修改试卷信息" :confirm-loading="infoSaving" @ok="saveInfo" :width="560">
        <a-form :label-col="{ span: 5 }" :wrapper-col="{ span: 18 }">
          <a-form-item label="级别">
            <a-select v-model:value="infoForm.level" :options="[{ value: 4, label: '四级' }, { value: 6, label: '六级' }]">
            </a-select>
          </a-form-item>
          <a-form-item label="考试年份">
            <a-input-number v-model:value="infoForm.examYear" :min="2000" :max="2100" style="width: 100%" />
          </a-form-item>
          <a-form-item label="上/下半年">
            <a-select v-model:value="infoForm.examHalf"
              :options="[{ value: 1, label: '上半年' }, { value: 2, label: '下半年' }]"></a-select>
          </a-form-item>
          <a-form-item label="试卷标题">
            <a-input v-model:value="infoForm.title" placeholder="请输入试卷标题" />
          </a-form-item>
          <a-form-item label="试卷总分">
            <a-input-number v-model:value="infoForm.totalScore" :min="0" :max="1000" style="width: 100%" />
          </a-form-item>
        </a-form>
      </a-modal>
    </a-spin>
  </div>
</template>
<style lang="scss" scoped>
.editor-page {
  height: calc(100vh - 140px);
  min-height: 560px;
}

.editor-spin {
  height: 100%;

  :deep(.ant-spin-container) {
    height: 100%;
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
}

.editor-head {
  display: flex;
  align-items: center;
  gap: 10px;
  flex-wrap: wrap;
  padding-bottom: 10px;
  border-bottom: 1px solid #f0f0f0;
  flex-shrink: 0;

  .paper-title {
    font-size: 16px;
    font-weight: 700;
    color: #1a1a1a;
    max-width: 420px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }

  .paper-meta {
    font-size: 12px;
    color: #70757a;
  }

  .head-actions {
    margin-left: auto;
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
  }
}

.editor-main {
  flex: 1;
  min-height: 0;
  display: flex;
  gap: 10px;
}

.section-nav {
  flex: 0 0 150px;
  display: flex;
  flex-direction: column;
  gap: 8px;

  .nav-item {
    border: 1px solid #e8eaed;
    border-radius: 10px;
    padding: 10px 12px;
    cursor: pointer;
    transition: all 0.2s;
    background: #fff;

    &:hover {
      border-color: rgba(66, 87, 178, 0.35);
    }

    &.active {
      border-color: #4257b2;
      background: linear-gradient(135deg, rgba(66, 87, 178, 0.08), rgba(251, 146, 60, 0.06));
      box-shadow: 0 0 10px rgba(66, 87, 178, 0.1);
    }

    .nav-name {
      font-size: 14px;
      font-weight: 600;
      color: #1a1a1a;
      display: flex;
      align-items: center;
      gap: 6px;

      .dirty-dot {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background: #fa8c16;
      }
    }

    .nav-count {
      margin-top: 4px;
      font-size: 12px;
      color: #70757a;

      &.ok {
        color: #28a745;
      }

      &.part {
        color: #fa8c16;
      }
    }
  }

  .nav-tip {
    font-size: 11px;
    color: #b0b4bb;
    line-height: 1.6;
    padding: 0 2px;
  }
}

.edit-area {
  flex: 1;
  min-width: 0;
  overflow-y: auto;
  padding-right: 4px;

  .warn-bar {
    position: sticky;
    top: 0;
    z-index: 10;
    display: flex;
    align-items: flex-start;
    gap: 8px;
    background: #fffbe6;
    border: 1px solid #ffe58f;
    border-radius: 8px;
    padding: 8px 12px;
    margin-bottom: 10px;

    .warn-icon {
      color: #faad14;
      margin-top: 3px;
      flex-shrink: 0;
    }

    .warn-list {
      flex: 1;
      max-height: 110px;
      overflow-y: auto;
      font-size: 12px;
      color: #876800;
      line-height: 1.8;
    }
  }

  .sub-group {
    border: 1px solid #e8eaed;
    border-radius: 12px;
    padding: 12px 14px;
    margin-bottom: 14px;
    background: #fafbfc;

    .group-head {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 10px;

      .group-name {
        font-size: 14px;
        font-weight: 700;
        color: #1a1a1a;
      }

      .group-count {
        font-size: 12px;
        color: #70757a;
      }
    }

    .group-article {
      margin-bottom: 12px;
    }

    /* ===== question-scroll：选词填空 / 长篇匹配 ===== */
    .question-scroll {
      background: #fff;
      border: 1px solid #e8eaed;
      border-radius: 10px;
      padding: 14px;
      margin-bottom: 10px;

      .word-bank-pool {
        background: rgba(66, 87, 178, 0.04);
        border: 1px dashed #adc6ff;
        border-radius: 8px;
        padding: 12px;
        margin-bottom: 14px;

        .word-bank-grid {
          display: flex;
          flex-wrap: wrap;
          gap: 8px;
        }

        .wb-cell {
          display: flex;
          align-items: center;
          gap: 4px;
          width: calc(20% - 7px);
          min-width: 140px;

          .wb-label-tag {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 26px;
            height: 26px;
            border-radius: 4px;
            background: #4257b2;
            color: #fff;
            font-size: 12px;
            font-weight: 700;
            flex-shrink: 0;
          }

          .wb-input {
            flex: 1;
            min-width: 0;
          }
        }
      }

      .topic-card {
        background: #fff;
        border: 1px solid #e8eaed;
        border-radius: 10px;
        padding: 12px;
        margin-bottom: 10px;

        .topic-head {
          display: flex;
          align-items: center;
          justify-content: space-between;
          margin-bottom: 8px;

          .topic-no {
            font-size: 12px;
            font-weight: 600;
            color: #4257b2;
          }
        }

        .word-bank-select {
          margin-top: 8px;
        }

        .answer-textarea-row {
          margin-top: 8px;
        }

        .analysis-row {
          margin-top: 8px;
        }
      }
    }

    /* ===== 普通模式 ===== */
    .topic-card {
      background: #fff;
      border: 1px solid #e8eaed;
      border-radius: 10px;
      padding: 12px;
      margin-bottom: 10px;

      .topic-head {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 8px;

        .topic-no {
          font-size: 12px;
          font-weight: 600;
          color: #4257b2;
        }
      }

      .topic-article {
        margin-top: 8px;
      }

      .options-editor {
        margin-top: 8px;
        display: flex;
        flex-direction: column;
        gap: 6px;

        .option-row {
          display: flex;
          align-items: center;
          gap: 8px;

          .opt-label {
            width: 56px;
            flex-shrink: 0;
          }

          .opt-content {
            flex: 1;
          }

          .opt-ans {
            flex-shrink: 0;
          }
        }
      }

      .answer-row {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-top: 10px;
        flex-wrap: wrap;

        .field-label {
          font-size: 12px;
          color: #70757a;
          flex-shrink: 0;
        }
      }

      .answer-textarea-row {
        margin-top: 8px;
      }

      .analysis-row {
        margin-top: 8px;
      }
    }

    .group-actions {
      display: flex;
      gap: 8px;
      flex-wrap: wrap;
    }
  }

  .field-label {
    display: block;
    font-size: 12px;
    color: #70757a;
    margin-bottom: 4px;
  }
}

.preview-area {
  flex: 0 0 440px;
  min-width: 0;
  border: 1px solid #e8eaed;
  border-radius: 12px;
  overflow: hidden;
}
</style>
