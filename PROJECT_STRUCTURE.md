# Project Structure

This document explains the organization and architecture of the AR Lens Translate project.

## Directory Structure

```
ar-lens-translate/
├── README.md                      # Main project documentation
├── LICENSE                        # Apache 2.0 license
├── CONTRIBUTING.md               # Contribution guidelines
├── QUICKSTART.md                 # Quick start guide
├── CHANGELOG.md                  # Version history
├── .gitignore                    # Git ignore rules
│
└── ARLensTranslate/              # Xcode project
    ├── ARLensTranslate.xcodeproj/
    │   └── project.pbxproj       # Xcode project file
    │
    └── ARLensTranslate/          # Source code
        ├── Info.plist            # App configuration
        │
        ├── App/                  # App entry point
        │   └── ARLensTranslateApp.swift
        │
        ├── Views/                # SwiftUI Views
        │   ├── ContentView.swift
        │   ├── CameraView.swift
        │   └── SettingsView.swift
        │
        ├── ViewModels/           # View Models (MVVM)
        │   └── CameraViewModel.swift
        │
        ├── Models/               # Data Models
        │   ├── Language.swift
        │   └── DetectedText.swift
        │
        ├── Services/             # Business Logic
        │   ├── TextDetectionService.swift
        │   ├── TranslationService.swift
        │   └── CameraService.swift
        │
        ├── Utilities/            # Helper files
        │   └── Extensions.swift
        │
        └── Assets.xcassets/      # App assets
            ├── AppIcon.appiconset/
            └── AccentColor.colorset/
```

## Architecture

The app follows the **MVVM (Model-View-ViewModel)** architecture pattern:

### Models
**Purpose**: Define data structures

- `Language.swift`: Language model with 28+ supported languages
- `DetectedText.swift`: Represents detected text with bounding box and translation
- `TranslationResult.swift`: Translation response model
- `SavedTranslation.swift`: Persistent translation history

### Views
**Purpose**: User interface components

- `ContentView.swift`: Main container view with language selector and controls
- `CameraView.swift`: Camera preview with AR overlay
- `TranslationOverlayView.swift`: AR translation bubbles
- `SettingsView.swift`: Settings and configuration
- `HistoryView.swift`: Translation history

### ViewModels
**Purpose**: Business logic and state management

- `CameraViewModel.swift`: Manages camera, text detection, and translation
- Connects services with views
- Handles state updates and user actions

### Services
**Purpose**: Core functionality

- `CameraService.swift`: AVFoundation camera handling
- `TextDetectionService.swift`: Vision framework text detection
- `TranslationService.swift`: Translation API integration (mock + real)
- Separation of concerns for testability

### Utilities
**Purpose**: Helper functions and extensions

- `Extensions.swift`: View, Color, UIImage, String, Date, CGRect extensions
- Reusable utility functions

## Key Technologies

### Apple Frameworks
- **SwiftUI**: Modern declarative UI
- **Vision**: Text detection and recognition
- **AVFoundation**: Camera capture and processing
- **Combine**: Reactive programming
- **Core ML**: (Ready for) On-device ML models

### Third-Party (Future)
- Translation API (Google Translate, DeepL, or LibreTranslate)
- Analytics (optional)

## Data Flow

1. **Camera Capture**
   - `CameraService` captures video frames
   - Frames passed to `TextDetectionService`

2. **Text Detection**
   - Vision framework detects text regions
   - Returns `DetectedText` objects with bounding boxes

3. **Translation**
   - `TranslationService` translates detected text
   - Results cached for performance

4. **UI Update**
   - `CameraViewModel` updates published properties
   - SwiftUI views automatically re-render
   - Translation bubbles appear over detected text

## State Management

### App State
- Global app state managed by `AppState` class
- Language preferences
- Offline mode setting
- Translation history
- Persisted to UserDefaults

### View State
- Camera state in `CameraViewModel`
- Real-time updates via `@Published` properties
- Reactive UI updates via Combine

## Features Overview

### ✅ Implemented
- Real-time text detection
- Mock translation service
- Camera preview
- AR overlay
- Language selection
- Settings
- History

### 🚧 Ready for Integration
- Real translation API (just needs API key)
- Core ML models (structure ready)
- Photo saving
- Sharing

### 📝 Planned
- Text-to-speech
- Conversation mode
- Handwriting recognition
- Widget support
- Watch app

## Testing Strategy

### Unit Tests (Recommended)
- Test `TranslationService` translation logic
- Test `Language` model methods
- Test `DetectedText` creation

### UI Tests (Recommended)
- Test language selection
- Test settings navigation
- Test camera permissions flow

### Integration Tests
- Test full translation flow
- Test offline mode
- Test caching

## Performance Considerations

1. **Camera Processing**
   - Process frames at 0.5s intervals (configurable)
   - Avoid processing every frame to prevent battery drain

2. **Translation Caching**
   - NSCache for in-memory translation cache
   - Reduces redundant API calls

3. **Memory Management**
   - Weak references in closures
   - Proper cleanup on view disappear

## Security & Privacy

1. **Camera Permissions**
   - Requested on first launch
   - Clear usage description in Info.plist

2. **Translation Privacy**
   - Online mode: text sent to API
   - Offline mode: all processing on-device
   - No analytics or tracking

3. **Photo Library**
   - Permission for saving translated images
   - User has full control

## Customization Points

### Adding Languages
Edit `Language.swift` to add new languages to `allLanguages` array

### Changing Translation Provider
Modify `TranslationService.swift` to integrate your preferred API

### Styling
Edit color schemes in `Extensions.swift` or use SwiftUI's color assets

### AR Overlay Appearance
Modify `TranslationBubble` view in `CameraView.swift`

## Build Configurations

### Debug
- Full logging enabled
- Debug symbols included
- No optimization

### Release
- Optimized for performance
- Stripped debug symbols
- Ready for App Store

## Deployment

### Requirements
- iOS 16.0+
- Xcode 15.0+
- Valid Apple Developer account

### Steps
1. Update bundle identifier
2. Configure signing certificate
3. Build for archive
4. Submit to App Store Connect

## Troubleshooting

### Common Issues

**Build Errors**
- Clean build folder
- Delete derived data
- Check deployment target

**Runtime Issues**
- Check camera permissions
- Verify Info.plist entries
- Check console logs

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:
- Code style
- Pull request process
- Issue reporting

## License

Apache License 2.0 - See [LICENSE](LICENSE) file

---

**Need Help?**
- Check the [README](README.md)
- See [QUICKSTART](QUICKSTART.md)
- Open an [Issue](https://github.com/yourusername/ar-lens-translate/issues)
