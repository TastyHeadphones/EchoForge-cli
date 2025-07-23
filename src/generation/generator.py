import json
import os
from .audio_generator import generate_audio_file
from .script_generator import set_podcast_series_args, generate_script

def generate_podcast_series(series_topic: str, language: str, number_of_episodes: int, word_count: int) -> None:
    """
    Generates a complete podcast series with scripts and audio files.

    Args:
        series_topic (str): The overarching topic for the entire podcast series.
        language (str): The desired language specified as a three-letter ISO 639-2 code.
        number_of_episodes (int): The total number of episodes in the series.
        word_count (int): The approximate word count for each episode's script.
    """
    set_podcast_series_args(series_topic, language, number_of_episodes, word_count)
    
    # Create a directory for the series topic if it doesn't exist
    
    output_dir = "podcast_series"
    
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    for episode in range(1, number_of_episodes + 1):
        info = generate_script(episode)
        unifyng_info = info[7:-3]
        print(f"Episode {episode} Script:\n{unifyng_info}\n")
        
        info_json = json.loads(unifyng_info)
        title = info_json['podcasts'][0]['title']
        script = info_json['podcasts'][0]['script']
        
        # Generate relative path for audio file
        audio_filename = os.path.join(output_dir, f"{title}.wav")
        generate_audio_file(audio_filename, script)
        
        print(f"Audio file for Episode {episode} generated: {audio_filename}\n")
        print("=" * 40)
