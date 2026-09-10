<template>
  <div class="trans-list-page">
    <div class="page-header">
      <div class="header-left">
        <h2 class="page-title">
          <SwapOutlined class="title-icon" />
          翻译练习
        </h2>
        <p class="page-desc">四六级翻译真题 + 专项练习，AI 智能评分提升翻译能力</p>
      </div>
    </div>

    <div class="category-bar">
      <div
        v-for="cat in categories"
        :key="cat.key"
        class="cat-tab"
        :class="{ active: activeCategory === cat.key }"
        @click="activeCategory = cat.key"
      >
        <component :is="cat.icon" class="cat-icon" />
        <span>{{ cat.label }}</span>
        <span class="cat-count">{{ getCategoryCount(cat.key) }}</span>
      </div>
    </div>

    <div v-if="filteredTopics.length" class="topic-grid">
      <div
        v-for="topic in filteredTopics"
        :key="topic.id"
        class="topic-card"
        @click="router.push(`/translation/${topic.id}`)"
      >
        <div class="card-header">
          <span class="type-badge" :class="topic.type === '真题' ? 'real' : 'practice'">
            {{ topic.type }}
          </span>
          <span class="level-badge">CET-{{ topic.level }}</span>
          <span v-if="topic.done" class="done-badge">
            <CheckCircleFilled /> 已完成
          </span>
        </div>
        <h3 class="topic-title">{{ topic.title }}</h3>
        <p class="topic-desc">{{ topic.description }}</p>
        <div class="card-footer">
          <span class="sentence-count">{{ topic.chineseSource.length }} 句</span>
          <span v-if="topic.done" class="go-hint">再次练习 →</span>
          <span v-else class="go-hint">开始练习 →</span>
        </div>
      </div>
    </div>
    <a-empty v-else description="该分类暂无题目" />
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import {
  SwapOutlined,
  FileTextOutlined,
  BookOutlined,
  CheckCircleFilled,
} from '@ant-design/icons-vue'

const router = useRouter()

type CategoryKey = 'cet4-real' | 'cet6-real' | 'cet4-practice' | 'cet6-practice'

const activeCategory = ref<CategoryKey>('cet4-real')

const categories = [
  { key: 'cet4-real' as CategoryKey, label: '四级真题', icon: FileTextOutlined },
  { key: 'cet6-real' as CategoryKey, label: '六级真题', icon: FileTextOutlined },
  { key: 'cet4-practice' as CategoryKey, label: '四级练习', icon: BookOutlined },
  { key: 'cet6-practice' as CategoryKey, label: '六级练习', icon: BookOutlined },
]

interface TransTopic {
  id: number
  title: string
  level: 4 | 6
  type: '真题' | '练习'
  done: boolean
  description: string
  chineseSource: string[]
  englishReference: string[]
}

