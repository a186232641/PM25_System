<!-- StationManagement.vue -->
<template>
  <div class="station-management bg-gray-50 min-h-screen p-6">
    <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-md p-6">
      <h1 class="text-2xl font-bold text-gray-800 mb-6 text-center">历史信息查询</h1>

      <!-- 选择框并排 -->
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
        <!-- 数据集选择 -->
        <div>
          <label for="dataset-select" class="block text-sm font-medium text-gray-700 mb-2">
            数据集选择
          </label>
          <select
            id="dataset-select"
            v-model="selectedDataset"
            @change="onDatasetChange"
            class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
          >
            <option value="">请选择数据集</option>
            <option v-for="dataset in datasets" :key="dataset.id" :value="dataset.id">
              {{ dataset.name }}
            </option>
          </select>
        </div>

        <!-- 城市站点选择 -->
        <div v-if="stations.length">
          <label for="station-select" class="block text-sm font-medium text-gray-700 mb-2">
            城市站点选择
          </label>
          <select
            id="station-select"
            v-model="selectedStation"
            @change="onStationChange"
            class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
          >
            <option value="">请选择站点</option>
            <option v-for="station in stations" :key="station.id" :value="station.id">
              {{ station.name }}
            </option>
          </select>
        </div>

        <!-- 特征选择 -->
        <div v-if="features.length">
          <label for="feature-select" class="block text-sm font-medium text-gray-700 mb-2">
            特征选择
          </label>
          <select
            id="feature-select"
            v-model="selectedFeature"
            @change="onFeatureChange"
            class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
          >
            <option value="">请选择特征</option>
            <option v-for="feature in features" :key="feature.id" :value="feature.id">
              {{ feature.name }}
            </option>
          </select>
        </div>
      </div>

      <!-- 加载状态 -->
      <div v-if="loading" class="flex justify-center items-center py-8">
        <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-500"></div>
        <span class="ml-2 text-gray-600">加载数据中...</span>
      </div>

      <!-- 时序数据可视化区域 -->
      <div v-if="historicalData" class="mt-6 border rounded-lg p-4">
        <!-- 时间范围选择 -->
        <div class="mb-4 flex gap-4 items-end">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">开始时间</label>
            <input
              type="datetime-local"
              v-model="dateRange.start"
              class="px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            />
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">结束时间</label>
            <input
              type="datetime-local"
              v-model="dateRange.end"
              class="px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            />
          </div>
          <button
            @click="applyDateRange"
            class="px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
          >
            应用
          </button>
          <button
            @click="resetDateRange"
            class="px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2"
          >
            重置
          </button>
        </div>

        <!-- ECharts 图表 -->
        <v-chart class="chart" :option="chartOptions" autoresize />
      </div>
    </div>
  </div>
</template>

<script>
import { ref, computed } from 'vue'
import axios from 'axios'
import { use } from 'echarts/core'
import { LineChart } from 'echarts/charts'
import { CanvasRenderer } from 'echarts/renderers'
import {
  GridComponent,
  TitleComponent,
  TooltipComponent,
  LegendComponent,
  DataZoomComponent,
  ToolboxComponent
} from 'echarts/components'
import VChart from 'vue-echarts'

use([
  LineChart,
  CanvasRenderer,
  GridComponent,
  TitleComponent,
  TooltipComponent,
  LegendComponent,
  DataZoomComponent,
  ToolboxComponent
])

