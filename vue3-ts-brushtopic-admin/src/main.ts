
import './styles/index.scss'
import { createApp } from 'vue'

import pinia from './stores/index'

import router from './router'

import Antd from 'ant-design-vue';

import 'ant-design-vue/dist/reset.css';

import *  as Icon from '@ant-design/icons-vue'

import './permisstion.ts'
import App from './App.vue'

const app = createApp(App)

Object.keys(Icon).forEach((key) => {
  app.component(key, (Icon as any)[key])
})

app.use(pinia)
app.use(router)
app.use(Antd)
app.mount('#app')
