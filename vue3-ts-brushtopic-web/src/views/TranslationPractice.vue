<template>
  <div class="trans-page">
    <div class="head-bar">
      <div class="back-bar" @click="router.push('/translation')">
        <LeftOutlined />
        <span>返回题目列表</span>
      </div>
      <div class="topic-title-bar">
        {{ topic.title }}
        <span class="topic-badge">{{ topic.level === 4 ? 'CET-4' : 'CET-6' }} · {{ topic.type }}</span>
      </div>
      <div class="direction-toggle">
        <a-button class="criteria-btn" size="small" @click="showCriteria = true">
          <FileSearchOutlined /> 评审标准
        </a-button>
        <a-radio-group v-model:value="direction" button-style="solid" size="small">
          <a-radio-button value="cn2en">中 → 英</a-radio-button>
          <a-radio-button value="en2cn">英 → 中</a-radio-button>
        </a-radio-group>
      </div>
    </div>

    <div class="trans-layout">
      <!-- 原文面板 -->
      <div class="source-panel">
        <div class="panel-head">
          <span class="panel-label">
            <FileTextOutlined /> {{ direction === 'cn2en' ? '中文原文' : 'English Source' }}
          </span>
          <span class="panel-hint">翻译下方段落</span>
        </div>
        <div class="source-body">
          <div
            v-for="(seg, sIdx) in currentSource"
            :key="sIdx"
            class="source-seg"
            :class="{ active: activeSegIdx === sIdx }"
            @click="activeSegIdx = sIdx"
          >
            <span class="seg-no">{{ sIdx + 1 }}</span>
            <span class="seg-text">{{ seg }}</span>
          </div>
        </div>
        <div class="source-foot">
          <a-button
            v-if="!showReference"
            type="link"
            size="small"
            @click="showReference = true"
          >
            <EyeOutlined /> 查看参考答案
          </a-button>
          <a-button
            v-else
            type="link"
            size="small"
            @click="showReference = false"
          >
            <EyeInvisibleOutlined /> 隐藏参考答案
          </a-button>
        </div>
        <transition name="slide">
          <div v-if="showReference" class="reference-box">
            <div class="ref-label">参考答案</div>
            <div
              v-for="(seg, sIdx) in currentReference"
              :key="sIdx"
              class="ref-seg"
            >
              <span class="seg-no">{{ sIdx + 1 }}</span>
              <span class="seg-text">{{ seg }}</span>
            </div>
          </div>
        </transition>
      </div>

      <!-- 翻译输入面板 -->
      <div class="target-panel">
        <div class="panel-head">
          <span class="panel-label">
            <EditOutlined /> {{ direction === 'cn2en' ? 'English Translation' : '中文翻译' }}
          </span>
          <span v-if="result.score !== null" class="score-badge">
            {{ result.score }}/15
          </span>
        </div>
        <div class="target-body">
          <div
            v-for="(seg, sIdx) in currentSource"
            :key="sIdx"
            class="input-seg"
            :class="{ active: activeSegIdx === sIdx }"
            @click="activeSegIdx = sIdx"
          >
            <span class="seg-no">{{ sIdx + 1 }}</span>
            <textarea
              v-model="translations[sIdx]"
              class="seg-input"
              :placeholder="direction === 'cn2en' ? 'Translate this sentence...' : '翻译此句...'"
              :rows="3"
              @focus="activeSegIdx = sIdx"
            />
          </div>
        </div>
        <div class="target-actions">
          <a-button @click="clearAll">
            <ClearOutlined /> 清空
          </a-button>
          <a-button
            type="primary"
            :loading="submitting"
            :disabled="!hasContent"
            class="submit-btn"
            @click="submitTranslation"
          >
            <SendOutlined /> {{ resultStale ? '重新提交批改' : '提交批改' }}
          </a-button>
        </div>
      </div>
    </div>

    <!-- AI 批改结果 -->
    <div v-if="submitted && !submitting && result.score !== null" class="result-section">
      <div class="result-head">
        <RobotOutlined class="result-icon" />
        <span class="result-title">AI 批改结果</span>
        <span v-if="resultStale" class="result-stale">译文已修改，当前结果为修改前的批改</span>
        <span class="result-band" :class="'band-' + result.band">{{ result.bandLabel }}</span>
        <span class="result-score">{{ result.score }} / 15 分</span>
      </div>

      <div class="result-grid">
        <div class="dim-card">
          <div class="dim-score" :class="dimColor(result.accuracy)">{{ result.accuracy }}</div>
          <div class="dim-label">准确度 / 完整度</div>
          <div class="dim-bar"><div class="dim-fill" :style="{ width: (result.accuracy / 5 * 100) + '%' }"></div></div>
        </div>
        <div class="dim-card">
          <div class="dim-score" :class="dimColor(result.fluency)">{{ result.fluency }}</div>
          <div class="dim-label">流畅连贯</div>
          <div class="dim-bar"><div class="dim-fill cyan" :style="{ width: (result.fluency / 5 * 100) + '%' }"></div></div>
        </div>
        <div class="dim-card">
          <div class="dim-score" :class="dimColor(result.grammar)">{{ result.grammar }}</div>
          <div class="dim-label">语法 / 拼写</div>
          <div class="dim-bar"><div class="dim-fill green" :style="{ width: (result.grammar / 5 * 100) + '%' }"></div></div>
        </div>
      </div>

      <div class="overall-box">
        <div class="section-title">总体评价</div>
        <div class="overall-text">{{ result.overall }}</div>
      </div>

      <!-- 逐句批改 -->
      <div v-if="result.details.length" class="detail-section">
        <div class="section-title">逐句批改</div>
        <div v-for="(d, idx) in result.details" :key="idx" class="detail-card">
          <div class="detail-no">第 {{ idx + 1 }} 句</div>
          <div class="detail-original">
            <span class="detail-label">原文：</span>{{ d.source }}
          </div>
          <div class="detail-user">
            <span class="detail-label">你的翻译：</span>
            <span class="user-trans">
              <template v-for="(seg, segIdx) in buildSegments(d)" :key="segIdx">
                <a-tooltip v-if="seg.error" placement="top">
                  <template #title>
                    <div class="err-tip">
                      <div class="tip-line">【{{ severityLabel(seg.error.severity) }}·{{ errTypeMeta(seg.error.type)?.label }}】{{ seg.error.explanation }}</div>
                      <div v-if="seg.error.suggestion" class="tip-line tip-sug">建议替换：{{ seg.error.suggestion }}</div>
                      <div class="tip-line tip-impact">影响：{{ seg.error.impact }}</div>
                    </div>
                  </template>
                  <span
                    class="err-mark"
                    :class="[seg.error.severity === 'serious' ? 'sev-serious' : 'sev-minor', 'err-' + (seg.error.type || 'expression')]"
                  >{{ seg.text }}</span>
                </a-tooltip>
                <span v-else>{{ seg.text }}</span>
              </template>
            </span>
          </div>
          <div v-if="d.completeness" class="detail-completeness">
            <span class="detail-label">完整度：</span>{{ d.completeness }}
          </div>
          <div v-if="d.errors.length" class="detail-errors">
            <div v-for="(err, eIdx) in d.errors" :key="eIdx" class="error-item">
              <span class="err-sev-tag" :class="err.severity === 'serious' ? 'sev-serious' : 'sev-minor'">
                {{ severityLabel(err.severity) }}
              </span>
              <span class="err-type-tag" :class="'tag-' + (err.type || 'expression')">
                {{ errTypeMeta(err.type)?.label }}
              </span>
              <span v-if="err.errorText" class="err-orig">{{ err.errorText }}</span>
              <span class="err-text">{{ err.explanation }}</span>
              <span v-if="err.suggestion" class="err-sug">建议替换：{{ err.suggestion }}</span>
              <span class="err-impact" :class="{ 'impact-serious': err.severity === 'serious' }">{{ err.impact }}</span>
            </div>
          </div>
          <!-- 两版修改建议 -->
          <div v-if="d.polishedConservative || d.polishedAdvanced" class="polished-group">
            <div v-if="d.polishedConservative" class="polished-item conservative">
              <span class="polished-tag">保守稳妥版</span>
              <span class="polished-text">{{ d.polishedConservative }}</span>
            </div>
            <div v-if="d.polishedAdvanced" class="polished-item advanced">
              <span class="polished-tag">进阶润色版</span>
              <span class="polished-text">{{ d.polishedAdvanced }}</span>
            </div>
          </div>
          <div class="detail-ref">
            <span class="detail-label">参考翻译：</span>{{ d.reference }}
          </div>
          <div v-if="d.comment" class="detail-comment">
            <BulbOutlined class="comment-icon" />
            {{ d.comment }}
          </div>
        </div>
      </div>

      <!-- 考生自查清单 -->
      <div v-if="result.selfCheckList.length" class="checklist-box">
        <div class="section-title">考生自查清单</div>
        <ul class="checklist">
          <li v-for="(c, cIdx) in result.selfCheckList" :key="cIdx">{{ c }}</li>
        </ul>
      </div>
    </div>
    <!-- 四六级评审标准弹窗（作文 + 翻译官方评分标准） -->
    <a-modal
      v-model:open="showCriteria"
      title="四六级评审标准（作文 · 翻译）"
      :footer="null"
      width="760px"
      wrap-class-name="criteria-modal-wrap"
    >
      <div class="criteria-body">
        <div class="criteria-note">
          档次描述引自《全国大学英语四、六级考试大纲（2016 修订版）》评分标准原文；作文与翻译均采用总体印象评分法，满分 15 分。
          四级、六级档次文字描述一致，同档次六级对质量要求更高。
        </div>
        <div class="criteria-section">
          <div class="criteria-title">一、作文评分标准</div>
          <div class="band-table">
            <div class="band-row band-head">
              <span>档次</span><span>分数区间</span><span>官方原文描述</span>
            </div>
            <div v-for="b in writingBands" :key="b.band" class="band-row">
              <span class="band-tag">{{ b.band }}</span>
              <span class="band-range">{{ b.range }}</span>
              <span class="band-desc">{{ b.desc }}</span>
            </div>
          </div>
        </div>
        <div class="criteria-section">
          <div class="criteria-title">二、翻译评分标准</div>
          <div class="band-table">
            <div class="band-row band-head">
              <span>档次</span><span>分数区间</span><span>官方原文描述</span>
            </div>
            <div v-for="b in transBands" :key="b.band" class="band-row">
              <span class="band-tag">{{ b.band }}</span>
              <span class="band-range">{{ b.range }}</span>
              <span class="band-desc">{{ b.desc }}</span>
            </div>
          </div>
        </div>
        <div class="criteria-section">
          <div class="criteria-title">三、本页翻译批改执行规则</div>
          <ul class="criteria-list">
            <li><b>未作答判定</b>：空白、单个字符、纯数字、乱码一律视为未作答；全部未作答或整篇与原文语义完全无关为 0 分档。</li>
            <li><b>漏译降档上限</b>：设 p = 有效作答句数 / 总句数，p=100% 才可评 14 档；p≥80% 上限 11 档；p≥60% 上限 8 档；p≥40% 上限 5 档；p>0 上限 2 档。</li>
            <li><b>档内取值</b>：已译部分准确流畅无错误取档次区间上沿，仅轻微小错取中，有严重错误取下沿。</li>
            <li><b>错误分级</b>：serious（缺谓语、时态严重混乱、主谓不一致、核心专有名词/事实错译、整句语义颠倒）会降档；minor（冠词、介词、单复数、轻微拼写）仅小幅扣分。</li>
            <li><b>辅助维度</b>：accuracy（信息准确/完整度）、fluency（可读连贯）、grammar（语法/拼写），各 0–5 分。</li>
            <li><b>评分透明</b>：每次批改结果的定档依据（bandReason）会注明大纲规则、实操规则与系统校准过程。</li>
          </ul>
        </div>
      </div>
    </a-modal>
  </div>
