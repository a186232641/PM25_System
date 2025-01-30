<template>
  <div class="model-training-container">
    <h2 class="main-title">深度学习模型训练系统</h2>
    
    <!-- 数据集和模型选择区域 -->
    <div class="selector-section">
      <div class="selector-item">
        <DatasetSelector 
          @dataset-selected="handleDatasetSelected"
          :datasets="availableDatasets"
        />
      </div>

      <div class="selector-item">
        <ModelSelector
          @model-selected="handleModelSelected"
          :models="availableModels"
        />
      </div>
    </div>

    <!-- 参数配置区域 -->
    <div class="parameters-section">
      <CommonParameters
        @parameters-updated="handleCommonParamsUpdated"
        :parameters="commonParameters"
      />
      
      <ModelParameters
        v-if="selectedModel"
        @parameters-updated="handleModelParamsUpdated"
        :parameters="modelParameters"
        :selectedModel="selectedModel"
      />
    </div>
    <div class="training-control">
  <el-button 
    type="primary" 
    :disabled="!isConfigValid"
    @click="handleStartTraining"
    size="large"
  >
    开始训练
  </el-button>
</div>
    <!-- 优化器和训练状态区域 -->
    <div class="training-section">
      <OptimizerSelector
        @optimizer-selected="handleOptimizerSelected"
        :optimizers="availableOptimizers"
      />

      <TrainingQueue
  :queueItems="trainingQueue"
  :isTraining="!!currentTrainingStatus"
  :trainingProgress="currentTrainingStatus?.progress || 0"
  :currentEpoch="currentTrainingStatus?.currentEpoch || 0"
  :currentMetrics="currentTrainingStatus?.metrics || { trainLoss: 0, valLoss: 0, mae: 0, rmse: 0 }"
  :trainingHistory="trainingHistory"
/>

<TrainingStatus :completedTrainings="completedTrainings" />

    </div>
  </div>
</template>

