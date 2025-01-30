<!-- TrainingQueue.vue -->
<template>
    <div class="training-queue">
      <h3 class="title">训练队列</h3>
      
      <div v-if="queueItems.length" class="queue-list">
        <div v-for="(item, index) in queueItems" 
             :key="item.id" 
             class="queue-item"
             :class="{ 'current': index === 0 }"
        >
          <!-- 队列项信息 -->
          <div class="item-content">
            <div class="config-section">
              <h4>基础配置</h4>
              <el-descriptions :column="2" size="small" border>
                <el-descriptions-item label="数据集">{{ item.dataset.name }}</el-descriptions-item>
                <el-descriptions-item label="模型">{{ item.model.name }}</el-descriptions-item>
              </el-descriptions>
            </div>
  
            <div class="config-section">
              <h4>通用参数</h4>
              <el-descriptions :column="3" size="small" border>
                <el-descriptions-item label="批次大小">{{ item.commonParams.batchSize }}</el-descriptions-item>
                <el-descriptions-item label="学习率">{{ item.commonParams.learningRate }}</el-descriptions-item>
                <el-descriptions-item label="训练轮次">{{ item.commonParams.epochs }}</el-descriptions-item>
                <el-descriptions-item label="隐藏层维度">{{ item.commonParams.hiddenSize }}</el-descriptions-item>
                <el-descriptions-item label="Dropout率">{{ item.commonParams.dropoutRate }}</el-descriptions-item>
                <el-descriptions-item label="激活函数">{{ item.commonParams.activation }}</el-descriptions-item>
                <el-descriptions-item label="序列长度">{{ item.commonParams.seqLength }}</el-descriptions-item>
                <el-descriptions-item label="预测长度">{{ item.commonParams.predLength }}</el-descriptions-item>
                <el-descriptions-item label="损失函数">{{ item.commonParams.lossFunction }}</el-descriptions-item>
              </el-descriptions>
            </div>
  
            <div class="config-section">
              <h4>模型参数</h4>
              <el-descriptions :column="3" size="small" border>
                <template v-if="item.model.type === 'GNN-MLP'">
                  <el-descriptions-item label="GCN层数">{{ item.modelParams.gcnLayers }}</el-descriptions-item>
                  <el-descriptions-item label="MLP层配置">{{ item.modelParams.mlpLayers.join(', ') }}</el-descriptions-item>
                </template>
                <template v-else-if="item.model.type === 'GNN-RNN'">
                  <el-descriptions-item label="GCN层数">{{ item.modelParams.gcnLayers }}</el-descriptions-item>
                  <el-descriptions-item :label="item.model.name === 'GCN-LSTM' ? 'LSTM层数' : 'GRU层数'">
                    {{ item.modelParams.lstmLayers || item.modelParams.gruLayers }}
                  </el-descriptions-item>
                  <el-descriptions-item :label="item.model.name === 'GCN-LSTM' ? 'LSTM隐藏维度' : 'GRU隐藏维度'">
                    {{ item.modelParams.lstmHidden || item.modelParams.gruHidden }}
                  </el-descriptions-item>
                </template>
                <template v-else>
                  <el-descriptions-item label="GCN层数">{{ item.modelParams.gcnLayers }}</el-descriptions-item>
                  <el-descriptions-item label="Transformer层数">{{ item.modelParams.numLayers }}</el-descriptions-item>
                  <el-descriptions-item label="注意力头数">{{ item.modelParams.numHeads }}</el-descriptions-item>
                  <template v-if="item.model.name === 'GCN-informer'">
                    <el-descriptions-item label="蒸馏因子">{{ item.modelParams.distilFactor }}</el-descriptions-item>
                  </template>
                  <template v-else-if="item.model.name === 'GCN-Autoformer'">
                    <el-descriptions-item label="移动平均">{{ item.modelParams.movingAvg }}</el-descriptions-item>
                  </template>
                  <template v-else-if="item.model.name === 'GCN-FFPformer'">
                    <el-descriptions-item label="频率维度">{{ item.modelParams.freqDim }}</el-descriptions-item>
                  </template>
                </template>
              </el-descriptions>
            </div>
          </div>
  
          <!-- 当前训练项的状态 -->
          <div v-if="index === 0 && isTraining" class="item-status">
            <div class="progress-info">
              <span class="epoch-info">当前轮次: {{ currentEpoch }}/{{ item.commonParams.epochs }}</span>
              <el-progress 
                :percentage="trainingProgress" 
                :format="progressFormat"
                :status="trainingProgress === 100 ? 'success' : ''"
              />
            </div>
  
            <div class="metrics-info">
              <div class="metrics-row">
                <div class="metric-item">
                  <span class="metric-label">训练损失:</span>
                  <span class="metric-value">{{ currentMetrics.trainLoss.toFixed(4) }}</span>
                </div>
                <div class="metric-item">
                  <span class="metric-label">测试损失:</span>
                  <span class="metric-value">{{ currentMetrics.valLoss.toFixed(4) }}</span>
                </div>
                <div class="metric-item">
                  <span class="metric-label">MAE:</span>
                  <span class="metric-value">{{ currentMetrics.mae.toFixed(4) }}</span>
                </div>
                <div class="metric-item">
                  <span class="metric-label">RMSE:</span>
                  <span class="metric-value">{{ currentMetrics.rmse.toFixed(4) }}</span>
                </div>
              </div>
              
              <!-- 训练曲线 -->
              <div class="charts-container">
                <div class="chart-item">
                  <h5>损失曲线</h5>
                  <v-chart class="chart" :option="getLossChartOption()" autoresize />
                </div>
                <div class="chart-item">
                  <h5>评估指标</h5>
                  <v-chart class="chart" :option="getMetricsChartOption()" autoresize />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
  
      <div v-else class="queue-empty">
        请配置模型参数开始训练
      </div>
    </div>
  </template>
  
  <script>
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
  
  // 在 TrainingQueue 组件的 setup 函数中修改
