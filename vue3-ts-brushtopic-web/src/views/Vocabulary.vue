<template>
  <div class="vocab-page">
    <div class="page-header">
      <div class="header-left">
        <h2 class="page-title">
          <BookOutlined class="title-icon" />
          背单词
        </h2>
        <p class="page-desc">科学记忆曲线，高效备考四六级词汇</p>
      </div>
      <div class="header-right">
        <a-button type="primary" class="neon-btn" @click="openBookModal">选择词书</a-button>
      </div>
    </div>

    <div class="action-grid">
      <div class="action-card primary" @click="startStudy">
        <div class="action-icon">
          <ThunderboltFilled />
        </div>
        <div class="action-info">
          <div class="action-title">{{ studyTotal > 0 ? '开始学习' : '继续巩固' }}</div>
          <div class="action-desc">
            <template v-if="studyTotal > 0">{{ stats.reviewDue || 0 }} 个待复习 · {{ todayRemaining }} 个新词</template>
            <template v-else>今日任务已完成，继续巩固吧</template>
          </div>
        </div>
        <div class="action-count">{{ studyTotal }}</div>
        <RightOutlined class="action-arrow" />
      </div>
    </div>

    <!-- 三卡片行 -->
    <div class="triple-row">
      <div class="panel square-card">
        <div class="panel-head">
          <div class="panel-title">
            <RobotOutlined class="t-icon purple" />
            AI 今日短文
          </div>
          <div class="panel-actions">
            <span v-if="articleStore.totalArticles > 1" class="multi-count">共 {{ articleStore.totalArticles }} 篇</span>
            <a-button v-if="articleContent && !generating" size="small" class="read-full-btn"
              @click="router.push('/vocabulary/article')">
              <ReadOutlined /> 全文阅读
            </a-button>
            <a-button type="primary" size="small" class="generate-btn"
              :loading="generating" @click="generateArticle">
              <template #icon>
                <ReloadOutlined v-if="articleContent" />
                <RobotOutlined v-else />
              </template>
              {{ generating ? '停止' : articleContent ? '重新生成' : '生成短文' }}
            </a-button>
          </div>
        </div>
        <!-- 多篇文章切换 -->
        <div v-if="articleStore.articles.length > 1" class="article-switcher">
          <button v-for="(a, i) in articleStore.articles" :key="i" class="switch-chip"
            :class="{ active: i === activeIdx }" @click="activeIdx = i">
            第 {{ i + 1 }} 篇
            <span v-if="a.done" class="chip-score">{{ a.meta?.evaluation?.score ?? '—' }}</span>
          </button>
        </div>
        <div class="card-body article-body" :class="{ empty: !articleContent && !generating }">
          <div v-if="generating" class="generating-tip">
            <a-spin size="small" />
            <span v-if="articlePhase === 'GROUP'">🧩 AI 正在给单词分组...</span>
            <span v-else-if="articlePhase === 'PLAN'">🧠 AI 正在规划文章大纲...</span>
            <span v-else-if="articlePhase === 'ARTICLE'">✍️ AI 正在撰写短文...</span>
            <span v-else-if="articlePhase === 'META'">✅ AI 正在评估质量...</span>
            <span v-else>AI 正在生成短文...</span>
            <span v-if="articleStore.totalArticles > 1" class="gen-progress">
              （第 {{ Math.min(activeIdx + 1, articleStore.totalArticles) }}/{{ articleStore.totalArticles }} 篇）
            </span>
          </div>
          <template v-else-if="articleContent">
            <MarkdownView :content="articleContent" />
          </template>
          <div v-else class="empty-tip">
            <RobotOutlined class="empty-icon" />
            <div>点击按钮，基于今日单词生成短文</div>
            <div class="sub">单词较多时自动按主题拆成多篇，每词自然复现</div>
          </div>
        </div>
      </div>

      <div class="panel square-card" v-if="todayWords.length">
        <div class="panel-head">
          <div class="panel-title">
            <ReadOutlined class="t-icon cyan" />
            今日单词
          </div>
          <span class="panel-meta">{{ todayWords.length }} 词</span>
        </div>
        <div class="card-body">
          <div class="word-scroll">
            <div v-for="w in pagedWords" :key="w.id" class="word-chip">
              <div class="chip-top">
                <span class="chip-word">{{ w.word }}</span>
                <span class="chip-phonetic">{{ w.phonetic || '' }}</span>
              </div>
              <div class="chip-meaning">{{ w.meaning || '—' }}</div>
              <div class="chip-dots">
                <span v-for="i in 5" :key="i" class="dot"
                  :class="{ filled: (w.proficiency || 0) >= i }" />
              </div>
            </div>
          </div>
          <div class="word-pager" v-if="totalWordPages > 1">
            <button class="pager-btn" :disabled="wordPage === 1" @click="wordPage--">
              <LeftOutlined />
            </button>
            <span class="pager-info">{{ wordPage }} / {{ totalWordPages }}</span>
            <button class="pager-btn" :disabled="wordPage === totalWordPages" @click="wordPage++">
              <RightOutlined />
            </button>
          </div>
        </div>
      </div>

      <div class="panel square-card heatmap-card">
        <div class="panel-head">
          <div class="panel-title">
            <CalendarOutlined class="t-icon orange" />
            学习打卡
          </div>
          <span class="panel-meta">近 90 天</span>
        </div>
        <div class="card-body">
          <div class="heatmap-wrap">
            <div class="heatmap-grid" :style="{ gridTemplateColumns: `repeat(${heatmapCells.numCols}, 1fr)` }">
              <div v-for="(day, i) in heatmapCells.cells" :key="i" class="heatmap-cell"
                :class="cellLevel(day)" :title="day ? `${day.date}：${day.count} 词` : ''" />
            </div>
            <div class="heatmap-footer">
              <div class="heatmap-legend">
                <span class="legend-label">少</span>
                <span class="legend-cell level-0" />
                <span class="legend-cell level-1" />
                <span class="legend-cell level-2" />
                <span class="legend-cell level-3" />
                <span class="legend-label">多</span>
              </div>
              <span class="heatmap-stat">已打卡 <b>{{ heatmapStudyDays }}</b> 天</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <a-modal v-model:open="bookModalVisible" title="选择词书" :footer="null" centered>
      <div class="book-list">
        <div v-for="book in books" :key="book.id" class="book-card-modal"
          :class="{ active: selectedBookId === book.id }" @click="selectedBookId = book.id">
          <div class="book-info">
            <div class="book-name">{{ book.name }}</div>
            <div class="book-count">共 {{ book.totalCount }} 词</div>
          </div>
          <CheckCircleOutlined v-if="selectedBookId === book.id" class="check-icon" />
        </div>
      </div>
      <div class="daily-count">
        <span>每日背诵量：</span>
        <a-slider v-model:value="dailyCount" :min="10" :max="100" :step="5" style="flex: 1" />
        <span class="count-value">{{ dailyCount }} 个</span>
      </div>
      <a-button type="primary" class="confirm-btn" @click="confirmSelectBook">确认选择</a-button>
    </a-modal>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, computed, onMounted, watch } from 'vue'
