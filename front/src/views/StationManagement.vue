<template>
  <div>
    <div class="controls">
      <label for="dataset-select">请选择数据集:</label>
      <select
        id="dataset-select"
        v-model="selectedDataset"
        @change="fetchStationData"
      >
        <option v-for="dataset in datasets" :key="dataset.name" :value="dataset.id">
          {{ dataset.name }}
        </option>
      </select>

      <div v-if="loading" class="loading">加载站点数据中...</div>
    </div>

    <div ref="chart" style="width: 100%; height: 600px"></div>
  </div>
</template>

<script>
import { onMounted, ref, onUnmounted } from 'vue'
import * as echarts from 'echarts'
import axios from 'axios'
import chinaMap from '../components/map/china.json'

export default {
  name: 'StationMap',
  setup() {
    const chart = ref(null)
    const datasets = ref([])
    const selectedDataset = ref(null)
    const loading = ref(false)
    let myChart = null

    const initChart = (stationData = []) => {
      if (!chart.value) return

      if (!myChart) {
        myChart = echarts.init(chart.value)
      }

      // 转换站点数据格式
      const data = stationData.map(station => ({
        name: station.name,
        value: [station.longitude, station.latitude],
        id: station.id
      }))

      // 注册地图
      echarts.registerMap('china', chinaMap)

      const option = {
        title: {
          text: '站点分布图',
          left: 'center',
          top: 20
        },
        tooltip: {
          trigger: 'item',
          formatter: function (params) {
            if (params.data) {
              return `${params.name}<br>ID: ${params.data.id}<br>经度: ${params.value[0]}<br>纬度: ${params.value[1]}`
            }
            return params.name
          }
        },
        geo: {
          map: 'china',
          roam: true,
          center: [114.5, 38.0], // 将地图中心设在河北中部
          zoom: 1.8, // 放大倍数
          label: {
            emphasis: {
              show: false
            }
          },
          itemStyle: {
            normal: {
              areaColor: '#f3f3f3',
              borderColor: '#ddd'
            },
            emphasis: {
              areaColor: '#e6e6e6'
            }
          }
        },
        series: [
          {
            name: '站点',
            type: 'scatter',
            coordinateSystem: 'geo',
            data: data,
            symbolSize: 12,
            itemStyle: {
              color: '#1890ff',
              shadowBlur: 10,
              shadowColor: 'rgba(24, 144, 255, 0.5)'
            },
            emphasis: {
              itemStyle: {
                borderColor: '#fff',
                borderWidth: 2
              }
            }
          },
          {
            name: '站点名称',
            type: 'scatter',
            coordinateSystem: 'geo',
            data: data,
            symbolSize: 1,
            label: {
              show: true,
              formatter: '{b}',
              position: 'right',
              distance: 5,
              fontSize: 12,
              color: '#333',
              backgroundColor: 'rgba(255, 255, 255, 0.7)',
              padding: [3, 5]
            },
            itemStyle: {
              color: 'transparent'
            }
          }
        ]
      }

      myChart.setOption(option)
    }

    // 获取数据集列表
    const fetchDatasets = async () => {
      try {
        const response = await axios.get('http://127.0.0.1:5000/api/stations/datasets')
        if (response.data.code === 200) {
          datasets.value = response.data.data
          // 如果有数据集，默认选择第一个
          if (datasets.value.length > 0) {
            selectedDataset.value = datasets.value[0].id
            fetchStationData()
          }
        }
      } catch (error) {
        console.error('请求数据集列表出错:', error)
      }
    }

    // 获取站点数据
    const fetchStationData = async () => {
      if (!selectedDataset.value) return

      loading.value = true
      try {
        const response = await axios.get(
          `http://127.0.0.1:5000/api/stations/dataset?dataset_id=${selectedDataset.value}`
        )
        if (response.data.code === 200) {
          initChart(response.data.data)
        }
      } catch (error) {
        console.error('请求站点数据出错:', error)
      } finally {
        loading.value = false
      }
    }

    // 处理窗口大小变化
    const handleResize = () => {
      myChart?.resize()
    }

    onMounted(() => {
      fetchDatasets()
      window.addEventListener('resize', handleResize)
    })

    onUnmounted(() => {
      window.removeEventListener('resize', handleResize)
      myChart?.dispose()
    })

    return {
      chart,
      datasets,
      selectedDataset,
      loading,
      fetchStationData
    }
  }
}
</script>

<style scoped>
.controls {
  margin-bottom: 20px;
  padding: 16px;
  background-color: #f5f5f5;
  border-radius: 4px;
}

.loading {
  margin-top: 8px;
  color: #666;
  font-size: 14px;
}

select {
  margin-left: 8px;
  padding: 4px 8px;
  border: 1px solid #d9d9d9;
  border-radius: 4px;
}
</style>