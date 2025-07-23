# EchoForge-cli
![logo](logo.png)

EchoForge can automatically generate a podcast series based on a given topic, including scripts and audio files. It uses the Gemini API for text generation and ElevenLabs for audio synthesis.

# Usage
1. **Set Up Environment**: Ensure you have Python installed and set up a virtual environment.
2. **Set API Key**: Run `export GEMINI_API_KEY="your_gemini_api_key"` to set the Gemini API key. [Google AI Document](https://ai.google.dev/gemini-api/docs/api-key)
3. **Install Dependencies**: Run `pip install -r requirements.txt` to install the necessary packages.
4. **Run the Script**: Execute the script with `python src/main.py`.

# TODOs
- [ ] Audio generation using TTS (Text-to-Speech) services.
- [ ] UI for easier interaction.