import { useRouter } from 'vue-router'
import { message } from 'ant-design-vue'
import {
  BookOutlined, ThunderboltFilled, RightOutlined,
  CheckCircleOutlined, RobotOutlined, ReloadOutlined, CalendarOutlined, ReadOutlined,
  LeftOutlined,
} from '@ant-design/icons-vue'
import { apiGetBooks, apiGetWordSetting, apiSelectBook, apiGetWordStats, apiGetTodayWords, apiGetTodayLearnedWords, apiGetWordCalendar } from '@/api/word'
import type { WordBook, UserWordSetting, WordStats, WordItem, WordCalendarItem } from '@/api/word'
import { useArticleStore } from '@/stores/article'
import MarkdownView from '@/components/MarkdownView.vue'

const router = useRouter()
const articleStore = useArticleStore()
const dailyGoal = ref(20)
const books = ref<WordBook[]>([])
const currentBook = ref<WordBook | null>(null)
const selectedBookId = ref<number | null>(null)
const bookModalVisible = ref(false)
const dailyCount = ref(20)
const todayWords = ref<WordItem[]>([])
const todayLearnedWords = ref<WordItem[]>([])
// 短文生成状态全部托管给全局 store，离开页面仍持续生成
const activeIdx = ref(0)
const generating = computed(() => articleStore.generating)
const articlePhase = computed(() => articleStore.phase)
const articleContent = computed(() => articleStore.articles[activeIdx.value]?.content || '')
const calendarData = ref<WordCalendarItem[]>([])

// 今日单词翻页
const wordPage = ref(1)
const wordPageSize = 5
const totalWordPages = computed(() => Math.max(1, Math.ceil(todayWords.value.length / wordPageSize)))
const pagedWords = computed(() => {
  const start = (wordPage.value - 1) * wordPageSize
  return todayWords.value.slice(start, start + wordPageSize)
})

