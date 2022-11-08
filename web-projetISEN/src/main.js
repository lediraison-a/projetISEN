import { createApp } from 'vue'
import { createPinia } from 'pinia'

import firebase from 'firebase/compat/app'

import App from './App.vue'
import router from './router'

import './assets/main.css'

const app = createApp(App)

const firebaseConfig = {
  apiKey: 'AIzaSyDs2K_h-zFhTblDrfnUtssyURLWa69F3D0',
  authDomain: 'projetisen-dd64c.firebaseapp.com',
  projectId: 'projetisen-dd64c',
  storageBucket: 'projetisen-dd64c.appspot.com',
  messagingSenderId: '450816157907',
  appId: '1:450816157907:web:23e1f93a6b67bed8fecc26',
}
firebase.initializeApp(firebaseConfig)

app.use(createPinia())
app.use(router)

app.mount('#app')
