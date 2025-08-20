# EchoForge-cli
![logo](logo.png)

EchoForge can automatically generate a podcast series based on a given topic, including scripts and audio files. It uses the Gemini API for text generation and includes both a Python CLI tool and an iOS mobile app.

## Features

- 🎙️ **AI-Powered Podcast Generation**: Create engaging multi-episode podcast series
- 🌍 **Multi-language Support**: Generate content in multiple languages  
- 🎧 **Audio Generation**: Convert scripts to speech using TTS
- 📱 **Cross-Platform**: Python CLI tool + iOS mobile app
- 🤖 **Gemini API Integration**: Leverages Google's latest AI models

## Usage

### Python CLI Tool

1. **Set Up Environment**: Ensure you have Python installed and set up a virtual environment.
2. **Set API Key**: Run `export GEMINI_API_KEY="your_gemini_api_key"` to set the Gemini API key. [Google AI Document](https://ai.google.dev/gemini-api/docs/api-key)
3. **Install Dependencies**: Run `pip install -r requirements.txt` to install the necessary packages.
4. **Run the Script**: Execute the script with `python src/main.py`.

### iOS Mobile App

The iOS app provides a native mobile interface for podcast generation:

1. **Setup**: Follow the setup instructions in `ios-app/README.md`
2. **Configure Firebase**: Set up Firebase project with Vertex AI enabled
3. **Generate Podcasts**: Use the intuitive SwiftUI interface to create podcast episodes

See the [iOS App Documentation](ios-app/README.md) for detailed setup and usage instructions.

## Project Structure

```
EchoForge-cli/
├── src/                    # Python CLI tool
│   ├── generation/         # Core generation logic
│   ├── prompt/            # Prompt templates
│   └── main.py           # Entry point
├── ios-app/               # iOS mobile app
│   ├── EchoForge/         # SwiftUI app source
│   │   ├── Models/        # Data models
│   │   ├── Services/      # API integration
│   │   ├── Utils/         # Prompt generation
│   │   └── Views/         # SwiftUI interface
│   └── README.md         # iOS setup guide
└── requirements.txt       # Python dependencies
```

## TODOs
- [x] iOS app with Firebase/Gemini integration
- [x] Cross-platform prompt template sharing
- [ ] Audio generation using TTS (Text-to-Speech) services
- [ ] Web-based UI for broader accessibility
- [ ] Podcast hosting platform integration