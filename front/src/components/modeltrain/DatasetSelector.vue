<!-- DatasetSelector.vue -->
<template>
  <div class="dataset-selector">
    <h3 class="title">数据集选择</h3>
    <div class="dataset-options">
      <div 
        v-for="dataset in datasets" 
        :key="dataset.id"
        class="dataset-option"
        :class="{ 'selected': selectedDatasetId === dataset.id }"
        @click="selectDataset(dataset)"
      >
        {{ dataset.name }}
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'

export default {
  name: 'DatasetSelector',
  
  props: {
    datasets: {
      type: Array,
      required: true,
      default: () => []
    }
  },

  emits: ['dataset-selected'],

  setup(props, { emit }) {
    const selectedDatasetId = ref(null)

    const selectDataset = (dataset) => {
      selectedDatasetId.value = dataset.id
      emit('dataset-selected', dataset)
    }

    return {
      selectedDatasetId,
      selectDataset
    }
  }
}
</script>

<style scoped>
.dataset-selector {
  padding: 10px;
}

.title {
  font-size: 1.2rem;
  font-weight: 600;
  margin-bottom: 12px;
  color: #2c3e50;
}

.dataset-options {
  display: flex;
  gap: 8px;
}

.dataset-option {
  padding: 4px 8px;
  border: 1px solid #e0e0e0;
  border-radius: 2px;
  cursor: pointer;
  transition: all 0.2s ease;
  background-color: white;
}

.dataset-option:hover {
  border-color: #4CAF50;
}

.dataset-option.selected {
  background-color: #4CAF50;
  color: white;
  border-color: #4CAF50;
}
</style>