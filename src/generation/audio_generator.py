from google import genai
from google.genai import types
import wave

def generate_audio_data(script: str) -> bytes:
    audio_client = genai.Client()
    prompt = f"TTS the following conversation between Speaker1 and Speaker2:\n{script}"
    response = audio_client.models.generate_content(
   model="gemini-2.5-flash-preview-tts",
   contents=prompt,
   config=types.GenerateContentConfig(
      response_modalities=["AUDIO"],
      speech_config=types.SpeechConfig(
         multi_speaker_voice_config=types.MultiSpeakerVoiceConfig(
            speaker_voice_configs=[
               types.SpeakerVoiceConfig(
                  speaker='Speaker1',
                  voice_config=types.VoiceConfig(
                     prebuilt_voice_config=types.PrebuiltVoiceConfig(
                        voice_name='Kore',
                     )
                  )
               ),
               types.SpeakerVoiceConfig(
                  speaker='Speaker2',
                  voice_config=types.VoiceConfig(
                     prebuilt_voice_config=types.PrebuiltVoiceConfig(
                        voice_name='Puck',
                     )
                  )
               ),
            ]
         )
      )
   )
)
    return response.candidates[0].content.parts[0].inline_data.data

def generate_audio_file(filename: str, script: str) -> None:
    audio_data = generate_audio_data(script)
    with wave.open(filename, 'wb') as audio_file:
        audio_file.setnchannels(1)
        audio_file.setsampwidth(2)
        audio_file.setframerate(24000)
        audio_file.writeframes(audio_data)
    print(f"Audio file '{filename}' generated successfully.")

if __name__ == "__main__":
    # Example usage
    script = "Speaker1: Hello, how are you?\nSpeaker2: I'm fine, thank you!"
    generate_audio_file("output.wav", script)