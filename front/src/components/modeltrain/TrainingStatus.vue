<!-- TrainingStatus.vue -->
<template>
    <div class="training-status">
      <h3 class="title">模型训练记录</h3>
      
      <div v-if="completedTrainings.length" class="history-list">
        <div v-for="(record) in completedTrainings" 
             :key="record.id" 
             class="history-item"
        >
          <div class="history-header" @click="toggleRecord(record.id)">
            <div class="header-main">
              <span class="status-tag">已完成</span>
              <span class="model-name">{{ record.model.name }}</span>
              <span class="dataset-name">{{ record.dataset.name }}</span>
            </div>
            <el-button 
              type="primary" 
              text
              :icon="expandedRecords.includes(record.id) ? 'el-icon-arrow-up' : 'el-icon-arrow-down'"
            >
              {{ expandedRecords.includes(record.id) ? '收起' : '展开' }}
            </el-button>
          </div>
  
          <!-- 详细信息部分 -->
          <div v-show="expandedRecords.includes(record.id)" class="history-details">
            <!-- 评估指标卡片 -->
            <div class="metrics-cards">
              <div class="metric-card">
                <div class="metric-value">{{ record.metrics.trainLoss.toFixed(4) }}</div>
                <div class="metric-label">训练损失</div>
              </div>
              <div class="metric-card">
                <div class="metric-value">{{ record.metrics.valLoss.toFixed(4) }}</div>
                <div class="metric-label">验证损失</div>
              </div>
              <div class="metric-card">
                <div class="metric-value">{{ record.metrics.mae.toFixed(4) }}</div>
                <div class="metric-label">MAE</div>
              </div>
              <div class="metric-card">
                <div class="metric-value">{{ record.metrics.rmse.toFixed(4) }}</div>
                <div class="metric-label">RMSE</div>
              </div>
            </div>
  
            <!-- 训练参数信息 -->
            <div class="parameters-info">
              <h4>训练参数配置</h4>
              <el-descriptions :column="3" size="small" border>
                <el-descriptions-item label="批次大小">{{ record.commonParams.batchSize }}</el-descriptions-item>
                <el-descriptions-item label="学习率">{{ record.commonParams.learningRate }}</el-descriptions-item>
                <el-descriptions-item label="训练轮次">{{ record.commonParams.epochs }}</el-descriptions-item>
                <el-descriptions-item label="隐藏层维度">{{ record.commonParams.hiddenSize }}</el-descriptions-item>
                <el-descriptions-item label="Dropout率">{{ record.commonParams.dropoutRate }}</el-descriptions-item>
                <el-descriptions-item label="激活函数">{{ record.commonParams.activation }}</el-descriptions-item>
                <el-descriptions-item label="序列长度">{{ record.commonParams.seqLength }}</el-descriptions-item>
                <el-descriptions-item label="预测长度">{{ record.commonParams.predLength }}</el-descriptions-item>
                <el-descriptions-item label="损失函数">{{ record.commonParams.lossFunction }}</el-descriptions-item>
              </el-descriptions>
            </div>
  
            <!-- 训练过程曲线图 -->
            <div class="charts-section">
              <h4>训练过程</h4>
              <div class="charts-container">
                <!-- 损失曲线 -->
                <div class="chart-item">
                  <h5>损失曲线</h5>
                  <v-chart class="chart" :option="getLossChartOption(record)" autoresize />
                </div>
                <!-- 评估指标曲线 -->
                <div class="chart-item">
                  <h5>评估指标</h5>
                  <v-chart class="chart" :option="getMetricsChartOption(record)" autoresize />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
  
      <!-- 无记录时的提示 -->
      <div v-else class="empty-history">
        暂无训练记录
      </div>
    </div>
  </template>
  
  <script>
  import { ref } from 'vue'
  import { use } from 'echarts/core'
  import { CanvasRenderer } from 'echarts/renderers'
  import { LineChart } from 'echarts/charts'
  import {
    GridComponent,
    TooltipComponent,
    LegendComponent,
    TitleComponent
  } from 'echarts/components'
  import VChart from 'vue-echarts'
  
  use([
    CanvasRenderer,
    LineChart,
    GridComponent,
    TooltipComponent,
    LegendComponent,
    TitleComponent
  ])
  
  export default {
    name: 'TrainingStatus',
    
    components: {
      VChart
    },
  
    props: {
      completedTrainings: {
        type: Array,
        required: true,
        default: () => []
      }
    },
  
    setup() {
      const expandedRecords = ref([])
  
      const toggleRecord = (id) => {
        const index = expandedRecords.value.indexOf(id)
        if (index === -1) {
          expandedRecords.value.push(id)
        } else {
          expandedRecords.value.splice(index, 1)
        }
      }
  
      const getLossChartOption = (record) => ({
        grid: {
          top: 40,
          right: 20,
          bottom: 40,
          left: 50
        },
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['训练损失', '验证损失'],
          top: 10
        },
        xAxis: {
          type: 'category',
          name: 'Epoch',
          data: record.history.epochs
        },
        yAxis: {
          type: 'value',
          name: 'Loss'
        },
        series: [
          {
            name: '训练损失',
            type: 'line',
            data: record.history.trainLoss,
            smooth: true
          },
          {
            name: '验证损失',
            type: 'line',
            data: record.history.valLoss,
            smooth: true
          }
        ]
      })
  
      const getMetricsChartOption = (record) => ({
        grid: {
          top: 40,
          right: 20,
          bottom: 40,
          left: 50
        },
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['MAE', 'RMSE'],
          top: 10
        },
        xAxis: {
          type: 'category',
          name: 'Epoch',
          data: record.history.epochs
        },
        yAxis: {
          type: 'value',
          name: 'Value'
        },
        series: [
          {
            name: 'MAE',
            type: 'line',
            data: record.history.mae,
            smooth: true
          },
          {
            name: 'RMSE',
            type: 'line',
            data: record.history.rmse,
            smooth: true
          }
        ]
      })
  
      return {
        expandedRecords,
        toggleRecord,
        getLossChartOption,
        getMetricsChartOption
      }
    }
  }
  </script>
  
  <style scoped>
  .training-status {
    margin: 20px 0;
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  }
  
  .title {
    margin: 0 0 20px 0;
    font-size: 16px;
    color: #303133;
    font-weight: 600;
  }
  
  .history-list {
    display: flex;
    flex-direction: column;
    gap: 16px;
  }
  
  .history-item {
    border: 1px solid #e4e7ed;
    border-radius: 8px;
    overflow: hidden;
  }
  
  .history-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 16px;
    background: #f8fafc;
    cursor: pointer;
  }
  
  .header-main {
    display: flex;
    align-items: center;
    gap: 12px;
  }
  
  .status-tag {
    padding: 2px 8px;
    background: #10b981;
    color: white;
    border-radius: 4px;
    font-size: 12px;
  }
  
  .model-name {
    font-weight: 500;
    color: #1e293b;
  }
  
  .dataset-name {
    color: #64748b;
  }
  
  .history-details {
    padding: 16px;
  }
  
  .metrics-cards {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 16px;
    margin-bottom: 24px;
  }
  
  .metric-card {
    background: #f8fafc;
    padding: 16px;
    border-radius: 6px;
    text-align: center;
  }
  
  .metric-value {
    font-size: 24px;
    font-weight: 600;
    color: #2563eb;
    margin-bottom: 4px;
  }
  
  .metric-label {
    color: #64748b;
    font-size: 14px;
  }
  
  .parameters-info h4,
  .charts-section h4 {
    margin: 0 0 16px 0;
    font-size: 14px;
    color: #374151;
  }
  
  .charts-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    margin-top: 16px;
  }
  
  .chart-item {
    border: 1px solid #e4e7ed;
    border-radius: 6px;
    padding: 16px;
  }
  
  .chart-item h5 {
    margin: 0 0 12px 0;
    font-size: 13px;
    color: #64748b;
    text-align: center;
  }
  
  .chart {
    height: 300px;
  }
  
  .empty-history {
    text-align: center;
    color: #94a3b8;
    padding: 40px 0;
    background: #f8fafc;
    border-radius: 6px;
    border: 1px dashed #e4e7ed;
  }
  </style>