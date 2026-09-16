<script setup lang="ts">
import { useUserStore } from '@/stores/modules/user';
const userStore = useUserStore()
import { ref, watch, onMounted } from 'vue'
import * as echarts from 'echarts';

import { useSettingStore } from '@/stores/modules/setting';
const settingStore = useSettingStore();
import { apiAdminHomeCount, apiTopicTrend, apiUserTrend, apiAiTrend } from '@/api/home'
import type { AdminLeftDataType, TopicTrendType } from '@/api/home/type';

const topicTrendChart = ref(null);
const initProblemTrendChart = () => {
  const myChart = echarts.init(topicTrendChart.value);
  const option = {
    backgroundColor: settingStore.isDark ? '#141414' : '#fff',
    tooltip: {
      trigger: 'axis'
    },
    legend: {
      data: ['刷题人数', '题目数量'],
      right: '5%',
      top: '2%',
      textStyle: {
        color: '#8c8c8c'
      }
    },
    grid: {
      top: '10%',
      left: '3%',
      right: '4%',
      bottom: '8%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      boundaryGap: false,
      data: middleData.value?.dateList,
      axisLine: {
        lineStyle: {
          color: '#E0E6F1'
        }
      },
      axisLabel: {
        color: '#666'
      }
    },
    yAxis: {
      type: 'value',
      axisLine: {
        show: false
      },
      axisTick: {
        show: false
      },
      axisLabel: {
        color: '#666'
      },
      splitLine: {
        lineStyle: {
          color: '#E0E6F1',
          type: 'dashed'
        }
      }
    },
    series: [
      {
        name: '刷题人数',
        type: 'line',
        smooth: true,
        symbol: 'circle',
        symbolSize: 8,
        showSymbol: true, 
        lineStyle: {
          width: 3,
          color: '#0a3442',
          type: 'dashed' 
        },
        itemStyle: {
          color: '#0a3442',
          borderColor: '#fff',
          borderWidth: 2
        },
        areaStyle: {
          color: 'rgba(10, 52, 66, 0.15)'
        },
        emphasis: {
          focus: 'series'
        },
        data: middleData.value?.countUserList
      },
      {
        name: '题目数量',
        type: 'line',
        smooth: true,
        symbol: 'triangle', 
        symbolSize: 8,
        showSymbol: true,
        lineStyle: {
          width: 3,
          color: '#3ad3cd'
        },
        itemStyle: {
          color: '#3ad3cd',
          borderColor: '#fff',
          borderWidth: 2
        },
        areaStyle: {
          color: 'rgba(58, 211, 205, 0.15)'
        },
        emphasis: {
          focus: 'series'
        },
        data: middleData.value?.countTopicList
      }
    ]
  };

  myChart.setOption(option);

  
  window.addEventListener('resize', () => {
    myChart.resize();
  });
}

const userGrowthChart = ref(null);
const initUserGrowthChart = () => {
  const myChart = echarts.init(userGrowthChart.value);
  const option = {
    backgroundColor: settingStore.isDark ? '#141414' : '#fff',

    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross',
        label: {
          backgroundColor: '#0a3442'
        }
      }
    },
    grid: {
      top: '10%',
      left: '3%',
      right: '7%',
      bottom: '15%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      boundaryGap: false,
      data: userTrend.value.dateList,
      axisLine: {
        lineStyle: {
          color: '#E0E6F1'
        }
      },
      axisLabel: {
        color: '#666'
      }
    },
    yAxis: {
      type: 'value',
      axisLine: {
        show: false
      },
      axisTick: {
        show: false
      },
      axisLabel: {
        color: '#666'
      },
      splitLine: {
        lineStyle: {
          color: '#E0E6F1',
          type: 'dashed'
        }
      }
    },
    series: [
      {
        name: '用户增长',
        type: 'line',
        stack: 'Total',
        smooth: true,
        symbol: 'circle',
        symbolSize: 6,
        showSymbol: true,
        lineStyle: {
          width: 3,
          color: '#0a3442'
        },
        itemStyle: {
          color: '#0a3442',
          borderColor: '#fff',
          borderWidth: 2
        },
        areaStyle: {
          color: 'rgba(10, 52, 66, 0.15)'
        },
        emphasis: {
          focus: 'series'
        },
        data: userTrend.value.countList
      }
    ]
  };
  myChart.setOption(option);

  
  window.addEventListener('resize', () => {
    myChart.resize();
  });
}

