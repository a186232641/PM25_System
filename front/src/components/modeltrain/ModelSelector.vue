<!-- ModelSelector.vue -->
<template>
  <div class="model-selector">
    <div class="selector-header">
      <h3 class="title">模型选择</h3>
    </div>
    <el-tabs type="border-card" class="model-tabs">
      <el-tab-pane 
        v-for="group in groupedModels" 
        :key="group.type"
        :label="getModelTypeLabel(group.type)"
      >
        <div class="model-grid">
          <div
            v-for="model in group.items"
            :key="model.id"
            class="model-card"
            :class="{ 'selected': selectedModelId === model.id }"
            @click="selectModel(model)"
          >
            <div class="model-name">{{ model.name }}</div>
          </div>
        </div>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import { ref, computed } from 'vue'

export default {
  name: 'ModelSelector',
  
  props: {
    models: {
      type: Array,
      required: true,
      default: () => []
    }
  },

  emits: ['model-selected'],

  setup(props, { emit }) {
    const selectedModelId = ref(null)

    const groupedModels = computed(() => {
      const groups = props.models.reduce((acc, model) => {
        if (!acc[model.type]) {
          acc[model.type] = {
            type: model.type,
            items: []
          }
        }
        acc[model.type].items.push(model)
        return acc
      }, {})
      
      return Object.values(groups)
    })

    const getModelTypeLabel = (type) => {
      const typeLabels = {
        'GNN-MLP': 'GCN with MLP',
        'GNN-RNN': 'GCN with RNN',
        'GNN-Transformer': 'GCN with Transformer'
      }
      return typeLabels[type] || type
    }

    const selectModel = (model) => {
      selectedModelId.value = model.id
      emit('model-selected', model)
    }

    return {
      selectedModelId,
      groupedModels,
      getModelTypeLabel,
      selectModel
    }
  }
}
</script>

<style scoped>
.model-selector {
  float: left;
  margin: 20px 0;
  background: #fff;
  border-radius: 8px;
}

.selector-header {
  padding: 16px 20px;
  border-bottom: 1px solid #eee;
}

.title {
  margin: 0;
  font-size: 16px;
  color: #303133;
  font-weight: 600;
}

.model-tabs {
  --el-border-radius: 8px;
}

.model-tabs :deep(.el-tabs__nav) {
  background: #f5f7fa;
}

.model-grid {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  gap: 10px;
  padding: 12px;
}

.model-card {
  position: relative;
  padding: 12px;
  border: 1px solid #e4e7ed;
  border-radius: 4px;
  background: #fff;
  cursor: pointer;
  transition: all 0.2s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 45px;
}

.model-card:hover {
  transform: translateY(-1px);
  box-shadow: 0 2px 8px 0 rgba(0, 0, 0, 0.1);
  border-color: #2563eb;
  background: #eff6ff;
}

.model-card.selected {
  background: #2563eb;
  border-color: #2563eb;
  box-shadow: 0 2px 8px 0 rgba(37, 99, 235, 0.2);
}

.model-name {
  font-size: 13px;
  color: #4b5563;
  text-align: center;
  font-weight: 500;
}

.model-card.selected.model-name {
  color: white;
}

:deep(.el-tabs__item) {
  font-size: 14px;
  height: 40px;
  line-height: 40px;
}

:deep(.el-tabs__content) {
  overflow: visible;
}

:deep(.el-tabs__nav-wrap) {
  padding: 0 16px;
}
</style>