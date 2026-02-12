# Quick Start Guide

Get AR Lens Translate up and running in 5 minutes!

## Prerequisites

- macOS with Xcode 15.0 or later
- iOS device with iOS 16.0 or later (camera required)
- Apple Developer account (for device deployment)

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/ar-lens-translate.git
cd ar-lens-translate
```

### 2. Open in Xcode

```bash
cd ARLensTranslate
open ARLensTranslate.xcodeproj
```

### 3. Configure Signing

1. Select the project in the navigator
2. Select the "ARLensTranslate" target
3. Go to "Signing & Capabilities" tab
4. Select your development team from the dropdown

### 4. Connect Your Device

1. Connect your iPhone or iPad via USB
2. Unlock your device
3. Trust the computer if prompted
4. Select your device from the scheme selector in Xcode

### 5. Build and Run

Press `Cmd + R` or click the Play button in Xcode

**Important**: This app requires a physical device with a camera. It will not work in the simulator.

## First Launch

1. Grant camera permissions when prompted
2. Point your camera at text (try a book, sign, or menu)
3. Tap the language selectors to choose source and target languages
4. Watch translations appear in real-time!

## Basic Usage

### Changing Languages

- Tap the language flags at the top to select source/target languages
- Source language supports "Auto Detect"
- Target language shows all available languages

### Taking Photos

- Tap the white circle button to capture translated images
- Photos are saved to your device with translations visible

### Settings

- Tap the gear icon for settings
- Toggle offline mode for translation without internet
- View translation history
- Clear history

## Troubleshooting

### Camera Not Working

- Check Settings → Privacy → Camera → AR Lens Translate is enabled
- Restart the app
- Restart your device

### Text Not Detected

- Ensure good lighting
- Hold camera steady
- Try different angles
- Make sure text is clear and in focus

### Translation Not Appearing

- Check internet connection (if not in offline mode)
- Verify target language is selected
- Try a different language pair

### Build Errors

- Clean build folder: `Cmd + Shift + K`
- Delete derived data: `Cmd + Shift + Option + K`
- Close and reopen Xcode
- Ensure deployment target matches your device

## Next Steps

- Explore different language combinations
- Try offline mode with downloaded language models
- Save favorite translations
- Check out the full README for advanced features

## Getting Help

- Check the [Issues](https://github.com/yourusername/ar-lens-translate/issues) page
- Read the full [README](README.md)
- Review the [Contributing Guide](CONTRIBUTING.md)

Happy translating! 🌍📱
