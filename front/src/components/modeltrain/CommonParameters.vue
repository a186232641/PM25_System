<!-- CommonParameters.vue -->
<template>
  <div class="common-parameters">
    <h3 class="title">通用参数配置</h3>
    <el-form 
      :model="form" 
      label-width="100px" 
      class="parameter-form"
      @change="handleParameterChange"
    >
      <div class="parameters-grid">
        <!-- 批次大小 -->
        <el-form-item label="批次大小">
          <el-input-number 
            v-model="form.batchSize"
            :min="8"
            :max="512"
            :step="8"
            @change="handleParameterChange"
          />
        </el-form-item>

        <!-- 学习率 -->
        <el-form-item label="学习率">
          <el-input-number
            v-model="form.learningRate"
            :min="0.0001"
            :max="0.1"
            :step="0.0001"
            :precision="4"
            :controls="false"
            @change="handleParameterChange"
          />
        </el-form-item>

        <!-- 训练轮次 -->
        <el-form-item label="训练轮次">
          <el-input-number
            v-model="form.epochs"
            :min="1"
            :max="1000"
            @change="handleParameterChange"
          />
        </el-form-item>

        <!-- 隐藏层维度 -->
        <el-form-item label="隐藏层维度">
          <el-input-number
            v-model="form.hiddenSize"
            :min="32"
            :max="512"
            :step="32"
            @change="handleParameterChange"
          />
        </el-form-item>

        <!-- Dropout率 -->
        <el-form-item label="Dropout率">
          <el-input-number
            v-model="form.dropoutRate"
            :min="0"
            :max="0.9"
            :step="0.1"
            :precision="1"
            @change="handleParameterChange"
          />
        </el-form-item>

        <!-- 激活函数 -->
        <el-form-item label="激活函数">
          <el-select 
            v-model="form.activation"
            class="param-select"
            @change="handleParameterChange"
          >
            <el-option label="ReLU" value="relu" />
            <el-option label="LeakyReLU" value="leakyrelu" />
            <el-option label="Sigmoid" value="sigmoid" />
            <el-option label="Tanh" value="tanh" />
          </el-select>
        </el-form-item>

        <!-- 损失函数 -->
        <el-form-item label="损失函数">
          <el-select 
            v-model="form.lossFunction"
            class="param-select"
            @change="handleParameterChange"
          >
            <el-option label="MSE" value="mse" />
            <el-option label="MAE" value="mae" />
            <el-option label="Huber" value="huber" />
            <el-option label="Smooth MAE" value="smoothmae" />
          </el-select>
        </el-form-item>

        <!-- 输入序列长度 -->
        <el-form-item label="序列长度">
          <el-input-number
            v-model="form.seqLength"
            :min="12"
            :max="168"
            :step="12"
            @change="handleParameterChange"
          />
        </el-form-item>

        <!-- 预测长度 -->
        <el-form-item label="预测长度">
          <el-input-number
            v-model="form.predLength"
            :min="1"
            :max="24"
            @change="handleParameterChange"
          />
        </el-form-item>
      </div>
    </el-form>
  </div>
</template>

<script>
import { ref, watch } from 'vue'

export default {
  name: 'CommonParameters',
  
  props: {
    initialParameters: {
      type: Object,
      default: () => ({
        batchSize: 32,
        learningRate: 0.0001,
        epochs: 100,
        hiddenSize: 64,
        dropoutRate: 0.3,
        seqLength: 24,
        predLength: 12,
        activation: 'relu',
        lossFunction: 'mse'
      })
    }
  },

  emits: ['parameters-updated'],

  setup(props, { emit }) {
    const form = ref({
      batchSize: props.initialParameters.batchSize,
      learningRate: props.initialParameters.learningRate,
      epochs: props.initialParameters.epochs,
      hiddenSize: props.initialParameters.hiddenSize,
      dropoutRate: props.initialParameters.dropoutRate,
      seqLength: props.initialParameters.seqLength,
      predLength: props.initialParameters.predLength,
      activation: props.initialParameters.activation,
      lossFunction: props.initialParameters.lossFunction
    })

    watch(() => props.initialParameters, (newVal) => {
      form.value = { ...newVal }
    })

    const handleParameterChange = () => {
      emit('parameters-updated', { ...form.value })
    }

    return {
      form,
      handleParameterChange
    }
  }
}
</script>

<style scoped>
.common-parameters {
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

.param-select {
  width: 180px;
}

:deep(.el-input-number) {
  width: 180px;
}

:deep(.el-form-item) {
  margin-bottom: 0;
}

:deep(.el-form-item__label) {
  font-weight: normal;
  color: #606266;
  padding-right: 12px;
}

/* Select样式 */
:deep(.el-select .el-input__wrapper) {
  border-radius: 4px;
}

:deep(.el-select .el-input__wrapper:hover) {
  border-color: #2563eb;
}

:deep(.el-select .el-input.is-focus .el-input__wrapper) {
  border-color: #2563eb;
  box-shadow: 0 0 0 1px #2563eb;
}

/* InputNumber样式 */
:deep(.el-input-number .el-input__wrapper) {
  border-radius: 4px;
}

:deep(.el-input-number .el-input__wrapper:hover) {
  border-color: #2563eb;
}

:deep(.el-input-number.is-controls-right .increase-button),
:deep(.el-input-number.is-controls-right .decrease-button) {
  border-color: #2563eb;
  background-color: #fff;
}

:deep(.el-input-number.is-controls-right .el-input-number__increase:hover),
:deep(.el-input-number.is-controls-right .el-input-number__decrease:hover) {
  color: #2563eb;
}
</style>