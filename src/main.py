from generation.generator import generate_podcast_series

def main():
    generate_podcast_series(
        series_topic="AI future",
        language="eng",
        number_of_episodes=2,
        word_count=50
    )

if __name__ == "__main__": 
    main()