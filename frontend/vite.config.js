import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => {
  // Base path for GitHub Pages
  // For project pages: /repo-name/ (lowercase, matches GitHub URL)
  // For user/org pages (username.github.io): '/'
  let basePath = '/'
  
  if (mode === 'production') {
    if (process.env.GITHUB_REPOSITORY) {
      // Extract repo name from "owner/repo-name" and convert to lowercase
      const repoName = process.env.GITHUB_REPOSITORY.split('/').pop()?.toLowerCase() || 'speeddemon'
      basePath = `/${repoName}/`
      console.log(`[Vite] Building for GitHub Pages with base: ${basePath}`)
    } else {
      // Default fallback (should match your actual repo name)
      basePath = '/speeddemon/'
      console.log(`[Vite] Using default base path: ${basePath}`)
    }
  }
  
  return {
    plugins: [react()],
    base: basePath,
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
  }
})
