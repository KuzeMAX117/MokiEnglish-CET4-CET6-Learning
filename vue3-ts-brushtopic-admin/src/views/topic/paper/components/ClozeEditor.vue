<script setup lang="ts">
import { computed, h, ref } from 'vue'
import { message } from 'ant-design-vue'
import { PlusOutlined, DeleteOutlined, SnippetsOutlined } from '@ant-design/icons-vue'
import type { PaperSubSectionType, PaperOptionType } from '@/api/topic/paper/type'

const props = defineProps<{
  group: PaperSubSectionType
}>()

const emit = defineEmits<{
  (e: 'update'): void
}>()

/* ---- 词库标记：用第一个特殊 topic 存储词库 ---- */
const CLOZE_BANK_MARKER = '__CLOZE_WORD_BANK__'

const bankTopic = computed(() =>
  props.group.topics.find((t) => t.topicName === CLOZE_BANK_MARKER)
)

const wordBank = computed<PaperOptionType[]>(() => bankTopic.value?.options || [])

/** 空位列表（排除词库标记） */
const blanks = computed(() =>
  props.group.topics.filter((t) => t.topicName !== CLOZE_BANK_MARKER)
)

/* ---- 词库操作 ---- */

const addWord = () => {
  const bank = wordBank.value
  if (bank.length >= 15) {
    message.warning('词库最多 15 个单词')
    return
  }
  const used = new Set(bank.map((w) => (w.label || '').trim().toUpperCase()))
  let label = ''
  for (const ch of 'ABCDEFGHIJKLMNO'.split('')) {
    if (!used.has(ch)) { label = ch; break }
  }
  if (!label) return

  if (bankTopic.value) {
    bankTopic.value.options.push({ label, content: '' })
  } else {
    // 在 topics 最前面插入词库标记
    props.group.topics.unshift({
      topicId: null,
      topicName: CLOZE_BANK_MARKER,
      options: [{ label, content: '' }],
      correctOption: '',
      answer: '',
      analysis: '',
      article: ''
    })
  }
  emit('update')
}

const removeWord = (oi: number) => {
  if (bankTopic.value) {
    bankTopic.value.options.splice(oi, 1)
    // 重新编号
    const labels = 'ABCDEFGHIJKLMNO'.split('')
    bankTopic.value.options.forEach((w, i) => { w.label = labels[i] })
    emit('update')
  }
}

/* ---- 空位操作 ---- */

const addBlank = () => {
  const nextNo = blanks.value.length + 1
  props.group.topics.push({
    topicId: null,
    topicName: String(nextNo),
    options: [],
    correctOption: '',
    answer: '',
    analysis: '',
    article: ''
  })
  emit('update')
}

const removeBlank = (ti: number) => {
  // ti 是 topics 数组中的索引
  props.group.topics.splice(ti, 1)
  // 重新编号
  renumberBlanks()
  emit('update')
}

const renumberBlanks = () => {
  let idx = 1
  for (const t of props.group.topics) {
    if (t.topicName !== CLOZE_BANK_MARKER) {
      t.topicName = String(idx++)
    }
  }
}

/* ---- 批量粘贴 ---- */

const batchModalVisible = ref(false)
const batchText = ref('')