export default {
  name: 'StationManagement',
  components: { VChart },
  setup() {
    const datasets = ref([])
    const selectedDataset = ref('')
    const stations = ref([])
    const selectedStation = ref('')
    const features = ref([])
    const selectedFeature = ref('')
    const loading = ref(false)
    const historicalData = ref(null)
    const dateRange = ref({
      start: '',
      end: ''
    })

    const currentStation = computed(() => {
      return stations.value.find(station => station.id === selectedStation.value)
    })

    // 过滤后的数据
    const filteredData = computed(() => {
      if (!historicalData.value || !dateRange.value.start || !dateRange.value.end) {
        return historicalData.value
      }

      const startTime = new Date(dateRange.value.start).getTime()
      const endTime = new Date(dateRange.value.end).getTime()

      return {
        ...historicalData.value,
        timeseries: historicalData.value.timeseries.filter(item => {
          const itemTime = new Date(item.timestamp).getTime()
          return itemTime >= startTime && itemTime <= endTime
        })
      }
    })

    // 图表配置
    const chartOptions = computed(() => {
  if (!filteredData.value) return {}

  const data = filteredData.value.timeseries

  return {
    title: {
      text: '历史数据趋势',
      left: 'center'
    },
    tooltip: {
      trigger: 'axis',
      formatter: function(params) {
        const param = params[0]
        return `${param.axisValue}<br/>${param.marker}值：${param.data.toFixed(3)}`
      }
    },
    toolbox: {
      feature: {
        dataZoom: {
          yAxisIndex: 'none'
        },
        restore: {},
        saveAsImage: {}
      },
      right: 20
    },
    grid: {
      left: '5%',
      right: '5%',
      bottom: '15%',
      top: '15%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      data: data.map(item => item.timestamp),
      axisLabel: {
        rotate: 45,
        interval: Math.floor(data.length / 10), // 控制显示的标签数量
        formatter: function(value) {
          // 将时间格式化为 "YYYY-MM-DD\nHH:mm"
          const date = new Date(value)
          const year = date.getFullYear()
          const month = String(date.getMonth() + 1).padStart(2, '0')
          const day = String(date.getDate()).padStart(2, '0')
          const hours = String(date.getHours()).padStart(2, '0')
          const minutes = String(date.getMinutes()).padStart(2, '0')
          return `${year}-${month}-${day}\n${hours}:${minutes}`
        }
      },
      boundaryGap: true
    },
    yAxis: {
      type: 'value',
      name: '数值',
      nameLocation: 'middle',
      nameGap: 50,
      axisLabel: {
        formatter: '{value}'
      },
      splitLine: {
        show: true,
        lineStyle: {
          type: 'dashed'
        }
      }
    },
    dataZoom: [
      {
        type: 'slider',
        show: true,
        start: 0,
        end: 100,
        bottom: 10,
        height: 20
      },
      {
        type: 'inside',
        start: 0,
        end: 100
      }
    ],
    series: [
      {
        name: '数值',
        type: 'line',
        data: data.map(item => item.value),
        smooth: true,
        symbolSize: 4,
        showSymbol: false,
        lineStyle: {
          width: 2
        },
        itemStyle: {
          color: '#5470c6'
        },
        emphasis: {
          scale: true,
          focus: 'series'
        }
      }
    ]
  }
})

    // API 请求
    const fetchDatasets = async () => {
      try {
        const response = await axios.get('http://127.0.0.1:5000/api/stations/datasets')
        if (response.data.code === 200) {
          datasets.value = response.data.data
        } else {
          console.error('请求失败:', response.data.message)
        }
      } catch (error) {
        console.error('请求出错:', error)
      }
    }

    const onDatasetChange = async () => {
      if (!selectedDataset.value) return

      loading.value = true
      stations.value = []
      selectedStation.value = ''
      selectedFeature.value = ''
      features.value = []
      historicalData.value = null

      try {
        const response = await axios.get(
          `http://127.0.0.1:5000/api/stations/dataset?dataset_id=${selectedDataset.value}`
        )
        if (response.data.code === 200) {
          stations.value = response.data.data
        }
      } catch (error) {
        console.error('请求站点数据出错:', error)
      } finally {
        loading.value = false
      }
    }

    const onStationChange = async () => {
      if (!selectedStation.value) return
      
      loading.value = true
      features.value = []
      selectedFeature.value = ''
      historicalData.value = null

      try {
        const response = await axios.get('http://127.0.0.1:5000/api/feature')
        if (response.data.code === 200) {
          features.value = response.data.data
        }
      } catch (error) {
        console.error('请求特征数据出错:', error)
      } finally {
        loading.value = false
      }
    }

    const onFeatureChange = async () => {
      if (!selectedFeature.value || !selectedStation.value || !selectedDataset.value) return
      
      loading.value = true
      historicalData.value = null

      try {
        const response = await axios.get(
          'http://127.0.0.1:5000/api/historical/data',
          {
            params: {
              dataset_id: selectedDataset.value,
              station_id: selectedStation.value,
              feature_id: selectedFeature.value
            }
          }
        )
        if (response.data.code === 200) {
          historicalData.value = response.data.data
          // 设置初始日期范围
          if (response.data.data.timeseries.length > 0) {
            const firstDate = response.data.data.timeseries[0].timestamp
            const lastDate = response.data.data.timeseries[response.data.data.timeseries.length - 1].timestamp
            dateRange.value = {
              start: firstDate.slice(0, 16), // 去掉秒
              end: lastDate.slice(0, 16)
            }
          }
        }
      } catch (error) {
        console.error('请求历史数据出错:', error)
      } finally {
        loading.value = false
      }
    }

    // 时间范围操作
    const applyDateRange = () => {
      // 日期范围的变化会自动触发 filteredData 和 chartOptions 的更新
    }

    const resetDateRange = () => {
      if (historicalData.value && historicalData.value.timeseries.length > 0) {
        dateRange.value = {
          start: historicalData.value.timeseries[0].timestamp.slice(0, 16),
          end: historicalData.value.timeseries[historicalData.value.timeseries.length - 1].timestamp.slice(0, 16)
        }
      }
    }

    // 初始化
    fetchDatasets()

    return {
      datasets,
      selectedDataset,
      stations,
      selectedStation,
      features,
      selectedFeature,
      loading,
      currentStation,
      historicalData,
      dateRange,
      chartOptions,
      onDatasetChange,
      onStationChange,
      onFeatureChange,
      applyDateRange,
      resetDateRange
    }
  }
}
</script>

<style scoped>
.chart {
  width: 100%;
  height: 400px;
}

.station-management {
  min-height: 100vh;
}
</style>