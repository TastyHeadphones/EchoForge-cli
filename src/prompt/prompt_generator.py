def create_initial_prompt_string(series_topic: str, language: str, number_of_episodes: int, word_count: int) -> str:
    """
    Generates a string containing the initial prompt for the AI podcast generator (Part 1).

    Args:
        series_topic (str): The overarching topic for the entire podcast series.
        language (str): The desired language specified as a three-letter ISO 639-2 code (e.g., 'eng').
        number_of_episodes (int): The total number of episodes in the series.
        word_count (int): The approximate word count for each episode's script.

    Returns:
        str: The fully formatted initial prompt string.
    """
    
    # The template for the initial prompt (Part 1).
    initial_prompt_template = f"""
You are an expert podcast series producer AI. Your task is to plan and generate a multi-part podcast series.

The series will have a total of {number_of_episodes} episodes. Plan a logical arc for the series where each episode builds upon the previous one, exploring the topic in stages.

Your first task is to generate Part 1 of the series.

The podcast must be generated in the language specified by this ISO 639-2 code: {language}

The script's total word count should be approximately {word_count} words.

The title you generate MUST indicate the episode number. For example: "Your Title - Part 1 of {number_of_episodes}".

Your entire response MUST be a single, valid JSON object and nothing else.

The JSON object must follow this exact structure:
{{
  "podcasts": [
    {{
      "title": "The title for this specific episode, including its part number.",
      "introduction": "A brief, engaging introduction to this episode.",
      "script": "The full podcast script as a single string. It must contain dialogue for two speakers, labeled 'Speaker 1' and 'Speaker 2'. Each line of dialogue must start with the speaker's label and be separated by a newline character (\n)."
    }}
  ]
}}

Here is the overarching topic for the series:
{series_topic}
"""
    return initial_prompt_template.strip()

def create_follow_up_prompt_string(current_episode_number: int, number_of_episodes: int, language: str, word_count: int) -> str:
    """
    Generates a string containing a follow-up prompt for subsequent episodes.

    Args:
        current_episode_number (int): The number of the episode this prompt is for (e.g., 2, 3, ...).
        number_of_episodes (int): The total number of episodes in the series.
        language (str): The desired language specified as a three-letter ISO 639-2 code.
        word_count (int): The approximate word count for the script.
        
    Returns:
        str: The fully formatted follow-up prompt string.
    """
    
    # The template for follow-up prompts (Parts 2, 3, etc.).
    follow_up_prompt_template = f"""
Excellent, that was Part {current_episode_number - 1} of {number_of_episodes}.

Now, generate the next episode: Part {current_episode_number} of the series.

Ensure this new episode has strong continuity. The introduction or the first few lines of dialogue should reference what was discussed in the previous episode, and then advance the topic to the next stage.

Remember to follow all the same rules:
- Language (ISO 639-2): {language}
- Script Word Count: Approximately {word_count} words
- Title: Must be updated to show it is Part {current_episode_number}
The JSON object must follow this exact structure:
{{
  "podcasts": [
    {{
      "title": "The title for this specific episode, including its part number.",
      "introduction": "A brief, engaging introduction to this episode.",
      "script": "The full podcast script as a single string. It must contain dialogue for two speakers, labeled 'Speaker 1' and 'Speaker 2'. Each line of dialogue must start with the speaker's label and be separated by a newline character (\n)."
    }}
  ]
}}
"""
    return follow_up_prompt_template.strip()


# --- Example Usage ---
if __name__ == "__main__":
    # --- Configuration for the Podcast Series ---
    series_topic = "A Journey Through the Silk Road"
    lang_code = "eng"
    total_episodes = 3
    words_per_episode = 350

    # --- Generate and print the Initial Prompt (Part 1) ---
    initial_prompt = create_initial_prompt_string(series_topic, lang_code, total_episodes, words_per_episode)
    print("--- PROMPT FOR PART 1 ---")
    print(initial_prompt)
    
    print("\n" + "="*40 + "\n")

    # --- Generate and print all Follow-Up Prompts (Part 2 onwards) ---
    if total_episodes > 1:
        for i in range(2, total_episodes + 1):
            follow_up_prompt = create_follow_up_prompt_string(i, total_episodes, lang_code, words_per_episode)
            print(f"--- PROMPT FOR PART {i} ---")
            print(follow_up_prompt)
            if i < total_episodes:
                print("\n" + "="*40 + "\n")