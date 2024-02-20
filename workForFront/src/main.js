import { createApp } from 'vue'
import {router} from './router'
import { createPinia } from 'pinia'
import Antd from 'ant-design-vue';
import App from './App.vue'
import './reset.css'
const pinia=createPinia()
createApp(App).use(router).use(Antd).use(pinia).mount('#app')