<script>
import { ref, computed } from 'vue'
import DatasetSelector from '../components/modeltrain/DatasetSelector.vue'
import ModelSelector from '../components/modeltrain/ModelSelector.vue'
import CommonParameters from '../components/modeltrain/CommonParameters.vue'
import ModelParameters from '../components/modeltrain/ModelParameters.vue'
import TrainingQueue from '../components/modeltrain/TrainingQueue.vue'
import TrainingStatus from '../components/modeltrain/TrainingStatus.vue'
export default {
  name: 'ModelTraining',
  
  components: {
    DatasetSelector,
    ModelSelector,
    CommonParameters,
    ModelParameters,
    TrainingQueue,
    TrainingStatus
  },

  setup() {
    // 可用数据集
    const availableDatasets = ref([
      { id: '1', name: '京津冀数据集', description: '京津冀区域时空数据集' },
      { id: '2', name: '长三角数据集', description: '长三角区域时空数据集' }
    ])

    // 可用模型
    const availableModels = ref([
      { id: 1, name: 'GCN-MLP', type: 'GNN-MLP' },
      { id: 2, name: 'GCN-LSTM', type: 'GNN-RNN' },
      { id: 3, name: 'GCN-GRU', type: 'GNN-RNN' },
      { id: 4, name: 'GCN-Transformer', type: 'GNN-Transformer' },
      { id: 5, name: 'GCN-informer', type: 'GNN-Transformer' },
      { id: 6, name: 'GCN-Autoformer', type: 'GNN-Transformer' },
      { id: 7, name: 'GCN-FFPformer', type: 'GNN-Transformer' }
    ])

    // 当前选择的配置
    const selectedDataset = ref(null)
    const selectedModel = ref(null)
    const commonParameters = ref({
      batchSize: 32,
      learningRate: 0.001,
      epochs: 100,
      hiddenSize: 64,
      dropoutRate: 0.3,
      seqLength: 24,
      predLength: 12,
      activation: 'relu',
      lossFunction: 'mse'
    })
    const modelParameters = ref({})

    // 训练队列和状态
    const trainingQueue = ref([])
    const currentTrainingStatus = ref(null)
    
    // 训练历史
    const trainingHistory = ref({
      epochs: [],
      trainLoss: [],
      valLoss: [],
      mae: [],
      rmse: []
    })

    // 计算属性：检查配置是否有效
    const isConfigValid = computed(() => {
      const hasCommonParams = Object.keys(commonParameters.value).length > 0
      const hasModelParams = Object.keys(modelParameters.value).length > 0
      
      return selectedDataset.value && 
             selectedModel.value && 
             hasCommonParams && 
             hasModelParams
    })

    // 处理选择事件
    const handleDatasetSelected = (dataset) => {
      selectedDataset.value = dataset
    }

    const handleModelSelected = (model) => {
      selectedModel.value = model
      modelParameters.value = getDefaultModelParameters(model)
    }

    const handleCommonParamsUpdated = (params) => {
      commonParameters.value = { ...params }
    }

    const handleModelParamsUpdated = (params) => {
      modelParameters.value = { ...params }
    }

    // 获取默认模型参数
    const getDefaultModelParameters = (model) => {
      const baseGCNParams = {
        gcnLayers: 2,
        hiddenChannels: 64,
        dropoutRate: 0.5
      }

      switch(model.name) {
        case 'GCN-MLP':
          return {
            ...baseGCNParams,
            mlpLayers: [128, 64]
          }
        case 'GCN-LSTM':
          return {
            ...baseGCNParams,
            lstmLayers: 2,
            lstmHidden: 64
          }
        case 'GCN-GRU':
          return {
            ...baseGCNParams,
            gruLayers: 2,
            gruHidden: 64
          }
        case 'GCN-Transformer':
          return {
            ...baseGCNParams,
            numLayers: 4,
            numHeads: 8,
            ffnDim: 256
          }
        case 'GCN-informer':
          return {
            ...baseGCNParams,
            numLayers: 4,
            numHeads: 8,
            distilFactor: 4
          }
        case 'GCN-Autoformer':
          return {
            ...baseGCNParams,
            numLayers: 4,
            numHeads: 8,
            movingAvg: 24
          }
        case 'GCN-FFPformer':
          return {
            ...baseGCNParams,
            numLayers: 4,
            numHeads: 8,
            freqDim: 64
          }
        default:
          return baseGCNParams
      }
    }

    // 开始训练
    const handleStartTraining = () => {
      if (!isConfigValid.value) return
      
      const trainingConfig = {
        id: Date.now(),
        dataset: selectedDataset.value,
        model: selectedModel.value,
        commonParams: { ...commonParameters.value },
        modelParams: { ...modelParameters.value },
        status: 'pending'
      }
      
      trainingQueue.value.push(trainingConfig)
      
      if (!currentTrainingStatus.value) {
        startTraining()
      }
    }

    // 训练过程
    const startTraining = () => {
      if (trainingQueue.value.length === 0) return
      
      const nextTraining = trainingQueue.value[0]
      currentTrainingStatus.value = {
        ...nextTraining,
        startTime: new Date(),
        progress: 0,
        currentEpoch: 0,
        metrics: {
          trainLoss: 0,
          valLoss: 0,
          mae: 0,
          rmse: 0
        }
      }

      // 重置训练历史
      trainingHistory.value = {
        epochs: [],
        trainLoss: [],
        valLoss: [],
        mae: [],
        rmse: []
      }

      simulateTraining()
    }

    // 模拟训练过程
    const simulateTraining = () => {
      const totalEpochs = currentTrainingStatus.value.commonParams.epochs
      let currentEpoch = 0

      const trainingInterval = setInterval(() => {
        if (currentEpoch >= totalEpochs) {
          clearInterval(trainingInterval)
          handleTrainingComplete()
          return
        }

        currentEpoch++

        // 模拟训练指标
        const trainLoss = 1.0 / (1 + 0.1 * currentEpoch) + (Math.random() - 0.5) * 0.1
        const valLoss = trainLoss + 0.05 + Math.random() * 0.1
        const mae = 0.2 / (1 + 0.05 * currentEpoch) + Math.random() * 0.05
        const rmse = mae * 1.2 + Math.random() * 0.05

        // 更新训练历史
        trainingHistory.value.epochs.push(currentEpoch)
        trainingHistory.value.trainLoss.push(trainLoss)
        trainingHistory.value.valLoss.push(valLoss)
        trainingHistory.value.mae.push(mae)
        trainingHistory.value.rmse.push(rmse)

        // 更新当前状态
        currentTrainingStatus.value = {
          ...currentTrainingStatus.value,
          progress: (currentEpoch / totalEpochs) * 100,
          currentEpoch,
          metrics: {
            trainLoss,
            valLoss,
            mae,
            rmse
          }
        }
      }, 1000) // 每秒更新一次
    }
    const completedTrainings = ref([])
    // 处理训练完成
    const handleTrainingComplete = () => {
  // 保存训练记录
  completedTrainings.value.push({
    ...currentTrainingStatus.value,
    metrics: {
      trainLoss: trainingHistory.value.trainLoss[trainingHistory.value.trainLoss.length - 1],
      valLoss: trainingHistory.value.valLoss[trainingHistory.value.valLoss.length - 1],
      mae: trainingHistory.value.mae[trainingHistory.value.mae.length - 1],
      rmse: trainingHistory.value.rmse[trainingHistory.value.rmse.length - 1]
    },
    history: { ...trainingHistory.value }
  })

  // 移除队列中的第一项
  trainingQueue.value.shift()
  currentTrainingStatus.value = null
  
  // 如果队列中还有任务，继续训练
  if (trainingQueue.value.length > 0) {
    startTraining()
  }
}

    return {
      // 数据
      availableDatasets,
      availableModels,
      selectedModel,
      commonParameters,
      modelParameters,
      trainingQueue,
      currentTrainingStatus,
      trainingHistory,
      // 计算属性
      isConfigValid,
      // 方法
      handleDatasetSelected,
      handleModelSelected,
      handleCommonParamsUpdated,
      handleModelParamsUpdated,
      handleStartTraining,
      completedTrainings
    }
  }
}
</script>