/** 解析批量粘贴：文章正文 + 词库选项 */
const applyBatch = () => {
  const text = batchText.value.trim()
  if (!text) {
    message.warning('请输入内容')
    return
  }

  // 清空现有数据
  props.group.topics.length = 0

  // 按行分割，找到词库选项开始的行
  const lines = text.split('\n').map(l => l.trim())
  let wordBankStartIndex = -1

  // 找到第一个词库选项行（格式：A) word 或 A. word，必须在行首）
  for (let i = 0; i < lines.length; i++) {
    const line = lines[i]
    // 匹配行首的 "A) word" 或 "A. word" 格式
    if (/^[A-O][)\.]\s*\S+/.test(line)) {
      wordBankStartIndex = i
      break
    }
  }

  if (wordBankStartIndex === -1) {
    message.warning('未找到词库选项，请确保格式为 "A) word" 或 "A. word"，且每行一个')
    return
  }

  // 文章正文是词库之前的部分
  const articleLines = lines.slice(0, wordBankStartIndex)
  const articleText = articleLines.join('\n').trim()

  // 词库选项从 wordBankStartIndex 开始
  const wordBankLines = lines.slice(wordBankStartIndex)
  const wordBankOptions: PaperOptionType[] = []

  // 解析词库选项（支持每行一个或多个，格式：A) word 或 A. word）
  const wordPattern = /\b([A-O])[)\.]\s*(\S+)/g
  for (const line of wordBankLines) {
    const matches = [...line.matchAll(wordPattern)]
    for (const match of matches) {
      wordBankOptions.push({
        label: match[1].toUpperCase(),
        content: match[2]
      })
    }
  }

  if (wordBankOptions.length === 0) {
    message.warning('未找到词库选项')
    return
  }

  if (wordBankOptions.length > 15) {
    message.warning(`词库最多 15 个单词，当前 ${wordBankOptions.length} 个`)
    return
  }

  // 从文章中提取空位编号（支持多种格式：___26___ 或 __26__ 或 _26_ 或 (26) 或 [26]）
  const blankPattern = /_+\s*(\d+)\s*_+|\(\s*(\d+)\s*\)|\[\s*(\d+)\s*\]/g
  const blankMatches = [...articleText.matchAll(blankPattern)]
  const blankNumbers = blankMatches.map(m => parseInt(m[1] || m[2] || m[3]))

  // 插入词库
  props.group.topics.push({
    topicId: null,
    topicName: CLOZE_BANK_MARKER,
    options: wordBankOptions,
    correctOption: '',
    answer: '',
    analysis: '',
    article: ''
  })

  // 将文章正文存入 group.article
  if (articleText) {
    props.group.article = articleText
  }

  // 生成空位（按文章中出现的顺序）
  blankNumbers.forEach((num, idx) => {
    props.group.topics.push({
      topicId: null,
      topicName: String(idx + 1),
      options: [],
      correctOption: '',
      answer: '',
      analysis: '',
      article: ''
    })
  })

  batchModalVisible.value = false
  batchText.value = ''
  emit('update')
  message.success(`已导入 ${wordBankOptions.length} 个单词，${blankNumbers.length} 个空位，文章已填入`)
}
</script>

<template>
  <div class="cloze-editor">
    <!-- 词库区域 -->
    <div class="cloze-section">
      <div class="cloze-section-head">
        <span class="cloze-section-title">词库 Word Bank</span>
        <a-tag color="blue">{{ wordBank.length }} / 15</a-tag>
        <a-button size="small" type="dashed" :icon="h(PlusOutlined)" @click="addWord">添加单词</a-button>
      </div>
      <div class="cloze-word-grid">
        <div v-for="(word, oi) in wordBank" :key="oi" class="cloze-word-item">
          <span class="cloze-word-label">{{ word.label }}</span>
          <a-input
            v-model:value="word.content"
            class="cloze-word-input"
            placeholder="单词"
            @input="emit('update')"
          />
          <a-button
            size="small"
            type="text"
            danger
            :icon="h(DeleteOutlined)"
            @click="removeWord(oi)"
          />
        </div>
        <div v-if="wordBank.length === 0" class="cloze-empty-tip">
          点击下方「添加单词」或「批量粘贴」导入词库
        </div>
      </div>
    </div>

    <!-- 答案映射区域 -->
    <div class="cloze-section">
      <div class="cloze-section-head">
        <span class="cloze-section-title">答案映射</span>
        <a-tag color="green">{{ blanks.length }} 空</a-tag>
        <a-button size="small" type="dashed" :icon="h(PlusOutlined)" @click="addBlank">添加空位</a-button>
      </div>
      <div v-if="blanks.length === 0" class="cloze-empty-tip">
        点击下方「添加空位」或「批量粘贴」快速录入
      </div>
      <div v-else class="cloze-blank-list">
        <div v-for="(blank, bi) in blanks" :key="bi" class="cloze-blank-row">
          <span class="cloze-blank-no">{{ blank.topicName }}</span>
          <span class="cloze-blank-arrow">→</span>
          <a-select
            v-model:value="blank.correctOption"
            style="width: 200px"
            placeholder="选择答案"
            allow-clear
            @change="emit('update')"
          >
            <a-select-option v-for="w in wordBank" :key="w.label" :value="w.label">
              {{ w.label }}. {{ w.content || '(未填写)' }}
            </a-select-option>
          </a-select>
          <a-button
            size="small"
            type="text"
            danger
            :icon="h(DeleteOutlined)"
            @click="removeBlank(props.group.topics.indexOf(blank))"
          />
        </div>
      </div>
    </div>

    <!-- 底部操作 -->
    <div class="cloze-actions">
      <a-button size="small" :icon="h(SnippetsOutlined)" @click="batchModalVisible = true">批量粘贴</a-button>
    </div>

    <!-- 批量粘贴弹窗 -->
    <a-modal
      v-model:open="batchModalVisible"
      title="批量粘贴选词填空"
      @ok="applyBatch"
      :width="520"
    >
      <div class="cloze-batch-help">
        <p><b>格式说明：</b></p>
        <p>1. 文章正文（包含空位标记，如 ___26___ 或 (26) 或 [26]）</p>
        <p>2. 词库选项（每行一个，格式：A) word 或 A. word）</p>
        <p class="cloze-batch-example">示例：</p>
        <pre>It's a fantasy that goes back centuries...
