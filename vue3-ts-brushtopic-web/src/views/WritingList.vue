<template>
  <div class="writing-page">
    <div class="page-header">
      <div class="header-left">
        <h2 class="page-title">
          <EditOutlined class="title-icon" />
          作文批改
        </h2>
        <p class="page-desc">AI 智能批改，提升写作水平</p>
      </div>
      <div class="header-right">
        <a-radio-group v-model:value="level" button-style="solid" size="small">
          <a-radio-button :value="4">CET-4</a-radio-button>
          <a-radio-button :value="6">CET-6</a-radio-button>
        </a-radio-group>
      </div>
    </div>

    <div class="stats-row">
      <div class="stat-card">
        <div class="stat-num purple">{{ myStats.total }}</div>
        <div class="stat-label">已写作文</div>
      </div>
      <div class="stat-card">
        <div class="stat-num cyan">{{ myStats.avgScore }}</div>
        <div class="stat-label">平均分</div>
      </div>
      <div class="stat-card">
        <div class="stat-num gold">{{ myStats.bestScore }}</div>
        <div class="stat-label">最高分</div>
      </div>
    </div>

    <div class="topic-grid">
      <div
        v-for="topic in topics"
        :key="topic.id"
        class="topic-card"
        @click="router.push(`/writing/${topic.id}`)"
      >
        <div class="card-header">
          <span class="type-badge">{{ topic.typeLabel }}</span>
          <span class="level-badge">CET-{{ topic.level }}</span>
        </div>
        <h3 class="topic-title">{{ topic.title }}</h3>
        <p class="topic-desc">{{ topic.description }}</p>
        <div class="card-footer">
          <span class="word-limit">{{ topic.wordLimit }} 词</span>
          <span v-if="topic.myScore" class="my-score">{{ topic.myScore }}/15</span>
          <span v-else class="write-hint">去写作 →</span>
        </div>
      </div>
    </div>

    <a-empty v-if="!topics.length" description="暂无作文题目" />
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { EditOutlined } from '@ant-design/icons-vue'

const router = useRouter()
const level = ref(4)

const myStats = reactive({ total: 0, avgScore: 0, bestScore: 0 })

const topics = ref<any[]>([
  {
    id: 1,
    title: 'The Importance of Reading in the Digital Age',
    description: 'Write an essay on the importance of reading, discussing why reading remains essential despite the prevalence of digital media.',
    level: 4,
    type: 'essay',
    typeLabel: '议论文',
    wordLimit: 200,
    myScore: null,
  },
  {
    id: 2,
    title: 'A Letter of Application',
    description: 'Write a letter applying for a volunteer position at an international conference. Include your qualifications and motivation.',
    level: 4,
    type: 'letter',
    typeLabel: '应用文',
    wordLimit: 150,
    myScore: null,
  },
  {
    id: 3,
    title: 'Should Universities Charge Tuition Fees?',
    description: 'Some people believe university education should be free. Discuss both views and give your opinion.',
    level: 6,
    type: 'essay',
    typeLabel: '议论文',
    wordLimit: 250,
    myScore: null,
  },
  {
    id: 4,
    title: 'The Impact of Social Media on Young People',
    description: 'Write an essay discussing how social media affects the mental health and social skills of young people.',
    level: 6,
    type: 'essay',
    typeLabel: '议论文',
    wordLimit: 250,
    myScore: null,
  },
])
</script>

<style scoped lang="scss">
.writing-page {
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

.stats-row {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 14px;

  .stat-card {
    background: var(--card-bg);
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    padding: 18px 20px;
    text-align: center;
    box-shadow: var(--shadow-card);

    .stat-num {
      font-size: calc(26px + var(--font-offset, 0px));
      font-weight: 800;

      &.purple { color: var(--primary); }
      &.cyan { color: var(--primary); }
      &.gold { color: var(--warning); }
    }

    .stat-label {
      font-size: calc(13px + var(--font-offset, 0px));
      color: var(--text-muted);
      margin-top: 4px;
    }
  }
}

.topic-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
  gap: 16px;

  .topic-card {
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

    .card-header {
      display: flex;
      gap: 8px;
      margin-bottom: 12px;

      .type-badge {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--primary);
        background: var(--primary-light);
        border: 1px solid var(--primary);
        padding: 2px 10px;
        border-radius: 6px;
      }

      .level-badge {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--primary);
        background: var(--tag-2);
        border: 1px solid var(--primary);
        padding: 2px 10px;
        border-radius: 6px;
      }
    }

    .topic-title {
      font-size: calc(16px + var(--font-offset, 0px));
      font-weight: 700;
      color: var(--text-title);
      line-height: 1.4;
      margin: 0 0 10px;
    }

    .topic-desc {
      font-size: calc(14px + var(--font-offset, 0px));
      color: var(--text-muted);
      line-height: 1.6;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
      margin: 0 0 14px;
    }

    .card-footer {
      display: flex;
      justify-content: space-between;
      align-items: center;

      .word-limit {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--text-muted);
      }

      .my-score {
        font-size: calc(14px + var(--font-offset, 0px));
        font-weight: 700;
        color: var(--success);
      }

      .write-hint {
        font-size: calc(13px + var(--font-offset, 0px));
        color: var(--primary);
        font-weight: 600;
      }
    }
  }
}

:deep(.ant-empty-description) {
  color: var(--text-muted);
}
</style>