const aiCallChart = ref(null);
const initAiCallChart = () => {
  const myChart = echarts.init(aiCallChart.value);
  const option = {
    backgroundColor: settingStore.isDark ? '#141414' : '#fff',
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross',
        label: {
          backgroundColor: '#0a3442'
        }
      }
    },
    grid: {
      top: '10%',
      left: '3%',
      right: '7%',
      bottom: '15%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      boundaryGap: false,
      data: aiTrend.value.dateList,
      axisLine: {
        lineStyle: {
          color: '#E0E6F1',
        }
      },
      axisLabel: {
        color: '#666',
      },
    },
    yAxis: {
      type: 'value',
      axisLine: {
        show: false
      },
      axisTick: {
        show: false
      },
      axisLabel: {
        color: '#666'
      },
      splitLine: {
        lineStyle: {
          color: '#E0E6F1',
          type: 'dashed'
        }
      }
    },
    series: [
      {
        name: '调用次数',
        type: 'line',
        stack: 'Total',
        smooth: true,
        symbol: 'circle',
        symbolSize: 6,
        showSymbol: true,
        lineStyle: {
          width: 3,
          color: '#104455'
        },
        itemStyle: {
          color: '#104455',
          borderColor: '#fff',
          borderWidth: 2
        },
        areaStyle: {
          color: 'rgba(16, 68, 85, 0.15)'
        },
        emphasis: {
          focus: 'series'
        },
        data: aiTrend.value.countList
      }
    ]
  };
  myChart.setOption(option);

  
  window.addEventListener('resize', () => {
    myChart.resize();
  });
}

watch(() => settingStore.isDark, () => {
  
  initAiCallChart()
  initProblemTrendChart();
  initUserGrowthChart();
});

const leftData = ref<AdminLeftDataType>(); 
const middleData = ref<TopicTrendType>(); 
const userTrend = ref(); 
const aiTrend = ref(); 

const getLeftData = async () => {
  const res = await apiAdminHomeCount();
  if (res.data) {
    leftData.value = res.data
  }
}

const getMiddleData = async () => {
  const res = await apiTopicTrend();
  if (res.data) {
    middleData.value = res.data
    initProblemTrendChart();
  }
}

const getUserTrendData = async () => {
  const res = await apiUserTrend();
  if (res.data) {
    userTrend.value = res.data
    initUserGrowthChart();
  }
}

const getAiTrendData = async () => {
  const res = await apiAiTrend();
  if (res.data) {
    aiTrend.value = res.data
    initAiCallChart()
  }
}

const initData = async () => {
  await Promise.all([
    getLeftData(),
    getMiddleData(),
    getUserTrendData(),
    getAiTrendData()
  ])
}

