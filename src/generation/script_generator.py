from google import genai
from prompt.prompt_generator import create_initial_prompt_string, create_follow_up_prompt_string

client = genai.Client()

def set_podcast_series_args(series_topic: str, language: str, number_of_episodes: int, word_count: int) -> None:
    global podcast_series_args
    podcast_series_args = {
        "series_topic": series_topic,
        "language": language,
        "number_of_episodes": number_of_episodes,
        "word_count": word_count
    }

def generate_script(order) -> str:
    """
    Generates a podcast script based on the current episode order.
    
    Args:
        order (int): The current episode number in the series.
        
    Returns:
        str: The generated podcast script.
    """
    if order == 1:
        prompt = create_initial_prompt_string(
            series_topic=podcast_series_args["series_topic"],
            language=podcast_series_args["language"],
            number_of_episodes=podcast_series_args["number_of_episodes"],
            word_count=podcast_series_args["word_count"]
        )
    else:
        prompt = create_follow_up_prompt_string(
            current_episode_number=order,
            number_of_episodes=podcast_series_args["number_of_episodes"],
            language=podcast_series_args["language"],
            word_count=podcast_series_args["word_count"]
        )

    response = client.models.generate_content(
        model="gemini-2.5-flash",
        contents=prompt,
    )
    
    return response.text

if __name__ == "__main__":
    # Example usage
    set_podcast_series_args(
        series_topic="The Future of AI",
        language="eng",
        number_of_episodes=5,
        word_count=1000
    )
    
    for episode in range(1, podcast_series_args["number_of_episodes"] + 1):
        script = generate_script(episode)
        print(f"Episode {episode} Script:\n{script}\n")
        print("=" * 40)