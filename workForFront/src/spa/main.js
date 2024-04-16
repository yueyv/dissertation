import { createApp } from 'vue'
import {router} from '@/router/index.js'
import 'bootstrap-icons/font/bootstrap-icons.scss'
import { createPinia } from 'pinia'
import Antd from 'ant-design-vue';
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate'
import App from './App.vue'
import '@/assets/reset.css';
import '@/mock/index.js'
import { storeToRefs } from 'pinia'
import "nprogress/nprogress.css";
import ElementPlus from "element-plus";
import "element-plus/dist/index.css";
const pinia=createPinia()
pinia.use(piniaPluginPersistedstate)
createApp(App).use(router).use(Antd).use(ElementPlus).use(pinia).mount('#app')
// IM 初始化数据
// done使用pinia
