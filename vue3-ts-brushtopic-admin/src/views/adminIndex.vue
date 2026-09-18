<script setup lang="ts">
import { useUserStore } from '@/stores/modules/user';
import { useSettingStore } from '@/stores/modules/setting';
import { ref, onMounted, watch, computed } from 'vue';
import * as echarts from 'echarts';
import dayjs from 'dayjs';
import { apiAdminHomeCount, apiAdminHomeCategory, apiTopicTrend, apiUserTrend, apiAiTrend } from '@/api/home';
import type { AdminLeftDataType, TopicTrendType } from '@/api/home/type';

const userStore = useUserStore();
const settingStore = useSettingStore();

const leftData = ref<AdminLeftDataType>();
const rightData = ref<any>();
const middleData = ref<TopicTrendType>();
const userTrend = ref<any>();
const aiTrend = ref<any>();

const currentTime = ref(dayjs().format('YYYY-MM-DD HH:mm'));

const statCards = computed(() => [
  { label: '刷题次数', value: leftData.value?.countTodayFrequency || 0, suffix: '次', icon: 'CodeOutlined', trend: leftData.value?.topicGrowthRate || 0, color: '#0a3442' },
  { label: 'AI调用', value: leftData.value?.aiCount || 0, suffix: '次', icon: 'RobotOutlined', trend: leftData.value?.aiGrowthRate || 0, color: '#104455' },
  { label: '用户总数', value: leftData.value?.userCount || 0, suffix: '名', icon: 'TeamOutlined', trend: leftData.value?.userGrowthRate || 0, color: '#3ad3cd' },
  { label: '题目数量', value: leftData.value?.totalTopicCount || 0, suffix: '题', icon: 'FileTextOutlined', color: '#7fffd4' },
  { label: '专题数量', value: leftData.value?.totalSubjectCount || 0, suffix: '个', icon: 'BookOutlined', color: '#0a3442' },
  { label: '标签数量', value: leftData.value?.topicLabelCount || 0, suffix: '个', icon: 'TagsOutlined', color: '#104455' }
]);

const miniChartRefs = ref<(HTMLDivElement | null)[]>([]);

const initMiniChart = (index: number, data: number[], color: string) => {
  const el = miniChartRefs.value[index];
  if (!el) return;
  const chart = echarts.init(el);
  chart.setOption({
    grid: { top: 5, right: 5, bottom: 5, left: 5 },
    xAxis: { type: 'category', show: false, data: data.map((_, i) => i) },
    yAxis: { type: 'value', show: false },
    series: [{ type: 'line', smooth: true, symbol: 'none', lineStyle: { width: 2, color }, areaStyle: { color: color + '25' }, data }]
  });
  window.addEventListener('resize', () => chart.resize());
};

const categoryChart = ref<HTMLDivElement | null>(null);
const topicTrendChart = ref<HTMLDivElement | null>(null);
const userGrowthChart = ref<HTMLDivElement | null>(null);
const aiCallChart = ref<HTMLDivElement | null>(null);

const initCategoryChart = () => {
  if (!categoryChart.value) return;
  const chart = echarts.init(categoryChart.value);
  chart.setOption({
    tooltip: { trigger: 'item', backgroundColor: 'rgba(255,255,255,0.95)', borderColor: '#eee', borderWidth: 1, textStyle: { color: '#333' } },
    animationDurationUpdate: (idx: number) => idx * 100,
    animationEasingUpdate: 'bounceIn' as const,
    series: [{
      type: 'graph', layout: 'force', force: { repulsion: 120, edgeLength: 15 },
      label: { show: true, formatter: ['{c|{c}}', '{b|{b}}'].join('\n'), fontSize: 12, color: '#fff', rich: { b: { fontSize: 11, color: '#fff', padding: [0, 0, 2, 0], align: 'center', width: 60 }, c: { fontSize: 14, color: '#fff', fontWeight: 'bold', align: 'center', width: 60 } } },
      itemStyle: { color: '#0a3442', opacity: 0.85, borderWidth: 2, borderColor: '#fff', shadowBlur: 10, shadowColor: 'rgba(10,52,66,0.3)' },
      data: (rightData.value || []).map((cat: any) => ({ name: cat.categoryName, value: cat.count, symbolSize: (cat.count === 0 ? 5 : cat.count) * 2.2, draggable: true }))
    }]
  });
  window.addEventListener('resize', () => chart.resize());
};

