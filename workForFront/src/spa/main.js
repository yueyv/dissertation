import { createApp } from 'vue'
import { router } from '@/router/index.js'
import 'bootstrap-icons/font/bootstrap-icons.scss'
import { createPinia } from 'pinia'
import Antd from 'ant-design-vue';
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate'
import App from './App.vue'
// import Vue3BaiduMapGL from 'vue3-baidu-map-gl'
import '@/assets/reset.css';
import '@/mock/index.js'
import { storeToRefs } from 'pinia'

import ElementPlus from "element-plus";
import "element-plus/dist/index.css";
import EventEmitter from 'events';
EventEmitter.defaultMaxListeners = 20; // 增加到20个监听器

const pinia = createPinia()
pinia.use(piniaPluginPersistedstate)

const app = createApp(App)
app.use(router)
app.use(Antd)
app.use(ElementPlus)
app.use(pinia)
// app.use(Vue3BaiduMapGL)
app.mount('#app')