<style scoped>
.model-training-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 10px;
}

.main-title {
  font-size: 20px;
  font-weight: 600;
  color: #303133;
  margin-bottom: 10px;
}

/* 选择器区域样式 */
.selector-section {
  display: flex;
  gap: 12px;
  margin-bottom: 24px;
}

.selector-item {
  flex: 1;
  min-width: 0;
  background: #fff;
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

/* 参数配置区域样式 */
.parameters-section {
  margin-bottom: 24px;
  background: #fff;
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

/* 训练区域样式 */
.training-section {
  background: #fff;
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  padding: 20px;
}

/* 按钮样式 */
.control-buttons {
  display: flex;
  gap: 12px;
  margin-top: 20px;
}
.training-control {
  margin: 20px 0;
  display: flex;
  justify-content: center;
}
/* 训练控制 */
.training-control .el-button {
  min-width: 120px;
  font-weight: 500;
}
.start-btn,
.queue-btn {
  padding: 10px 24px;
  border-radius: 4px;
  border: none;
  cursor: pointer;
  font-weight: 500;
  font-size: 14px;
  transition: all 0.2s ease;
}

.start-btn {
  background-color: #2563eb;
  color: white;
}

.start-btn:hover:not(:disabled) {
  background-color: #1d4ed8;
}

.queue-btn {
  background-color: #10b981;
  color: white;
}

.queue-btn:hover:not(:disabled) {
  background-color: #059669;
}

.start-btn:disabled,
.queue-btn:disabled {
  background-color: #e5e7eb;
  color: #9ca3af;
  cursor: not-allowed;
}
</style>