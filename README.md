# 📸 AR Lens Translate

A powerful iOS app that translates text in real-time through your camera using augmented reality overlays. Point your camera at any text and see instant translations anchored to the original text position.

![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)
![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)
![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)

## 🌟 Features

- **Real-time Text Detection**: Uses Apple's Vision framework for accurate text recognition
- **AR Translation Overlay**: Translations appear directly over the original text using ARKit
- **Multi-Language Support**: Translate between 50+ languages
- **Offline Mode**: On-device Core ML models for offline translation
- **Save & Share**: Capture and share translated images
- **Low-Light Optimization**: Enhanced text detection in various lighting conditions
- **Haptic Feedback**: Tactile response when text is detected
- **History**: Keep track of your translation history

## 🛠️ Tech Stack

- **Language**: Swift 5.9+
- **UI Framework**: SwiftUI
- **Frameworks**:
  - Vision - Text detection
  - AVFoundation - Camera handling
  - Core ML - On-device translation models
  - Combine - Reactive programming
  - CoreImage - Image processing

## 📋 Requirements

- iOS 16.0+
- Xcode 15.0+
- Physical iOS device (camera required)
- Internet connection (for online translation mode)

## 🚀 Getting Started

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/ar-lens-translate.git
cd ar-lens-translate
```

2. Open the project in Xcode:
```bash
open ARLensTranslate.xcodeproj
```

3. Select your development team in Xcode:
   - Select the project in the navigator
   - Go to "Signing & Capabilities"
   - Select your team

4. Build and run on a physical device (Cmd + R)

**Note**: This app requires a physical iOS device with a camera. It will not work in the simulator.

## 📱 Usage

1. **Launch the app** and grant camera permissions
2. **Point your camera** at any text (signs, menus, documents, etc.)
3. **Select target language** from the language picker
4. **Watch as translations** appear in real-time over the original text
5. **Tap the camera button** to save translated images
6. **Access settings** to switch between online/offline mode

## 🏗️ Architecture

The project follows the MVVM (Model-View-ViewModel) architecture:

```
ARLensTranslate/
├── App/
│   └── ARLensTranslateApp.swift       # App entry point
├── Views/
│   ├── ContentView.swift              # Main container view
│   ├── CameraView.swift               # Camera preview
│   ├── TranslationOverlayView.swift   # AR overlay rendering
│   └── SettingsView.swift             # Settings screen
├── ViewModels/
│   ├── CameraViewModel.swift          # Camera logic
│   └── TranslationViewModel.swift     # Translation logic
├── Models/
│   ├── DetectedText.swift             # Text detection model
│   ├── Language.swift                 # Language model
│   └── TranslationResult.swift        # Translation result
├── Services/
│   ├── TextDetectionService.swift     # Vision framework wrapper
│   ├── TranslationService.swift       # Translation API service
│   └── CameraService.swift            # Camera management
└── Utilities/
    ├── Extensions.swift               # Helper extensions
    └── Constants.swift                # App constants
```

## 🔑 Key Components

### TextDetectionService
Handles real-time text detection using Vision framework:
- Processes camera frames
- Detects text regions
- Returns bounding boxes and recognized text

### TranslationService
Manages translation functionality:
- Online translation via API
- Offline translation using Core ML models
- Language detection
- Caching for performance

### CameraViewModel
Controls camera operations:
- Camera session management
- Frame capture and processing
- AR coordinate mapping

## 🌍 Supported Languages

The app supports translation between 50+ languages including:
- English, Spanish, French, German, Italian
- Chinese (Simplified & Traditional), Japanese, Korean
- Arabic, Russian, Portuguese, Dutch
- And many more...

## 🎨 Customization

### Adding New Languages

Edit `Models/Language.swift` to add more languages:

```swift
static let languages: [Language] = [
    Language(code: "en", name: "English"),
    Language(code: "es", name: "Spanish"),
    // Add your language here
]
```

### Changing Translation Provider

The app uses a translation API by default. To switch providers, modify `TranslationService.swift`:

```swift
// Implement your preferred translation API
func translate(_ text: String, to targetLanguage: String) async throws -> String {
    // Your implementation
}
```

## 🔒 Privacy

This app:
- Processes camera frames locally on device
- Does not store or transmit images without user consent
- Translation data may be sent to translation API (online mode only)
- No analytics or tracking

See `Privacy Policy` for details.

## 📄 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 🐛 Known Issues

- AR overlay may drift slightly during rapid camera movement
- Low-contrast text may not be detected accurately
- Offline mode supports limited language pairs

## 🗺️ Roadmap

- [ ] Add more offline language models
- [ ] Implement text-to-speech for translations
- [ ] Add conversation mode
- [ ] Support for handwriting recognition
- [ ] iPad optimization with split view
- [ ] Apple Watch companion app

## 👨‍💻 Author

Your Name - [@yourtwitter](https://twitter.com/yourtwitter)

Project Link: [https://github.com/yourusername/ar-lens-translate](https://github.com/yourusername/ar-lens-translate)

## 🙏 Acknowledgments

- Apple's Vision framework documentation
- SwiftUI tutorials and community
- Translation API providers
- Open source Swift community

## 📞 Support

For support, email your@email.com or open an issue in the GitHub repository.

---

Made with ❤️ and Swift
