import { createRouter, createWebHistory } from 'vue-router';
import StationManagement from '../views/StationManagement.vue';
import HistoryInfoQuery from '../views/DataQuery.vue';
import ModelTraining  from '../views/ModelTraining.vue';
// import DataQuery from './views/DataQuery.vue';
// import ModelTraining from './views/ModelTraining.vue';
// import ConcentrationPredict from './views/ConcentrationPredict.vue';

const routes = [
  // { path: '/data-query', component: DataQuery },
  // { path: '/model-training', component: ModelTraining },
  // { path: '/concentration-predict', component: ConcentrationPredict },
  { path: '/city-history-query', component: StationManagement, name: '监测站点可视化' },
  { path: '/history-data-query', component: HistoryInfoQuery, name: '历史数据查询' },
  { path: '/model-training', component: ModelTraining, name: '模型训练模块' },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