const allTopics = ref<TransTopic[]>([
  // ===== 四级真题 =====
  {
    id: 1,
    title: '中国的传统节日',
    level: 4,
    type: '真题',
    done: false,
    description: '关于春节等中国传统节日的文化介绍，考查节日习俗和文化传承相关表达。',
    chineseSource: [
      '春节是中国最重要的传统节日，通常在农历正月初一庆祝。',
      '在这一天，家人会团聚在一起，享用丰盛的年夜饭。',
      '孩子们会收到红包，里面装着长辈们给的压岁钱。',
      '人们还会放鞭炮、贴春联，以驱赶邪气，迎接新年的到来。',
      '春节不仅是一个节日，更是中华民族家庭和睦、文化传承的重要象征。',
    ],
    englishReference: [
      'The Spring Festival is the most important traditional holiday in China, usually celebrated on the first day of the first lunar month.',
      'On this day, family members gather together to enjoy a lavish New Year\'s Eve dinner.',
      'Children receive red envelopes containing lucky money given by their elders.',
      'People also set off firecrackers and paste Spring Festival couplets to ward off evil spirits and welcome the arrival of the new year.',
      'The Spring Festival is not just a holiday, but also an important symbol of family harmony and cultural heritage of the Chinese nation.',
    ],
  },
  {
    id: 2,
    title: '高铁与中国经济',
    level: 4,
    type: '真题',
    done: false,
    description: '中国高铁的发展及其对经济和社会的影响，考查交通与经济发展相关表达。',
    chineseSource: [
      '中国的高铁网络是世界上最大的，总里程超过4万公里。',
      '高铁极大地缩短了城市之间的旅行时间，促进了区域经济发展。',
      '许多上班族现在可以住在郊区城市，每天乘高铁到大城市上班。',
      '高铁建设也为制造业和服务业创造了大量就业机会。',
      '可以说，高铁已经成为中国现代化进程中的一个重要标志。',
    ],
    englishReference: [
      'China\'s high-speed rail network is the largest in the world, with a total length exceeding 40,000 kilometers.',
      'High-speed rail has greatly reduced travel time between cities and promoted regional economic development.',
      'Many commuters can now live in suburban cities and take high-speed trains to big cities for work every day.',
      'The construction of high-speed rail has also created a large number of jobs in manufacturing and service industries.',
      'It can be said that high-speed rail has become an important symbol of China\'s modernization.',
    ],
  },
  {
    id: 3,
    title: '互联网与教育变革',
    level: 4,
    type: '真题',
    done: false,
    description: '互联网技术对教育方式的深刻变革，考查科技与教育相关表达。',
    chineseSource: [
      '互联网的普及正在深刻改变着教育的方式和内容。',
      '越来越多的学生通过在线平台获取知识，不再受时间和地点的限制。',
      '人工智能技术的应用使得个性化学习成为可能。',
      '然而，在线教育也面临着学生自律性不足和互动性较差的挑战。',
      '未来的教育模式可能是线上与线下相结合的混合式教学。',
    ],
    englishReference: [
      'The popularization of the Internet is profoundly changing the methods and content of education.',
      'More and more students acquire knowledge through online platforms, no longer limited by time and place.',
      'The application of artificial intelligence technology makes personalized learning possible.',
      'However, online education also faces challenges such as insufficient student self-discipline and poor interactivity.',
      'The future education model may be a blended approach that combines online and offline teaching.',
    ],
  },
  // ===== 六级真题 =====
  {
    id: 4,
    title: '中华饮食文化',
    level: 6,
    type: '真题',
    done: false,
    description: '中国饮食文化的丰富内涵与哲学思想，考查文化深度表达。',
    chineseSource: [
      '中国饮食文化源远流长，蕴含着丰富的哲学思想和生活智慧。',
      '"色、香、味、形"是中国烹饪追求的四大标准。',
      '不同地区的饮食风格各异，形成了八大菜系。',
      '中国人注重"药食同源"，认为合理的饮食可以起到养生保健的作用。',
      '随着全球化的推进，中国饮食文化也在不断吸收外来元素，呈现出更加多元化的面貌。',
    ],
    englishReference: [
      'Chinese food culture has a long history, containing rich philosophical thoughts and wisdom of life.',
      '"Color, aroma, taste, and appearance" are the four standards pursued in Chinese cooking.',
      'Different regions have diverse food styles, forming eight major cuisines.',
      'Chinese people emphasize the concept of "food as medicine," believing that a reasonable diet can promote health and well-being.',
      'With the advancement of globalization, Chinese food culture is constantly absorbing external elements, presenting a more diversified appearance.',
    ],
  },
  {
    id: 5,
    title: '数字经济与科技创新',
    level: 6,
    type: '真题',
    done: false,
    description: '数字经济的快速发展与科技创新驱动，考查经济与科技领域的高级表达。',
    chineseSource: [
      '数字经济已经成为推动中国经济增长的重要引擎。',
      '大数据、云计算和人工智能等新兴技术正在深刻改变传统产业的运营模式。',
      '中国政府提出了"数字中国"战略，旨在加快数字化转型步伐。',
      '然而，数据安全和个人隐私保护仍然是数字经济发展面临的主要挑战。',
      '只有在创新与监管之间找到平衡，数字经济才能实现可持续发展。',
    ],
    englishReference: [
      'The digital economy has become an important engine driving China\'s economic growth.',
      'Emerging technologies such as big data, cloud computing, and artificial intelligence are profoundly transforming the operational models of traditional industries.',
      'The Chinese government has proposed the "Digital China" strategy, aiming to accelerate the pace of digital transformation.',
      'However, data security and personal privacy protection remain major challenges facing the development of the digital economy.',
      'Only by finding a balance between innovation and regulation can the digital economy achieve sustainable development.',
    ],
  },
  {
    id: 6,
    title: '乡村振兴与城乡发展',
    level: 6,
    type: '真题',
    done: false,
    description: '中国乡村振兴战略与城乡一体化发展，考查社会发展领域的高级表达。',
    chineseSource: [
      '乡村振兴战略是中国推动农业农村现代化的重大举措。',
      '通过发展特色产业和电子商务，许多农村地区实现了经济转型。',
      '越来越多的年轻人选择返乡创业，为农村发展注入了新的活力。',
      '城乡一体化发展有助于缩小城乡差距，促进社会公平。',
      '乡村振兴不仅关乎经济发展，更是保护和传承中华农耕文明的重要途径。',
    ],
    englishReference: [
      'The rural revitalization strategy is a major initiative by China to promote the modernization of agriculture and rural areas.',
      'Through the development of characteristic industries and e-commerce, many rural areas have achieved economic transformation.',
      'An increasing number of young people are choosing to return to their hometowns to start businesses, injecting new vitality into rural development.',
      'Integrated urban-rural development helps narrow the urban-rural gap and promote social equity.',
      'Rural revitalization is not only about economic development, but also an important way to protect and inherit Chinese agricultural civilization.',
    ],
  },
  // ===== 四级练习 =====
  {
    id: 7,
    title: '移动支付与生活',
    level: 4,
    type: '练习',
    done: false,
    description: '中国移动支付的普及及其对日常生活的改变，考查科技与生活相关表达。',
    chineseSource: [
      '移动支付已经成为中国人日常生活中不可或缺的一部分。',
      '无论是购物、就餐还是乘坐公共交通，人们都可以通过手机完成支付。',
      '支付宝和微信支付是最受欢迎的两大移动支付平台。',
      '移动支付的普及大大减少了人们携带现金的需求。',
      '然而，一些老年人和偏远地区的居民在使用移动支付时仍然面临困难。',
    ],
    englishReference: [
      'Mobile payment has become an indispensable part of Chinese people\'s daily lives.',
      'Whether shopping, dining, or taking public transportation, people can complete payments through their mobile phones.',
      'Alipay and WeChat Pay are the two most popular mobile payment platforms.',
      'The popularity of mobile payment has greatly reduced people\'s need to carry cash.',
      'However, some elderly people and residents in remote areas still face difficulties using mobile payment.',
    ],
  },
  {
    id: 8,
    title: '共享单车与绿色出行',
    level: 4,
    type: '练习',
    done: false,
    description: '共享单车的发展及其对城市交通和环境保护的影响。',
    chineseSource: [
      '共享单车在中国城市中迅速普及，成为短途出行的重要方式。',
      '用户只需通过手机扫码就可以租用和归还自行车。',
      '共享单车不仅缓解了城市交通拥堵问题，还减少了汽车尾气排放。',
      '然而，过度投放和管理不善也带来了乱停乱放等问题。',
      '政府和企业合作加强管理，使共享单车行业逐步走向规范化。',
    ],
    englishReference: [
      'Shared bicycles have rapidly spread across Chinese cities, becoming an important mode of short-distance travel.',
      'Users only need to scan a QR code with their mobile phones to rent and return bicycles.',
      'Shared bicycles not only alleviate urban traffic congestion but also reduce automobile exhaust emissions.',
      'However, excessive deployment and poor management have also led to problems such as random parking.',
      'The government and enterprises have cooperated to strengthen management, gradually standardizing the shared bicycle industry.',
    ],
  },
  // ===== 六级练习 =====
  {
    id: 9,
    title: '人工智能的伦理挑战',
    level: 6,
    type: '练习',
    done: false,
    description: '人工智能技术发展带来的伦理问题与社会思考，考查深度论述能力。',
    chineseSource: [
      '人工智能的快速发展在带来巨大便利的同时，也引发了一系列伦理问题。',
      '算法偏见可能导致招聘、贷款等领域的歧视性决策。',
      '自动驾驶技术在事故责任认定方面面临法律和道德的双重困境。',
      '深度伪造技术的滥用给信息真实性带来了前所未有的挑战。',
      '建立完善的AI伦理框架，需要政府、企业和学术界的共同努力。',
    ],
    englishReference: [
      'The rapid development of artificial intelligence, while bringing great convenience, has also raised a series of ethical issues.',
      'Algorithm bias may lead to discriminatory decisions in areas such as recruitment and lending.',
      'Autonomous driving technology faces a dual dilemma of law and morality in the determination of accident liability.',
      'The misuse of deepfake technology poses unprecedented challenges to the authenticity of information.',
      'Establishing a comprehensive AI ethics framework requires the joint efforts of the government, enterprises, and academia.',
    ],
  },
  {
    id: 10,
    title: '非物质文化遗产保护',
    level: 6,
    type: '练习',
    done: false,
    description: '中国非物质文化遗产的保护现状与传承挑战，考查文化保护领域的高级表达。',
    chineseSource: [
      '中国拥有丰富的非物质文化遗产，包括传统戏曲、民间工艺和口头文学等。',
      '随着现代化进程的加速，许多非物质文化遗产面临失传的危险。',
      '老一辈传承人的离去使得技艺传承面临断代危机。',
      '数字化技术的应用为非遗的保护和传播提供了新的手段。',
      '将非遗融入现代生活，是实现活态传承的有效途径。',
    ],
    englishReference: [
      'China possesses a wealth of intangible cultural heritage, including traditional operas, folk crafts, and oral literature.',
      'With the acceleration of modernization, many intangible cultural heritages face the danger of being lost.',
      'The passing away of older-generation inheritors has caused a generational crisis in skill transmission.',
      'The application of digital technology provides new means for the protection and dissemination of intangible cultural heritage.',
      'Integrating intangible cultural heritage into modern life is an effective way to achieve living inheritance.',
    ],
  },
])

