<!-- App.vue -->
<template>
  <div class="app">
    <Header />
    <div class="main-container">
      <Sidebar />
      <div class="content">
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<script>
import Header from './components/HeaderPage.vue'
import Sidebar from './components/SidebarPage.vue'

export default {
  name: 'App',
  components: {
    Header,
    Sidebar
  }
}
</script>

<style>
.app {
  height: 100vh;
  display: flex;
  flex-direction: column;
}

.main-container {
  flex: 1;
  display: flex;
}

.content {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
}
</style>