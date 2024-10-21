// src/main.js
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import axios from 'axios'
import './assets/styles/main.css'

const app = createApp(App)

app.config.globalProperties.$http = axios

app
  .use(router)
  .use(store)
  .mount('#app')
