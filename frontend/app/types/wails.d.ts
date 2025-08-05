// TypeScript declarations for Wails runtime

declare global {
  interface Window {
    wails?: {
      App: {
        Greet(name: string): Promise<string>
        GetAppInfo(): Promise<{
          name: string
          version: string
          description: string
          framework: string
          backend: string
        }>
        GetSystemInfo(): Promise<{
          platform: string
          runtime: string
          ready: boolean
        }>
      }
    }
  }
}

export {}
