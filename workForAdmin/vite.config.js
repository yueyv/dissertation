import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { fileURLToPath, URL } from "node:url";
import ssr from 'vite-plugin-ssr/plugin'
import viteCompression from 'vite-plugin-compression';
// gzip压缩打包
// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue(),ssr()],
  resolve: {
    alias: {
      "@": fileURLToPath(new URL("./src", import.meta.url)),
      "@c": fileURLToPath(new URL("./src/components", import.meta.url))
    }
  },
  server: {
    port: 5174,
    open: true,
    cors: true,
    proxy: {
      '/api': {
        target: 'http://localhost:3000',
        // target:'http://20.213.10.238:3000',
        changeOrigin: true,
        // rewrite: (path) => path.replace('/api', '')
      }
    },
    targets:[viteCompression()],
  },
})
