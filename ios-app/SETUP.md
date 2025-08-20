# EchoForge iOS App Configuration

## Firebase Setup Guide

### 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project
3. Choose a project name (e.g., "EchoForge Podcast Generator")

### 2. Enable Vertex AI

1. In your Firebase project, go to the Google Cloud Console
2. Enable the Vertex AI API
3. Make sure billing is enabled (required for Vertex AI)

### 3. Configure iOS App

1. In Firebase Console, click "Add app" → iOS
2. Enter bundle ID: `com.echoforge.app`
3. Download `GoogleService-Info.plist`
4. Replace the placeholder file in `EchoForge/GoogleService-Info.plist`

### 4. API Configuration

The app uses Firebase Vertex AI to access Gemini API:

- **Model**: `gemini-2.5-pro` for text generation
- **TTS Model**: `gemini-2.5-flash-preview-tts` for audio generation
- **Authentication**: Handled automatically by Firebase SDK

### 5. Xcode Setup

1. Open `EchoForge.xcodeproj`
2. In Project Settings → Package Dependencies, add:
   ```
   https://github.com/firebase/firebase-ios-sdk.git
   ```
3. Select these packages:
   - FirebaseCore
   - FirebaseVertexAI
   - FirebaseAuth

### 6. Test Configuration

Run the setup script to verify everything is configured correctly:

```bash
cd ios-app
./setup.sh
```

## Customization

### Bundle Identifier
If you want to use a different bundle identifier:
1. Update in Xcode project settings
2. Update in Firebase console
3. Re-download GoogleService-Info.plist

### Voice Configuration
To customize TTS voices, modify `GeminiService.swift`:
```swift
speakerVoiceConfigs: [
    SpeakerVoiceConfig(
        speaker: "Speaker1",
        voiceConfig: VoiceConfig(
            prebuiltVoiceConfig: PrebuiltVoiceConfig(
                voiceName: "YourPreferredVoice"
            )
        )
    )
]
```

## Production Considerations

- **Rate Limiting**: Add proper rate limiting for API calls
- **Error Handling**: Implement comprehensive error handling
- **Caching**: Cache generated content locally
- **Analytics**: Add Firebase Analytics for usage tracking
- **Authentication**: Implement user authentication for personalized experience