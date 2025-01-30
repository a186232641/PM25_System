<!-- ModelParameters.vue -->
<template>
  <div class="model-parameters">
    <h3 class="title">模型参数配置</h3>
    <div v-if="selectedModel" class="parameters-content">
      <el-form 
        :model="form" 
        label-width="140px" 
        class="parameter-form"
        @change="handleParameterChange"
      >
        <div class="parameters-grid">
          <!-- GCN基础参数 -->
          <el-form-item label="GCN层数">
            <el-input 
              v-model.number="form.gcnLayers"
              placeholder="默认: 2"
              @change="handleParameterChange"
            />
          </el-form-item>

          <!-- GCN-MLP特有参数 -->
          <template v-if="selectedModel.type === 'GNN-MLP'">
            <el-form-item label="MLP层配置">
              <el-input 
                v-model="form.mlpLayersInput"
                placeholder="逗号分隔, 如: 128,64"
                @change="handleMlpLayersChange"
              />
            </el-form-item>
          </template>

          <!-- GCN-LSTM/GRU特有参数 -->
          <template v-if="selectedModel.type === 'GNN-RNN'">
            <el-form-item :label="rnnTypeLabel">
              <el-input 
                v-model.number="form.rnnLayers"
                placeholder="默认: 2"
                @change="handleParameterChange"
              />
            </el-form-item>

            <el-form-item :label="rnnHiddenLabel">
              <el-input 
                v-model.number="form.rnnHidden"
                placeholder="默认: 64"
                @change="handleParameterChange"
              />
            </el-form-item>
          </template>

          <!-- Transformer系列特有参数 -->
          <template v-if="selectedModel.type === 'GNN-Transformer'">
            <el-form-item label="Transformer层数">
              <el-input 
                v-model.number="form.numLayers"
                placeholder="默认: 4"
                @change="handleParameterChange"
              />
            </el-form-item>

            <el-form-item label="注意力头数">
              <el-input 
                v-model.number="form.numHeads"
                placeholder="默认: 8"
                @change="handleParameterChange"
              />
            </el-form-item>

            <!-- Informer特有参数 -->
            <template v-if="selectedModel.name === 'GCN-informer'">
              <el-form-item label="蒸馏因子">
                <el-input 
                  v-model.number="form.distilFactor"
                  placeholder="默认: 4"
                  @change="handleParameterChange"
                />
              </el-form-item>
            </template>

            <!-- Autoformer特有参数 -->
            <template v-if="selectedModel.name === 'GCN-Autoformer'">
              <el-form-item label="移动平均">
                <el-input 
                  v-model.number="form.movingAvg"
                  placeholder="默认: 24"
                  @change="handleParameterChange"
                />
              </el-form-item>
            </template>

            <!-- FFPformer特有参数 -->
            <template v-if="selectedModel.name === 'GCN-FFPformer'">
              <el-form-item label="频率维度">
                <el-input 
                  v-model.number="form.freqDim"
                  placeholder="默认: 64"
                  @change="handleParameterChange"
                />
              </el-form-item>
            </template>

            <!-- 通用Transformer参数 -->
            <el-form-item label="前馈网络维度">
              <el-input 
                v-model.number="form.ffnDim"
                placeholder="默认: 256"
                @change="handleParameterChange"
              />
            </el-form-item>
          </template>
        </div>
      </el-form>
    </div>
    <div v-else class="no-model-selected">
      请先选择一个模型
    </div>
  </div>
</template>

<script>
import { ref, watch, computed } from 'vue'

export default {
  name: 'ModelParameters',
  
  props: {
    selectedModel: {
      type: Object,
      default: null
    },
    parameters: {
      type: Object,
      default: () => ({})
    }
  },

  emits: ['parameters-updated'],

  setup(props, { emit }) {
    const form = ref({
      // GCN基础参数
      gcnLayers: 2,
      // MLP参数
      mlpLayersInput: '128,64',
      mlpLayers: [128, 64],
      // RNN参数
      rnnLayers: 2,
      rnnHidden: 64,
      // Transformer参数
      numLayers: 4,
      numHeads: 8,
      ffnDim: 256,
      // 特殊参数
      distilFactor: 4,
      movingAvg: 24,
      freqDim: 64
    })

    // 监听参数变化
    watch(() => props.parameters, (newVal) => {
      if (newVal) {
        if (newVal.mlpLayers) {
          form.value.mlpLayersInput = newVal.mlpLayers.join(',')
        }
        form.value = { ...form.value, ...newVal }
      }
    })

    // 计算RNN类型标签
    const rnnTypeLabel = computed(() => {
      if (props.selectedModel) {
        return props.selectedModel.name === 'GCN-LSTM' ? 'LSTM层数' : 'GRU层数'
      }
      return 'RNN层数'
    })

    // 计算RNN隐藏层标签
    const rnnHiddenLabel = computed(() => {
      if (props.selectedModel) {
        return props.selectedModel.name === 'GCN-LSTM' ? 'LSTM隐藏维度' : 'GRU隐藏维度'
      }
      return 'RNN隐藏维度'
    })

    // 处理MLP层配置变化
    const handleMlpLayersChange = (value) => {
      try {
        form.value.mlpLayers = value.split(',').map(num => parseInt(num.trim()))
        handleParameterChange()
      } catch (error) {
        console.error('Invalid MLP layers input')
      }
    }

    const handleParameterChange = () => {
      const params = { ...form.value }
      delete params.mlpLayersInput // 移除临时输入字段
      emit('parameters-updated', params)
    }

    return {
      form,
      rnnTypeLabel,
      rnnHiddenLabel,
      handleMlpLayersChange,
      handleParameterChange
    }
  }
}
</script>

<style scoped>
.model-parameters {
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

.parameter-form {
  width: 100%;
}

.parameters-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
}

:deep(.el-input) {
  width: 180px;
}

:deep(.el-form-item) {
  margin-bottom: 0;
}

:deep(.el-form-item__label) {
  font-weight: normal;
  color: #606266;
}

.no-model-selected {
  text-align: center;
  color: #909399;
  padding: 40px 0;
}

:deep(.el-input .el-input__wrapper) {
  border-radius: 4px;
}

:deep(.el-input .el-input__wrapper:hover) {
  border-color: #2563eb;
}

:deep(.el-input.is-focus .el-input__wrapper) {
  border-color: #2563eb;
  box-shadow: 0 0 0 1px #2563eb;
}
</style>