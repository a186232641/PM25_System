// router/index.js
import { createRouter, createWebHistory } from 'vue-router'
import DataQuery from '../views/DataQuery.vue'
import ModelTraining from '../views/ModelTraining.vue'
import ConcentrationPredict from '../views/ConcentrationPredict.vue'
import StationManagement from '../views/StationManagement.vue'

const routes = [
  {
    path: '/',
    redirect: '/data-query'
  },
  {
    path: '/data-query',
    name: 'DataQuery',
    component: DataQuery
  },
  {
    path: '/model-training',
    name: 'ModelTraining',
    component: ModelTraining
  },
  {
    path: '/concentration-predict',
    name: 'ConcentrationPredict',
    component: ConcentrationPredict
  },
  {
    path: '/city-history-query',
    name: 'StationManagement',
    component: StationManagement
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router