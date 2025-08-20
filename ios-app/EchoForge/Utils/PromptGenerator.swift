import Foundation

struct PromptGenerator {
    
    /// Generates the initial prompt for the first episode of a podcast series
    /// Mirrors the Python `create_initial_prompt_string` function
    static func createInitialPrompt(
        seriesTopic: String,
        language: String,
        numberOfEpisodes: Int,
        wordCount: Int
    ) -> String {
        return """
You are an expert podcast series producer AI. Your task is to plan and generate a multi-part podcast series.

The series will have a total of \(numberOfEpisodes) episodes. Plan a logical arc for the series where each episode builds upon the previous one, exploring the topic in stages.

Your first task is to generate Part 1 of the series.

The podcast must be generated in the language specified by this ISO 639-2 code: \(language)

The script's total word count should be approximately \(wordCount) words.

The title you generate MUST indicate the episode number. For example: "Your Title - Part 1 of \(numberOfEpisodes)".

Your entire response MUST be a single, valid JSON object and nothing else.

The JSON object must follow this exact structure:
{
  "podcasts": [
    {
      "title": "The title for this specific episode, including its part number.",
      "introduction": "A brief, engaging introduction to this episode.",
      "script": "The full podcast script as a single string. It must contain dialogue for two speakers, labeled '[SPEAKER0]' and '[SPEAKER1]'. Each line of dialogue must start with the speaker's label,like '[SPEAKER0]Dad, we're pals, right?[SPEAKER1]Right.' and use \\n to separate lines."
    }
  ]
}

Here is the overarching topic for the series:
\(seriesTopic)
"""
    }
    
    /// Generates follow-up prompts for subsequent episodes
    /// Mirrors the Python `create_follow_up_prompt_string` function
    static func createFollowUpPrompt(
        currentEpisodeNumber: Int,
        numberOfEpisodes: Int,
        language: String,
        wordCount: Int
    ) -> String {
        return """
Excellent, that was Part \(currentEpisodeNumber - 1) of \(numberOfEpisodes).

Now, generate the next episode: Part \(currentEpisodeNumber) of the series.

Ensure this new episode has strong continuity. The introduction or the first few lines of dialogue should reference what was discussed in the previous episode, and then advance the topic to the next stage.

Remember to follow all the same rules:
- Language (ISO 639-2): \(language)
- Script Word Count: Approximately \(wordCount) words
- Title: Must be updated to show it is Part \(currentEpisodeNumber)
The JSON object must follow this exact structure:
{
  "podcasts": [
    {
      "title": "The title for this specific episode, including its part number.",
      "introduction": "A brief, engaging introduction to this episode.",
      "script": "The full podcast script as a single string. It must contain dialogue for two speakers, labeled '[SPEAKER0]' and '[SPEAKER1]'. Each line of dialogue must start with the speaker's label,like '[SPEAKER0]Dad, we're pals, right?[SPEAKER1]Right.' and use \\n to separate lines."
    }
  ]
}
"""
    }
}