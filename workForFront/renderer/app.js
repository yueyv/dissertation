import { createSSRApp, defineComponent, h, toRaw } from 'vue'
import { router } from '@/router/index';
import Antd from 'ant-design-vue'
import all from './all.page.vue'
import { createPinia} from "pinia"
export { createApp }





function createApp(Page, pageProps, pageContext) {
  // pinia 持久化插件
  // type Options = {
  //   key?: string
  // }

  // const setStorage = (key: string, value: any) => {
  //   localStorage.setItem(key, JSON.stringify(value))
  // }
  // const getStorage = (key: string) => {
  //   return localStorage.getItem(key) ? JSON.parse(localStorage.getItem(key) as string) : {}
  // }
  // const __piniaKey__ = 'key'
  // const piniaPlugin = (options: Options) => {
  //   return (context: PiniaPluginContext) => {
  //     const { store } = context
  //     const data = getStorage(`${options?.key ?? __piniaKey__}-${store.$id}`)

  //     store.$subscribe(() => {
  //       setStorage(`${options?.key ?? __piniaKey__}-${store.$id}`, toRaw(store.$state))
  //     })
  //     console.log(store)
  //     return {
  //       ...data
  //     }
  //   }

  // }
  // const store = createPinia()

  // store.use(piniaPlugin({
  //   // key: "pinia"
  // }))

  // router.beforeEach((to, from, next) => {
  //   document.title = to.meta.title as string
  //   next()
  // })
  const PageWithLayout = defineComponent({
    render() {
      return h(
        all,
        {},
        {
          default() {
            return h(Page, pageProps || {})
          }
        }
      )
    }
  })
  const app = createSSRApp(PageWithLayout)
  const pinia=createPinia()
  // Make pageContext available from any Vue component
    app.use(Antd)
    app.use(router)
    app.use(pinia)
  return { app, router }
}