const initTopicTrendChart = () => {
  if (!topicTrendChart.value || !middleData.value) return;
  const chart = echarts.init(topicTrendChart.value);
  const isDark = settingStore.isDark;
  chart.setOption({
    backgroundColor: 'transparent',
    tooltip: { trigger: 'axis', backgroundColor: isDark ? '#1f1f1f' : '#fff', borderColor: isDark ? '#333' : '#eee', textStyle: { color: isDark ? '#fff' : '#333' } },
    legend: { data: ['刷题人数', '题目数量'], right: '5%', top: '2%', textStyle: { color: isDark ? '#aaa' : '#8c8c8c' } },
    grid: { top: '12%', left: '3%', right: '4%', bottom: '8%', containLabel: true },
    xAxis: { type: 'category', boundaryGap: false, data: middleData.value.dateList, axisLine: { lineStyle: { color: isDark ? '#333' : '#E0E6F1' } }, axisLabel: { color: isDark ? '#aaa' : '#666' } },
    yAxis: { type: 'value', axisLine: { show: false }, axisTick: { show: false }, axisLabel: { color: isDark ? '#aaa' : '#666' }, splitLine: { lineStyle: { color: isDark ? '#222' : '#E0E6F1', type: 'dashed' } } },
    series: [
      { name: '刷题人数', type: 'line', smooth: true, symbol: 'circle', symbolSize: 8, lineStyle: { width: 3, color: '#0a3442' }, itemStyle: { color: '#0a3442', borderColor: '#fff', borderWidth: 2 }, areaStyle: { color: 'rgba(10,52,66,0.15)' }, data: middleData.value.countUserList },
      { name: '题目数量', type: 'line', smooth: true, symbol: 'triangle', symbolSize: 8, lineStyle: { width: 3, color: '#3ad3cd' }, itemStyle: { color: '#3ad3cd', borderColor: '#fff', borderWidth: 2 }, areaStyle: { color: 'rgba(58,211,205,0.15)' }, data: middleData.value.countTopicList }
    ]
  });
  window.addEventListener('resize', () => chart.resize());
};

const initUserGrowthChart = () => {
  if (!userGrowthChart.value || !userTrend.value) return;
  const chart = echarts.init(userGrowthChart.value);
  const isDark = settingStore.isDark;
  chart.setOption({
    backgroundColor: 'transparent',
    tooltip: { trigger: 'axis', axisPointer: { type: 'cross', label: { backgroundColor: '#0a3442' } }, backgroundColor: isDark ? '#1f1f1f' : '#fff', borderColor: isDark ? '#333' : '#eee', textStyle: { color: isDark ? '#fff' : '#333' } },
    grid: { top: '10%', left: '3%', right: '7%', bottom: '15%', containLabel: true },
    xAxis: { type: 'category', boundaryGap: false, data: userTrend.value.dateList, axisLine: { lineStyle: { color: isDark ? '#333' : '#E0E6F1' } }, axisLabel: { color: isDark ? '#aaa' : '#666' } },
    yAxis: { type: 'value', axisLine: { show: false }, axisTick: { show: false }, axisLabel: { color: isDark ? '#aaa' : '#666' }, splitLine: { lineStyle: { color: isDark ? '#222' : '#E0E6F1', type: 'dashed' } } },
    series: [{ name: '用户增长', type: 'line', smooth: true, symbol: 'circle', symbolSize: 6, lineStyle: { width: 3, color: '#0a3442' }, itemStyle: { color: '#0a3442', borderColor: '#fff', borderWidth: 2 }, areaStyle: { color: 'rgba(10,52,66,0.15)' }, data: userTrend.value.countList }]
  });
  window.addEventListener('resize', () => chart.resize());
};

