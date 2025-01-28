<template>
  <div ref="chart" style="width: 100%; height: 500px"></div>
</template>

<script>
import { onMounted, ref } from 'vue'
import * as echarts from 'echarts'
// 引入中国地图
import chinaMap from './china.json'

export default {
  name: 'LongMarchMap',
  setup() {
    const chart = ref(null)

    const initChart = () => {
    const myChart = echarts.init(chart.value)


    //将请求的数据展示在这里即可

      let data = [
        { name: '承德', value: [117.928, 40.9642] },
        { name: '张家口', value: [114.9, 40.8] },
        // 其他位置数据
      ]
      // 注册地图
      echarts.registerMap('china', chinaMap)

      const option = {
        tooltip: {
          trigger: 'item',
          formatter: function (params) {
            return (
              params.name +
              '<br>' +
              '经度: ' +
              params.value[0] +
              ', 纬度: ' +
              params.value[1]
            )
          },
        },
        geo: {
          map: 'china', // 地图类型为中国
          roam: true, // 启用缩放和平移功能
          label: {
            emphasis: {
              show: false,
            },
          },
          left: 10,
          top: 50,
          right: 5,
          bottom: -200,
          itemStyle: {
            normal: {
              areaColor: '#eee', // 默认区域颜色
              borderColor: '#ccc', // 默认边界颜色
            },
            emphasis: {
              areaColor: '#ddd', // 鼠标悬停时的区域颜色
            },
          },
          itemStyle: {
            color: '#E3F9F8',
            opacity: 0.8,
          },
        },
        series: [
          {
            name: '位置标记',
            type: 'scatter', // 使用散点图标记位置
            coordinateSystem: 'geo', // 使用地理坐标系统
            data: data, // 位置数据
            symbolSize: 10, // 点的大小
            itemStyle: {
              color: 'blue', // 点的颜色
            },
          },
          {
            name: '城市名称', // 标注文字的系列
            type: 'effectScatter', // 使用带效果的散点图
            coordinateSystem: 'geo',
            data: data, // 数据包括位置名称
            symbolSize: 20, // 设置标记的大小
            label: {
              show: true, // 显示名称
              formatter: '{b}', // 显示名称
              position: 'right', // 标注的位置
              fontSize: 16, // 字体大小
              color: '#11144E', // 字体颜色
            },
            itemStyle: {
              color: 'transparent', // 让点透明，只显示文字
            },
          },
        ],
      }

      myChart.setOption(option)
    }

    onMounted(() => {
      initChart()
    })

    return {
      chart,
    }
  },
}
</script>

<style scoped></style>
