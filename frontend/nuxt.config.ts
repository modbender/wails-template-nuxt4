// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },

  // Nuxt 4 compatibility
  future: {
    compatibilityVersion: 4,
  },

  // Nuxt 4 directory structure
  srcDir: 'app/',

  // Modules
  modules: ['@nuxt/ui'],

  // Build configuration for Wails
  nitro: {
    preset: 'static',
  },

  // Generate static files for Wails embedding
  ssr: false,

  // Output directory for Wails
  generate: {
    dir: 'dist',
  },

  // App configuration
  app: {
    head: {
      title: 'Wails Nuxt 4 App',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        {
          name: 'description',
          content: 'A modern desktop application built with Wails and Nuxt 4',
        },
      ],
      link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }],
    },
  },

  // CSS configuration
  css: ['~/assets/css/main.css'],

  // TypeScript configuration
  typescript: {
    strict: true,
    typeCheck: true,
  },

  // Development server configuration
  devServer: {
    port: 3000,
    host: 'localhost',
  },

  // Wails runtime integration
  runtimeConfig: {
    public: {
      wailsContext:
        process.env.NODE_ENV === 'development' ? 'dev' : 'production',
    },
  },
});
