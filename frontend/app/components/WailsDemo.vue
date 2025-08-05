<template>
  <div class="wails-demo">
    <h3>🔗 Wails Integration Demo</h3>

    <!-- Connection Status -->
    <div
      class="status-card"
      :class="{ connected: isWailsConnected, disconnected: !isWailsConnected }"
    >
      <div class="status-indicator"></div>
      <span>{{
        isWailsConnected
          ? 'Connected to Wails Runtime'
          : 'Running in Browser Mode'
      }}</span>
      <div v-if="!isWailsConnected" class="browser-notice">
        <small
          >💡 To test Wails APIs, open the app at:
          <strong>http://localhost:34115</strong></small
        >
      </div>
    </div>

    <!-- API Testing -->
    <div class="demo-section">
      <h4>Backend API Testing</h4>

      <div class="input-group">
        <input
          v-model="testInput"
          type="text"
          placeholder="Enter test message"
          class="demo-input"
          @keyup.enter="testGreeting"
        />
        <button @click="testGreeting" class="demo-btn" :disabled="loading">
          {{ loading ? 'Testing...' : 'Test API' }}
        </button>
      </div>

      <div v-if="apiResponse" class="response-box">
        <strong>API Response:</strong>
        <pre>{{ apiResponse }}</pre>
      </div>
    </div>

    <!-- System Information -->
    <div class="demo-section">
      <h4>System Information</h4>
      <button @click="getSystemInfo" class="demo-btn" :disabled="loading">
        Get System Info
      </button>

      <div v-if="systemInfo" class="info-grid">
        <div v-for="(value, key) in systemInfo" :key="key" class="info-item">
          <span class="info-key">{{ key }}:</span>
          <span class="info-value">{{ value }}</span>
        </div>
      </div>
    </div>

    <!-- Error Display -->
    <div v-if="error" class="error-box">
      <strong>Error:</strong> {{ error }}
    </div>
  </div>
</template>

<script setup lang="ts">
import type { SystemInfo } from '~/types/wails';

// Reactive state
const isWailsConnected = ref(false);
const testInput = ref('Hello from Nuxt 4!');
const apiResponse = ref('');
const systemInfo = ref<SystemInfo | null>(null);
const loading = ref(false);
const error = ref('');

// Check Wails connection on mount
onMounted(() => {
  checkWailsConnection();
});

// Methods
const checkWailsConnection = () => {
  if (
    typeof window !== 'undefined' &&
    (window.wails || window.go || window.runtime)
  ) {
    isWailsConnected.value = true;
    console.log('Wails runtime detected and connected');
    console.log('Available APIs:', {
      wails: !!window.wails,
      go: !!window.go,
      runtime: !!window.runtime,
    });
  } else {
    isWailsConnected.value = false;
    console.log('Running in browser mode - Wails runtime not available');
  }
};

const testGreeting = async () => {
  if (!testInput.value.trim()) {
    error.value = 'Please enter a test message';
    return;
  }

  loading.value = true;
  error.value = '';

  try {
    if (isWailsConnected.value) {
      // Try different Wails API access methods
      if (window.wails?.App?.Greet) {
        apiResponse.value = await window.wails.App.Greet(testInput.value);
      } else if (window.go?.main?.App?.Greet) {
        apiResponse.value = await window.go.main.App.Greet(testInput.value);
      } else {
        throw new Error('Wails API not found - methods not available');
      }
    } else {
      // Simulate API call for browser development
      await new Promise((resolve) => setTimeout(resolve, 500));
      apiResponse.value = `Mock Response: Hello ${testInput.value}, It's show time! (Browser Mode)`;
    }
  } catch (err) {
    error.value = `API Error: ${(err as Error).message || err}`;
    console.error('API call failed:', err);
    console.error(
      'Available window objects:',
      Object.keys(window).filter((key) =>
        ['wails', 'go', 'runtime'].includes(key)
      )
    );
  } finally {
    loading.value = false;
  }
};

const getSystemInfo = async () => {
  loading.value = true;
  error.value = '';

  try {
    if (isWailsConnected.value) {
      // Try different Wails API access methods
      if (window.wails?.App?.GetSystemInfo) {
        systemInfo.value = await window.wails.App.GetSystemInfo();
      } else if (window.go?.main?.App?.GetSystemInfo) {
        systemInfo.value = await window.go.main.App.GetSystemInfo();
      } else {
        throw new Error('Wails GetSystemInfo API not found');
      }
    } else {
      // Mock system info for browser
      await new Promise((resolve) => setTimeout(resolve, 300));
      systemInfo.value = {
        platform: 'browser',
        runtime: 'development',
        ready: true,
        mode: 'mock',
      };
    }
  } catch (err) {
    error.value = `System Info Error: ${(err as Error).message || err}`;
    console.error('System info failed:', err);
  } finally {
    loading.value = false;
  }
};
</script>

<style scoped>
.wails-demo {
  max-width: 600px;
  margin: 0 auto;
}

.status-card {
  display: flex;
  align-items: center;
  padding: 1rem;
  border-radius: 8px;
  margin-bottom: 1.5rem;
  font-weight: 500;
}

.status-card.connected {
  background: #d1fae5;
  color: #065f46;
  border: 1px solid #a7f3d0;
}

.status-card.disconnected {
  background: #fef3c7;
  color: #92400e;
  border: 1px solid #fcd34d;
}

.status-indicator {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  margin-right: 0.75rem;
}

.connected .status-indicator {
  background: #10b981;
}

.disconnected .status-indicator {
  background: #f59e0b;
}

.browser-notice {
  margin-top: 0.5rem;
  padding: 0.5rem;
  background: #f3f4f6;
  border-radius: 4px;
  border-left: 3px solid #f59e0b;
}

.demo-section {
  margin-bottom: 2rem;
}

.demo-section h4 {
  color: #374151;
  margin-bottom: 1rem;
}

.input-group {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 1rem;
}

.demo-input {
  flex: 1;
  padding: 0.75rem;
  border: 2px solid #e5e7eb;
  border-radius: 6px;
  font-size: 0.9rem;
}

.demo-input:focus {
  outline: none;
  border-color: #667eea;
}

.demo-btn {
  padding: 0.75rem 1.5rem;
  background: #667eea;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 0.9rem;
  font-weight: 500;
  transition: background 0.2s;
}

.demo-btn:hover:not(:disabled) {
  background: #5a67d8;
}

.demo-btn:disabled {
  background: #9ca3af;
  cursor: not-allowed;
}

.response-box,
.error-box {
  padding: 1rem;
  border-radius: 6px;
  margin-top: 1rem;
}

.response-box {
  background: #f0f9ff;
  border: 1px solid #bae6fd;
  color: #0c4a6e;
}

.error-box {
  background: #fef2f2;
  border: 1px solid #fecaca;
  color: #991b1b;
}

.response-box pre {
  margin: 0.5rem 0 0;
  font-family: 'Courier New', monospace;
  font-size: 0.9rem;
  white-space: pre-wrap;
}

.info-grid {
  display: grid;
  gap: 0.5rem;
  margin-top: 1rem;
}

.info-item {
  display: flex;
  justify-content: space-between;
  padding: 0.5rem;
  background: #f9fafb;
  border-radius: 4px;
}

.info-key {
  font-weight: 500;
  color: #374151;
}

.info-value {
  color: #6b7280;
  font-family: monospace;
}
</style>
