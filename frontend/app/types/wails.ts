// Wails runtime types
export interface WailsApp {
  Greet(name: string): Promise<string>;
  GetAppInfo(): Promise<AppInfo>;
  GetSystemInfo(): Promise<SystemInfo>;
}

export interface AppInfo {
  name: string;
  version: string;
  description: string;
  framework: string;
  backend: string;
}

export interface SystemInfo {
  platform: string;
  runtime: string;
  ready: boolean;
  mode?: string;
}

export interface WailsRuntime {
  App: WailsApp;
}

// Extend the global Window interface
declare global {
  interface Window {
    wails?: WailsRuntime;
    go?: {
      main: {
        App: WailsApp;
      };
    };
    runtime?: any;
  }
}
