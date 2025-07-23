from generation.script_generator import set_podcast_series_args, generate_script

def main():
    # Example usage
    set_podcast_series_args(
        series_topic="The Future of AI",
        language="eng",
        number_of_episodes=5,
        word_count=1000
    )
    
    for episode in range(1, 6):
        script = generate_script(episode)
        print(f"Episode {episode} Script:\n{script}\n")
        print("=" * 40)

if __name__ == "__main__": 
    main()