const filteredTopics = computed(() => {
  const map: Record<CategoryKey, { level: number; type: string }> = {
    'cet4-real': { level: 4, type: '真题' },
    'cet6-real': { level: 6, type: '真题' },
    'cet4-practice': { level: 4, type: '练习' },
    'cet6-practice': { level: 6, type: '练习' },
  }
  const filter = map[activeCategory.value]
  return allTopics.value.filter(
    (t) => t.level === filter.level && t.type === filter.type
  )
})

const getCategoryCount = (key: CategoryKey) => {
  const map: Record<CategoryKey, { level: number; type: string }> = {
    'cet4-real': { level: 4, type: '真题' },
    'cet6-real': { level: 6, type: '真题' },
    'cet4-practice': { level: 4, type: '练习' },
    'cet6-practice': { level: 6, type: '练习' },
  }
  const filter = map[key]
  return allTopics.value.filter(
    (t) => t.level === filter.level && t.type === filter.type
  ).length
}
</script>

<style scoped lang="scss">
.trans-list-page {
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
}

.category-bar {
  display: flex;
  gap: 12px;

  .cat-tab {
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 12px 22px;
    border-radius: var(--radius-md);
    background: var(--card-bg);
    border: 1px solid var(--border);
    cursor: pointer;
    transition: all 0.25s;
    font-size: calc(14px + var(--font-offset, 0px));
    font-weight: 600;
    color: var(--text-body);

    .cat-icon {
      font-size: calc(15px + var(--font-offset, 0px));
    }

    .cat-count {
      margin-left: 4px;
      font-size: calc(12px + var(--font-offset, 0px));
      font-weight: 700;
      color: var(--text-muted);
      background: var(--border);
      padding: 1px 8px;
      border-radius: 8px;
    }

    &:hover {
      border-color: var(--primary);
      color: var(--primary);
    }

    &.active {
      background: var(--primary-light);
      border-color: var(--primary);
      color: var(--primary);

      .cat-count {
        color: var(--primary);
        background: var(--primary-light);
      }
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
      align-items: center;
      margin-bottom: 12px;

      .type-badge {
        font-size: calc(12px + var(--font-offset, 0px));
        padding: 2px 10px;
        border-radius: 6px;

        &.real {
          color: var(--primary);
          background: var(--primary-light);
          border: 1px solid var(--primary);
        }

        &.practice {
          color: var(--primary);
          background: var(--tag-2);
          border: 1px solid var(--primary);
        }
      }

      .level-badge {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--warning);
        background: var(--warning-light);
        border: 1px solid var(--warning);
        padding: 2px 10px;
        border-radius: 6px;
      }

      .done-badge {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--success);
        background: var(--success-light);
        border: 1px solid var(--success);
        padding: 2px 10px;
        border-radius: 6px;
        margin-left: auto;
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

      .sentence-count {
        font-size: calc(12px + var(--font-offset, 0px));
        color: var(--text-muted);
      }

      .go-hint {
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
