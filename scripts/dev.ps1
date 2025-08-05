# Development script for Wails Nuxt 4 Template
# This script helps set up and run the development environment

Write-Host "Wails Nuxt 4 Template - Development Setup" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# Check if Wails CLI is installed
Write-Host "Checking Wails CLI installation..." -ForegroundColor Yellow
$wailsVersion = wails version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "Warning: Wails CLI not found. Installing automatically..." -ForegroundColor Yellow
    go install github.com/wailsapp/wails/v2/cmd/wails@latest
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to install Wails CLI. Please check your Go installation." -ForegroundColor Red
        exit 1
    }
    Write-Host "✅ Wails CLI installed successfully" -ForegroundColor Green
    $wailsVersion = wails version 2>$null
} else {
    Write-Host "✅ Wails CLI found: $wailsVersion" -ForegroundColor Green
}

# Check if Go is installed
Write-Host "Checking Go installation..." -ForegroundColor Yellow
$goVersion = go version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Go not found. Please install Go 1.21 or later." -ForegroundColor Red
    Write-Host "   Download from: https://golang.org/dl/" -ForegroundColor White
    Write-Host "   Or use package managers:" -ForegroundColor White
    Write-Host "   - Chocolatey: choco install golang" -ForegroundColor White
    Write-Host "   - Scoop: scoop install go" -ForegroundColor White
    Write-Host "   - Winget: winget install GoLang.Go" -ForegroundColor White
    exit 1
}
Write-Host "✅ Go found: $goVersion" -ForegroundColor Green

# Check if Node.js is installed
Write-Host "Checking Node.js installation..." -ForegroundColor Yellow
$nodeVersion = node --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Node.js not found. Please install Node.js 18.0 or later." -ForegroundColor Red
    Write-Host "   Download from: https://nodejs.org/" -ForegroundColor White
    Write-Host "   Or use package managers:" -ForegroundColor White
    Write-Host "   - Chocolatey: choco install nodejs" -ForegroundColor White
    Write-Host "   - Scoop: scoop install nodejs" -ForegroundColor White
    Write-Host "   - Winget: winget install OpenJS.NodeJS" -ForegroundColor White
    exit 1
}
Write-Host "✅ Node.js found: $nodeVersion" -ForegroundColor Green

# Install Go dependencies
Write-Host "Installing Go dependencies..." -ForegroundColor Yellow
if (!(Test-Path "go.sum")) {
    Write-Host "Downloading Go modules for the first time..." -ForegroundColor Cyan
}
go mod tidy
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to install Go dependencies" -ForegroundColor Red
    exit 1
}
go mod download
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to download Go dependencies" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Go dependencies ready" -ForegroundColor Green

# Function to detect package manager
function Get-PackageManager {
    Write-Host "Detecting package manager..." -ForegroundColor Yellow

    # Check for lock files in order of preference
    if (Test-Path "frontend/pnpm-lock.yaml") {
        Write-Host "Detected pnpm-lock.yaml - using pnpm" -ForegroundColor Cyan
        return "pnpm"
    }
    elseif (Test-Path "frontend/yarn.lock") {
        Write-Host "Detected yarn.lock - using yarn" -ForegroundColor Cyan
        return "yarn"
    }
    elseif (Test-Path "frontend/package-lock.json") {
        Write-Host "Detected package-lock.json - using npm" -ForegroundColor Cyan
        return "npm"
    }
    else {
        # No lock file found, check what's available and ask user
        Write-Host "No lock file detected. Checking available package managers..." -ForegroundColor Yellow

        $available = @()
        if (Get-Command pnpm -ErrorAction SilentlyContinue) { $available += "pnpm" }
        if (Get-Command yarn -ErrorAction SilentlyContinue) { $available += "yarn" }
        if (Get-Command npm -ErrorAction SilentlyContinue) { $available += "npm" }

        if ($available.Count -eq 0) {
            Write-Host "❌ No package managers found. Please install npm, yarn, or pnpm." -ForegroundColor Red
            exit 1
        }

        Write-Host "Available package managers: $($available -join ', ')" -ForegroundColor Cyan
        Write-Host "Which package manager would you like to use?" -ForegroundColor Yellow

        for ($i = 0; $i -lt $available.Count; $i++) {
            Write-Host "  $($i + 1). $($available[$i])" -ForegroundColor White
        }

        do {
            $choice = Read-Host "Enter your choice (1-$($available.Count))"
            $choiceNum = [int]$choice - 1
        } while ($choiceNum -lt 0 -or $choiceNum -ge $available.Count)

        $selected = $available[$choiceNum]
        Write-Host "Selected: $selected" -ForegroundColor Green
        return $selected
    }
}

