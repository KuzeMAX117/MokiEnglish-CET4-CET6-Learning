<template>
  <div class="reading-detail-page">
    <div class="head-bar">
      <div class="back-bar" @click="router.push('/vocabulary')">
        <LeftOutlined />
        <span>返回背单词</span>
      </div>
      <div class="head-badges">
        <span v-if="meta" class="meta-badge ai-badge">
          <RobotOutlined /> AI 生成
        </span>
        <span v-if="meta" class="meta-badge score-badge">
          评分 {{ meta.evaluation?.score || '—' }}
        </span>
      </div>
      <div v-if="totalArticles > 1" class="article-nav">
        <button class="nav-btn" :disabled="currentIdx === 0" @click="switchTo(currentIdx - 1)">
          <LeftOutlined />
        </button>
        <span class="nav-info">第 {{ currentIdx + 1 }} / {{ totalArticles }} 篇</span>
        <button class="nav-btn" :disabled="currentIdx === totalArticles - 1" @click="switchTo(currentIdx + 1)">
          <RightOutlined />
        </button>
      </div>
      <div class="read-timer">
        <ClockCircleOutlined />
        <span>{{ readTimeStr }}</span>
      </div>
    </div>

    <div class="content-layout">
      <div class="article-panel">
        <div class="article-header">
          <h1 class="article-title">{{ title }}</h1>
          <div class="article-meta">
            <span v-if="meta" class="meta-tag">{{ meta.theme }} · {{ meta.genre }}</span>
            <span class="meta-info">{{ wordCount }} 词</span>
            <span v-if="meta" class="meta-info">难度 {{ meta.difficulty }}</span>
          </div>
        </div>
        <div class="article-body" @mouseup="onMouseUp">
          <p v-for="(para, idx) in paragraphs" :key="idx" class="para">
            <span
              v-for="(token, tIdx) in para"
              :key="tIdx"
              :class="{
                highlight: isHighlighted(token.word),
                'sel-marker': selectionMarkers.has(`${idx}-${tIdx}`),
                'sel-pronunciation': pronunciationMarkers.has(`${idx}-${tIdx}`),
              }"
              class="word-token"
              :data-idx="idx"
              :data-tidx="tIdx"
              @click.stop="onWordClick($event, token)"
            >{{ token.raw }}</span>
          </p>
          <!-- 中文翻译 -->
          <div v-if="translation" class="translation-section">
            <div class="translation-divider">
              <span class="translation-label">中文翻译</span>
            </div>
            <div class="translation-body">{{ translation }}</div>
          </div>
        </div>
      </div>

      <div class="dict-panel">
        <!-- 单词详情视图 -->
        <template v-if="selectedWord">
          <div class="dict-head">
            <span class="dict-back" @click="selectedWord = null">
              <LeftOutlined /> 返回列表
            </span>
          </div>
          <div class="dict-body">
            <div class="dict-word-large">{{ selectedWord }}</div>
            <div class="dict-phonetic">{{ lookupResult.phonetic }}</div>
            <div class="dict-meaning">{{ lookupResult.meaning }}</div>
            <div v-if="lookupResult.example" class="dict-example">
              <div class="ex-en">{{ lookupResult.example }}</div>
              <div class="ex-cn">{{ lookupResult.exampleCn }}</div>
            </div>
            <a-button
              v-if="!isSaved"
              type="primary"
              size="small"
              class="save-btn"
              @click="saveWord"
            >
              <StarOutlined /> 加入单词本
            </a-button>
            <a-button v-else size="small" disabled class="save-btn">
              <CheckOutlined /> 已收藏
            </a-button>
          </div>
        </template>
        <!-- 词汇卡片 / 收藏列表视图 -->
        <template v-else>
          <div class="dict-head">
            <span class="dict-title">
              <StarOutlined /> 词汇卡片
            </span>
            <span class="dict-count">{{ vocabWords.length }} 词</span>
          </div>
          <div class="dict-body">
            <!-- AI 生成的词汇注释 -->
            <template v-if="vocabWords.length">
              <div
                v-for="w in vocabWords"
                :key="w.word"
                class="word-item"
                :class="{ uncovered: !w.appearCount }"
                @click="selectWordInPanel(w.word)"
              >
                <div class="word-item-left">
                  <span class="word-item-name">
                    {{ w.word }}
                    <span v-if="w.appearCount" class="word-item-count">×{{ w.appearCount }}</span>
                    <span v-else class="uncovered-tag">未出现</span>
                  </span>
                  <span class="word-item-meaning">{{ w.meaning || '' }}</span>
                </div>
              </div>
            </template>
            <!-- 用户手动收藏的单词 -->
            <template v-if="collectedWords.length">
              <div class="collected-divider">手动收藏</div>
              <div
                v-for="w in collectedWords"
                :key="'c-'+w"
                class="word-item"
                @click="selectWordInPanel(w)"
              >
                <div class="word-item-left">
                  <span class="word-item-name">{{ w }}</span>
                  <span class="word-item-meaning">{{ collectedMeaning(w) }}</span>
                </div>
                <span class="word-item-del" @click.stop="removeWord(w)">✕</span>
              </div>
            </template>
            <div v-if="!vocabWords.length && !collectedWords.length" class="dict-empty">
              <StarOutlined class="empty-icon" />
              <p>暂无词汇卡片</p>
              <p class="empty-hint">点击文章中的单词可查看详情</p>
            </div>
          </div>
        </template>
      </div>
    </div>

    <!-- 悬浮单词提示框 -->
    <div
      v-if="showTooltip && tooltipData"
      class="word-tooltip"
      :style="{ left: tooltipPos.x + 'px', top: tooltipPos.y + 'px' }"
      @click.stop
    >
      <div class="tooltip-word-row">
        <span class="tooltip-word" @click="selectWordInPanel(tooltipData.word); hideTooltip()" title="点击查看详细">{{ tooltipData.word }}</span>
        <span v-if="tooltipData.phonetic" class="tooltip-phonetic">{{ tooltipData.phonetic }}</span>
      </div>
      <div class="tooltip-meaning">{{ tooltipData.meaning || '暂无释义' }}</div>
      <div v-if="tooltipData.example" class="tooltip-example">
        <div class="ex-en">{{ tooltipData.example }}</div>
        <div class="ex-cn">{{ tooltipData.exampleTranslate }}</div>
      </div>
    </div>

    <!-- 划词翻译弹出框 -->
    <div
      v-if="selectionTranslation"
      class="translate-popup"
      :style="{ left: translationPos.x + 'px', top: translationPos.y + 'px' }"
    >
      <div class="tp-header">
        <span class="tp-drag-handle" @mousedown="onDragStart" title="拖动">
          <span class="drag-dots"></span>
        </span>
        <span class="tp-label">翻译</span>
        <span class="tp-close" @click="closeTranslatePopup">✕</span>
      </div>
      <div class="tp-original">{{ selectionOriginalText }}</div>
      <div class="tp-divider"></div>
      <div class="tp-result">{{ selectionTranslation }}</div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, onUnmounted, ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { message } from 'ant-design-vue'
