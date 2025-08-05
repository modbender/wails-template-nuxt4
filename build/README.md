# Build Assets

This directory contains build-time assets for the Wails application.

## Required Files

### App Icon
- **appicon.png** - Main application icon (512x512 pixels recommended)
  - This file should be placed in this directory
  - Used for generating platform-specific icons
  - PNG format with transparent background recommended

### Platform-specific directories

#### darwin/
Contains macOS-specific build assets:
- Info.plist (optional) - macOS app bundle information
- icon.icns (generated from appicon.png)

#### windows/
Contains Windows-specific build assets:
- icon.ico (generated from appicon.png)
- app.manifest (optional) - Windows application manifest

## Notes

- If appicon.png is missing, Wails will use a default icon
- Platform-specific icons are automatically generated from appicon.png
- You can customize the build process by adding platform-specific configuration files

## Generating Icons

To create your own app icon:
1. Create a 512x512 PNG image
2. Name it `appicon.png`
3. Place it in this directory
4. Wails will automatically generate platform-specific icons during build