const initAiCallChart = () => {
  if (!aiCallChart.value || !aiTrend.value) return;
  const chart = echarts.init(aiCallChart.value);
  const isDark = settingStore.isDark;
  chart.setOption({
    backgroundColor: 'transparent',
    tooltip: { trigger: 'axis', axisPointer: { type: 'cross', label: { backgroundColor: '#104455' } }, backgroundColor: isDark ? '#1f1f1f' : '#fff', borderColor: isDark ? '#333' : '#eee', textStyle: { color: isDark ? '#fff' : '#333' } },
    grid: { top: '10%', left: '3%', right: '7%', bottom: '15%', containLabel: true },
    xAxis: { type: 'category', boundaryGap: false, data: aiTrend.value.dateList, axisLine: { lineStyle: { color: isDark ? '#333' : '#E0E6F1' } }, axisLabel: { color: isDark ? '#aaa' : '#666' } },
    yAxis: { type: 'value', axisLine: { show: false }, axisTick: { show: false }, axisLabel: { color: isDark ? '#aaa' : '#666' }, splitLine: { lineStyle: { color: isDark ? '#222' : '#E0E6F1', type: 'dashed' } } },
    series: [{ name: '调用次数', type: 'line', smooth: true, symbol: 'circle', symbolSize: 6, lineStyle: { width: 3, color: '#104455' }, itemStyle: { color: '#104455', borderColor: '#fff', borderWidth: 2 }, areaStyle: { color: 'rgba(16,68,85,0.15)' }, data: aiTrend.value.countList }]
  });
  window.addEventListener('resize', () => chart.resize());
};

watch(() => settingStore.isDark, () => { initCategoryChart(); initTopicTrendChart(); initUserGrowthChart(); initAiCallChart(); });

const getAllData = async () => {
  const [leftRes, categoryRes, topicRes, userRes, aiRes] = await Promise.all([apiAdminHomeCount(), apiAdminHomeCategory(), apiTopicTrend(), apiUserTrend(), apiAiTrend()]);
  if (leftRes.data) leftData.value = leftRes.data;
  if (categoryRes.data) { rightData.value = categoryRes.data; initCategoryChart(); }
  if (topicRes.data) { middleData.value = topicRes.data; initTopicTrendChart(); }
  if (userRes.data) { userTrend.value = userRes.data; initUserGrowthChart(); }
  if (aiRes.data) { aiTrend.value = aiRes.data; initAiCallChart(); }

  setTimeout(() => {
    initMiniChart(0, [3, 5, 8, 6, 9, 7, 11, 10, 13, 12], '#0a3442');
    initMiniChart(1, [2, 4, 3, 6, 5, 8, 7, 10, 9, 12], '#104455');
    initMiniChart(2, [1, 3, 2, 5, 4, 7, 6, 9, 8, 11], '#3ad3cd');
    initMiniChart(3, [5, 7, 6, 9, 8, 11, 10, 13, 12, 15], '#7fffd4');
    initMiniChart(4, [4, 6, 5, 8, 7, 10, 9, 12, 11, 14], '#0a3442');
    initMiniChart(5, [3, 5, 4, 7, 6, 9, 8, 11, 10, 13], '#104455');
  }, 100);
};

onMounted(() => { getAllData(); });
</script>

<template>
  <div class="admin-dashboard">
    <div class="welcome-banner">
      <div class="welcome-content">
        <div class="welcome-text">
          <h1 class="welcome-title">欢迎回来，{{ userStore.userInfo.nickname || userStore.userInfo.account }}</h1>
          <p class="welcome-subtitle">这是您的管理控制台，今天是 {{ currentTime }}</p>
        </div>
        <div class="admin-badge">
          <span class="badge-icon">&#128081;</span>
          <span class="badge-text">管理员</span>
        </div>
      </div>
    </div>

    <div class="stats-grid">
      <div v-for="(card, index) in statCards" :key="index" class="stat-card" :style="{ '--card-accent': card.color }">
        <div class="stat-card-header">
          <div class="stat-icon"><component :is="card.icon" /></div>
          <div class="stat-mini-chart" :ref="el => { if (el) miniChartRefs[index] = el as HTMLDivElement }"></div>
        </div>
        <div class="stat-card-body">
          <div class="stat-value">
            <span class="stat-number">{{ card.value.toLocaleString() }}</span>
            <span class="stat-suffix">{{ card.suffix }}</span>
          </div>
          <div class="stat-label">{{ card.label }}</div>
        </div>
        <div v-if="card.trend !== undefined" class="stat-card-footer">
          <span :class="['trend-indicator', card.trend >= 0 ? 'trend-up' : 'trend-down']">{{ card.trend >= 0 ? '+' : '' }} {{ card.trend }}</span>
          <span class="trend-label">较昨日</span>
        </div>
      </div>
    </div>

    <div class="charts-section">
      <div class="chart-card chart-card-full">
        <div class="chart-card-header"><h3 class="chart-title">刷题趋势</h3></div>
        <div ref="topicTrendChart" class="chart-container"></div>
      </div>
    </div>

    <div class="charts-section">
      <div class="chart-card">
        <div class="chart-card-header"><h3 class="chart-title">分类概览</h3></div>
        <div ref="categoryChart" class="chart-container"></div>
      </div>
      <div class="chart-card">
        <div class="chart-card-header"><h3 class="chart-title">用户增长</h3></div>
        <div ref="userGrowthChart" class="chart-container"></div>
      </div>
      <div class="chart-card">
        <div class="chart-card-header"><h3 class="chart-title">AI调用统计</h3></div>
        <div ref="aiCallChart" class="chart-container"></div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.admin-dashboard {
  padding: 0;
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.welcome-banner {
  background: #0a3442;
  border-radius: 16px;
  padding: 32px;
  color: #fff;
  position: relative;
  overflow: hidden;
  &::before {
    content: '';
    position: absolute;
    top: -50%;
    right: -20%;
    width: 400px;
    height: 400px;
    background: rgba(255, 255, 255, 0.05);
    border-radius: 50%;
  }
  &::after {
    content: '';
    position: absolute;
    bottom: -30%;
    left: -10%;
    width: 300px;
    height: 300px;
    background: rgba(255, 255, 255, 0.03);
    border-radius: 50%;
  }
}

.welcome-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: relative;
  z-index: 1;
}