</template>

<script setup lang="ts">
import { computed, ref, reactive, watch, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { message } from 'ant-design-vue'
import { apiCorrectTranslation } from '@/api/ai'
import type { TranslationCoreInfoItem, TranslationCorrectionDetail, TranslationCorrectionResult, TranslationErrorItem } from '@/types'
import {
  LeftOutlined,
  FileTextOutlined,
  EditOutlined,
  SendOutlined,
  ClearOutlined,
  RobotOutlined,
  EyeOutlined,
  EyeInvisibleOutlined,
  BulbOutlined,
  FileSearchOutlined,
} from '@ant-design/icons-vue'

const route = useRoute()
const router = useRouter()

const direction = ref<'cn2en' | 'en2cn'>('cn2en')
const activeSegIdx = ref(0)
const showReference = ref(false)
const submitted = ref(false)
const submitting = ref(false)
const showCriteria = ref(false)

// 四六级官方评分标准档次表（评审标准弹窗展示，描述引自大纲 2016 修订版）
const writingBands = [
  { band: '14分档', range: '13–15', desc: '切题。表达思想清楚，文字通顺、连贯，基本上无语言错误。' },
  { band: '11分档', range: '10–12', desc: '切题。表达思想清楚，文字连贯，但有少量语言错误。' },
  { band: '8分档', range: '7–9', desc: '基本切题。有些地方表达思想不够清楚，文字勉强连贯，语言错误相当多，其中有一些是严重错误。' },
  { band: '5分档', range: '4–6', desc: '基本切题。表达思想不清楚，连贯性差，有相当多的严重语言错误。' },
  { band: '2分档', range: '1–3', desc: '条理不清，思路紊乱，语言支离破碎，只有个别句子与主题相关。' },
  { band: '0分档', range: '0', desc: '未写任何文字，或只有几个与主题无关的孤立单词。' },
]
const transBands = [
  { band: '14分档', range: '13–15', desc: '译文准确表达了原文的意思。译文流畅，结构清晰，用词贴切，基本无语言错误，仅有个别小错。' },
  { band: '11分档', range: '10–12', desc: '译文基本表达了原文的意思。结构较清晰，语言通顺，但有少量语言错误。' },
  { band: '8分档', range: '7–9', desc: '译文勉强表达了原文的意思。译文勉强连贯，语言错误相当多，其中有一些是严重错误。' },
  { band: '5分档', range: '4–6', desc: '译文仅表达了一小部分原文的意思。连贯性差，有相当多的严重语言错误。' },
  { band: '2分档', range: '1–3', desc: '译文支离破碎。除个别词语或句子，绝大部分文字没有表达原文意思。' },
  { band: '0分档', range: '0', desc: '未作答；仅有孤立单词；译文与原文语义完全无关。（阅卷执行标准）' },
]

interface TransTopic {
  id: number
  title: string
  level: 4 | 6
  type: string
  chineseSource: string[]
  englishReference: string[]
}

// 所有题目数据（与 TranslationList 共享同一数据源）
const allTopics: TransTopic[] = [
  {
    id: 1, title: '中国的传统节日', level: 4, type: '真题',
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
    id: 2, title: '高铁与中国经济', level: 4, type: '真题',
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
    id: 3, title: '互联网与教育变革', level: 4, type: '真题',
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
  {
    id: 4, title: '中华饮食文化', level: 6, type: '真题',
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
    id: 5, title: '数字经济与科技创新', level: 6, type: '真题',
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
    id: 6, title: '乡村振兴与城乡发展', level: 6, type: '真题',
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
  {
    id: 7, title: '移动支付与生活', level: 4, type: '练习',
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
    id: 8, title: '共享单车与绿色出行', level: 4, type: '练习',
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
  {
    id: 9, title: '人工智能的伦理挑战', level: 6, type: '练习',
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
    id: 10, title: '非物质文化遗产保护', level: 6, type: '练习',
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
]

// 根据路由参数加载题目
const topicId = computed(() => Number(route.params.id))
const topic = computed(() => {
  const found = allTopics.find((t) => t.id === topicId.value)
  return found || allTopics[0]
})

/**
 * 根据翻译方向动态返回原文和参考答案
 * - cn2en（中→英）：原文=中文，参考=英文
 * - en2cn（英→中）：原文=英文，参考=中文
 */
const currentSource = computed(() => {
  return direction.value === 'cn2en'
    ? topic.value.chineseSource
    : topic.value.englishReference
})

const currentReference = computed(() => {
  return direction.value === 'cn2en'
    ? topic.value.englishReference
    : topic.value.chineseSource
})

const translations = ref<string[]>([])

const hasContent = computed(() => translations.value.some((t) => t.trim().length > 0))

const result = reactive({
  band: 0,
  score: null as number | null,
  bandLabel: '',
  bandDescription: '',
  bandReason: '',
  levelScene: '',
  accuracy: 0,
  fluency: 0,
  grammar: 0,
  overall: '',
  coreInfoCheck: [] as TranslationCoreInfoItem[],
  selfCheckList: [] as string[],
  details: [] as TranslationCorrectionDetail[],
})

/** 重置批改结果全部字段 */
const resetResult = () => {
  result.band = 0
  result.score = null
  result.bandLabel = ''
  result.bandDescription = ''
  result.bandReason = ''
  result.levelScene = ''
  result.accuracy = 0
  result.fluency = 0
  result.grammar = 0
  result.overall = ''
  result.coreInfoCheck = []
  result.selfCheckList = []
  result.details = []
}

/** 最近一次提交批改成功时的译文快照，用于判断当前展示的结果是否因内容修改而失效 */
const gradedTranslations = ref<string[]>([])

/** 当前输入内容的归一化快照 */
const currentSnapshot = () => translations.value.map((t) => t || '')

/** 结果陈旧：已有提交结果但输入与批改时快照不一致，展示的仍是旧结果 */
const resultStale = computed(
  () =>
    submitted.value &&
    result.score !== null &&
    JSON.stringify(gradedTranslations.value) !== JSON.stringify(currentSnapshot()),
)

// ======================== AI 错误类型/分级标识 ========================

const ERR_TYPE_META: Record<string, { label: string }> = {
  spelling: { label: '拼写错误' },
  grammar: { label: '语法错误' },
  word_choice: { label: '用词不当' },
  expression: { label: '表达不地道' },
  omission: { label: '漏译' },
  completeness: { label: '完整度' },
}

const errTypeMeta = (type?: string) => ERR_TYPE_META[type || ''] || { label: '其他问题' }

/** 错误分级：严重错误（会降档）/ 轻微小错 */
const severityLabel = (sev?: string) => (sev === 'serious' ? '严重错误' : '轻微小错')

interface TransSegment {
  text: string
  error: TranslationErrorItem | null
}

/**
 * 将用户译文按 AI 返回的错误片段切分为高亮/普通分段，
 * 重叠或未命中的 errorText 直接忽略，避免高亮错位。
 */
const buildSegments = (d: TranslationCorrectionDetail): TransSegment[] => {
  const text = d.userTranslation || ''
  if (!text) return []
  const ranges: { start: number; end: number; error: TranslationErrorItem }[] = []
  for (const err of d.errors || []) {
    if (!err.errorText) continue
    const idx = text.indexOf(err.errorText)
    if (idx < 0) continue
    const end = idx + err.errorText.length
    if (ranges.some((r) => idx < r.end && end > r.start)) continue
    ranges.push({ start: idx, end, error: err })
  }
  ranges.sort((a, b) => a.start - b.start)
  const segs: TransSegment[] = []
  let cursor = 0
  for (const r of ranges) {
    if (r.start > cursor) segs.push({ text: text.slice(cursor, r.start), error: null })
    segs.push({ text: text.slice(r.start, r.end), error: r.error })
    cursor = r.end
  }
  if (cursor < text.length) segs.push({ text: text.slice(cursor), error: null })
  return segs
}

// ======================== 界面进度保存/恢复 ========================

const progressKey = (dir = direction.value) => `trans-progress-${topicId.value}-${dir}`
let saveTimer: ReturnType<typeof setTimeout> | null = null

const saveProgress = () => {
  try {
    localStorage.setItem(
      progressKey(),
      JSON.stringify({
        translations: translations.value,
        submitted: submitted.value,
        graded: gradedTranslations.value,
        result: {
          band: result.band,
          score: result.score,
          bandLabel: result.bandLabel,
          bandDescription: result.bandDescription,
          bandReason: result.bandReason,
          levelScene: result.levelScene,
          accuracy: result.accuracy,
          fluency: result.fluency,
          grammar: result.grammar,
          overall: result.overall,
          coreInfoCheck: result.coreInfoCheck,
          selfCheckList: result.selfCheckList,
          details: result.details,
        },
        savedAt: Date.now(),
      })
    )
  } catch {
    // 存储满等异常忽略，不影响练习
  }
}

/** 内容变化后防抖自动保存进度 */
watch([translations, submitted, () => result.score], () => {
  if (saveTimer) clearTimeout(saveTimer)
  saveTimer = setTimeout(saveProgress, 600)
}, { deep: true })

const restoreProgress = () => {
  activeSegIdx.value = 0
  showReference.value = false
  translations.value = currentSource.value.map(() => '')
  resetResult()
  gradedTranslations.value = []
  submitted.value = false

  try {
    const raw = localStorage.getItem(progressKey())
    if (!raw) return
    const saved = JSON.parse(raw)
    if (Array.isArray(saved.translations) && saved.translations.length === currentSource.value.length) {
      translations.value = saved.translations
    }
    // 旧版进度无 graded 字段时按与当前输入一致处理，避免误报陈旧
    gradedTranslations.value = Array.isArray(saved.graded)
      ? saved.graded
      : Array.isArray(saved.translations)
        ? saved.translations
        : []
    if (saved.result && saved.result.score !== null && saved.result.score !== undefined) {
      Object.assign(result, saved.result)
      submitted.value = !!saved.submitted
    }
    if (hasContent.value || result.score !== null) {
      message.info('已恢复上次练习进度')
    }
  } catch {
    localStorage.removeItem(progressKey())
  }
}

const resetState = () => {
  restoreProgress()
}

watch(direction, () => {
  resetState()
})

watch(topicId, () => {
  resetState()
})

onMounted(() => {
  resetState()
})

const clearAll = () => {
  translations.value = currentSource.value.map(() => '')
  submitted.value = false
  resetResult()
  gradedTranslations.value = []
  localStorage.removeItem(progressKey())
}

const dimColor = (val: number) => {
  if (val >= 4) return 'good'
  if (val >= 3) return 'mid'
  return 'low'
}

const applyResult = (data: TranslationCorrectionResult) => {
  result.band = data.band
  result.score = data.score
  result.bandLabel = data.bandLabel
  result.bandDescription = data.bandDescription
  result.bandReason = data.bandReason
  result.levelScene = data.levelScene
  result.accuracy = data.accuracy
  result.fluency = data.fluency
  result.grammar = data.grammar
  result.overall = data.overall
  result.coreInfoCheck = data.coreInfoCheck || []
  result.selfCheckList = data.selfCheckList || []
  result.details = data.details || []
}

const submitTranslation = async () => {
  submitting.value = true
  try {
    const res = await apiCorrectTranslation({
      direction: direction.value,
      level: topic.value.level,
      topic: topic.value.title,
      items: currentSource.value.map((src, idx) => ({
        source: src,
        reference: currentReference.value[idx],
        userTranslation: translations.value[idx] || '',
      })),
    })
    applyResult(res.data)
    gradedTranslations.value = currentSnapshot()
    submitted.value = true
    saveProgress()
    message.success('批改完成！')
  } catch {
    submitted.value = false
  } finally {
    submitting.value = false
  }
}
</script>

<style scoped lang="scss">
.trans-page {
  display: flex;
  flex-direction: column;
  gap: 18px;
}

.head-bar {
  display: flex;
  align-items: center;
  gap: 18px;
  flex-wrap: wrap;

  .back-bar {
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-muted);
    cursor: pointer;
    transition: color 0.2s;
    flex-shrink: 0;

    &:hover { color: var(--primary); }
  }

  .topic-title-bar {
    font-size: calc(18px + var(--font-offset, 0px));
    font-weight: 700;
    color: var(--text-title);
    flex: 1;
    display: flex;
    align-items: center;
    gap: 10px;

    .topic-badge {
      font-size: calc(12px + var(--font-offset, 0px));
      font-weight: 600;
      color: var(--primary);
      background: var(--primary-light);
      border: 1px solid var(--primary);
      padding: 2px 10px;
      border-radius: 6px;
    }
  }

  .direction-toggle {
    display: flex;
    align-items: center;
    gap: 10px;
    flex-shrink: 0;
  }

  .criteria-btn {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    font-size: calc(12px + var(--font-offset, 0px));
    color: var(--text-body);
    border-color: var(--border);
    background: var(--card-bg);

    &:hover {
      color: var(--primary);
      border-color: var(--primary);
    }
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

.trans-layout {
  display: flex;
  gap: 16px;
  min-height: 420px;
}

.source-panel,
.target-panel {
  flex: 1;
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  display: flex;
  flex-direction: column;
  overflow: hidden;
  box-shadow: var(--shadow-card);

  .panel-head {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 14px 20px;
    border-bottom: 1px solid var(--border);

    .panel-label {
      font-size: calc(15px + var(--font-offset, 0px));
      font-weight: 600;
      color: var(--text-title);
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .panel-hint {
      font-size: calc(12px + var(--font-offset, 0px));
      color: var(--text-muted);
    }

    .score-badge {
      font-size: calc(14px + var(--font-offset, 0px));
      font-weight: 700;
      color: var(--success);
      background: var(--success-light);
      border: 1px solid var(--success);
      padding: 3px 12px;
      border-radius: var(--radius-sm);
    }
  }
}

.source-body {
  flex: 1;
  overflow-y: auto;
  padding: 16px 20px;

  .source-seg {
    display: flex;
    gap: 12px;
    padding: 12px 14px;
    border-radius: var(--radius-sm);
    cursor: pointer;
    transition: all 0.2s;
    margin-bottom: 8px;

    &:hover {
      background: var(--primary-light);
    }

    &.active {
      background: var(--primary-light);
      border-left: 3px solid var(--primary);
    }

    .seg-no {
      width: 24px;
      height: 24px;
      border-radius: 50%;
      background: var(--primary-light);
      color: var(--primary);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: calc(12px + var(--font-offset, 0px));
      font-weight: 700;
      flex-shrink: 0;
      margin-top: 1px;
    }

    .seg-text {
      font-size: calc(15px + var(--font-offset, 0px));
      color: var(--text-body);
      line-height: 1.8;
    }
  }
}

.source-foot {
  padding: 10px 20px;
  border-top: 1px solid var(--border);
}

.reference-box {
  padding: 14px 20px;
  border-top: 1px solid var(--border);
  background: var(--success-light);

  .ref-label {
    font-size: calc(12px + var(--font-offset, 0px));
    color: var(--success);
    font-weight: 600;
    margin-bottom: 10px;
  }

  .ref-seg {
    display: flex;
    gap: 12px;
    padding: 8px 0;

    .seg-no {
      width: 20px;
      height: 20px;
      border-radius: 50%;
      background: var(--success-light);
      color: var(--success);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: calc(11px + var(--font-offset, 0px));
      font-weight: 700;
      flex-shrink: 0;
      margin-top: 2px;
    }

    .seg-text {
      font-size: calc(14px + var(--font-offset, 0px));
      color: var(--text-body);
      line-height: 1.7;
      font-style: italic;
    }
  }
}

.target-body {
  flex: 1;
  overflow-y: auto;
  padding: 16px 20px;

  .input-seg {
    display: flex;
    gap: 12px;
    padding: 10px 14px;
    border-radius: var(--radius-sm);
    cursor: pointer;
    transition: all 0.2s;
    margin-bottom: 8px;
    border: 1px solid transparent;

    &:hover {
      background: var(--primary-light);
    }

    &.active {
      background: var(--primary-light);
      border-color: var(--primary);
    }

    .seg-no {
      width: 24px;
      height: 24px;
      border-radius: 50%;
      background: var(--primary-light);
      color: var(--primary);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: calc(12px + var(--font-offset, 0px));
      font-weight: 700;
      flex-shrink: 0;
      margin-top: 6px;
    }

    .seg-input {
      flex: 1;
      background: var(--page-bg);
      border: 1px solid var(--border);
      border-radius: var(--radius-sm);
      color: var(--text-title);
      font-size: calc(14px + var(--font-offset, 0px));
      line-height: 1.7;
      padding: 8px 12px;
      resize: none;
      font-family: inherit;
      outline: none;
      transition: border-color 0.2s;

      &::placeholder {
        color: var(--text-muted);
      }

      &:focus {
        border-color: var(--primary);
        box-shadow: 0 0 0 2px var(--primary-light);
      }
    }
  }
}

.target-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 20px;
  border-top: 1px solid var(--border);

  .submit-btn {
    height: 38px;
    border-radius: var(--radius-sm);
    border: none;
    background: var(--primary);
    font-weight: 600;

    &:hover {
      background: var(--primary-hover) !important;
    }

    &:disabled {
      background: var(--border);
      color: var(--text-muted);
    }
  }
}

.result-section {
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  padding: 24px;
  box-shadow: var(--shadow-card);

  .result-head {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 20px;

    .result-icon {
      font-size: calc(20px + var(--font-offset, 0px));
      color: var(--primary);
    }

    .result-title {
      font-size: calc(17px + var(--font-offset, 0px));
      font-weight: 700;
      color: var(--text-title);
    }

    .result-band {
      margin-left: auto;
      font-size: calc(13px + var(--font-offset, 0px));
      font-weight: 700;
      padding: 3px 12px;
      border-radius: 20px;
      border: 1px solid transparent;

      &.band-14 { color: var(--success); background: var(--success-light); border-color: var(--success); }
      &.band-11 { color: #389e0d; background: rgba(82, 196, 26, 0.12); border-color: #52c41a; }
      &.band-8 { color: var(--warning); background: var(--warning-light); border-color: var(--warning); }
      &.band-5 { color: #d46b08; background: rgba(250, 140, 22, 0.12); border-color: #fa8c16; }
      &.band-2 { color: var(--error); background: var(--error-light); border-color: var(--error); }
      &.band-0 { color: var(--text-muted); background: var(--border); border-color: var(--text-muted); }
    }

    .result-score {
      font-size: calc(18px + var(--font-offset, 0px));
      font-weight: 800;
      color: var(--success);
    }

    .result-stale {
      font-size: calc(12px + var(--font-offset, 0px));
      color: var(--warning);
      background: var(--warning-light);
      border: 1px solid var(--warning);
      padding: 2px 10px;
      border-radius: 20px;
    }
  }
}

.result-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 14px;
  margin-bottom: 24px;

  .dim-card {
    background: var(--page-bg);
    border: 1px solid var(--border);
    border-radius: var(--radius-md);
    padding: 18px;
    text-align: center;

    .dim-score {
      font-size: calc(32px + var(--font-offset, 0px));
      font-weight: 800;
      line-height: 1;

      &.good { color: var(--success); }
      &.mid { color: var(--warning); }
      &.low { color: var(--error); }
    }

    .dim-label {
      font-size: calc(13px + var(--font-offset, 0px));
      color: var(--text-muted);
      margin: 8px 0;
    }

    .dim-bar {
      height: 6px;
      background: var(--border);
      border-radius: 3px;
      overflow: hidden;

      .dim-fill {
        height: 100%;
        border-radius: 3px;
        background: var(--primary);
        transition: width 0.6s;

        &.cyan {
          background: var(--primary);
        }

        &.green {
          background: var(--success);
        }
      }
    }
  }
}

.section-title {
  font-size: calc(15px + var(--font-offset, 0px));
  font-weight: 700;
  color: var(--text-title);
  margin-bottom: 14px;
  padding-bottom: 8px;
  border-bottom: 1px solid var(--border);
}

.overall-box {
  margin-bottom: 24px;

  .overall-text {
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-body);
    line-height: 1.8;
  }
}

.detail-section {
  .detail-card {
    background: var(--page-bg);
    border: 1px solid var(--border);
    border-radius: var(--radius-md);
    padding: 18px;
    margin-bottom: 12px;

    .detail-no {
      font-size: calc(12px + var(--font-offset, 0px));
      font-weight: 700;
      color: var(--primary);
      margin-bottom: 10px;
    }

    .detail-original,
    .detail-user,
    .detail-completeness,
    .detail-ref {
      font-size: calc(14px + var(--font-offset, 0px));
      line-height: 1.7;
      margin-bottom: 6px;

      .detail-label {
        color: var(--text-muted);
        font-size: calc(12px + var(--font-offset, 0px));
      }
    }

    .detail-original { color: var(--text-body); }
    .detail-user {
      color: var(--text-title);

      .user-trans {
        .err-mark {
          padding: 0 2px;
          border-radius: 3px;
          cursor: help;
          text-underline-offset: 3px;

          &.sev-serious {
            color: var(--error);
            background: var(--error-light);
            text-decoration: underline wavy var(--error);
            font-weight: 600;
          }

          &.sev-minor {
            color: var(--warning);
            background: var(--warning-light);
            text-decoration: underline wavy var(--warning);
          }
        }
      }
    }
    .detail-completeness { color: var(--text-body); }
    .detail-ref { color: var(--success); font-style: italic; }

    .detail-errors {
      margin-top: 10px;

      .error-item {
        display: flex;
        align-items: baseline;
        flex-wrap: wrap;
        gap: 8px;
        font-size: calc(13px + var(--font-offset, 0px));
        color: var(--text-body);
        margin-bottom: 6px;

        .err-sev-tag {
          flex-shrink: 0;
          font-size: calc(12px + var(--font-offset, 0px));
          font-weight: 700;
          padding: 1px 8px;
          border-radius: 4px;

          &.sev-serious { color: #fff; background: var(--error); }
          &.sev-minor { color: var(--warning); background: var(--warning-light); }
        }

        .err-type-tag {
          flex-shrink: 0;
          font-size: calc(12px + var(--font-offset, 0px));
          font-weight: 600;
          padding: 1px 8px;
          border-radius: 4px;

          &.tag-spelling { color: var(--error); background: var(--error-light); }
          &.tag-grammar { color: var(--warning); background: var(--warning-light); }
          &.tag-word_choice,
          &.tag-expression { color: var(--primary); background: var(--primary-light); }
          &.tag-omission,
          &.tag-completeness { color: var(--text-muted); background: var(--border); }
        }

        .err-orig {
          font-weight: 600;
          color: var(--error);
        }

        .err-sug {
          color: var(--success);
          font-weight: 600;
        }

        .err-impact {
          font-size: calc(12px + var(--font-offset, 0px));
          color: var(--text-muted);

          &.impact-serious {
            color: var(--error);
            font-weight: 700;
          }
        }
      }
    }

    .detail-comment {
      margin-top: 10px;
      display: flex;
      align-items: flex-start;
      gap: 8px;
      font-size: calc(13px + var(--font-offset, 0px));
      color: var(--text-muted);
      background: var(--warning-light);
      border-left: 3px solid var(--warning);
      padding: 10px 14px;
      border-radius: 0 var(--radius-sm) var(--radius-sm) 0;

      .comment-icon { color: var(--warning); flex-shrink: 0; margin-top: 2px; }
    }

    .polished-group {
      margin-top: 12px;
      display: flex;
      flex-direction: column;
      gap: 8px;

      .polished-item {
        display: flex;
        align-items: baseline;
        gap: 10px;
        padding: 10px 14px;
        border-radius: var(--radius-sm);
        font-size: calc(13px + var(--font-offset, 0px));
        line-height: 1.7;

        .polished-tag {
          flex-shrink: 0;
          font-size: calc(12px + var(--font-offset, 0px));
          font-weight: 700;
          padding: 1px 8px;
          border-radius: 4px;
          background: var(--page-bg);
        }

        &.conservative {
          background: var(--primary-light);
          border-left: 3px solid var(--primary);

          .polished-tag { color: var(--primary); }
        }

        &.advanced {
          background: var(--success-light);
          border-left: 3px solid var(--success);

          .polished-tag { color: var(--success); }
        }

        .polished-text { color: var(--text-body); }
      }
    }
  }
}

.checklist-box {
  margin-top: 24px;

  .checklist {
    padding-left: 22px;

    li {
      font-size: calc(14px + var(--font-offset, 0px));
      color: var(--text-body);
      line-height: 1.9;
    }
  }
}

.slide-enter-active,
.slide-leave-active {
  transition: all 0.3s ease;
}
.slide-enter-from,
.slide-leave-to {
  opacity: 0;
  max-height: 0;
}
.slide-enter-to,
.slide-leave-from {
  opacity: 1;
  max-height: 400px;
}

@media (max-width: 900px) {
  .trans-layout {
    flex-direction: column;
  }

  .result-grid {
    grid-template-columns: 1fr;
  }
}
</style>

<style lang="scss">
/* 评审标准弹窗（modal 渲染在 body 下，不能用 scoped） */
.criteria-modal-wrap {
  .criteria-body {
    max-height: 62vh;
    overflow-y: auto;
    padding-right: 4px;
  }

  .criteria-note {
    font-size: calc(13px + var(--font-offset, 0px));
    color: var(--text-muted);
    line-height: 1.8;
    background: var(--primary-light);
    border: 1px solid var(--border);
    border-radius: 8px;
    padding: 10px 14px;
    margin-bottom: 16px;
  }

  .criteria-section {
    margin-bottom: 18px;
  }

  .criteria-title {
    font-size: calc(15px + var(--font-offset, 0px));
    font-weight: 700;
    color: var(--text-title);
    margin-bottom: 10px;
  }

  .band-table {
    border: 1px solid var(--border);
    border-radius: 8px;
    overflow: hidden;
  }

  .band-row {
    display: grid;
    grid-template-columns: 64px 64px 1fr;
    gap: 10px;
    padding: 8px 12px;
    border-bottom: 1px solid var(--border);
    font-size: calc(13px + var(--font-offset, 0px));
    color: var(--text-body);
    line-height: 1.7;

    &:last-child {
      border-bottom: none;
    }

    &.band-head {
      background: var(--page-bg);
      font-weight: 600;
      color: var(--text-title);
    }

    .band-tag {
      font-weight: 700;
      color: var(--primary);
    }

    .band-range {
      color: var(--text-muted);
    }
  }

  .criteria-list {
    margin: 0;
    padding-left: 18px;

    li {
      font-size: calc(13px + var(--font-offset, 0px));
      color: var(--text-body);
      line-height: 1.9;
      margin-bottom: 4px;
    }

    b {
      color: var(--text-title);
    }
  }
}

/* AI 批改错误悬浮提示（tooltip 渲染在 body 下，不能用 scoped） */
.err-tip {
  .tip-line {
    font-size: 13px;
    line-height: 1.6;
  }

  .tip-sug {
    margin-top: 4px;
    font-weight: 600;
    color: #95de64;
  }
}
</style>