onMounted(() => {
  initData()
});
</script>
<template>
  <div class="admin-body">
    
    <a-row>
      
      <a-col :xs="24" :sm="24" :md="12" :lg="12" :xl="12">
        <a-card :bordered="false">
          <a-row>
            
            <a-col :span="8" class="user-info-col">
              <div class="user-info-container">
                <a-avatar
                  :style="{ 'border': `1px solid ${userStore.userInfo.identity === 1 ? '#ffd700' : '#0a3442'}` }"
                  :size="100" :src="userStore.userInfo.avatar">
                  <template #icon>
                    <UserOutlined />
                  </template>
                </a-avatar>
                <div class="user-details">
                  
                  <div class="username" :style="{ 'color': userStore.userInfo.identity === 1 ? '#ffd700' : '#0a3442' }">
                    {{
                      userStore.userInfo.nickname || userStore.userInfo.account
                    }}</div>
                  <div class="achievements">
                    
                    <a-tag
                      style="background: rgba(10, 52, 66, 0.15);"
                      class="user-identity">
                      <CrownOutlined /> 管理员
                    </a-tag>
                  </div>
                </div>
              </div>
            </a-col>
            
            <a-col :span="16" class="user-data-col">
              <a-row :gutter="[16, 16]">
                <a-col :span="12">
                  <a-statistic title="用户增长" :value="leftData?.userGrowthRate || 0" class="stat-item">
                    <template #prefix>
                      <TeamOutlined />
                    </template>
                    <template #suffix>
                      <span>人</span>
                    </template>
                  </a-statistic>
                </a-col>
                <a-col :span="12">
                  <a-statistic title="AI调用总次数" :value="leftData?.aiCount" class=" stat-item">
                    <template #prefix>
                      <RobotOutlined />
                    </template>
                    <template #suffix>
                      <span>次</span>
                      <span class="top-magnitude" v-if="leftData && leftData.aiGrowthRate > 0">
                        <ArrowUpOutlined /> {{ leftData.aiGrowthRate }}次
                      </span>
                      <span class="bottom-magnitude" v-else>
                        <ArrowDownOutlined /> {{ Math.abs(leftData?.aiGrowthRate ?? 0) }}次
                      </span>
                    </template>
                  </a-statistic>
                </a-col>
                <a-col :span="12">
                  <a-statistic title="用户总数" :value="leftData?.userCount" class="stat-item">
                    <template #prefix>
                      <TeamOutlined />
                    </template>
                    <template #suffix>
                      <span>名</span>
                      <span class="top-magnitude" v-if="leftData && leftData?.userGrowthRate > 0">
                        <ArrowUpOutlined /> {{ leftData?.userGrowthRate }}名
                      </span>
                      <span class="bottom-magnitude">
                        <ArrowDownOutlined /> {{ Math.abs(leftData?.userGrowthRate ?? 0) }}名
                      </span>
                    </template>
                  </a-statistic>
                </a-col>
                <a-col :span="12">
                  <a-statistic title="收录题目数量" suffix="题" :value="leftData?.totalTopicCount" class="stat-item">
                    <template #prefix>
                      <FileTextOutlined />
                    </template>
                  </a-statistic>
                </a-col>
                <a-col :span="12">
                  <a-statistic title="收录专题数量" :value="leftData?.totalSubjectCount" suffix="个" class="stat-item">
                    <template #prefix>
                      <BookOutlined />
                    </template>
                  </a-statistic>
                </a-col>
                <a-col :span="12">
                  <a-statistic title="收录标签数量" :value="leftData?.topicLabelCount" suffix="个" class="stat-item">
                    <template #prefix>
                      <TagsOutlined />
                    </template>
                  </a-statistic>
                </a-col>
              </a-row>
            </a-col>
          </a-row>
        </a-card>
      </a-col>
    </a-row>
    
    <div class="middle-section">
      <a-card :bordered="false">
        <div class="chart-title">刷题趋势图</div>
        <div ref="topicTrendChart" class="topic-trend"></div>
      </a-card>
    </div>
    
    <div class="bottom-section">
      
      <a-card :bordered="false" class="bottom-section-container">
        <a-row>
          <a-col :span="12">
            <div class="chart-title">用户增长趋势图</div>
            <div ref="userGrowthChart" class="user-growth"></div>
          </a-col>
          <a-col :span="12">
            <div class="chart-title">AI调用次数趋势图</div>
            <div ref="aiCallChart" class="ai-call"></div>
          </a-col>
        </a-row>
      </a-card>
    </div>
  </div>
</template>
<style lang="scss" scoped>
.user-info-col {
  display: flex;
  justify-content: center;
}

.user-info-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  padding-right: 30px;
}

.user-details {
  margin-top: 10px;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-left: 4px;
}

.username {
  text-align: center;
  margin-bottom: 8px;
}

.user-data-col {
  padding-bottom: 33px;
}

.stat-item {
  margin-bottom: 10px;

  .top-magnitude {
    color: #0a3442;
    font-size: 14px;
  }

  .bottom-magnitude {
    color: #cf1322;
    font-size: 14px;
  }
}

.middle-section {
  margin-top: 20px;
  margin-bottom: 20px;
}

.chart-title {
  font-size: 18px;
  font-weight: 600;
  margin-bottom: 15px;
  color: $base-personal-color;
  display: flex;
  align-items: center;
}

.chart-title::before {
  content: '';
  display: inline-block;
  width: 4px;
  height: 18px;
  background: #0a3442;
  margin-right: 10px;
  border-radius: 2px;
}

.topic-trend {
  width: 100%;
  height: 350px;
}

.bottom-section {
  width: 100%;
  display: flex;

  .bottom-section-container {
    width: 100%;

  }
}

.user-growth {

  width: 100%;
  height: 350px;
}

.ai-call {

  width: 100%;
  height: 350px;
}
</style>
