import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'

import './assets/main.css'

const app = createApp(App)
app.provide('appName', 'projet ISEN')

app.use(createPinia())
app.use(router)

app.mount('#app')
