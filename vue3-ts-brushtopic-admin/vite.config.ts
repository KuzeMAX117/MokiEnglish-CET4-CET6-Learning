import path from 'path'
import { defineConfig, loadEnv } from 'vite';
import vue from '@vitejs/plugin-vue';

export default defineConfig(({ mode }) => {
  
  const env = loadEnv(mode, process.cwd());
  return {
    plugins: [
      vue(),
      
    ],
    resolve: {
      alias: {
        '@': path.resolve('./src'), 
      },
    },
    
    css: {
      preprocessorOptions: {
        scss: {
          javascriptEnabled: true,
          additionalData: '@use "@/styles/variable.scss" as *;\n',
        },
      },
    },
    
    server: {
      port: parseInt(env.VITE_PORT) || 3000, 
      proxy: {
        [env.VITE_APP_BASE_API]: {
          target: env.VITE_SERVE || 'http://localhost', 
          changeOrigin: true,
          
          
          
          
        },
      },
    },
  };
});