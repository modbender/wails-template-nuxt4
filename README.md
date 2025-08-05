# 🚀 Wails + Nuxt 4 Template

A modern desktop application template that combines the power of **Wails v2** (Go backend) with **Nuxt 4** (Vue.js frontend) to create fast, native desktop applications with web technologies.

## ✨ Features

### Frontend (Nuxt 4)

- 🎯 **Vue 3** with Composition API
- 📝 **TypeScript** support out of the box
- 🎨 **Nuxt UI** components for beautiful interfaces
- 🔄 **Auto-imports** for components and composables
- 📁 **File-based routing** with Nuxt
- ⚡ **Hot Module Replacement** for fast development
- 🎭 **SSG** (Static Site Generation) for optimal performance
- 🗂️ **New directory structure** with `app/` as srcDir (Nuxt 4)

### Backend (Go + Wails v2)

- 🏃‍♂️ **Native performance** with Go
- 🌍 **Cross-platform** builds (Windows, macOS, Linux)
- 🔒 **Secure** API calls between frontend and backend
- 📂 **File system access** and system integration
- 🔔 **Native notifications** and system tray support
- 📦 **Single executable** distribution

## 🛠️ Prerequisites

Before you begin, ensure you have the following installed:

- **Go** 1.21 or later ([Download](https://golang.org/dl/))
- **Node.js** 18.0 or later ([Download](https://nodejs.org/))

> **Note**: The Wails CLI will be automatically installed by our setup script if not present.

## 🚀 Quick Start

### 1. Create a new project using this template

```bash
# Clone or download this template
git clone <your-repo-url> my-wails-app
cd my-wails-app
```

### 2. Interactive Setup

```bash
# Run the interactive setup script
./scripts/dev.sh    # On Unix systems
# or
.\scripts\dev.ps1   # On Windows

# The script will automatically:
# - Install Wails CLI if not present
# - Install Go dependencies
# - Detect your preferred package manager (pnpm → yarn → npm)
# - Install frontend dependencies
# - Provide interactive options for next steps
```

#### Package Manager Detection

The setup script intelligently detects your preferred package manager:

1. **Lock file detection**: Checks for `pnpm-lock.yaml`, `yarn.lock`, or `package-lock.json`
2. **Automatic selection**: Uses the package manager that matches the lock file
3. **Interactive choice**: If no lock file exists, presents available options
4. **Smart defaults**: Prefers pnpm → yarn → npm in that order

### 3. Development Options

After running the setup script, you'll get an interactive menu with these options:

1. **Full Development Server** (`wails dev`)

   - Starts both Go backend and Nuxt frontend
   - Opens desktop application window
   - Hot reload for both frontend and backend
   - **Recommended for full development**

2. **Frontend Only** (`pnpm/yarn/npm dev`)

   - Starts only the Nuxt development server
   - Runs in browser at http://localhost:3000
   - Faster startup, but no backend API access
   - **Good for UI/frontend-only development**

3. **Production Build** (`wails build`)

   - Creates optimized desktop application
   - Outputs to `build/bin/` directory
   - **Ready for distribution**

4. **Project Information**
   - Shows configuration details
   - Lists key directories and commands
   - **Helpful reference**

### 4. Build for production

```bash
# Build for current platform
wails build

# Build for specific platforms
wails build -platform windows/amd64
wails build -platform darwin/amd64
wails build -platform linux/amd64
```

## 📁 Project Structure

```
wails-template-nuxt4/
├── frontend/                 # Nuxt 4 frontend
│   ├── app/                 # Nuxt 4 app directory (srcDir)
│   │   ├── assets/          # Static assets (CSS, images)
│   │   ├── components/      # Vue components
│   │   ├── pages/           # File-based routing
│   │   ├── types/           # TypeScript declarations
│   │   └── app.vue          # Root component
│   ├── nuxt.config.ts       # Nuxt configuration
│   ├── package.json         # Frontend dependencies
│   └── tsconfig.json        # TypeScript configuration
├── build/                   # Build assets
│   ├── appicon.png          # Application icon
│   ├── darwin/              # macOS specific files
│   └── windows/             # Windows specific files
├── scripts/                 # Development scripts
├── main.go                  # Application entry point
├── app.go                   # Application logic
├── go.mod                   # Go dependencies
├── wails.json               # Wails configuration
└── README.md                # This file
```

> **Note**: This template uses the new Nuxt 4 directory structure where frontend files are organized under `frontend/app/` (the `srcDir`). The `~` alias points to this directory, so `~/components` resolves to `frontend/app/components/`.

## 🔧 Configuration

### Wails Configuration (`wails.json`)

The `wails.json` file contains the Wails-specific configuration:

- **Frontend commands**: Build and dev commands for Nuxt
- **Application metadata**: Name, version, author information
- **Build settings**: Output filename and build options

### Nuxt Configuration (`frontend/nuxt.config.ts`)

Key configurations for Wails integration:

- **SSR disabled**: `ssr: false` for static generation
- **Static preset**: `nitro.preset: 'static'` for file-based output
- **Output directory**: `generate.dir: 'dist'` for Wails embedding

## 🎯 Adding Features

### Backend (Go)

Add new methods to `app.go`:

```go
func (a *App) MyNewMethod(param string) string {
    // Your Go logic here
    return "Result: " + param
}
```

### Frontend (Vue/Nuxt)

Call backend methods from your Vue components:

```vue
<script setup>
const callBackend = async () => {
  const result = await window.wails.App.MyNewMethod('test');
  console.log(result);
};
</script>
```

## 📦 Building and Distribution

### Development Build

```bash
wails build -debug
```

### Production Build

```bash
wails build
```

### Cross-platform Builds

```bash
# Windows
wails build -platform windows/amd64

# macOS
wails build -platform darwin/amd64

# Linux
wails build -platform linux/amd64
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development Setup

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Wails](https://wails.io/) - For the amazing Go + Web framework
- [Nuxt](https://nuxt.com/) - For the powerful Vue.js framework
- [Vue.js](https://vuejs.org/) - For the reactive frontend framework

## 📞 Support

If you have any questions or need help, please:

1. Check the [Wails documentation](https://wails.io/docs/)
2. Check the [Nuxt documentation](https://nuxt.com/docs)
3. Open an issue in this repository
4. Join the [Wails Discord community](https://discord.gg/JDdSxwjhGf)

---

**Happy coding!** 🎉
