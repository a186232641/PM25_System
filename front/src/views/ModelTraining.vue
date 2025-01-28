<!-- views/TrafficQuery.vue -->
<template>
  <div class="traffic-query">
    <div class="query-form">
      <div class="form-item">
        <label>时间范围</label>
        <div class="date-range">
          <input type="datetime-local" v-model="timeRange.start">
          <span>至</span>
          <input type="datetime-local" v-model="timeRange.end">
        </div>
      </div>
      <div class="form-item">
        <label>区域选择</label>
        <select v-model="selectedAreas" multiple>
          <option v-for="area in areas" :key="area.id" :value="area.id">
            {{ area.name }}
          </option>
        </select>
      </div>
      <button class="query-btn" @click="handleQuery">查询</button>
    </div>

    <div class="visualization">
      <div class="chart heat-map" ref="heatMapRef"></div>
      <div class="chart line-chart" ref="lineChartRef"></div>
      <div class="chart pie-chart" ref="pieChartRef"></div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
import * as echarts from 'echarts'

export default {
  name: 'TrafficQuery',
  setup() {
    const timeRange = ref({
      start: '',
      end: ''
    })
    const selectedAreas = ref([])
    const areas = ref([
      { id: 1, name: '区域1' },
      { id: 2, name: '区域2' },
      // ... 更多区域
    ])

    const heatMapRef = ref(null)
    const lineChartRef = ref(null)
    const pieChartRef = ref(null)

    let heatMap = null
    let lineChart = null
    let pieChart = null

    onMounted(() => {
      // 初始化图表
      heatMap = echarts.init(heatMapRef.value)
      lineChart = echarts.init(lineChartRef.value)
      pieChart = echarts.init(pieChartRef.value)

      // 初始化展示默认数据
      updateCharts()
    })

    const handleQuery = async () => {
      try {
        // 发送请求获取数据
        // 更新图表
        updateCharts()
      } catch (error) {
        console.error('查询失败:', error)
      }
    }

    const updateCharts = () => {
      // 更新热力图
      heatMap.setOption({
        // ... 热力图配置
      })

      // 更新折线图
      lineChart.setOption({
        // ... 折线图配置
      })

      // 更新饼图
      pieChart.setOption({
        // ... 饼图配置
      })
    }

    return {
      timeRange,
      selectedAreas,
      areas,
      heatMapRef,
      lineChartRef,
      pieChartRef,
      handleQuery
    }
  }
}
</script>

<style scoped>
.traffic-query {
  height: 100%;
  display: flex;
  flex-direction: column;
}

.query-form {
  padding: 20px;
  background-color: #fff;
  border-radius: 4px;
  margin-bottom: 20px;
}

.form-item {
  margin-bottom: 15px;
}

.form-item label {
  display: block;
  margin-bottom: 5px;
}

.date-range {
  display: flex;
  align-items: center;
  gap: 10px;
}

.query-btn {
  padding: 8px 16px;
  background-color: #1e1e1e;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.visualization {
  flex: 1;
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-template-rows: 1fr 1fr;
  gap: 20px;
}

.chart {
  background-color: #fff;
  border-radius: 4px;
  min-height: 300px;
}

.heat-map {
  grid-column: 1 / 3;
}
</style>