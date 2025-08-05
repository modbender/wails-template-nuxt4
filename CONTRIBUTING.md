# Contributing to Wails Nuxt 4 Template

Thank you for your interest in contributing to the Wails Nuxt 4 Template! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Reporting Issues

If you find a bug or have a feature request:

1. **Search existing issues** to avoid duplicates
2. **Create a new issue** with a clear title and description
3. **Include steps to reproduce** for bugs
4. **Provide system information** (OS, Go version, Node.js version, Wails version)

### Submitting Changes

1. **Fork the repository**
2. **Create a feature branch** from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes** following our coding standards
4. **Test your changes** thoroughly
5. **Commit with clear messages**:
   ```bash
   git commit -m "feat: add new component for file handling"
   ```
6. **Push to your fork** and **create a pull request**

## 🛠️ Development Setup

### Prerequisites

- Go 1.21 or later
- Node.js 18.0 or later
- Wails CLI v2.10.0 or later

### Setup Steps

1. Clone your fork:
   ```bash
   git clone https://github.com/your-username/wails-template-nuxt4.git
   cd wails-template-nuxt4
   ```

2. Install dependencies:
   ```bash
   # Run the setup script
   ./scripts/dev.sh  # On Unix systems
   # or
   .\scripts\dev.ps1  # On Windows
   ```

3. Start development:
   ```bash
   wails dev
   ```

## 📝 Coding Standards

### Go Code (Backend)

- Follow standard Go formatting (`go fmt`)
- Use meaningful variable and function names
- Add comments for exported functions
- Handle errors appropriately
- Write tests for new functionality

### Vue/TypeScript Code (Frontend)

- Use TypeScript for type safety
- Follow Vue 3 Composition API patterns
- Use meaningful component and variable names
- Add JSDoc comments for complex functions
- Ensure responsive design

### File Organization

- Keep components small and focused
- Use descriptive file names
- Organize files logically in directories
- Update documentation when adding new features

## 🧪 Testing

### Backend Testing

```bash
go test ./...
```

### Frontend Testing

```bash
cd frontend
npm run test  # When test scripts are added
```

### Manual Testing

1. Test in development mode (`wails dev`)
2. Test production build (`wails build`)
3. Test on different platforms if possible
4. Verify all features work as expected

## 📚 Documentation

When contributing:

- Update README.md if adding new features
- Add inline code comments for complex logic
- Update this CONTRIBUTING.md if changing processes
- Include examples in documentation

## 🎯 Areas for Contribution

We welcome contributions in these areas:

### High Priority
- Bug fixes and stability improvements
- Performance optimizations
- Cross-platform compatibility
- Documentation improvements

### Medium Priority
- New example components
- Additional utility functions
- UI/UX improvements
- Build process enhancements

### Low Priority
- Code refactoring
- Additional development tools
- Extended configuration options

## 🔄 Pull Request Process

1. **Ensure your PR has a clear title and description**
2. **Reference any related issues** using `#issue-number`
3. **Include screenshots** for UI changes
4. **Update documentation** as needed
5. **Ensure all checks pass** (when CI is set up)
6. **Be responsive to feedback** during review

### PR Title Format

Use conventional commit format:
- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation changes
- `style:` for formatting changes
- `refactor:` for code refactoring
- `test:` for adding tests
- `chore:` for maintenance tasks

## 🚀 Release Process

Releases are managed by maintainers:

1. Version bumping follows semantic versioning
2. Changelog is updated with each release
3. Tags are created for each release
4. Release notes highlight major changes

## 📞 Getting Help

If you need help:

1. **Check the README.md** for basic information
2. **Search existing issues** for similar questions
3. **Create a new issue** with the "question" label
4. **Join the Wails Discord** for community support

## 🙏 Recognition

Contributors will be:

- Listed in the README.md contributors section
- Mentioned in release notes for significant contributions
- Invited to become maintainers for consistent, high-quality contributions

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to make this template better for everyone! 🎉
