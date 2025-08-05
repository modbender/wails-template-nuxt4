<template>
  <div id="app">
    <NuxtPage />
  </div>
</template>

<script setup lang="ts">
// Global app setup
useHead({
  titleTemplate: '%s - Wails Nuxt 4 App',
})

// Initialize Wails context if available
onMounted(() => {
  if (typeof window !== 'undefined' && window.wails) {
    console.log('Wails runtime detected')
  }
})
</script>

<style>
html, body, #app {
  height: 100%;
  margin: 0;
  padding: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

#app {
  display: flex;
  flex-direction: column;
}
</style>