const stats = reactive({
  learned: 0, mastered: 0, reviewDue: 0, toLearn: 0, todayLearned: 0,
  cet4Learned: 0, cet4Total: 231, cet6Learned: 0, cet6Total: 0,
})

// 今日剩余待学 = 每日目标 - 今日已学（学完后归 0，卡片转为“继续学习”）
const todayRemaining = computed(() => Math.max(0, dailyGoal.value - (stats.todayLearned || 0)))

// 学习入口合计 = 待复习词 + 今日待学新词（与复习页混合队列一致）
const studyTotal = computed(() => (stats.reviewDue || 0) + todayRemaining.value)

// 标准 GitHub 风格热力图：7 行（周一~周日）× N 列（周），90 天全部展示
const heatmapCells = computed(() => {
  const today = new Date()
  const totalDays = 90
  const map = new Map<string, number>()
  calendarData.value.forEach((item) => map.set(item.date, item.count))
  const start = new Date(today)
  start.setDate(start.getDate() - totalDays + 1)

  // 收集所有天的数据
  const days: { date: string; count: number }[] = []
  for (let i = 0; i < totalDays; i++) {
    const d = new Date(start)
    d.setDate(d.getDate() + i)
    const dateStr = d.toISOString().slice(0, 10)
    days.push({ date: dateStr, count: map.get(dateStr) || 0 })
  }

  // 构建周列矩阵：每列是一周（7 天），每行是一个星期几
  const cols: ({ date: string; count: number } | null)[][] = []
  let col: ({ date: string; count: number } | null)[] = []
  const firstDow = (new Date(days[0].date).getDay() || 7) - 1 // 0=Mon
  for (let i = 0; i < firstDow; i++) col.push(null)
  days.forEach(d => {
    col.push(d)
    if (col.length === 7) { cols.push(col); col = [] }
  })
  if (col.length > 0) {
    while (col.length < 7) col.push(null)
    cols.push(col)
  }

  // 转置：行优先输出（row0 = 所有周一，row1 = 所有周二 ...）
  const result: ({ date: string; count: number } | null)[] = []
  for (let r = 0; r < 7; r++) {
    for (let c = 0; c < cols.length; c++) {
      result.push(cols[c][r] ?? null)
    }
  }
  return { cells: result, numCols: cols.length }
})

const heatmapStudyDays = computed(() => {
  return heatmapCells.value.cells.filter(d => d && d.count > 0).length
})

const cellLevel = (day: { date: string; count: number } | null) => {
  if (!day) return 'empty'
  if (day.count === 0) return 'level-0'
  if (day.count <= 5) return 'level-1'
  if (day.count <= 15) return 'level-2'
  return 'level-3'
}

onMounted(() => {
  // 从 localStorage / 全局 store 恢复当日文章（生成可能正在后台进行）
  if (!articleStore.articles.length) articleStore.hydrate()
  loadData()
  loadCalendar()
})

// 生成结束（true→false）时统一提示，无论用户当前在哪个页面
watch(() => articleStore.generating, (val, old) => {
  if (old && !val) {
    if (articleStore.error) message.error('生成失败：' + articleStore.error)
    else if (articleStore.hasArticles) message.success(`短文生成完成！共 ${articleStore.totalArticles} 篇`)
  }
})

const loadCalendar = async () => {
  try {
    const res = await apiGetWordCalendar(90)
    calendarData.value = res.data || []
  } catch { /* silent */ }
}

const loadData = async () => {
  try {
    const [booksRes, settingRes, statsRes, todayRes, learnedRes] = await Promise.all([
      apiGetBooks(), apiGetWordSetting(), apiGetWordStats(), apiGetTodayWords(), apiGetTodayLearnedWords(),
    ])
    books.value = booksRes.data || []
    if (settingRes.data) {
      const setting: UserWordSetting = settingRes.data
      dailyGoal.value = setting.dailyCount
      dailyCount.value = setting.dailyCount
      selectedBookId.value = setting.bookId
      currentBook.value = books.value.find((b) => b.id === setting.bookId) || null
    } else if (books.value.length > 0) {
      selectedBookId.value = books.value[0].id
      currentBook.value = books.value[0]
    }
    if (statsRes.data) {
      const s: WordStats = statsRes.data
      stats.learned = s.learned || 0
      stats.mastered = s.mastered || 0
      stats.reviewDue = s.reviewDue || 0
      stats.toLearn = s.toLearn || 0
      stats.todayLearned = s.todayLearned || 0
      stats.cet4Learned = s.cet4Learned || 0
      stats.cet4Total = s.cet4Total || 231
      stats.cet6Learned = s.cet6Learned || 0
      stats.cet6Total = s.cet6Total || 0
    }
    todayWords.value = (todayRes.data || []) as WordItem[]
    todayLearnedWords.value = (learnedRes.data || []) as WordItem[]
    wordPage.value = 1
  } catch (e) {
    message.error('加载词书信息失败')
  }
}

