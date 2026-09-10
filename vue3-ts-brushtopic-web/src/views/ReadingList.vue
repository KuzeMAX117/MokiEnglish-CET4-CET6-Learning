<template>
  <div class="reading-page">
    <div class="page-header">
      <div class="header-left">
        <h2 class="page-title">
          <ReadOutlined class="title-icon" />
          文章阅读
        </h2>
        <p class="page-desc">精读外刊文章，提升阅读理解能力</p>
      </div>
      <div class="header-right">
        <a-radio-group v-model:value="level" button-style="solid" size="small">
          <a-radio-button :value="4">CET-4</a-radio-button>
          <a-radio-button :value="6">CET-6</a-radio-button>
        </a-radio-group>
      </div>
    </div>

    <div class="filter-row">
      <div
        v-for="tag in tags"
        :key="tag"
        class="filter-tag"
        :class="{ active: activeTag === tag }"
        @click="activeTag = tag"
      >
        {{ tag }}
      </div>
    </div>

    <div class="article-grid">
      <div
        v-for="article in articles"
        :key="article.id"
        class="article-card"
        @click="router.push(`/reading/${article.id}`)"
      >
        <div class="card-top">
          <span class="difficulty">
            <span v-for="i in article.difficulty" :key="i" class="diff-dot active"></span>
            <span v-for="i in (5 - article.difficulty)" :key="'e'+i" class="diff-dot"></span>
          </span>
          <span class="word-count">{{ article.wordCount }} 词</span>
        </div>
        <h3 class="article-title">{{ article.title }}</h3>
        <p class="article-preview">{{ article.preview }}</p>
        <div class="card-footer">
          <span class="source-tag">{{ article.source }}</span>
          <span class="read-count">{{ article.readCount || 0 }} 次阅读</span>
        </div>
      </div>
    </div>

    <a-empty v-if="!articles.length" description="暂无文章，敬请期待" />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { ReadOutlined } from '@ant-design/icons-vue'

const router = useRouter()
const level = ref(4)
const activeTag = ref('全部')

const tags = ['全部', '科技', '社会', '教育', '环境', '经济', '健康', '文化']

const articles = ref<any[]>([
  {
    id: 1,
    title: 'The Rise of Artificial Intelligence in Healthcare',
    preview: 'Artificial intelligence is transforming the healthcare industry in ways that were unimaginable a decade ago. From diagnosing diseases to developing personalized treatment plans...',
    source: 'The Guardian',
    difficulty: 3,
    wordCount: 520,
    readCount: 128,
    tags: '科技',
  },
  {
    id: 2,
    title: 'Climate Change and Its Impact on Global Agriculture',
    preview: 'As global temperatures continue to rise, farmers around the world are facing unprecedented challenges. Crop yields are declining in many regions due to extreme weather events...',
    source: 'BBC News',
    difficulty: 4,
    wordCount: 680,
    readCount: 95,
    tags: '环境',
  },
  {
    id: 3,
    title: 'The Future of Remote Work After the Pandemic',
    preview: 'The COVID-19 pandemic forced millions of people to work from home, fundamentally changing how we think about the workplace. As restrictions ease, companies are grappling with...',
    source: 'NYT',
    difficulty: 2,
    wordCount: 450,
    readCount: 210,
    tags: '社会',
  },
  {
    id: 4,
    title: 'Digital Literacy in the Modern Education System',
    preview: 'In today\'s digital age, being able to use technology effectively is as important as reading and writing. Schools and universities are increasingly incorporating digital skills...',
    source: 'The Economist',
    difficulty: 3,
    wordCount: 550,
    readCount: 76,
    tags: '教育',
  },
])
</script>

<style scoped lang="scss">
.reading-page {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;

  .page-title {
    font-size: calc(22px + var(--font-offset, 0px));
    font-weight: 800;
    color: var(--text-title);
    display: flex;
    align-items: center;
    gap: 10px;
    margin: 0;

    .title-icon { color: var(--primary); }
  }

  .page-desc {
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-muted);
    margin-top: 6px;
  }

  :deep(.ant-radio-button-wrapper) {
    background: var(--card-bg);
    border-color: var(--border);
    color: var(--text-body);

    &.ant-radio-button-wrapper-checked {
      background: var(--primary);
      color: #fff;
      border-color: var(--primary);
    }
  }
}

.filter-row {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;

  .filter-tag {
    padding: 7px 18px;
    border-radius: var(--radius-sm);
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-body);
    background: var(--card-bg);
    border: 1px solid var(--border);
    cursor: pointer;
    transition: all 0.25s;

    &:hover {
      border-color: var(--primary);
      color: var(--primary);
    }

    &.active {
      background: var(--primary-light);
      border-color: var(--primary);
      color: var(--primary);
    }
  }
}

.article-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
  gap: 16px;

  .article-card {
    background: var(--card-bg);
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    padding: 22px 24px;
    cursor: pointer;
    transition: all 0.28s;
    box-shadow: var(--shadow-card);

    &:hover {
      border-color: var(--primary);
      transform: translateY(-3px);
      box-shadow: var(--shadow-hover);
    }

    .card-top {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 12px;

      .difficulty {
        display: flex;
        gap: 4px;

        .diff-dot {
          width: 8px;
          height: 8px;
          border-radius: 50%;
          background: var(--border);

          &.active { background: var(--warning); }
        }
      }

      .word-count {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--text-muted);
      }
    }

    .article-title {
      font-size: calc(16px + var(--font-offset, 0px));
      font-weight: 700;
      color: var(--text-title);
      line-height: 1.4;
      margin: 0 0 10px;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .article-preview {
      font-size: calc(14px + var(--font-offset, 0px));
      color: var(--text-muted);
      line-height: 1.6;
      display: -webkit-box;
      -webkit-line-clamp: 3;
      -webkit-box-orient: vertical;
      overflow: hidden;
      margin: 0 0 14px;
    }

    .card-footer {
      display: flex;
      justify-content: space-between;
      align-items: center;

      .source-tag {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--primary);
        background: var(--primary-light);
        border: 1px solid var(--primary);
        padding: 2px 10px;
        border-radius: 6px;
      }

      .read-count {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--text-muted);
      }
    }
  }
}

:deep(.ant-empty-description) {
  color: var(--text-muted);
}
</style>
