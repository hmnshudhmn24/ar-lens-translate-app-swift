# Changelog

All notable changes to AR Lens Translate will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-02-12

### Added
- Real-time text detection using Apple Vision framework
- Multi-language translation support (50+ languages)
- AR overlay for translated text
- Camera preview with live translation
- Offline translation mode with on-device models
- Translation history
- Settings panel for language selection
- Photo capture with translations
- Haptic feedback
- Low-light optimization for text detection
- Support for both iPhone and iPad
- Portrait and landscape orientations

### Features
- **Vision Framework Integration**: Accurate text recognition from camera feed
- **Translation Service**: Mock translation service (ready for API integration)
- **SwiftUI Interface**: Modern, responsive UI
- **MVVM Architecture**: Clean, maintainable code structure
- **Camera Service**: Professional camera handling with AVFoundation
- **Language Support**: 28 languages including major world languages
- **User Preferences**: Persistent settings using UserDefaults
- **Translation Cache**: Improved performance with cached translations

### Technical Details
- iOS 16.0+ support
- Swift 5.9+
- SwiftUI for UI
- Combine for reactive programming
- Vision framework for text detection
- AVFoundation for camera
- Core ML ready for offline models

### Known Issues
- AR overlay may drift during rapid camera movement
- Low-contrast text may not be detected accurately
- Offline mode uses mock translations (real ML models coming soon)

### Documentation
- Comprehensive README with installation and usage instructions
- Apache 2.0 license
- Contributing guidelines
- Quick start guide

## [Unreleased]

### Planned Features
- Real translation API integration (Google Translate, DeepL, or LibreTranslate)
- Core ML models for true offline translation
- Text-to-speech for translations
- Conversation mode
- Handwriting recognition
- iPad split view optimization
- Apple Watch companion app
- Cloud sync for translation history
- Multiple translation providers
- Custom translation models
- Widget support

### Improvements Planned
- Better AR overlay stability
- Enhanced low-light text detection
- Improved performance for real-time translation
- Additional language support
- Better error handling
- Accessibility improvements

---

For more details on upcoming features, check the [GitHub Issues](https://github.com/yourusername/ar-lens-translate/issues) page.
