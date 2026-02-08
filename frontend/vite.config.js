import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  // Base path for GitHub Pages (set to your repo name if using project pages)
  // For user/organization pages (username.github.io), use base: '/'
  // For project pages (username.github.io/repo-name), use base: '/repo-name/'
  base: process.env.NODE_ENV === 'production' ? '/SpeedDemon/' : '/',
  server: {
    host: '0.0.0.0', // Allow connections from outside the container
    port: 3000,
    proxy: {
      '/api': {
        target: 'http://backend:8000', // Use service name for Docker networking
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, '')
      }
    }
  }
})
