<script setup lang="ts">
import { useUserStore } from '@/stores/modules/user';
import { ref, onMounted } from 'vue';
import * as echarts from 'echarts';
import { apiAdminHomeCount, apiUserTrend, apiAiTrend } from '@/api/home';
import type { AdminLeftDataType } from '@/api/home/type';

const userStore = useUserStore();

const leftData = ref<AdminLeftDataType>();
const userTrend = ref<any>();
const aiTrend = ref<any>();

const moduleStats = ref([
  { label: '背单词次数', value: 0, icon: 'book', color: '#2c5a5e' },
  { label: '作文次数', value: 0, icon: 'edit', color: '#3ad3cd' },
  { label: '翻译次数', value: 0, icon: 'translate', color: '#6dd5c8' }
]);

const dataOverview = ref([
  { label: '收录题目', value: 0, icon: 'file', color: '#2c5a5e' },
  { label: '收录标签', value: 0, icon: 'tag', color: '#3ad3cd' },
  { label: '注册用户', value: 0, icon: 'users', color: '#6dd5c8' },
  { label: 'AI调用次数', value: 0, icon: 'monitor', color: '#2c5a5e' }
]);

const userGrowthChart = ref<HTMLDivElement | null>(null);
const aiCallChart = ref<HTMLDivElement | null>(null);

const initUserGrowthChart = () => {
  if (!userGrowthChart.value || !userTrend.value) return;
  const chart = echarts.init(userGrowthChart.value);
  chart.setOption({
    backgroundColor: 'transparent',
    tooltip: { trigger: 'axis', axisPointer: { type: 'cross', label: { backgroundColor: '#2c5a5e' } }, backgroundColor: '#fff', borderColor: '#eee', textStyle: { color: '#333' } },
    grid: { top: '15%', left: '5%', right: '5%', bottom: '20%', containLabel: true },
    xAxis: {
      type: 'category', boundaryGap: false,
      data: userTrend.value.dateList,
      axisLine: { lineStyle: { color: '#E0E6F1' } },
      axisLabel: { color: '#666', fontSize: 11 },
      axisTick: { show: false }
    },
    yAxis: {
      type: 'value',
      axisLine: { show: false },
      axisTick: { show: false },
      axisLabel: { color: '#666', fontSize: 11 },
      splitLine: { lineStyle: { color: '#E0E6F1', type: 'dashed' } }
    },
    series: [{
      name: '用户增长',
      type: 'line',
      smooth: true,
      symbol: 'none',
      lineStyle: { width: 3, color: '#3ad3cd' },
      areaStyle: {
        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
          { offset: 0, color: 'rgba(58, 211, 205, 0.3)' },
          { offset: 1, color: 'rgba(58, 211, 205, 0.02)' }
        ])
      },
      data: userTrend.value.countList
    }]
  });
  window.addEventListener('resize', () => chart.resize());
};

const initAiCallChart = () => {
  if (!aiCallChart.value || !aiTrend.value) return;
  const chart = echarts.init(aiCallChart.value);
  chart.setOption({
    backgroundColor: 'transparent',
    tooltip: { trigger: 'axis', axisPointer: { type: 'cross', label: { backgroundColor: '#2c5a5e' } }, backgroundColor: '#fff', borderColor: '#eee', textStyle: { color: '#333' } },
    grid: { top: '15%', left: '5%', right: '5%', bottom: '20%', containLabel: true },
    xAxis: {
      type: 'category', boundaryGap: false,
      data: aiTrend.value.dateList,
      axisLine: { lineStyle: { color: '#E0E6F1' } },
      axisLabel: { color: '#666', fontSize: 11 },
      axisTick: { show: false }
    },
    yAxis: {
      type: 'value',
      axisLine: { show: false },
      axisTick: { show: false },
      axisLabel: { color: '#666', fontSize: 11 },
      splitLine: { lineStyle: { color: '#E0E6F1', type: 'dashed' } }
    },
    series: [{
      name: '调用次数',
      type: 'line',
      smooth: true,
      symbol: 'none',
      lineStyle: { width: 3, color: '#3ad3cd' },
      areaStyle: {
        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
          { offset: 0, color: 'rgba(58, 211, 205, 0.3)' },
          { offset: 1, color: 'rgba(58, 211, 205, 0.02)' }
        ])
      },
      data: aiTrend.value.countList
    }]
  });
  window.addEventListener('resize', () => chart.resize());
};

