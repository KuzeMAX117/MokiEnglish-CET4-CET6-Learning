import { defineStore } from 'pinia'
import { useUserStore } from '@/stores/user'

/** AI 短文元数据（后端 ArticleResult 结构） */
export interface ArticleMeta {
  title: string
  content?: string
  translation?: string
  vocabulary: { word: string; phonetic: string; meaning: string; appearCount: number; usageContext: string }[]
  evaluation: { score: number; coveragePercent: number; difficultyMatched: boolean; refined: boolean }
  theme: string
  genre: string
  difficulty: string
}

/** 单篇文章的运行时状态 */
export interface ArticleItem {
  /** Markdown 正文（含末尾中文翻译） */
  content: string
  /** 大纲摘要文本 */
  plan: string
  /** 结构化元数据（生成完成后才有） */
  meta: ArticleMeta | null
  /** 是否已完成 */
  done: boolean
}

/** 生成短文所需的单词输入 */
export interface ArticleWordInput {
  word: string
  meaning: string
  phonetic: string
  example: string
  exampleTranslate: string
  proficiency: number
}

interface ArticleState {
  generating: boolean
  /** 当前 Pipeline 阶段: GROUP / PLAN / ARTICLE / META / ALL_DONE / '' */
  phase: string
  totalArticles: number
  articles: ArticleItem[]
  currentDate: string
  error: string
}

// AbortController 存放在模块作用域，避免被 Pinia 响应式代理，也保证其生命周期
// 独立于任何组件——用户离开背单词页面后 fetch 仍持续进行。
let controller: AbortController | null = null

const todayStr = () => new Date().toISOString().slice(0, 10)
const storageKey = (date: string) => `vocab_article_list_${date}`

const MARKER_RE = /<!-- PHASE:([A-Z_]+)([^>]*)-->/g

export const useArticleStore = defineStore('article', {
  state: (): ArticleState => ({
    generating: false,
    phase: '',
    totalArticles: 0,
    articles: [],
    currentDate: todayStr(),
    error: '',
  }),
  getters: {
    /** 是否已有可展示的文章（正文或元数据） */
    hasArticles: (s) => s.articles.some((a) => a.meta || a.content),
    /** 已完成的篇数 */
    completedCount: (s) => s.articles.filter((a) => a.done).length,
  },
  actions: {
    /** 从 localStorage 恢复当日文章（含旧单篇格式兼容） */
    hydrate() {
      const date = todayStr()
      this.currentDate = date
      const raw = localStorage.getItem(storageKey(date))
      if (raw) {
        try {
          const arr = JSON.parse(raw) as ArticleItem[]
          if (Array.isArray(arr) && arr.length) {
            this.articles = arr
            this.totalArticles = arr.length
            return
          }
        } catch {
          /* 解析失败则走旧格式兼容 */
        }
      }
      // 兼容旧的单篇存储格式
      const oldContent = localStorage.getItem(`vocab_article_${date}`)
      const oldMeta = localStorage.getItem(`vocab_article_meta_${date}`)
      if (oldContent || oldMeta) {
        let meta: ArticleMeta | null = null
        if (oldMeta) {
          try {
            meta = JSON.parse(oldMeta)
          } catch {
            /* ignore */
          }
        }
        this.articles = [{ content: oldContent || '', plan: '', meta, done: true }]
        this.totalArticles = 1
      } else {
        this.articles = []
        this.totalArticles = 0
      }
    },

    /** 持久化当前文章列表 */
    persist() {
      const date = todayStr()
      this.currentDate = date
      try {
        localStorage.setItem(storageKey(date), JSON.stringify(this.articles))
      } catch {
        /* localStorage 满或不可用时忽略 */
      }
    },

    /**
     * 启动多篇文章生成。该方法运行在 store（应用级），fetch 与组件生命周期解耦，
     * 用户离开背单词页面后仍会继续生成并写入 localStorage。
     */
    async start(words: ArticleWordInput[], level = 'CET-4') {
      if (this.generating) return
      const userStore = useUserStore()
      const baseUrl = import.meta.env.VITE_SERVE

      this.articles = []
      this.totalArticles = 0
      this.phase = 'GROUP'
      this.error = ''
      this.generating = true
      controller = new AbortController()

      try {
        const resp = await fetch(`${baseUrl}/api/ai/article/generate`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json', Authorization: userStore.token },
          signal: controller.signal,
          body: JSON.stringify({ words, level, nickname: userStore.nickname }),
        })
        if (!resp.ok || !resp.body) throw new Error('AI 生成失败')

        const reader = resp.body.getReader()
        const decoder = new TextDecoder('utf-8')
        let fullText = ''
        while (true) {
          const { value, done } = await reader.read()
          if (done) break
          fullText += decoder.decode(value)
          this.parseAndApply(fullText)
          this.persist()
        }
        this.parseAndApply(fullText)
        this.persist()
      } catch (e: any) {
        if (e?.name !== 'AbortError') this.error = e?.message || '生成失败'
        this.persist()
      } finally {
        this.generating = false
        this.phase = ''
        controller = null
      }
    },

    /** 主动停止生成 */
    stop() {
      if (controller) controller.abort()
      this.generating = false
      this.phase = ''
      controller = null
      this.persist()
    },

    /** 解析累计的 SSE 文本，按 idx 拆分到各篇文章（幂等，可反复调用） */
    parseAndApply(fullText: string) {
      const markers: { type: string; idx: number; start: number; end: number }[] = []
      MARKER_RE.lastIndex = 0
      let m: RegExpExecArray | null
      while ((m = MARKER_RE.exec(fullText))) {
        const idxM = /idx=(\d+)/.exec(m[2])
        const totalM = /total=(\d+)/.exec(m[2])
        if (totalM) this.totalArticles = +totalM[1]
        markers.push({ type: m[1], idx: idxM ? +idxM[1] : -1, start: m.index, end: m.index + m[0].length })
      }

      for (let j = 0; j < markers.length; j++) {
        const mk = markers[j]
        const segEnd = j + 1 < markers.length ? markers[j + 1].start : fullText.length
        const seg = fullText.slice(mk.end, segEnd)

        if (mk.type === 'PLAN' && mk.idx >= 0) {
          this.ensureIdx(mk.idx)
          this.articles[mk.idx].plan = seg.replace(/^\n+/, '')
          this.phase = 'PLAN'
        } else if (mk.type === 'ARTICLE' && mk.idx >= 0) {
          this.ensureIdx(mk.idx)
          this.articles[mk.idx].content = seg.replace(/^\n+/, '')
          this.phase = 'ARTICLE'
        } else if (mk.type === 'META' && mk.idx >= 0) {
          this.ensureIdx(mk.idx)
          const t = seg.trim()
          if (t) {
            try {
              this.articles[mk.idx].meta = JSON.parse(t)
              this.articles[mk.idx].done = true
            } catch {
              /* 流式未完整，忽略 */
            }
          }
          this.phase = 'META'
        } else if (mk.type === 'ALL_DONE') {
          this.phase = 'ALL_DONE'
        }
      }
    },

    ensureIdx(idx: number) {
      while (this.articles.length <= idx) {
        this.articles.push({ content: '', plan: '', meta: null, done: false })
      }
    },
  },
})