const openBookModal = () => { bookModalVisible.value = true }

const confirmSelectBook = async () => {
  if (!selectedBookId.value) { message.warning('请选择词书'); return }
  try {
    await apiSelectBook({ bookId: selectedBookId.value, dailyCount: dailyCount.value })
    dailyGoal.value = dailyCount.value
    currentBook.value = books.value.find((b) => b.id === selectedBookId.value) || null
    bookModalVisible.value = false
    message.success('词书选择成功')
  } catch (e) { message.error('保存失败') }
}

const startStudy = () => router.push('/vocabulary/review')

const generateArticle = async () => {
  // 正在生成时，再次点击则停止
  if (articleStore.generating) {
    articleStore.stop()
    return
  }
  if (!todayWords.value.length && !todayLearnedWords.value.length) { message.warning('今日暂无单词，先去学习吧'); return }

  // 优先使用今天实际学习过的单词；若今日尚未学习，则回退到今日待学单词
  const sourceWords = todayLearnedWords.value.length ? todayLearnedWords.value : todayWords.value
  const words = sourceWords.map((w) => ({
    word: w.word,
    meaning: w.meaning || '',
    phonetic: w.phonetic || '',
    example: w.example || '',
    exampleTranslate: w.exampleTranslate || '',
    proficiency: w.proficiency || 0,
  }))

  activeIdx.value = 0
  // 交给全局 store 执行，组件卸载不会中断生成
  await articleStore.start(words, 'CET-4')
}
</script>

<style scoped lang="scss">
.vocab-page { display: flex; flex-direction: column; gap: 20px; }

.page-header {
  display: flex; justify-content: space-between; align-items: flex-start;
  .page-title {
    font-size: calc(22px + var(--font-offset, 0px)); font-weight: 800; color: var(--text-title);
    display: flex; align-items: center; gap: 10px; margin: 0;
    .title-icon { color: var(--primary); }
  }
  .page-desc { font-size: calc(14px + var(--font-offset, 0px)); color: var(--text-muted); margin-top: 6px; }
}

.neon-btn {
  height: 42px; border-radius: var(--radius-md); border: none;
  background: var(--primary); font-weight: 600; box-shadow: var(--shadow-card);
  &:hover { background: var(--primary-hover) !important; }
}

.action-grid {
  display: grid; grid-template-columns: 1fr; gap: 14px;
  .action-card {
    display: flex; align-items: center; gap: 16px; padding: 20px 24px;
    border-radius: var(--radius-lg); background: var(--card-bg);
    border: 1px solid var(--border); cursor: pointer; transition: all 0.28s;
    box-shadow: var(--shadow-card);
    &:hover { border-color: var(--primary); transform: translateY(-2px); box-shadow: var(--shadow-hover); }
    &.primary { background: var(--primary-light); border-color: var(--primary); }
    .action-icon {
      width: 48px; height: 48px; border-radius: 13px; display: flex;
      align-items: center; justify-content: center; font-size: calc(22px + var(--font-offset, 0px));
      background: var(--primary-light); color: var(--primary); flex-shrink: 0;
    }
    .action-info {
      flex: 1; min-width: 0;
      .action-title { font-size: calc(16px + var(--font-offset, 0px)); font-weight: 700; color: var(--text-title); }
      .action-desc { font-size: calc(13px + var(--font-offset, 0px)); color: var(--text-muted); margin-top: 4px; }
    }
    .action-count {
      flex-shrink: 0; min-width: 44px; text-align: center; line-height: 1;
      font-size: calc(28px + var(--font-offset, 0px)); font-weight: 800; color: var(--primary);
    }
    .action-arrow { color: var(--text-muted); font-size: calc(14px + var(--font-offset, 0px)); }
  }
}

