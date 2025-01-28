<template>
  <div class="station-management">
    <h1>数据集站点可视化</h1>
    <label for="dataset-select">请选择数据集:</label>
    <select
      id="dataset-select"
      v-model="selectedDataset"
      @change="onDatasetChange"
    >
      <option v-for="dataset in datasets" :key="dataset.name" :value="dataset.id">
        {{ dataset.name }}
      </option>
    </select>

    <!-- 显示加载状态 -->
    <div v-if="loading" class="loading">加载站点数据中...</div>

    <!-- 显示站点数据 -->
    <ul v-else class="stations-list">
      <li v-for="station in stations" :key="station.id">
        {{ station.name }} (纬度: {{ station.latitude }}, 经度: {{ station.longitude }})
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'StationManagement',
  data() {
    return {
      datasets: [], // 数据集列表
      selectedDataset: null, // 当前选中的数据集
      stations: [], // 当前数据集的站点数据
      loading: false, // 加载状态
    };
  },
  async mounted() {
    try {
      const response = await axios.get('http://127.0.0.1:5000/api/stations/datasets');
      if (response.data.code === 200) {
        this.datasets = response.data.data;
      } else {
        console.error('请求失败:', response.data.message);
      }
    } catch (error) {
      console.error('请求出错:', error);
    }
  },
  methods: {
    async onDatasetChange() {
      if (!this.selectedDataset) return;

      this.loading = true; // 开始加载
      this.stations = []; // 清空之前的站点数据
      try {
        const response = await axios.get(
          `http://127.0.0.1:5000/api/stations/dataset?dataset_id=${this.selectedDataset}`
        );
        if (response.data.code === 200) {
          this.stations = response.data.data; // 保存站点数据
        } else {
          console.error('获取站点数据失败:', response.data.message);
        }
      } catch (error) {
        console.error('请求站点数据出错:', error);
      } finally {
        this.loading = false; // 结束加载
      }
    },
  },
};
</script>

<style scoped>
.stations-list {
  margin-top: 20px;
  padding: 0;
  list-style: none;
}

.stations-list li {
  background-color: #fff;
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 10px;
  margin-bottom: 10px;
  font-size: 14px;
  color: #333;
}

.loading {
  margin-top: 20px;
  font-size: 16px;
  color: #555;
  text-align: center;
}

</style>