export default {
  name: 'TrainingQueue',
  
  components: {
    VChart
  },

  props: {
    queueItems: {
      type: Array,
      required: true,
      default: () => []
    },
    isTraining: {
      type: Boolean,
      default: false
    },
    trainingProgress: {
      type: Number,
      default: 0
    },
    currentEpoch: {
      type: Number,
      default: 0
    },
    currentMetrics: {
      type: Object,
      default: () => ({
        trainLoss: 0,
        valLoss: 0,
        mae: 0,
        rmse: 0
      })
    },
    trainingHistory: {
      type: Object,
      default: () => ({
        epochs: [],
        trainLoss: [],
        valLoss: [],
        mae: [],
        rmse: []
      })
    }
  },

  setup(props) {  // 添加 props 参数
    const progressFormat = (percentage) => {
      return `${Math.round(percentage)}%`
    }

    const getLossChartOption = () => {
      return {
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
          data: ['训练损失', '测试损失'],
          top: 10
        },
        xAxis: {
          type: 'category',
          name: 'Epoch',
          data: props.trainingHistory.epochs  // 使用 props
        },
        yAxis: {
          type: 'value',
          name: 'Loss'
        },
        series: [
          {
            name: '训练损失',
            type: 'line',
            data: props.trainingHistory.trainLoss,  // 使用 props
            smooth: true
          },
          {
            name: '测试损失',
            type: 'line',
            data: props.trainingHistory.valLoss,  // 使用 props
            smooth: true
          }
        ]
      }
    }

    const getMetricsChartOption = () => {
      return {
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
          data: props.trainingHistory.epochs  // 使用 props
        },
        yAxis: {
          type: 'value',
          name: 'Value'
        },
        series: [
          {
            name: 'MAE',
            type: 'line',
            data: props.trainingHistory.mae,  // 使用 props
            smooth: true
          },
          {
            name: 'RMSE',
            type: 'line',
            data: props.trainingHistory.rmse,  // 使用 props
            smooth: true
          }
        ]
      }
    }

    return {
      progressFormat,
      getLossChartOption,
      getMetricsChartOption
    }
  }
}
  </script>
  
  <style scoped>
  .training-queue {
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
  
  .queue-list {
    display: flex;
    flex-direction: column;
    gap: 16px;
  }
  
  .queue-item {
    border: 1px solid #e4e7ed;
    border-radius: 6px;
    overflow: hidden;
  }
  
  .queue-item.current {
    border-color: #2563eb;
    box-shadow: 0 2px 8px rgba(37, 99, 235, 0.1);
  }
  
  .config-section {
    margin-bottom: 16px;
  }
  
  .config-section h4 {
    margin: 0 0 8px 0;
    font-size: 14px;
    color: #374151;
  }
  
  .item-content {
    padding: 16px;
  }
  
  .item-status {
    padding: 16px;
    background: #f8fafc;
    border-top: 1px solid #e4e7ed;
  }
  
  .progress-info {
    margin-bottom: 16px;
  }
  
  .epoch-info {
    display: block;
    margin-bottom: 8px;
    color: #64748b;
    font-size: 14px;
  }
  
  .metrics-info {
    margin-top: 16px;
  }
  
  .metrics-row {
    display: flex;
    flex-wrap: wrap;
    gap: 16px;
    margin-bottom: 16px;
  }
  
  .metric-item {
    display: flex;
    align-items: center;
    gap: 8px;
  }
  
  .metric-label {
    color: #64748b;
    font-size: 14px;
  }
  
  .metric-value {
    color: #1e293b;
    font-size: 14px;
    font-weight: 500;
  }
  
  .charts-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 16px;
  }
  
  .chart-item {
    border: 1px solid #e4e7ed;
    border-radius: 4px;
    padding: 8px;
  }
  
  .chart-item h5 {
    margin: 0 0 8px 0;
    font-size: 13px;
    color: #64748b;
    text-align: center;
  }
  
  .chart {
    height: 200px;
  }
  
  .queue-empty {
    text-align: center;
    color: #94a3b8;
    padding: 40px 0;
    background: #f8fafc;
    border-radius: 6px;
    border: 1px dashed #e4e7ed;
  }
  
  :deep(.el-descriptions__cell) {
    padding: 8px 12px !important;
  }
  </style>