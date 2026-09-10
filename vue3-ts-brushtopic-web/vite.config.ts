import path from 'path'
import { defineConfig, loadEnv } from 'vite'
import vue from '@vitejs/plugin-vue'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd())
  return {
    plugins: [vue(), tailwindcss()],
    resolve: {
      alias: {
        '@': path.resolve('./src'),
      },
    },
    server: {
      port: parseInt(env.VITE_PORT) || 9990,
      proxy: {
        [env.VITE_APP_BASE_API || '/api']: {
          target: env.VITE_SERVE || 'http://localhost:9993',
          changeOrigin: true,
        },
      },
    },
  }
})