.welcome-title {
  font-size: 28px;
  font-weight: 700;
  margin: 0 0 8px 0;
}

.welcome-subtitle {
  font-size: 16px;
  opacity: 0.9;
  margin: 0;
}

.admin-badge {
  display: flex;
  align-items: center;
  gap: 8px;
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  padding: 12px 20px;
  border-radius: 12px;
  border: 1px solid rgba(255, 255, 255, 0.3);
  .badge-icon { font-size: 24px; }
  .badge-text { font-size: 16px; font-weight: 600; }
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  gap: 20px;
}

.stat-card {
  background: #fff;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 20px rgba(10, 52, 66, 0.08);
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
  &:hover { transform: translateY(-4px); box-shadow: 0 8px 30px rgba(10, 52, 66, 0.15); }
  &::before { content: ''; position: absolute; top: 0; left: 0; width: 4px; height: 100%; background: var(--card-accent); border-radius: 0 4px 4px 0; }
}

.stat-card-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 16px; }

.stat-icon {
  width: 48px; height: 48px; border-radius: 12px; background: var(--card-accent);
  display: flex; align-items: center; justify-content: center; font-size: 24px; color: #fff;
}

.stat-mini-chart { width: 80px; height: 40px; }
.stat-card-body { margin-bottom: 12px; }

.stat-value { display: flex; align-items: baseline; gap: 4px; margin-bottom: 4px; }
.stat-number { font-size: 32px; font-weight: 700; color: #1a1a1a; line-height: 1; }
.stat-suffix { font-size: 14px; color: #8c8c8c; }
.stat-label { font-size: 14px; color: #666; }

.stat-card-footer { display: flex; align-items: center; gap: 8px; padding-top: 12px; border-top: 1px solid #f0f0f0; }
.trend-indicator { font-size: 13px; font-weight: 600; &.trend-up { color: #52c41a; } &.trend-down { color: #ff4d4f; } }
.trend-label { font-size: 12px; color: #8c8c8c; }

.charts-section { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }

.chart-card {
  background: #fff; border-radius: 16px; box-shadow: 0 4px 20px rgba(10, 52, 66, 0.08);
  overflow: hidden; transition: all 0.3s ease;
  &:hover { box-shadow: 0 8px 30px rgba(10, 52, 66, 0.15); }
  &.chart-card-full { grid-column: 1 / -1; }
}

.chart-card-header { padding: 20px 24px 0; }

.chart-title {
  font-size: 18px; font-weight: 600; color: #1a1a1a; margin: 0;
  position: relative; padding-left: 12px;
  &::before { content: ''; position: absolute; left: 0; top: 50%; transform: translateY(-50%); width: 4px; height: 18px; background: #0a3442; border-radius: 2px; }
}

.chart-container { width: 100%; height: 300px; padding: 0 24px 24px; }

@media (max-width: 1600px) {
  .stats-grid { grid-template-columns: repeat(3, 1fr); }
  .charts-section { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 1200px) {
  .stats-grid { grid-template-columns: repeat(2, 1fr); }
  .charts-section { grid-template-columns: 1fr; }
}
@media (max-width: 768px) {
  .stats-grid { grid-template-columns: 1fr; }
  .welcome-content { flex-direction: column; align-items: flex-start; gap: 16px; }
  .welcome-title { font-size: 22px; }
}
</style>