const getAllData = async () => {
  const [leftRes, userRes, aiRes] = await Promise.all([apiAdminHomeCount(), apiUserTrend(), apiAiTrend()]);
  if (leftRes.data) {
    leftData.value = leftRes.data;
    dataOverview.value[0].value = leftData.value?.totalTopicCount || 0;
    dataOverview.value[1].value = leftData.value?.topicLabelCount || 0;
    dataOverview.value[2].value = leftData.value?.userCount || 0;
    dataOverview.value[3].value = leftData.value?.aiCount || 0;
  }
  if (userRes.data) { userTrend.value = userRes.data; initUserGrowthChart(); }
  if (aiRes.data) { aiTrend.value = aiRes.data; initAiCallChart(); }
};

onMounted(() => { getAllData(); });
</script>

<template>
  <div class="admin-dashboard">
    <div class="welcome-banner">
      <div class="welcome-left">
        <div class="user-avatar">
          <svg viewBox="0 0 24 24" fill="currentColor" width="48" height="48">
            <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
          </svg>
        </div>
        <div class="welcome-text">
          <p class="welcome-subtitle">欢迎回来</p>
          <h1 class="welcome-title">{{ userStore.userInfo.nickname || userStore.userInfo.account }}</h1>
          <div class="admin-badge">
            <svg viewBox="0 0 24 24" fill="currentColor" width="14" height="14">
              <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4z"/>
            </svg>
            <span>管理员</span>
          </div>
        </div>
      </div>
      <div class="welcome-right">
        <div class="banner-stat">
          <span class="banner-stat-value">{{ leftData?.userCount || 0 }}</span>
          <span class="banner-stat-label">注册用户</span>
        </div>
        <div class="banner-stat">
          <span class="banner-stat-value">{{ leftData?.totalTopicCount || 0 }}</span>
          <span class="banner-stat-label">收录题目</span>
        </div>
        <div class="banner-stat">
          <span class="banner-stat-value">{{ leftData?.aiCount || 0 }}</span>
          <span class="banner-stat-label">AI调用</span>
        </div>
      </div>
    </div>

    <div class="section-header">
      <div class="section-indicator"></div>
      <h2 class="section-title">数据概览</h2>
    </div>
    <div class="data-overview-grid">
      <div v-for="(item, index) in dataOverview" :key="index" class="overview-card">
        <div class="overview-icon" :style="{ background: item.color }">
          <svg v-if="item.icon === 'file'" viewBox="0 0 24 24" fill="currentColor" width="24" height="24">
            <path d="M14 2H6c-1.1 0-1.99.9-1.99 2L4 20c0 1.1.89 2 1.99 2H18c1.1 0 2-.9 2-2V8l-6-6zm2 16H8v-2h8v2zm0-4H8v-2h8v2zm-3-5V3.5L18.5 9H13z"/>
          </svg>
          <svg v-else-if="item.icon === 'tag'" viewBox="0 0 24 24" fill="currentColor" width="24" height="24">
            <path d="M21.41 11.58l-9-9C12.05 2.22 11.55 2 11 2H4c-1.1 0-2 .9-2 2v7c0 .55.22 1.05.59 1.42l9 9c.36.36.86.58 1.41.58.55 0 1.05-.22 1.41-.59l7-7c.37-.36.59-.86.59-1.41 0-.55-.23-1.06-.59-1.42zM5.5 7C4.67 7 4 6.33 4 5.5S4.67 4 5.5 4 7 4.67 7 5.5 6.33 7 5.5 7z"/>
          </svg>
          <svg v-else-if="item.icon === 'users'" viewBox="0 0 24 24" fill="currentColor" width="24" height="24">
            <path d="M16 11c1.66 0 2.99-1.34 2.99-3S17.66 5 16 5c-1.66 0-3 1.34-3 3s1.34 3 3 3zm-8 0c1.66 0 2.99-1.34 2.99-3S9.66 5 8 5C6.34 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5z"/>
          </svg>
          <svg v-else viewBox="0 0 24 24" fill="currentColor" width="24" height="24">
            <path d="M21 3H3c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h5v2h8v-2h5c1.1 0 1.99-.9 1.99-2L23 5c0-1.1-.9-2-2-2zm0 14H3V5h18v12z"/>
          </svg>
        </div>
        <div class="overview-content">
          <span class="overview-value">{{ item.value }}</span>
          <span class="overview-label">{{ item.label }}</span>
        </div>
      </div>
    </div>

    <div class="section-header">
      <div class="section-indicator"></div>
      <h2 class="section-title">模块使用统计</h2>
    </div>
    <div class="module-stats-grid">
      <div v-for="(item, index) in moduleStats" :key="index" class="module-card">
        <div class="module-icon" :style="{ background: item.color }">
          <svg v-if="item.icon === 'book'" viewBox="0 0 24 24" fill="currentColor" width="24" height="24">
            <path d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 4h5v8l-2.5-1.5L6 12V4z"/>
          </svg>
          <svg v-else-if="item.icon === 'edit'" viewBox="0 0 24 24" fill="currentColor" width="24" height="24">
            <path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"/>
          </svg>
          <svg v-else viewBox="0 0 24 24" fill="currentColor" width="24" height="24">
            <path d="M12.87 15.07l-2.54-2.51.03-.03c1.74-1.94 2.98-4.17 3.71-6.53H17V4h-7V2H8v2H1v1.99h11.17C11.5 7.92 10.44 9.75 9 11.35 8.07 10.32 7.3 9.19 6.69 8h-2c.73 1.63 1.73 3.17 2.98 4.56l-5.09 5.02L4 19l5-5 3.11 3.11.76-2.04zM18.5 10h-2L12 22h2l1.12-3h4.75L21 22h2l-4.5-12zm-2.62 7l1.62-4.33L19.12 17h-3.24z"/>
          </svg>
        </div>
        <div class="module-content">
          <span class="module-value">{{ item.value }}</span>
          <span class="module-label">{{ item.label }}</span>
        </div>
        <div class="module-progress">
          <svg viewBox="0 0 36 36" class="circular-chart">
            <path class="circle-bg" d="M18 2.0845
              a 15.9155 15.9155 0 0 1 0 31.831
              a 15.9155 15.9155 0 0 1 0 -31.831"/>
            <path class="circle" :stroke-dasharray="`${item.value > 0 ? 100 : 0}, 100`" d="M18 2.0845
              a 15.9155 15.9155 0 0 1 0 31.831
              a 15.9155 15.9155 0 0 1 0 -31.831"/>
          </svg>
        </div>
      </div>
    </div>

    <div class="charts-row">
      <div class="chart-card">
        <div class="chart-card-header">
          <div class="chart-dot"></div>
          <h3 class="chart-title">用户增长趋势</h3>
        </div>
        <div ref="userGrowthChart" class="chart-container"></div>
      </div>
      <div class="chart-card">
        <div class="chart-card-header">
          <div class="chart-dot ai"></div>
          <h3 class="chart-title">AI调用次数趋势</h3>
        </div>
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
  background: linear-gradient(135deg, #2c5a5e 0%, #1a3a3d 100%);
  border-radius: 16px;
  padding: 32px;
  color: #fff;
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: relative;
  overflow: hidden;

  &::before {
    content: '';
    position: absolute;
    top: -50%;
    right: -10%;
    width: 300px;
    height: 300px;
    background: rgba(255, 255, 255, 0.05);
    border-radius: 50%;
  }
}

