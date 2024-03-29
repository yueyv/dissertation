export { render }
// See https://vite-plugin-ssr.com/data-fetching
export const passToClient = ['pageProps', 'urlPathname']

import { renderToString as renderToString_ } from '@vue/server-renderer'
import { escapeInject, dangerouslySkipEscape } from 'vite-plugin-ssr/server'
import { createApp } from './app'
import logoUrl from '/FeHeart.svg'
// import {Pinia} from 'pinia';
async function render(pageContext) {
  const { Page, pageProps } = pageContext
  // This render() hook only supports SSR, see https://vite-plugin-ssr.com/render-modes for how to modify render() to support SPA
  // if (!Page) throw new Error('My render() hook expects pageContext.Page to be defined')
  // console.log(Page);
  
  const {app,router} = createApp(Page, pageProps, pageContext)
  router.push(pageContext.urlOriginal)
  await router.isReady()
  const appHtml = await renderToString(app)
  // console.log(router.currentRoute.value.meta);
  
  // See https://vite-plugin-ssr.com/head
  const documentProps  = router.currentRoute.value.meta
  // console.log(documentProps);
  // 从路由中读取路由元信息

  // SRO 优化
  const title = (documentProps && documentProps.title) || '云聘'
  const desc = (documentProps && documentProps.description) || '这是一个招聘网站的seo'
  // console.log(desc);
  // SEO 处理
  const documentHtml = escapeInject`<!DOCTYPE html>
    <html lang="zh-CN">
      <head>
        <meta charset="UTF-8" />
        <link rel="icon" href="${logoUrl}" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta name="description" content="${desc}" />
        <title>${title}</title>
      </head>
      <body>
        <div id="app">${dangerouslySkipEscape(appHtml)}</div>
      </body>
    </html>`

  return {
    documentHtml,
    pageContext: {
      // We can add some `pageContext` here, which is useful if we want to do page redirection https://vite-plugin-ssr.com/page-redirection
    }
  }
}

async function renderToString(app) {
  let err
  // Workaround: renderToString_() swallows errors in production, see https://github.com/vuejs/core/issues/7876
  app.config.errorHandler = (err_) => {
    err = err_
  }
  const appHtml = await renderToString_(app)
  if (err) throw err
  return appHtml
}