Authors, artists and children ___26___ have dreamed...
This time, though, it's not a bottle...

A) wore
B) wildlife
C) suspect
D) struck
...</pre>
      </div>
      <a-textarea
        v-model:value="batchText"
        :auto-size="{ minRows: 6, maxRows: 15 }"
        placeholder="粘贴内容..."
      />
    </a-modal>
  </div>
</template>

<style lang="scss" scoped>
.cloze-editor {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.cloze-section {
  background: #fff;
  border: 1px solid #e8eaed;
  border-radius: 10px;
  padding: 14px;

  .cloze-section-head {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 12px;

    .cloze-section-title {
      font-size: 13px;
      font-weight: 600;
      color: #1a1a1a;
    }
  }
}

.cloze-word-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 8px;

  .cloze-word-item {
    display: flex;
    align-items: center;
    gap: 6px;
    background: #f7f8fa;
    border: 1px solid #e8eaed;
    border-radius: 6px;
    padding: 4px 8px;

    .cloze-word-label {
      font-size: 13px;
      font-weight: 700;
      color: #4257b2;
      min-width: 18px;
      text-align: center;
    }

    .cloze-word-input {
      flex: 1;
      border: none;
      background: transparent;
      box-shadow: none;
      padding: 2px 4px;

      &:focus {
        box-shadow: none;
        border-bottom: 1px solid #4257b2;
      }
    }
  }
}

.cloze-empty-tip {
  font-size: 12px;
  color: #999;
  padding: 8px 0;
  grid-column: 1 / -1;
}

.cloze-blank-list {
  display: flex;
  flex-direction: column;
  gap: 6px;

  .cloze-blank-row {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 4px 8px;
    border-radius: 6px;
    background: #f7f8fa;

    &:hover {
      background: #eef0f5;
    }

    .cloze-blank-no {
      font-size: 13px;
      font-weight: 700;
      color: #4257b2;
      min-width: 28px;
      text-align: center;
    }

    .cloze-blank-arrow {
      color: #999;
      font-size: 14px;
    }
  }
}

.cloze-actions {
  display: flex;
  gap: 8px;
}

.cloze-batch-help {
  margin-bottom: 12px;
  font-size: 12px;
  color: #666;

  p {
    margin: 2px 0;
  }

  .cloze-batch-example {
    margin-top: 8px;
    font-weight: 600;
    color: #333;
  }

  pre {
    background: #f5f5f5;
    border: 1px solid #e8eaed;
    border-radius: 6px;
    padding: 8px 12px;
    font-size: 11px;
    line-height: 1.6;
    overflow-x: auto;
    margin-top: 4px;
  }
}
</style>