import {
  LeftOutlined, RightOutlined, StarOutlined, CheckOutlined,
  ClockCircleOutlined, RobotOutlined,
} from '@ant-design/icons-vue'
import { apiLookupWord, apiTranslateText } from '@/api/word'
import { useArticleStore } from '@/stores/article'
import { useWordCollectionStore } from '@/stores/wordCollection'

const router = useRouter()
const articleStore = useArticleStore()
const collectionStore = useWordCollectionStore()

// ===== 多篇文章：从全局 store 读取（与背单词页共享，生成中也能实时展示） =====
const currentIdx = ref(0)
const totalArticles = computed(() => articleStore.articles.length)
const current = computed(() => articleStore.articles[currentIdx.value] || null)
const rawContent = computed(() => current.value?.content || '')
const meta = computed(() => current.value?.meta || null)

// 提取正文（去掉翻译部分，翻译单独显示）
const articleText = computed(() => {
  const rc = rawContent.value
  if (!rc) return ''
  const sepIdx = rc.lastIndexOf('---')
  if (sepIdx !== -1 && sepIdx < rc.length - 3) {
    const afterSep = rc.substring(sepIdx + 3).trim()
    if (/[\u4e00-\u9fa5]/.test(afterSep)) return rc.substring(0, sepIdx).trim()
  }
  return rc.trim()
})

