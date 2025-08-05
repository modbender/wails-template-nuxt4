package main

import (
	"context"
	"fmt"
)

// App struct
type App struct {
	ctx context.Context
}

// NewApp creates a new App application struct
func NewApp() *App {
	return &App{}
}

// startup is called when the app starts. The context here
// can be used to call the runtime methods
func (a *App) startup(ctx context.Context) {
	a.ctx = ctx
}

// domReady is called after front-end resources have been loaded
func (a *App) domReady(ctx context.Context) {
	// Add your action here
}

// beforeClose is called when the application is about to quit,
// either by clicking the window close button or calling runtime.Quit.
// Returning true will cause the application to continue, false will continue shutdown as normal.
func (a *App) beforeClose(ctx context.Context) (prevent bool) {
	return false
}

// shutdown is called at application termination
func (a *App) shutdown(ctx context.Context) {
	// Perform your teardown here
}

// Greet returns a greeting for the given name
func (a *App) Greet(name string) string {
	return fmt.Sprintf("Hello %s, It's show time!", name)
}

// GetAppInfo returns basic application information
func (a *App) GetAppInfo() map[string]string {
	return map[string]string{
		"name":        "Wails Nuxt 4 Template",
		"version":     "1.0.0",
		"description": "A modern desktop application built with Wails and Nuxt 4",
		"framework":   "Nuxt 4",
		"backend":     "Go + Wails v2",
	}
}

// GetSystemInfo returns basic system information
func (a *App) GetSystemInfo() map[string]interface{} {
	return map[string]interface{}{
		"platform": "desktop",
		"runtime":  "wails",
		"ready":    true,
	}
}
