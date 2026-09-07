<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import BoxPlate from './BoxPlate.vue'
import * as echarts from 'echarts'

const users = ref([
    "张三", "李四", "王五", "赵六", "钱七",
    "孙八", "周九", "吴十", "郑十一", "王十二",
    "刘明", "陈强", "杨帆", "黄磊", "徐静",
    "朱军", "马超", "胡斌", "林涛", "高翔"
])

const xAxisData = ref<string[]>([])

const yAxisData = ref<number[]>([])

let chartInstance: echarts.ECharts | null = null
const chartRef = ref<HTMLDivElement | null>(null)

let timer: number | null = null

const generateNewData = () => {
    
    const raw = users.value.map(user => {
        
        const baseValue = 1000 + Math.random() * 1900
        
        const fluctuation = (Math.random() - 0.5) * 1000
        
        const finalValue = Math.max(0, baseValue + fluctuation)

        return {
            name: user,
            value: Math.floor(finalValue)
        }
    })

    
    const top10 = raw.sort((a, b) => a.value - b.value).slice(0, 10)

    
    xAxisData.value = top10.map(i => i.name)
    yAxisData.value = top10.map(i => i.value)
}

const getOption = () => {
    return {
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow',
            },
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '0%',
            top: '10%',
            containLabel: true,
        },
        xAxis: {
            type: 'category',
            data: xAxisData.value,
            axisLabel: {
                interval: 0,
                formatter: (value: any) => {
                    return value.length > 3 ? value.slice(0, 3) + '\n' + value.slice(3) : value
                },
                textStyle: {
                    fontSize: 12,
                    fontWeight: 400,
                    color: '#9fa2a9',
                    align: 'center',
                },
            },
            axisTick: { alignWithLabel: true },
            axisLine: { show: true, lineStyle: { color: 'rgba(153,206,255,0.6)' } },
            splitLine: { show: false },
        },
        yAxis: {
            type: 'value',
            min: 0,
            axisLine: { show: true, lineStyle: { color: 'rgba(153,206,255,0.6)' } },
            splitLine: { show: true, lineStyle: { color: 'rgba(153,206,255,0.3)', type: 'dashed' } },
            axisLabel: {
                interval: 0,
                textStyle: {
                    fontSize: 10,
                    fontWeight: 400,
                    color: '#5b626d',
                },
            },
        },
        series: [
            {
                name: '刷题量',
                type: 'bar',
                barWidth: '60%',
                data: yAxisData.value,
                itemStyle: {
                    color: {
                        type: 'linear',
                        x: 0,
                        y: 0,
                        x2: 1,
                        y2: 0,
                        colorStops: [
                            { offset: 0, color: 'rgba(51, 158, 235, 1)' },
                            { offset: 1, color: 'rgba(29, 63, 133, 0)' },
                        ],
                        global: false,
                    },
                    barBorderRadius: [2, 0, 0, 2],
                },
                label: {
                    show: true,
                    position: 'top',
                    color: '#fff',
                    fontSize: 14,
                },
            },
        ],
    }
}

onMounted(() => {
    generateNewData()

    if (chartRef.value) {
        chartInstance = echarts.init(chartRef.value)
        chartInstance.setOption(getOption())
    }

    
    timer = window.setInterval(() => {
        generateNewData()
        chartInstance?.setOption(getOption())
    }, 10000)
})

onUnmounted(() => {
    if (timer) clearInterval(timer)
    chartInstance?.dispose()
})
</script>

<template>
    <BoxPlate title="用户刷题量TOP10排行榜">
        <div class="chart" ref="chartRef"></div>
    </BoxPlate>
</template>

<style scoped lang="scss">
.chart {
    display: flex;
    align-items: center;
    width: 100%;
    height: 300px;
}
</style>
