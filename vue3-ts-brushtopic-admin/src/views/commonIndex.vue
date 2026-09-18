<script setup lang="ts">
import { useUserStore } from '@/stores/modules/user';
import { useSettingStore } from '@/stores/modules/setting';
import { ref, onMounted, watch, computed } from 'vue';
import * as echarts from 'echarts';
import { getYearDateRange } from '@/utils/date';
import { apiUserHomeCount, apiUserHomeCategory, apiUserTopicCount } from '@/api/home';
import type { UserHomeCount } from '@/api/home/type';

const userStore = useUserStore();
const settingStore = useSettingStore();

const leftData = ref<UserHomeCount>();
const rightData = ref<any>();
const trendData = ref<any>();

const getUserIdentity = computed(() => {
  const totalProblems = leftData.value?.topicFrequencyCount || 0;
  if (totalProblems >= 1000) return { name: '学习之神', color: '#722ed1' };
  if (totalProblems >= 800) return { name: '学习专家', color: '#f5222d' };
  if (totalProblems >= 500) return { name: '学习达人', color: '#fa8c16' };
  if (totalProblems >= 300) return { name: '学习高手', color: '#0a3442' };
  if (totalProblems >= 100) return { name: '学习新秀', color: '#52c41a' };
  return { name: '学习新手', color: '#8c8c8c' };
});

