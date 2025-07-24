import json
import os
import time
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
    info_file_path = os.path.join(output_dir, "series_info.txt")
    if not os.path.exists(info_file_path):
        with open(info_file_path, 'w') as info_file:
            info_file.write(f"Series Topic: {series_topic}\n")
            info_file.write(f"Language: {language}\n")
            info_file.write(f"Number of Episodes: {number_of_episodes}\n")
            info_file.write(f"Word Count per Episode: {word_count}\n")

    for episode in range(1, number_of_episodes + 1):
        info = generate_script(episode)
        # sleep 30seconds to avoid rate limit issues
        time.sleep(10)
        unifyng_info = info[7:-3]
        print(f"Episode {episode} Script:\n{unifyng_info}\n")
        
        info_json = json.loads(unifyng_info)
        title = info_json['podcasts'][0]['title']
        introduction = info_json['podcasts'][0]['introduction']
        script = info_json['podcasts'][0]['script']
        
        # Save the script to a text file
        with open(info_file_path, 'a') as info_file:
            info_file.write(f"---\n")
            info_file.write(f"Episode {episode}:\n")
            info_file.write(f"Title: {title}\n")
            info_file.write(f"Introduction: {introduction}\n")
        
        # Generate relative path for audio file
        script_filename = os.path.join(output_dir, f"{title}.txt")
        with open(script_filename, 'w', encoding='utf-8') as script_file:
            script_file.write(script)
        audio_filename = os.path.join(output_dir, f"{title}.wav")
        generate_audio_file(audio_filename, script)
        time.sleep(10)  # Sleep to avoid rate limit issues
        
        print(f"Audio file for Episode {episode} generated: {audio_filename}\n")
        print("=" * 40)
