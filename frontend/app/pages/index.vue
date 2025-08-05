<template>
  <div>
    <!-- Header Section -->
    <header class="header">
      <div class="container">
        <h1>🚀 Wails + Nuxt 4</h1>
        <p>Modern Desktop Applications with Go and Vue.js</p>
      </div>
    </header>

    <!-- Main Content -->
    <main class="main-content">
      <div class="container">
        <!-- Welcome Card -->
        <div class="card">
          <h2>Welcome to Your Wails Nuxt 4 App!</h2>
          <p>
            This template combines the power of <strong>Wails v2</strong> (Go
            backend) with <strong>Nuxt 4</strong> (Vue.js frontend) to create
            modern, cross-platform desktop applications.
          </p>
        </div>

        <!-- Interactive Demo -->
        <div class="grid grid-cols-2">
          <!-- Greeting Demo -->
          <div class="card">
            <h3>🎯 Backend Integration</h3>
            <p>Test the connection between frontend and Go backend:</p>

            <div class="mt-4">
              <input
                v-model="name"
                type="text"
                placeholder="Enter your name"
                class="input"
                @keyup.enter="greetUser"
              />
              <button @click="greetUser" class="btn mt-4">Say Hello</button>
            </div>

            <div v-if="greeting" class="mt-4">
              <p><strong>Response:</strong> {{ greeting }}</p>
            </div>
          </div>

          <!-- App Info -->
          <div class="card">
            <h3>📱 App Information</h3>
            <button @click="getAppInfo" class="btn">Get App Info</button>

            <div v-if="appInfo" class="mt-4">
              <div v-for="(value, key) in appInfo" :key="key">
                <strong>{{ key }}:</strong> {{ value }}
              </div>
            </div>
          </div>
        </div>

        <!-- Interactive Demo Component -->
        <div class="card">
          <WailsDemo />
        </div>

        <!-- Features -->
        <div class="card">
          <h3>✨ Template Features</h3>
          <div class="grid grid-cols-2">
            <div>
              <h4>Frontend (Nuxt 4)</h4>
              <ul>
                <li>Vue 3 Composition API</li>
                <li>TypeScript support</li>
                <li>Auto-imports</li>
                <li>File-based routing</li>
                <li>Nuxt UI components</li>
                <li>Hot module replacement</li>
              </ul>
            </div>
            <div>
              <h4>Backend (Go + Wails)</h4>
              <ul>
                <li>Native performance</li>
                <li>Cross-platform builds</li>
                <li>System integration</li>
                <li>Secure API calls</li>
                <li>File system access</li>
                <li>Native notifications</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
// Page metadata
useHead({
  title: 'Home',
});

// Reactive data
const name = ref('');
const greeting = ref('');
const appInfo = ref(null);

// Methods
const greetUser = async () => {
  if (!name.value.trim()) {
    greeting.value = 'Please enter a name!';
    return;
  }

  try {
    // Call Go backend method
    if (typeof window !== 'undefined' && window.wails) {
      greeting.value = await window.wails.App.Greet(name.value);
    } else {
      // Fallback for development
      greeting.value = `Hello ${name.value}, It's show time! (Development mode)`;
    }
  } catch (error) {
    console.error('Error calling backend:', error);
    greeting.value = 'Error connecting to backend';
  }
};

const getAppInfo = async () => {
  try {
    if (typeof window !== 'undefined' && window.wails) {
      appInfo.value = await window.wails.App.GetAppInfo();
    } else {
      // Fallback for development
      appInfo.value = {
        name: 'Wails Nuxt 4 Template',
        version: '1.0.0',
        framework: 'Nuxt 4',
        backend: 'Go + Wails v2',
        mode: 'Development',
      };
    }
  } catch (error) {
    console.error('Error getting app info:', error);
  }
};

// Initialize on mount
onMounted(() => {
  console.log('Wails Nuxt 4 app initialized');
});
</script>

<style scoped>
ul {
  list-style-type: none;
  padding: 0;
}

li {
  padding: 0.25rem 0;
  position: relative;
  padding-left: 1.5rem;
}

li::before {
  content: '✓';
  position: absolute;
  left: 0;
  color: #667eea;
  font-weight: bold;
}

h4 {
  color: #667eea;
  margin-bottom: 1rem;
}
</style>