const statCards = computed(() => [
  { label: '已刷题次数', value: leftData.value?.topicFrequencyCount || 0, suffix: '次', icon: 'BarChartOutlined', trend: leftData.value?.topicFrequencyGrowthRate || 0, color: '#0a3442' },
  { label: '刷题排名', value: leftData.value?.rank || 0, suffix: '名', icon: 'TrophyOutlined', trend: leftData.value?.rankGrowthRate || 0, color: '#104455' },
  { label: '已刷题目', value: leftData.value?.totalTopicRecordCountSize || 0, suffix: '/' + (leftData.value?.totalTopicCount || 0) + '题', icon: 'CheckCircleOutlined', color: '#3ad3cd' },
  { label: 'AI陪背次数', value: leftData.value?.aiCount || 0, suffix: '次', icon: 'RobotOutlined', color: '#7fffd4' },
  { label: '最长连续刷题', value: leftData.value?.maxConsecutiveCount || 0, suffix: '天', icon: 'CalendarOutlined', color: '#0a3442' },
  { label: '最近连续刷题', value: leftData.value?.recentConsecutiveCount || 0, suffix: '天', icon: 'HourglassOutlined', color: '#104455' }
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
const contributionChart = ref<HTMLDivElement | null>(null);

const initCategoryChart = () => {
  if (!categoryChart.value || !rightData.value) return;
  const chart = echarts.init(categoryChart.value);
  chart.setOption({
    tooltip: {
      trigger: 'item', backgroundColor: 'rgba(255,255,255,0.95)', borderColor: '#eee', borderWidth: 1, textStyle: { color: '#333' },
      formatter: (params: any) => '<div style="text-align:center;border:1px solid #ccc;background:#fff;padding:8px;border-radius:4px;"><strong style="color:#1a1a1a;">' + params.name + '</strong><br/><span style="color:#1a1a1a;">' + params.value + '</span><span style="color:#b1b1b1;"> / ' + params.data.count + '</span></div>'
    },
    animationDurationUpdate: (idx: number) => idx * 100,
    animationEasingUpdate: 'bounceIn' as const,
    series: [{
      type: 'graph', layout: 'force', force: { repulsion: 120, edgeLength: 15 },
      label: { show: true, formatter: '{b|{b}}', fontSize: 12, color: '#fff', rich: { b: { fontSize: 11, color: '#fff', fontWeight: 'bold' } } },
      itemStyle: { color: '#0a3442', opacity: 0.85, borderWidth: 2, borderColor: '#fff', shadowBlur: 10, shadowColor: 'rgba(10,52,66,0.3)' },
      data: rightData.value.map((cat: any) => ({ name: cat.categoryName, value: cat.count, count: cat.totalCount, symbolSize: (cat.totalCount < 5 ? 5 : cat.totalCount) * 2.2, draggable: true }))
    }]
  });
  window.addEventListener('resize', () => chart.resize());
};

const currentYear = new Date().getFullYear();
const yearOptions = ref([currentYear, currentYear - 1, currentYear - 2]);
const selectedYear = ref(currentYear);
let myChart: any = null;

const renderContributionChart = (year: number) => {
  if (!contributionChart.value) return;
  if (!myChart) { myChart = echarts.init(contributionChart.value); }
  const { startStr, endStr } = getYearDateRange(year);
  const isDark = settingStore.isDark;
  myChart.setOption({
    tooltip: { formatter: (params: any) => params.value[1] + '次刷题：' + params.value[0], backgroundColor: isDark ? '#1f1f1f' : '#fff', borderColor: isDark ? '#333' : '#eee', textStyle: { color: isDark ? '#fff' : '#333' } },
    visualMap: {
      type: 'piecewise', orient: 'horizontal', left: 'center',
      pieces: [{ min: 0, max: 10, color: '#e0f7f0', label: '0-10' }, { min: 10, max: 30, color: '#a3e4d8', label: '10-30' }, { min: 30, max: 50, color: '#66d1c0', label: '30-50' }, { min: 50, max: 80, color: '#3ad3cd', label: '50-80' }, { min: 80, max: 120, color: '#104455', label: '80-120' }, { min: 120, max: 99999, color: '#0a3442', label: '120+' }],
      show: true, textStyle: { color: isDark ? '#aaa' : '#8c8c8c' }
    },
    calendar: { top: 25, left: 30, right: 30, cellSize: [18, 18], range: [startStr, endStr], itemStyle: { borderWidth: 1, borderColor: isDark ? '#1a3a40' : '#d0f0ea' }, yearLabel: { show: false }, monthLabel: { nameMap: 'cn', color: isDark ? '#aaa' : '#888' }, dayLabel: { firstDay: 1, nameMap: 'cn', color: isDark ? '#aaa' : '#888' } },
    series: [{ type: 'heatmap', coordinateSystem: 'calendar', data: trendData.value ? trendData.value.map((item: any) => [item.date, item.count]) : [] }]
  });
  window.addEventListener('resize', () => myChart.resize());
};

watch(selectedYear, () => { getTrendData(); });
watch(() => settingStore.isDark, () => { initCategoryChart(); if (trendData.value) renderContributionChart(selectedYear.value); });

const getTrendData = async () => {
  const { data } = await apiUserTopicCount(String(selectedYear.value));
  if (data) { trendData.value = data; renderContributionChart(selectedYear.value); }
};

const getAllData = async () => {
  const [leftRes, categoryRes] = await Promise.all([apiUserHomeCount(), apiUserHomeCategory()]);
  if (leftRes.data) leftData.value = leftRes.data;
  if (categoryRes.data) { rightData.value = categoryRes.data; initCategoryChart(); }
  await getTrendData();
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
  <div class="user-dashboard">
    <div class="welcome-banner">
      <div class="welcome-content">
        <div class="welcome-text">
          <h1 class="welcome-title">Hi，{{ userStore.userInfo.nickname || userStore.userInfo.account }}</h1>
          <p class="welcome-subtitle">继续加油，今天也要好好刷题哦！</p>
        </div>
        <div class="identity-badge" :style="{ background: getUserIdentity.color }">
          <span class="badge-text">{{ getUserIdentity.name }}</span>
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
      <div class="chart-card">
        <div class="chart-card-header"><h3 class="chart-title">分类概览</h3></div>
        <div ref="categoryChart" class="chart-container"></div>
      </div>
      <div class="chart-card chart-card-wide">
        <div class="chart-card-header">
          <h3 class="chart-title">刷题日历</h3>
          <div class="year-select">
            <a-select v-model:value="selectedYear" size="small">
              <a-select-option v-for="year in yearOptions" :key="year" :value="year">{{ year }}</a-select-option>
            </a-select>
          </div>
        </div>
        <div ref="contributionChart" class="contribution-chart"></div>
        <div class="footer-description">每一次查看面试题就会统计刷题次数</div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.user-dashboard { padding: 0; display: flex; flex-direction: column; gap: 24px; }

.welcome-banner {
  background: #0a3442; border-radius: 16px; padding: 32px; color: #fff; position: relative; overflow: hidden;
  &::before { content: ''; position: absolute; top: -50%; right: -20%; width: 400px; height: 400px; background: rgba(255,255,255,0.05); border-radius: 50%; }
  &::after { content: ''; position: absolute; bottom: -30%; left: -10%; width: 300px; height: 300px; background: rgba(255,255,255,0.03); border-radius: 50%; }
}

.welcome-content { display: flex; justify-content: space-between; align-items: center; position: relative; z-index: 1; }
.welcome-title { font-size: 28px; font-weight: 700; margin: 0 0 8px 0; }
.welcome-subtitle { font-size: 16px; opacity: 0.9; margin: 0; }

.identity-badge {
  display: flex; align-items: center; gap: 8px; padding: 12px 24px; border-radius: 12px;
  border: 1px solid rgba(255,255,255,0.3); backdrop-filter: blur(10px);
  .badge-text { font-size: 16px; font-weight: 600; color: #fff; }
}

.stats-grid { display: grid; grid-template-columns: repeat(6, 1fr); gap: 20px; }

.stat-card {
  background: #fff; border-radius: 16px; padding: 24px; box-shadow: 0 4px 20px rgba(10,52,66,0.08);
  transition: all 0.3s ease; position: relative; overflow: hidden;
  &:hover { transform: translateY(-4px); box-shadow: 0 8px 30px rgba(10,52,66,0.15); }
  &::before { content: ''; position: absolute; top: 0; left: 0; width: 4px; height: 100%; background: var(--card-accent); border-radius: 0 4px 4px 0; }
}

.stat-card-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 16px; }
.stat-icon { width: 48px; height: 48px; border-radius: 12px; background: var(--card-accent); display: flex; align-items: center; justify-content: center; font-size: 24px; color: #fff; }
.stat-mini-chart { width: 80px; height: 40px; }
.stat-card-body { margin-bottom: 12px; }
.stat-value { display: flex; align-items: baseline; gap: 4px; margin-bottom: 4px; }
.stat-number { font-size: 32px; font-weight: 700; color: #1a1a1a; line-height: 1; }
.stat-suffix { font-size: 14px; color: #8c8c8c; }
.stat-label { font-size: 14px; color: #666; }
.stat-card-footer { display: flex; align-items: center; gap: 8px; padding-top: 12px; border-top: 1px solid #f0f0f0; }
.trend-indicator { font-size: 13px; font-weight: 600; &.trend-up { color: #52c41a; } &.trend-down { color: #ff4d4f; } }
.trend-label { font-size: 12px; color: #8c8c8c; }

.charts-section { display: grid; grid-template-columns: 1fr 2fr; gap: 20px; }

.chart-card {
  background: #fff; border-radius: 16px; box-shadow: 0 4px 20px rgba(10,52,66,0.08); overflow: hidden; transition: all 0.3s ease;
  &:hover { box-shadow: 0 8px 30px rgba(10,52,66,0.15); }
}

.chart-card-header { padding: 20px 24px 0; display: flex; justify-content: space-between; align-items: center; }
.chart-title {
  font-size: 18px; font-weight: 600; color: #1a1a1a; margin: 0; position: relative; padding-left: 12px;
  &::before { content: ''; position: absolute; left: 0; top: 50%; transform: translateY(-50%); width: 4px; height: 18px; background: #0a3442; border-radius: 2px; }
}

.chart-container { width: 100%; height: 300px; padding: 16px 24px 24px; }
.contribution-chart { width: 100%; height: 200px; padding: 0 24px 24px; }
.footer-description { font-size: 13px; color: #8c92a4; padding: 0 24px 16px; }
.year-select { display: flex; justify-content: flex-end; }

@media (max-width: 1600px) { .stats-grid { grid-template-columns: repeat(3, 1fr); } .charts-section { grid-template-columns: 1fr; } }
@media (max-width: 1200px) { .stats-grid { grid-template-columns: repeat(2, 1fr); } }
@media (max-width: 768px) { .stats-grid { grid-template-columns: 1fr; } .welcome-content { flex-direction: column; align-items: flex-start; gap: 16px; } .welcome-title { font-size: 22px; } }
</style>
