export { render }
import Antd from 'ant-design-vue';
import "nprogress/nprogress.css";
import ElementPlus from "element-plus";
import "element-plus/dist/index.css";
import { createApp } from './app'
import { ID_INJECTION_KEY } from 'element-plus'
import 'bootstrap-icons/font/bootstrap-icons.scss'

// This render() hook only supports SSR, see https://vite-plugin-ssr.com/render-modes for how to modify render() to support SPA
async function render(pageContext) {
  const { Page, pageProps } = pageContext
  if (!Page) throw new Error('Client-side render() hook expects pageContext.Page to be defined')
  const {app,router} = createApp(Page, pageProps, pageContext)
  await router.isReady()
  app.use(Antd).use(ElementPlus)
  app.provide(ID_INJECTION_KEY, {
    prefix: 1024,
    current: 0,
  })
  app.mount('#app')
}


