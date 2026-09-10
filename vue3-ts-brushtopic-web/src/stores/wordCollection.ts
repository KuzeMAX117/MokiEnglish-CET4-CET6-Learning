import { defineStore } from 'pinia'
import {
  apiGetCollection,
  apiAddCollection,
  apiRemoveCollection,
  type WordCollectionItem,
} from '@/api/word'

interface WordCollectionState {
  /** 是否已从后端加载过 */
  loaded: boolean
  loading: boolean
  /** 收藏单词列表（后端按收藏时间倒序返回） */
  words: WordCollectionItem[]
}

/**
 * 用户级全局生词本（阅读收藏）。
 * 独立于具体文章：任意文章页收藏的单词都汇入此处，
 * 进入任意文章时根据「词是否在生词本中」渲染高亮与侧栏。
 * 数据后端持久化，跨设备/刷新均保留。
 */
export const useWordCollectionStore = defineStore('wordCollection', {
  state: (): WordCollectionState => ({
    loaded: false,
    loading: false,
    words: [],
  }),
  getters: {
    count: (s) => s.words.length,
    /** 小写词集合（缓存，供高频高亮判断使用） */
    wordSet: (s) => new Set(s.words.map((x) => x.word)),
    /** 小写词 -> 条目映射（缓存，供释义快照查询） */
    wordMap: (s) => {
      const m: Record<string, WordCollectionItem> = {}
      for (const x of s.words) m[x.word] = x
      return m
    },
    /** 判断某词是否已收藏（统一小写比较） */
    has() {
      return (word: string) => this.wordSet.has((word || '').toLowerCase())
    },
    /** 取某词收藏时的释义快照 */
    meaningOf() {
      return (word: string) => this.wordMap[(word || '').toLowerCase()]?.meaning || ''
    },
  },
  actions: {
    /** 加载生词本；已加载则跳过（force 可强制刷新） */
    async load(force = false) {
      if (this.loading) return
      if (this.loaded && !force) return
      this.loading = true
      try {
        const res = await apiGetCollection()
        this.words = (res.data || []).map((x) => ({ ...x, word: (x.word || '').toLowerCase() }))
        this.loaded = true
      } finally {
        this.loading = false
      }
    },

    /** 收藏一个单词（携带前端已查得的释义快照，避免后端重复查词） */
    async add(data: WordCollectionItem) {
      const word = (data.word || '').toLowerCase()
      if (!word) return
      await apiAddCollection({ ...data, word })
      if (!this.words.some((x) => x.word === word)) {
        this.words.unshift({ ...data, word })
      }
    },

    /** 移除一个收藏单词 */
    async remove(word: string) {
      const w = (word || '').toLowerCase()
      if (!w) return
      await apiRemoveCollection(w)
      this.words = this.words.filter((x) => x.word !== w)
    },
  },
})
