#!/bin/bash

# Development script for Wails Nuxt 4 Template
# This script helps set up and run the development environment

echo "🚀 Wails Nuxt 4 Template - Development Setup"
echo "============================================="

# Check if Wails CLI is installed
echo "Checking Wails CLI installation..."
if ! command -v wails &> /dev/null; then
    echo "⚠️  Wails CLI not found. Installing automatically..."
    if ! go install github.com/wailsapp/wails/v2/cmd/wails@latest; then
        echo "❌ Failed to install Wails CLI. Please check your Go installation."
        exit 1
    fi
    echo "✅ Wails CLI installed successfully"
else
    echo "✅ Wails CLI found: $(wails version)"
fi

# Check if Go is installed
echo "Checking Go installation..."
if ! command -v go &> /dev/null; then
    echo "❌ Go not found. Please install Go 1.21 or later."
    echo "   Download from: https://golang.org/dl/"
    echo "   Or use your package manager:"
    echo "   - Ubuntu/Debian: sudo apt install golang-go"
    echo "   - macOS: brew install go"
    echo "   - Windows: Download installer from golang.org"
    exit 1
fi
echo "✅ Go found: $(go version)"

# Check if Node.js is installed
echo "Checking Node.js installation..."
if ! command -v node &> /dev/null; then
    echo "❌ Node.js not found. Please install Node.js 18.0 or later."
    echo "   Download from: https://nodejs.org/"
    echo "   Or use your package manager:"
    echo "   - Ubuntu/Debian: sudo apt install nodejs npm"
    echo "   - macOS: brew install node"
    echo "   - Windows: Download installer from nodejs.org"
    exit 1
fi
echo "✅ Node.js found: $(node --version)"

# Install Go dependencies
echo "Installing Go dependencies..."
if [ ! -f "go.sum" ]; then
    echo "📦 Downloading Go modules for the first time..."
fi
if ! go mod tidy; then
    echo "❌ Failed to install Go dependencies"
    exit 1
fi
if ! go mod download; then
    echo "❌ Failed to download Go dependencies"
    exit 1
fi
echo "✅ Go dependencies ready"

# Function to detect package manager
detect_package_manager() {
    echo "Detecting package manager..."

    # Check for lock files in order of preference
    if [ -f "frontend/pnpm-lock.yaml" ]; then
        echo "📦 Detected pnpm-lock.yaml - using pnpm"
        echo "pnpm"
        return
    elif [ -f "frontend/yarn.lock" ]; then
        echo "📦 Detected yarn.lock - using yarn"
        echo "yarn"
        return
    elif [ -f "frontend/package-lock.json" ]; then
        echo "📦 Detected package-lock.json - using npm"
        echo "npm"
        return
    else
        # No lock file found, check what's available and ask user
        echo "No lock file detected. Checking available package managers..."

        available=()
        if command -v pnpm &> /dev/null; then
            available+=("pnpm")
        fi
        if command -v yarn &> /dev/null; then
            available+=("yarn")
        fi
        if command -v npm &> /dev/null; then
            available+=("npm")
        fi

        if [ ${#available[@]} -eq 0 ]; then
            echo "❌ No package managers found. Please install npm, yarn, or pnpm."
            exit 1
        fi

        echo "Available package managers: ${available[*]}"
        echo "Which package manager would you like to use?"

        for i in "${!available[@]}"; do
            echo "  $((i + 1)). ${available[i]}"
        done

        while true; do
            read -p "Enter your choice (1-${#available[@]}): " choice
            if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le ${#available[@]} ]; then
                selected=${available[$((choice - 1))]}
                echo "Selected: $selected"
                echo "$selected"
                return
            else
                echo "Invalid choice. Please enter a number between 1 and ${#available[@]}."
            fi
        done
    fi
}

# Function to install dependencies based on package manager
install_dependencies() {
    local package_manager=$1

    echo "Installing frontend dependencies with $package_manager..."
    cd frontend

    case $package_manager in
        "pnpm")
            if [ -d "node_modules" ]; then
                echo "Updating packages with pnpm..."
                if ! pnpm install; then
                    echo "❌ Failed to install frontend dependencies with pnpm"
                    exit 1
                fi
            else
                echo "Installing packages with pnpm..."
                if ! pnpm install; then
                    echo "❌ Failed to install frontend dependencies with pnpm"
                    exit 1
                fi
            fi
            ;;
        "yarn")
            if [ -f "yarn.lock" ]; then
                echo "Installing packages with yarn..."
                if ! yarn install --frozen-lockfile; then
                    echo "❌ Failed to install frontend dependencies with yarn"
                    exit 1
                fi
            else
                echo "Installing packages with yarn..."
                if ! yarn install; then
                    echo "❌ Failed to install frontend dependencies with yarn"
                    exit 1
                fi
            fi
            ;;
        "npm")
            if [ -f "package-lock.json" ] && [ -d "node_modules" ]; then
                echo "Installing packages with npm ci..."
                if ! npm ci; then
                    echo "⚠️  npm ci failed, falling back to npm install..."
                    if ! npm install; then
                        echo "❌ Failed to install frontend dependencies with npm"
                        exit 1
                    fi
                fi
            else
                echo "Installing packages with npm..."
                if ! npm install; then
                    echo "❌ Failed to install frontend dependencies with npm"
                    exit 1
                fi
            fi
            ;;
    esac

    cd ..
    echo "✅ Frontend dependencies ready"
}

# Detect and use package manager
package_manager=$(detect_package_manager)
install_dependencies "$package_manager"

echo ""
echo "🎉 Setup complete! What would you like to do next?"
echo ""
echo "Available options:"
echo "  1. Start development server (wails dev)"
echo "  2. Start frontend only ($package_manager dev)"
echo "  3. Build for production (wails build)"
echo "  4. Show project information"
echo "  5. Exit"
echo ""

while true; do
    read -p "Enter your choice (1-5): " choice
    case $choice in
        1)
            echo "Starting Wails development server..."
            echo "This will start both Go backend and Nuxt frontend with hot reload"
            wails dev
            break
            ;;
        2)
            echo "Starting frontend development server only..."
            echo "Note: Backend API calls will not work in this mode"
            cd frontend
            case $package_manager in
                "pnpm") pnpm dev ;;
                "yarn") yarn dev ;;
                "npm") npm run dev ;;
            esac
            cd ..
            break
            ;;
        3)
            echo "Building for production..."
            wails build
            echo "✅ Build complete! Check the build/ directory for output"
            break
            ;;
        4)
            echo ""
            echo "📋 Project Information:"
            echo "  • Template: Wails + Nuxt 4"
            echo "  • Package Manager: $package_manager"
            echo "  • Frontend: Nuxt 4 with Vue 3 + TypeScript"
            echo "  • Backend: Go + Wails v2"
            echo ""
            echo "📁 Key directories:"
            echo "  • frontend/app/ - Nuxt 4 application code"
            echo "  • app.go - Go backend logic"
            echo "  • main.go - Application entry point"
            echo ""
            echo "🚀 Quick commands:"
            echo "  • wails dev - Start development server"
            echo "  • wails build - Build for production"
            echo "  • $package_manager dev - Frontend only (in frontend/ dir)"
            echo ""
            continue
            ;;
        5)
            echo "Happy coding! 🎉"
            break
            ;;
        *)
            echo "Invalid choice. Please enter 1-5."
            continue
            ;;
    esac
done
