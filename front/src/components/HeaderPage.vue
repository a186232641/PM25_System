<!-- components/Header.vue -->
<template>
  <header class="header">
    <div class="logo">PM2.5 Forecast</div>
    <div class="title">短期PM2.5浓度预测系统</div>
  </header>
</template>

<style scoped>
.header {
  height: 60px;
  background-color: #2c3e50;
  color: white;
  display: flex;
  align-items: center;
  padding: 0 20px;
}

.logo {
  font-size: 24px;
  font-weight: bold;
  margin-right: 20px;
}

.title {
  font-size: 18px;
}
</style>