# Function to install dependencies based on package manager
function Install-Dependencies {
    param($PackageManager)

    Write-Host "Installing frontend dependencies with $PackageManager..." -ForegroundColor Yellow
    Set-Location frontend

    try {
        switch ($PackageManager) {
            "pnpm" {
                if (Test-Path "node_modules") {
                    Write-Host "Updating packages with pnpm..." -ForegroundColor Cyan
                    pnpm install
                } else {
                    Write-Host "Installing packages with pnpm..." -ForegroundColor Cyan
                    pnpm install
                }
            }
            "yarn" {
                if (Test-Path "yarn.lock") {
                    Write-Host "Installing packages with yarn..." -ForegroundColor Cyan
                    yarn install --frozen-lockfile
                } else {
                    Write-Host "Installing packages with yarn..." -ForegroundColor Cyan
                    yarn install
                }
            }
            "npm" {
                if (Test-Path "package-lock.json" -and Test-Path "node_modules") {
                    Write-Host "Installing packages with npm ci..." -ForegroundColor Cyan
                    npm ci
                } else {
                    Write-Host "Installing packages with npm..." -ForegroundColor Cyan
                    npm install
                }
            }
        }

        if ($LASTEXITCODE -ne 0) {
            throw "Package installation failed"
        }

        Write-Host "✅ Frontend dependencies ready" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Failed to install frontend dependencies with $PackageManager" -ForegroundColor Red
        exit 1
    }
    finally {
        Set-Location ..
    }
}

# Detect and use package manager
$packageManager = Get-PackageManager
Install-Dependencies $packageManager

Write-Host ""
Write-Host "Setup complete! What would you like to do next?" -ForegroundColor Green
Write-Host ""
Write-Host "Available options:" -ForegroundColor Yellow
Write-Host "  1. Start development server (wails dev)" -ForegroundColor White
Write-Host "  2. Start frontend only ($packageManager dev)" -ForegroundColor White
Write-Host "  3. Build for production (wails build)" -ForegroundColor White
Write-Host "  4. Show project information" -ForegroundColor White
Write-Host "  5. Exit" -ForegroundColor White
Write-Host ""

do {
    $choice = Read-Host "Enter your choice (1-5)"
    switch ($choice) {
        "1" {
            Write-Host "Starting Wails development server..." -ForegroundColor Cyan
            Write-Host "This will start both Go backend and Nuxt frontend with hot reload" -ForegroundColor Gray
            wails dev
            break
        }
        "2" {
            Write-Host "Starting frontend development server only..." -ForegroundColor Cyan
            Write-Host "Note: Backend API calls will not work in this mode" -ForegroundColor Yellow
            Set-Location frontend
            switch ($packageManager) {
                "pnpm" { pnpm dev }
                "yarn" { yarn dev }
                "npm" { npm run dev }
            }
            Set-Location ..
            break
        }
        "3" {
            Write-Host "Building for production..." -ForegroundColor Cyan
            wails build
            Write-Host "✅ Build complete! Check the build/ directory for output" -ForegroundColor Green
            break
        }
        "4" {
            Write-Host ""
            Write-Host "Project Information:" -ForegroundColor Cyan
            Write-Host "  • Template: Wails + Nuxt 4" -ForegroundColor White
            Write-Host "  • Package Manager: $packageManager" -ForegroundColor White
            Write-Host "  • Frontend: Nuxt 4 with Vue 3 + TypeScript" -ForegroundColor White
            Write-Host "  • Backend: Go + Wails v2" -ForegroundColor White
            Write-Host ""
            Write-Host "Key directories:" -ForegroundColor Cyan
            Write-Host "  • frontend/app/ - Nuxt 4 application code" -ForegroundColor White
            Write-Host "  • app.go - Go backend logic" -ForegroundColor White
            Write-Host "  • main.go - Application entry point" -ForegroundColor White
            Write-Host ""
            Write-Host "Quick commands:" -ForegroundColor Cyan
            Write-Host "  • wails dev - Start development server" -ForegroundColor White
            Write-Host "  • wails build - Build for production" -ForegroundColor White
            Write-Host "  • $packageManager dev - Frontend only (in frontend/ dir)" -ForegroundColor White
            Write-Host ""
            continue
        }
        "5" {
            Write-Host "Happy coding!" -ForegroundColor Green
            break
        }
        default {
            Write-Host "Invalid choice. Please enter 1-5." -ForegroundColor Red
            continue
        }
    }
} while ($true)