.panel {
  background: var(--card-bg); border: 1px solid var(--border);
  border-radius: var(--radius-lg); padding: 20px 22px; box-shadow: var(--shadow-card);
  .panel-head {
    display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;
    .panel-title {
      display: flex; align-items: center; gap: 10px;
      font-size: calc(16px + var(--font-offset, 0px)); font-weight: 700; color: var(--text-title);
      .t-icon {
        font-size: calc(17px + var(--font-offset, 0px));
        &.orange { color: var(--warning); } &.cyan { color: var(--primary); }
        &.purple { color: var(--primary); }
      }
    }
    .panel-meta { font-size: calc(13px + var(--font-offset, 0px)); color: var(--text-muted); }
  }
}

// 三卡片行
.triple-row { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; align-items: stretch; }
.square-card {
  aspect-ratio: 1 / 1; display: flex; flex-direction: column; overflow: hidden;
  .card-body { flex: 1; min-height: 0; overflow: hidden; display: flex; flex-direction: column; }
}

.heatmap-wrap {
  display: flex; flex-direction: column; height: 100%; gap: 8px;
}
.heatmap-grid {
  flex: 1; display: grid;
  gap: 3px; align-content: center;
  min-height: 0;
}
.heatmap-cell {
  aspect-ratio: 1 / 1; border-radius: 3px; transition: all 0.15s ease;
  min-width: 0;
  &:hover:not(.empty) { transform: scale(1.15); box-shadow: 0 1px 4px rgba(66, 87, 178, 0.2); }
  &.empty { background: transparent; }
  &.level-0 { background: #edf0f2; }
  &.level-1 { background: rgba(66, 87, 178, 0.2); }
  &.level-2 { background: rgba(66, 87, 178, 0.45); }
  &.level-3 { background: var(--primary); }
}
.heatmap-footer {
  display: flex; align-items: center; justify-content: space-between; flex-shrink: 0;
  .heatmap-stat {
    font-size: calc(11px + var(--font-offset, 0px)); color: var(--text-muted);
    b { color: var(--primary); font-weight: 700; }
  }
}
.heatmap-legend {
  display: flex; align-items: center; gap: 3px;
  .legend-label { font-size: calc(10px + var(--font-offset, 0px)); color: var(--text-muted); }
  .legend-cell {
    width: 10px; height: 10px; border-radius: 2px;
    &.level-0 { background: #edf0f2; } &.level-1 { background: rgba(66, 87, 178, 0.2); }
    &.level-2 { background: rgba(66, 87, 178, 0.45); } &.level-3 { background: var(--primary); }
  }
}

.word-scroll {
  display: flex; flex-direction: column; gap: 10px; overflow-y: auto; flex: 1; min-height: 0;
  &::-webkit-scrollbar { width: 4px; }
  &::-webkit-scrollbar-thumb { background: var(--border); border-radius: 2px; }
}
.word-pager {
  display: flex; align-items: center; justify-content: center; gap: 12px;
  padding-top: 10px; flex-shrink: 0;
  .pager-btn {
    width: 28px; height: 28px; border-radius: 50%; border: 1px solid var(--border);
    background: var(--card-bg); color: var(--text-muted); cursor: pointer;
    display: flex; align-items: center; justify-content: center;
    font-size: calc(12px + var(--font-offset, 0px)); transition: all 0.2s;
    &:hover:not(:disabled) { border-color: var(--primary); color: var(--primary); background: var(--primary-light); }
    &:disabled { opacity: 0.35; cursor: not-allowed; }
  }
  .pager-info { font-size: calc(12px + var(--font-offset, 0px)); color: var(--text-muted); font-weight: 600; min-width: 40px; text-align: center; }
}
.word-chip {
  flex-shrink: 0; padding: 10px 12px; border-radius: var(--radius-md);
  border: 1px solid var(--border); background: var(--card-bg); transition: all 0.25s;
  &:hover { border-color: var(--primary); background: var(--primary-light); }
  .chip-top {
    display: flex; align-items: baseline; gap: 6px; margin-bottom: 4px;
    .chip-word { font-size: calc(14px + var(--font-offset, 0px)); font-weight: 700; color: var(--text-title); }
    .chip-phonetic { font-size: calc(11px + var(--font-offset, 0px)); color: var(--text-muted); }
  }
  .chip-meaning {
    font-size: calc(12px + var(--font-offset, 0px)); color: var(--text-muted); line-height: 1.3; margin-bottom: 6px;
    display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden;
  }
  .chip-dots {
    display: flex; gap: 4px;
    .dot {
      width: 6px; height: 6px; border-radius: 50%; background: var(--border); transition: background 0.2s;
      &.filled { background: var(--primary); }
    }
  }
}

.article-body {
  color: var(--text-body); font-size: calc(13px + var(--font-offset, 0px)); line-height: 1.7; overflow-y: auto;
  &::-webkit-scrollbar { width: 4px; }
  &::-webkit-scrollbar-thumb { background: var(--border); border-radius: 2px; }
  &.empty { display: flex; align-items: center; justify-content: center; }
  .generating-tip { display: flex; align-items: center; justify-content: center; gap: 8px; color: var(--text-muted); }
  .empty-tip {
    text-align: center; color: var(--text-muted);
    .empty-icon { font-size: calc(28px + var(--font-offset, 0px)); color: var(--primary); margin-bottom: 6px; }
    .sub { font-size: calc(11px + var(--font-offset, 0px)); color: var(--text-muted); margin-top: 4px; }
  }
}
.panel-actions {
  display: flex; align-items: center; gap: 8px;
}
.read-full-btn {
  border-radius: var(--radius-sm); border: 1px solid var(--primary);
  background: var(--primary-light); color: var(--primary); font-weight: 600;
  display: inline-flex; align-items: center; gap: 4px;
  &:hover { background: var(--primary); color: #fff !important; }
}
.generate-btn {
  border-radius: var(--radius-sm); background: var(--primary); border: none; font-weight: 600;
  &:hover { background: var(--primary-hover) !important; }
}

.multi-count {
  font-size: calc(11px + var(--font-offset, 0px)); color: var(--text-muted);
  padding: 1px 7px; border-radius: 10px; background: var(--primary-light);
}
.article-switcher {
  display: flex; flex-wrap: wrap; gap: 6px; margin-bottom: 10px;
  .switch-chip {
    display: inline-flex; align-items: center; gap: 4px; cursor: pointer;
    padding: 3px 10px; border-radius: var(--radius-sm); border: 1px solid var(--border);
    background: var(--card-bg); color: var(--text-muted); font-size: calc(12px + var(--font-offset, 0px));
    transition: all 0.2s;
    &:hover { border-color: var(--primary); }
    &.active { background: var(--primary); border-color: var(--primary); color: #fff; }
    .chip-score { font-size: calc(10px + var(--font-offset, 0px)); opacity: 0.75; }
  }
}
.gen-progress { font-size: calc(11px + var(--font-offset, 0px)); color: var(--text-muted); }

.book-list {
  .book-card-modal {
    display: flex; justify-content: space-between; align-items: center;
    padding: 16px; border-radius: var(--radius-md); background: var(--card-bg);
    border: 1px solid var(--border); margin-bottom: 12px; cursor: pointer; transition: all 0.25s;
    &:hover, &.active { border-color: var(--primary); background: var(--primary-light); }
    .book-name { font-size: calc(16px + var(--font-offset, 0px)); font-weight: 700; color: var(--text-title); margin-bottom: 4px; }
    .book-count { font-size: calc(13px + var(--font-offset, 0px)); color: var(--text-muted); }
    .check-icon { color: var(--primary); font-size: calc(20px + var(--font-offset, 0px)); }
  }
}
.daily-count {
  display: flex; align-items: center; gap: 12px; margin: 20px 0; font-size: calc(14px + var(--font-offset, 0px)); color: var(--text-title);
  .count-value { white-space: nowrap; min-width: 50px; text-align: right; }
}
.confirm-btn {
  width: 100%; height: 44px; border-radius: var(--radius-md);
  background: var(--primary); border: none; font-weight: 600;
  &:hover { background: var(--primary-hover) !important; }
}

@media (max-width: 1200px) {
  .triple-row { grid-template-columns: 1fr; .square-card { aspect-ratio: auto; min-height: 300px; } }
}

:deep(.ant-empty-description) { color: var(--text-muted); }
:deep(.ant-modal-content) { background: var(--page-bg); }
:deep(.ant-modal-header) { background: var(--page-bg); border-bottom: 1px solid var(--border); }
:deep(.ant-modal-title) { color: var(--text-title); }
:deep(.ant-slider-track) { background: var(--primary); }
:deep(.ant-slider-handle) { border-color: var(--primary); }
:deep(.md-body) {
  h1, h2, h3, h4 { color: var(--text-title); }
  p { color: var(--text-body); line-height: 1.8; }
  strong { color: var(--primary); }
}
</style>
