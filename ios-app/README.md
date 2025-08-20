# EchoForge iOS App

An iOS application that integrates with the Gemini API via Firebase to generate podcast episodes with preview information and audio content.

## Features

- 📝 **Topic Input**: Users can enter any podcast topic they want to explore
- 🌍 **Multi-language Support**: Supports multiple languages (English, Chinese, Spanish, French, German, Japanese)
- 🎯 **Customizable Parameters**: Set number of episodes and word count per episode
- 🤖 **AI-Powered Generation**: Uses Gemini API through Firebase to generate engaging podcast scripts
- 🎧 **Audio Generation**: Converts generated scripts to audio using Text-to-Speech
- 📱 **Native iOS Experience**: Built with SwiftUI for a modern, responsive interface
- 🎮 **Audio Playback**: Built-in audio player for generated podcast episodes

## Architecture

The app mirrors the structure of the Python CLI tool but adapted for iOS:

### Core Components

- **Models**: Data structures for podcast series, episodes, and generation states
- **Services**: `PodcastService` handles Gemini API integration and audio generation  
- **Utils**: `PromptGenerator` contains the same prompt logic as the Python version
- **Views**: SwiftUI-based user interface with input forms and episode preview

### Key Files

- `PodcastModel.swift` - Data models for podcast content and generation states
- `PromptGenerator.swift` - Swift port of the Python prompt generation logic
- `PodcastService.swift` - Service class for Gemini API integration and workflow orchestration
- `ContentView.swift` - Main SwiftUI interface with input forms and episode display

## Setup Instructions

### Prerequisites

1. **Xcode 15.0 or later**
2. **iOS 17.0 or later**
3. **Firebase Project** with Vertex AI enabled
4. **Gemini API access** through Google Cloud

### Firebase Setup

1. Create a new Firebase project at [https://console.firebase.google.com](https://console.firebase.google.com)
2. Enable the Vertex AI API in your Google Cloud Console
3. Add an iOS app to your Firebase project:
   - Bundle ID: `com.echoforge.app` (or customize in Xcode)
   - Download the `GoogleService-Info.plist` file
4. Replace the placeholder `GoogleService-Info.plist` in the project with your downloaded file

### Xcode Setup

1. Open `EchoForge.xcodeproj` in Xcode
2. Ensure the Bundle Identifier matches your Firebase app configuration
3. Add Firebase SDK dependencies:
   - In Xcode, go to File → Add Package Dependencies
   - Add `https://github.com/firebase/firebase-ios-sdk.git`
   - Select the following packages:
     - FirebaseCore
     - FirebaseVertexAI
     - FirebaseAuth
4. Build and run the project

### API Configuration

The app uses Firebase Vertex AI to access Gemini API. Make sure:

1. Vertex AI API is enabled in your Google Cloud project
2. Your Firebase project has billing enabled (required for Vertex AI)
3. Gemini model access is configured in your Google Cloud Console

## Usage

1. **Enter Topic**: Type in the podcast topic you want to generate content about
2. **Configure Settings**: 
   - Select the language for podcast generation
   - Choose number of episodes (1-10)
   - Set word count per episode (500-5000)
3. **Generate**: Tap "Generate Podcast" to start the AI generation process
4. **Preview Episodes**: View generated episode titles, introductions, and full scripts
5. **Generate Audio**: Tap on any episode to generate and play audio content

## Integration with Existing Python Code

This iOS app reuses the core logic from the Python CLI tool:

- **Prompt Templates**: The `PromptGenerator.swift` contains identical prompt templates to the Python `prompt_generator.py`
- **Generation Workflow**: The sequence of generating episodes mirrors the Python `generate_podcast_series` function
- **Data Structures**: Swift models correspond to the JSON structures used in the Python version
- **API Integration**: Uses the same Gemini API endpoints through Firebase instead of direct Python SDK

## Development Notes

### Current Implementation Status

- ✅ **UI Framework**: Complete SwiftUI interface
- ✅ **Data Models**: All podcast-related data structures
- ✅ **Prompt Generation**: Full port of Python prompt logic
- ⚠️ **API Integration**: Placeholder implementation (needs Firebase Vertex AI integration)
- ⚠️ **Audio Generation**: Placeholder implementation (needs TTS integration)
- ✅ **Audio Playback**: Framework ready for audio player integration

### Production Considerations

To make this app production-ready, you would need to:

1. **Complete Firebase Integration**: Implement actual Vertex AI API calls in `PodcastService.swift`
2. **Audio Implementation**: Integrate Firebase TTS or other audio generation service
3. **Error Handling**: Add comprehensive error handling for network and API failures
4. **Offline Support**: Cache generated content for offline viewing
5. **User Authentication**: Add Firebase Auth for user management
6. **Storage**: Save generated podcasts to device or cloud storage

### Extending the App

The modular architecture makes it easy to:

- Add new languages by extending the language picker
- Implement custom voice selection for TTS
- Add social sharing features for generated podcasts
- Integrate with podcast hosting platforms
- Add user feedback and rating systems

## License

This project follows the same license as the main EchoForge-cli repository.