const translation = computed(() => {
  const rc = rawContent.value
  if (!rc) return ''
  const sepIdx = rc.lastIndexOf('---')
  if (sepIdx !== -1 && sepIdx < rc.length - 3) {
    const afterSep = rc.substring(sepIdx + 3).trim()
    if (/[\u4e00-\u9fa5]/.test(afterSep)) return afterSep
  }
  return ''
})

const title = computed(() => meta.value?.title || 'AI 今日短文')
const wordCount = computed(() => {
  const text = articleText.value.trim()
  if (!text) return 0
  return text.split(/\s+/).filter(w => /^[a-zA-Z]/.test(w)).length
})

// ===== 文章分词 =====
const paragraphs = computed(() => {
  return articleText.value.split('\n\n').filter(Boolean).map((para) => {
    const tokens: { word: string; raw: string }[] = []
    const parts = para.split(/(\s+)/)
    for (const part of parts) {
      const word = part.replace(/[^a-zA-Z'-]/g, '').toLowerCase()
      tokens.push({ word, raw: part })
    }
    return tokens
  })
})

// ===== 词汇卡片（来自 AI 元数据） =====
const vocabWords = computed(() => meta.value?.vocabulary || [])

// ===== 收藏单词（用户级全局生词本，后端持久化） =====
const isHighlighted = (word: string) => collectionStore.has(word)
const collectedWords = computed(() => collectionStore.words.map((w) => w.word))
const collectedMeaning = (word: string) =>
  collectionStore.meaningOf(word) || wordCache[word]?.meaning || ''

const selectedWord = ref<string | null>(null)
const isSaved = ref(false)
const lookupResult = reactive({
  phonetic: '',
  meaning: '点击单词查看释义',
  example: '',
  exampleCn: '',
})

const wordCache = reactive<Record<string, any>>({})

// ===== 鼠标位置追踪 =====
const mouseX = ref(0)
const mouseY = ref(0)

// ===== 悬浮提示框 =====
const showTooltip = ref(false)
const tooltipData = ref<any>(null)
const tooltipPos = reactive({ x: 0, y: 0 })

const hideTooltip = () => {
  showTooltip.value = false
  tooltipData.value = null
}

// ===== 单击单词弹出提示框 =====
const onWordClick = async (event: MouseEvent, token: { word: string; raw: string }) => {
  const word = token.word
  if (!word || !/^[a-z'-]+$/.test(word)) return

  event.stopPropagation()

  if (showTooltip.value && tooltipData.value?.word === word) {
    hideTooltip()
    return
  }

  tooltipData.value = { word, phonetic: '', meaning: '查询中...', example: '', exampleTranslate: '' }
  tooltipPos.x = event.clientX + 12
  tooltipPos.y = event.clientY + 16
  if (tooltipPos.x + 300 > window.innerWidth) tooltipPos.x = event.clientX - 312
  if (tooltipPos.y + 200 > window.innerHeight) tooltipPos.y = event.clientY - 180
  showTooltip.value = true

  selectWordInPanel(word)

  let data = wordCache[word]
  if (!data) {
    try {
      const res = await apiLookupWord(word)
      data = res.data
      if (data) wordCache[word] = data
    } catch { /* 忽略 */ }
  }
  if (data) {
    tooltipData.value = {
      word: data.word || word,
      phonetic: data.phonetic || '',
      meaning: data.meaning || '暂无释义',
      example: data.example || '',
      exampleTranslate: data.exampleTranslate || '',
    }
  } else {
    tooltipData.value = { word, phonetic: '', meaning: '未找到释义', example: '', exampleTranslate: '' }
  }
}

const onDocumentClick = () => {
  if (showTooltip.value) hideTooltip()
}

// ===== 侧栏单词选中 =====
const selectWordInPanel = async (word: string) => {
  selectedWord.value = word
  isSaved.value = collectionStore.has(word)

  const data = wordCache[word]
  if (data) {
    lookupResult.phonetic = data.phonetic || ''
    lookupResult.meaning = data.meaning || '暂无释义'
    lookupResult.example = data.example || ''
    lookupResult.exampleCn = data.exampleTranslate || ''
    return
  }

  lookupResult.phonetic = '加载中...'
  lookupResult.meaning = ''
  lookupResult.example = ''
  lookupResult.exampleCn = ''

  try {
    const res = await apiLookupWord(word)
    const d = res.data
    if (d) {
      wordCache[word] = d
      lookupResult.phonetic = d.phonetic || ''
      lookupResult.meaning = d.meaning || '暂无释义'
      lookupResult.example = d.example || ''
      lookupResult.exampleCn = d.exampleTranslate || ''
    } else {
      lookupResult.phonetic = ''
      lookupResult.meaning = '暂无释义'
    }
  } catch {
    lookupResult.meaning = '查询失败'
  }
}

// ===== 划词翻译 =====
const selectionMarkers = ref(new Set<string>())
const pronunciationMarkers = ref(new Set<string>())
const selectionTranslation = ref<string | null>(null)
const selectionOriginalText = ref('')
const translationPos = reactive({ x: 0, y: 0 })

// ===== 拖拽 =====
const isDragging = ref(false)
const dragOffset = reactive({ x: 0, y: 0 })

const onDragMove = (e: MouseEvent) => {
  if (!isDragging.value) return
  translationPos.x = e.clientX - dragOffset.x
  translationPos.y = e.clientY - dragOffset.y
}

const onDragEnd = () => {
  isDragging.value = false
  document.removeEventListener('mousemove', onDragMove)
  document.removeEventListener('mouseup', onDragEnd)
}

const onDragStart = (e: MouseEvent) => {
  isDragging.value = true
  dragOffset.x = e.clientX - translationPos.x
  dragOffset.y = e.clientY - translationPos.y
  document.addEventListener('mousemove', onDragMove)
  document.addEventListener('mouseup', onDragEnd)
  e.preventDefault()
}

const onMouseUp = async () => {
  hideTooltip()
  const selection = window.getSelection()
  const text = selection?.toString().trim()
  if (!text) return
  const wc = text.split(/\s+/).filter(Boolean).length
  if (wc < 2) return

  // 用 getClientRects() 获取每行的精确矩形，避免单一大矩形导致的 overlap 误判
  const range = selection!.getRangeAt(0)
  const clientRects = Array.from(range.getClientRects())
  if (clientRects.length === 0) return
  selection!.removeAllRanges()

  // 只要包含英文字母就尝试翻译，不再用严格白名单正则
  if (/[a-zA-Z]/.test(text)) {
    applySelectionMarkers(clientRects)
    selectionOriginalText.value = text
    selectionTranslation.value = '翻译中...'
    // 用第一个 rect 定位弹窗
    const firstRect = clientRects[0]
    translationPos.x = Math.max(8, firstRect.left + firstRect.width / 2 - 150)
    translationPos.y = firstRect.bottom + 10
    if (translationPos.y + 160 > window.innerHeight) translationPos.y = firstRect.top - 160

    try {
      // 限制最大翻译长度，防止 AI 调用超时
      const trimmed = text.length > 500 ? text.slice(0, 500) + '...' : text
      const res = await apiTranslateText(trimmed)
      selectionTranslation.value = res.data || '翻译失败'
    } catch {
      selectionTranslation.value = '翻译失败，请重试'
    }
  }
}

const applySelectionMarkers = (clientRects: DOMRect[]) => {
  selectionMarkers.value = new Set<string>()
  pronunciationMarkers.value = new Set<string>()
  const spans = document.querySelectorAll('.article-body .word-token')
  spans.forEach((span) => {
    const sr = span.getBoundingClientRect()
    // 检查 span 是否与任意一个 selection rect 有重叠
    let overlap = false
    for (const rect of clientRects) {
      if (!(sr.right < rect.left || sr.left > rect.right || sr.bottom < rect.top || sr.top > rect.bottom)) {
        overlap = true
        break
      }
    }
    if (overlap) {
      const idx = (span as HTMLElement).dataset.idx
      const tIdx = (span as HTMLElement).dataset.tidx
      if (idx !== undefined && tIdx !== undefined) {
        selectionMarkers.value.add(`${idx}-${tIdx}`)
        const token = paragraphs.value[Number(idx)]?.[Number(tIdx)]
        if (token?.word && /^[a-z'-]+$/.test(token.word)) {
          pronunciationMarkers.value.add(`${idx}-${tIdx}`)
        }
      }
    }
  })
}

const closeTranslatePopup = () => {
  selectionTranslation.value = null
  selectionOriginalText.value = ''
  selectionMarkers.value = new Set<string>()
  pronunciationMarkers.value = new Set<string>()
}

// ===== 收藏单词 =====
const saveWord = async () => {
  if (selectedWord.value) {
    const word = selectedWord.value
    if (!wordCache[word]) {
      try {
        const res = await apiLookupWord(word)
        if (res.data) wordCache[word] = res.data
      } catch { /* 忽略 */ }
    }
    const data = wordCache[word] || {}
    try {
      await collectionStore.add({
        word,
        phonetic: data.phonetic || '',
        meaning: data.meaning || '',
        example: data.example || '',
        exampleTranslate: data.exampleTranslate || '',
      })
      isSaved.value = true
      message.success(`已收藏「${word}」`)
    } catch {
      message.error('收藏失败，请重试')
    }
  }
}

const removeWord = async (word: string) => {
  try {
    await collectionStore.remove(word)
    if (selectedWord.value === word) isSaved.value = false
    message.success(`已移除「${word}」`)
  } catch {
    message.error('移除失败，请重试')
  }
}

// ===== 阅读计时 =====
const readSeconds = ref(0)
let timer: ReturnType<typeof setInterval> | null = null

const readTimeStr = computed(() => {
  const m = Math.floor(readSeconds.value / 60)
  const s = readSeconds.value % 60
  return `${String(m).padStart(2, '0')}:${String(s).padStart(2, '0')}`
})

// ===== 多篇文章切换 =====
const switchTo = (idx: number) => {
  if (idx < 0 || idx >= totalArticles.value || idx === currentIdx.value) return
  currentIdx.value = idx
  // 切换时重置临时交互状态，避免错位
  selectedWord.value = null
  hideTooltip()
  closeTranslatePopup()
  selectionMarkers.value = new Set<string>()
  pronunciationMarkers.value = new Set<string>()
}

onMounted(() => {
  collectionStore.load()
  if (!articleStore.articles.length) articleStore.hydrate()
  if (!articleStore.articles.some((a) => a.content)) {
    message.warning('暂无短文内容，请先在背单词页面生成')
    router.push('/vocabulary')
    return
  }
  timer = setInterval(() => { readSeconds.value++ }, 1000)
  document.addEventListener('click', onDocumentClick)
})

onUnmounted(() => {
  if (timer) clearInterval(timer)
  document.removeEventListener('click', onDocumentClick)
})
</script>

<style scoped lang="scss">
.reading-detail-page {
  display: flex; flex-direction: column; gap: 16px;
  height: calc(100vh - 64px - 56px);
}

.head-bar {
  display: flex; justify-content: space-between; align-items: center;

  .back-bar {
    display: inline-flex; align-items: center; gap: 8px;
    padding: 8px 14px; border-radius: var(--radius-sm);
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-muted); cursor: pointer; transition: all 0.25s;
    &:hover { color: var(--primary); background: var(--primary-light); }
  }

  .head-badges {
    display: flex; gap: 10px; align-items: center;
  }

  .meta-badge {
    font-size: calc(12px + var(--font-offset, 0px));
    padding: 4px 12px; border-radius: 8px;
    display: inline-flex; align-items: center; gap: 6px;
  }

  .ai-badge {
    color: var(--primary); background: var(--primary-light); border: 1px solid var(--primary);
  }

  .score-badge {
    color: var(--success); background: var(--success-light); border: 1px solid var(--success);
    font-weight: 700;
  }

  .read-timer {
    display: flex; align-items: center; gap: 8px;
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-muted); background: var(--card-bg);
    border: 1px solid var(--border); padding: 7px 16px;
    border-radius: var(--radius-sm);
  }

  .article-nav {
    display: flex; align-items: center; gap: 10px;
    background: var(--card-bg); border: 1px solid var(--border);
    padding: 5px 10px; border-radius: var(--radius-sm);
    .nav-info { font-size: calc(13px + var(--font-offset, 0px)); color: var(--text-body); white-space: nowrap; }
    .nav-btn {
      display: inline-flex; align-items: center; justify-content: center;
      width: 26px; height: 26px; border-radius: 6px; cursor: pointer;
      border: 1px solid var(--border); background: var(--card-bg);
      color: var(--text-muted); transition: all 0.15s;
      &:hover:not(:disabled) { color: var(--primary); border-color: var(--primary); }
      &:disabled { opacity: 0.4; cursor: not-allowed; }
    }
  }
}

.content-layout { flex: 1; display: flex; gap: 16px; min-height: 0; }

.article-panel {
  flex: 1; background: var(--card-bg); border: 1px solid var(--border);
  border-radius: var(--radius-lg); overflow: hidden; display: flex; flex-direction: column;

  .article-header {
    padding: 22px 28px; border-bottom: 1px solid var(--border);

    .article-title {
      font-size: calc(22px + var(--font-offset, 0px)); font-weight: 800;
      color: var(--text-title); line-height: 1.4; margin: 0 0 12px;
    }

    .article-meta {
      display: flex; gap: 12px; align-items: center;

      .meta-tag {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--primary); background: var(--primary-light);
        border: 1px solid var(--primary); padding: 2px 10px; border-radius: 6px;
      }

      .meta-info { font-size: calc(12px + var(--font-offset, 0px)); color: var(--text-muted); }
    }
  }

  .article-body {
    flex: 1; overflow-y: auto; padding: 24px 28px;

    .para {
      font-size: calc(16px + var(--font-offset, 0px)); line-height: 2;
      color: var(--text-body); margin-bottom: 20px;

      .word-token {
        cursor: pointer; border-radius: 3px; padding: 1px 2px; transition: all 0.15s;
        &:hover { background: var(--primary-light); color: var(--text-title); }
        &.highlight {
          background: var(--primary-light); color: var(--primary);
          border-bottom: 1px dashed var(--primary);
        }
      }
    }

    .translation-section {
      margin-top: 32px;
    }

    .translation-divider {
      display: flex; align-items: center; gap: 16px; margin-bottom: 16px;
      &::before, &::after {
        content: ''; flex: 1; height: 1px; background: var(--border);
      }
      .translation-label {
        font-size: calc(14px + var(--font-offset, 0px));
        color: var(--text-muted); font-weight: 600; white-space: nowrap;
      }
    }

    .translation-body {
      font-size: calc(15px + var(--font-offset, 0px));
      color: var(--text-muted); line-height: 2;
    }
  }
}

.dict-panel {
  width: 320px; flex-shrink: 0; background: var(--card-bg);
  border: 1px solid var(--border); border-radius: var(--radius-lg);
  overflow: hidden; display: flex; flex-direction: column;

  .dict-head {
    display: flex; justify-content: space-between; align-items: center;
    padding: 16px 20px; border-bottom: 1px solid var(--border);

    .dict-title {
      font-size: calc(16px + var(--font-offset, 0px)); font-weight: 700;
      color: var(--text-title); display: flex; align-items: center; gap: 8px;
    }

    .dict-count {
      font-size: calc(13px + var(--font-offset, 0px)); color: var(--text-muted);
      background: var(--primary-light); padding: 2px 10px; border-radius: 10px;
    }

    .dict-back {
      font-size: calc(14px + var(--font-offset, 0px)); color: var(--text-muted);
      cursor: pointer; display: inline-flex; align-items: center; gap: 6px;
      transition: color 0.15s;
      &:hover { color: var(--primary); }
    }
  }

  .dict-word-large {
    font-size: calc(22px + var(--font-offset, 0px)); font-weight: 800;
    color: var(--text-title); margin-bottom: 8px;
  }

  .dict-body {
    flex: 1; overflow-y: auto; padding: 20px;

    .dict-phonetic {
      font-size: calc(15px + var(--font-offset, 0px)); color: var(--text-muted); margin-bottom: 12px;
    }

    .dict-meaning {
      font-size: calc(17px + var(--font-offset, 0px)); font-weight: 600;
      color: var(--text-title); line-height: 1.5; margin-bottom: 18px;
    }

    .dict-example {
      background: var(--card-bg); border-left: 3px solid var(--primary);
      padding: 12px 16px; border-radius: 0 10px 10px 0; margin-bottom: 18px;

      .ex-en { font-size: calc(14px + var(--font-offset, 0px)); color: var(--text-body); line-height: 1.6; font-style: italic; }
      .ex-cn { font-size: calc(13px + var(--font-offset, 0px)); color: var(--text-muted); margin-top: 6px; }
    }

    .save-btn {
      width: 100%; height: 38px; border-radius: var(--radius-sm); font-weight: 600;
      border: none; background: var(--primary);
      &:hover { background: var(--primary-hover) !important; }
    }
  }

  .word-list { display: flex; flex-direction: column; gap: 4px; }

  .word-item {
    display: flex; justify-content: space-between; align-items: center;
    padding: 10px 12px; border-radius: var(--radius-sm);
    cursor: pointer; transition: all 0.15s;
    &:hover { background: var(--primary-light); }

    .word-item-left {
      display: flex; flex-direction: column; gap: 2px; min-width: 0;
    }

    .word-item-name {
      font-size: calc(15px + var(--font-offset, 0px)); font-weight: 600; color: var(--text-title);
      .word-item-count {
        font-size: calc(11px + var(--font-offset, 0px)); color: var(--primary);
        font-weight: 400; margin-left: 6px;
      }
    }

    .word-item-meaning {
      font-size: calc(12px + var(--font-offset, 0px)); color: var(--text-muted);
      white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 220px;
    }

    .word-item-del {
      font-size: calc(12px + var(--font-offset, 0px)); color: var(--text-muted);
      padding: 4px 6px; border-radius: 4px; opacity: 0; transition: all 0.15s;
    }

    &:hover .word-item-del {
      opacity: 1;
      &:hover { color: var(--error); background: var(--error-light); }
    }

    &.uncovered {
      opacity: 0.6;
      .word-item-name { color: var(--text-muted); }
    }
    .uncovered-tag {
      font-size: calc(10px + var(--font-offset, 0px)); color: var(--warning);
      font-weight: 400; margin-left: 6px; padding: 0 6px;
      border-radius: 8px; background: var(--warning-light, rgba(250, 173, 20, 0.12));
    }
  }

  .collected-divider {
    font-size: calc(12px + var(--font-offset, 0px)); color: var(--text-muted);
    font-weight: 600; padding: 12px 0 6px; margin-top: 8px;
    border-top: 1px solid var(--border);
  }

  .dict-empty {
    text-align: center; padding: 40px 20px; color: var(--text-muted);

    .empty-icon { font-size: calc(36px + var(--font-offset, 0px)); color: var(--border); margin-bottom: 12px; }
    p { font-size: calc(14px + var(--font-offset, 0px)); margin: 0; }
    .empty-hint { font-size: calc(12px + var(--font-offset, 0px)); margin-top: 6px; }
  }
}

/* 悬浮单词提示框 */
.word-tooltip {
  position: fixed; z-index: 1000; background: var(--card-bg);
  border: 1px solid var(--border); border-radius: var(--radius-md);
  padding: 14px 18px; min-width: 220px; max-width: 320px;
  box-shadow: var(--shadow-hover); pointer-events: auto;
  animation: tooltip-fade-in 0.15s ease;

  .tooltip-word-row { display: flex; align-items: baseline; gap: 10px; margin-bottom: 6px; }

  .tooltip-word {
    font-size: calc(18px + var(--font-offset, 0px)); font-weight: 700;
    color: var(--primary); cursor: pointer; transition: color 0.15s;
    &:hover { color: var(--primary-hover); text-decoration: underline; }
  }

  .tooltip-phonetic { font-size: calc(13px + var(--font-offset, 0px)); color: var(--text-muted); }
  .tooltip-meaning { font-size: calc(14px + var(--font-offset, 0px)); color: var(--text-body); line-height: 1.5; margin-bottom: 8px; }

  .tooltip-example {
    border-left: 3px solid var(--primary); padding-left: 10px;
    .ex-en { font-size: calc(13px + var(--font-offset, 0px)); color: var(--text-body); font-style: italic; line-height: 1.5; }
    .ex-cn { font-size: calc(12px + var(--font-offset, 0px)); color: var(--text-muted); margin-top: 4px; }
  }
}

@keyframes tooltip-fade-in {
  from { opacity: 0; transform: translateY(4px); }
  to   { opacity: 1; transform: translateY(0); }
}

/* 划词翻译弹出框 */
.translate-popup {
  position: fixed; z-index: 1000; background: var(--card-bg);
  border: 1px solid var(--border); border-radius: var(--radius-md);
  padding: 16px 20px; min-width: 280px; max-width: 420px;
  max-height: 60vh; overflow-y: auto;
  box-shadow: var(--shadow-hover); animation: tooltip-fade-in 0.15s ease;

  .tp-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; }

  .tp-drag-handle {
    cursor: grab; padding: 4px 8px; border-radius: 4px;
    display: inline-flex; align-items: center; user-select: none;
    transition: background 0.15s; margin-right: 6px;
    &:hover { background: var(--primary-light); }
    &:active { cursor: grabbing; }
  }

  .drag-dots {
    display: inline-block; width: 16px; height: 16px;
    background-image: radial-gradient(circle, var(--text-muted) 1.5px, transparent 1.5px);
    background-size: 5px 5px; background-position: 1px 1px; opacity: 0.6;
  }

  .tp-label {
    font-size: calc(12px + var(--font-offset, 0px)); font-weight: 600;
    color: var(--primary); background: var(--primary-light);
    padding: 2px 10px; border-radius: 6px;
  }

  .tp-close {
    cursor: pointer; color: var(--text-muted); font-size: calc(14px + var(--font-offset, 0px));
    padding: 2px 6px; border-radius: 4px; transition: all 0.15s;
    &:hover { color: var(--text-title); background: var(--primary-light); }
  }

  .tp-original { font-size: calc(14px + var(--font-offset, 0px)); color: var(--text-body); line-height: 1.6; margin-bottom: 10px; font-style: italic; }
  .tp-divider { height: 1px; background: var(--border); margin: 8px 0; }
  .tp-result { font-size: calc(15px + var(--font-offset, 0px)); color: var(--text-title); line-height: 1.6; font-weight: 500; }
}

.sel-marker { background: rgba(66, 87, 178, 0.25) !important; border-radius: 2px; padding: 1px 0; }
.sel-pronunciation { text-decoration: underline; text-decoration-color: var(--primary); text-underline-offset: 3px; }
::selection { background: rgba(66, 87, 178, 0.25); }

@media (max-width: 900px) {
  .content-layout { flex-direction: column; }
  .dict-panel { width: 100%; }
}
</style>