.welcome-left {
  display: flex;
  align-items: center;
  gap: 20px;
  position: relative;
  z-index: 1;
}

.user-avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.15);
  display: flex;
  align-items: center;
  justify-content: center;

  svg {
    width: 48px;
    height: 48px;
    opacity: 0.9;
  }
}

.welcome-text {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.welcome-subtitle {
  font-size: 14px;
  opacity: 0.8;
  margin: 0;
}

.welcome-title {
  font-size: 28px;
  font-weight: 700;
  margin: 0;
}

.admin-badge {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  background: rgba(58, 211, 205, 0.2);
  padding: 4px 12px;
  border-radius: 4px;
  font-size: 12px;
  width: fit-content;
  margin-top: 4px;

  svg {
    width: 14px;
    height: 14px;
    fill: #3ad3cd;
  }
}

.welcome-right {
  display: flex;
  gap: 40px;
  position: relative;
  z-index: 1;
}

.banner-stat {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
}

.banner-stat-value {
  font-size: 32px;
  font-weight: 700;
}

.banner-stat-label {
  font-size: 13px;
  opacity: 0.8;
}

.section-header {
  display: flex;
  align-items: center;
  gap: 8px;
}

.section-indicator {
  width: 4px;
  height: 20px;
  background: #3ad3cd;
  border-radius: 2px;
}

.section-title {
  font-size: 18px;
  font-weight: 600;
  color: #1a1a1a;
  margin: 0;
}

.data-overview-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
}

