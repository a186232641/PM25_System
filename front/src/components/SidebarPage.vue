<!-- components/Sidebar.vue -->
<template>
  <div class="sidebar">
    <router-link
      v-for="route in routes"
      :key="route.path"
      :to="route.path"
      class="menu-item"
    >
      {{ route.name }}
    </router-link>
  </div>
</template>

<script>
export default {
  data() {
    return {
      routes: [
        { path: '/data-query', name: '历史数据查询' },
        { path: '/model-training', name: '模型训练' },
        { path: '/concentration-predict', name: 'PM2.5浓度预测' },
        { path: '/city-history-query', name: '监测站点管理' }
      ]
    }
  }
}
</script>

<style scoped>
.sidebar {
  width: 200px;
  background-color: #f5f5f5;
  padding: 20px 0;
}

.menu-item {
  display: block;
  padding: 12px 24px;
  color: #333;
  text-decoration: none;
}

.menu-item:hover {
  background-color: #e0e0e0;
}

.router-link-active {
  background-color: #2c3e50;
  color: white;
}
</style>