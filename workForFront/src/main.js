import { createApp } from 'vue'
import {router} from './router'
import Antd from 'ant-design-vue';
import App from './App.vue'
import './reset.css'

createApp(App).use(router).use(Antd).mount('#app')