.overview-card {
  background: #fff;
  border-radius: 12px;
  padding: 24px;
  display: flex;
  align-items: center;
  gap: 16px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
  transition: all 0.3s ease;

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  }
}

.overview-icon {
  width: 56px;
  height: 56px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;

  svg {
    width: 28px;
    height: 28px;
    fill: #fff;
  }
}

.overview-content {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.overview-value {
  font-size: 28px;
  font-weight: 700;
  color: #1a1a1a;
}

.overview-label {
  font-size: 14px;
  color: #666;
}

.module-stats-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
}

.module-card {
  background: #fff;
  border-radius: 12px;
  padding: 24px;
  display: flex;
  align-items: center;
  gap: 16px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
  transition: all 0.3s ease;

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  }
}

.module-icon {
  width: 56px;
  height: 56px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;

  svg {
    width: 28px;
    height: 28px;
    fill: #fff;
  }
}

.module-content {
  display: flex;
  flex-direction: column;
  gap: 4px;
  flex: 1;
}

.module-value {
  font-size: 28px;
  font-weight: 700;
  color: #1a1a1a;
}

.module-label {
  font-size: 14px;
  color: #666;
}

.module-progress {
  width: 48px;
  height: 48px;

  .circular-chart {
    width: 100%;
    height: 100%;
  }

  .circle-bg {
    fill: none;
    stroke: #e6f7f5;
    stroke-width: 3;
  }

  .circle {
    fill: none;
    stroke-width: 3;
    stroke: #3ad3cd;
    stroke-linecap: round;
    animation: progress 1s ease-out forwards;
  }
}

@keyframes progress {
  0% {
    stroke-dasharray: 0 100;
  }
}

.charts-row {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
}

.chart-card {
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
  overflow: hidden;
  transition: all 0.3s ease;

  &:hover {
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  }
}

.chart-card-header {
  padding: 20px 24px 0;
  display: flex;
  align-items: center;
  gap: 8px;
}

.chart-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #3ad3cd;

  &.ai {
    background: #2c5a5e;
  }
}

.chart-title {
  font-size: 16px;
  font-weight: 600;
  color: #1a1a1a;
  margin: 0;
}

.chart-container {
  width: 100%;
  height: 280px;
  padding: 16px;
}

@media (max-width: 1200px) {
  .data-overview-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  .module-stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  .charts-row {
    grid-template-columns: 1fr;
  }
  .welcome-right {
    gap: 24px;
  }
}

@media (max-width: 768px) {
  .data-overview-grid {
    grid-template-columns: 1fr;
  }
  .module-stats-grid {
    grid-template-columns: 1fr;
  }
  .welcome-banner {
    flex-direction: column;
    gap: 24px;
    text-align: center;
  }
  .welcome-left {
    flex-direction: column;
  }
  .admin-badge {
    margin: 0 auto;
  }
}
</style>
