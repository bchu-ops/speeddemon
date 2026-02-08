import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  // Base path for GitHub Pages
  // Automatically detects repo name from GITHUB_REPOSITORY env var
  // Format: owner/repo-name -> /repo-name/
  // If GITHUB_REPOSITORY is not set, defaults to '/speeddemon/'
  // For user/organization pages (username.github.io), manually set to '/'
  base: process.env.NODE_ENV === 'production' 
    ? (process.env.GITHUB_REPOSITORY 
        ? `/${process.env.GITHUB_REPOSITORY.split('/').pop()}/` 
        : '/speeddemon/')
    : '/',
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
