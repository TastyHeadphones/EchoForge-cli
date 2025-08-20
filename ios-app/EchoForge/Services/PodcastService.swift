import Foundation
import Combine

class PodcastService: ObservableObject {
    @Published var generationState: PodcastGenerationState = .idle
    @Published var audioState: AudioState = .idle
    
    private var cancellables = Set<AnyCancellable>()
    private var currentSeries: PodcastSeries?
    private var generatedEpisodes: [PodcastEpisode] = []
    private let geminiService = GeminiService()
    
    // MARK: - Podcast Generation
    
    /// Generates a complete podcast series
    /// Mirrors the Python `generate_podcast_series` function
    func generatePodcastSeries(
        topic: String,
        language: String,
        numberOfEpisodes: Int,
        wordCount: Int
    ) {
        let series = PodcastSeries(
            topic: topic,
            language: language,
            numberOfEpisodes: numberOfEpisodes,
            wordCount: wordCount
        )
        
        self.currentSeries = series
        self.generatedEpisodes = []
        self.generationState = .generating(progress: 0)
        
        generateEpisodesSequentially(series: series, currentEpisode: 1)
    }
    
    private func generateEpisodesSequentially(series: PodcastSeries, currentEpisode: Int) {
        guard currentEpisode <= series.numberOfEpisodes else {
            // All episodes generated
            self.generationState = .completed(episodes: generatedEpisodes)
            return
        }
        
        let prompt: String
        if currentEpisode == 1 {
            prompt = PromptGenerator.createInitialPrompt(
                seriesTopic: series.topic,
                language: series.language,
                numberOfEpisodes: series.numberOfEpisodes,
                wordCount: series.wordCount
            )
        } else {
            prompt = PromptGenerator.createFollowUpPrompt(
                currentEpisodeNumber: currentEpisode,
                numberOfEpisodes: series.numberOfEpisodes,
                language: series.language,
                wordCount: series.wordCount
            )
        }
        
        generateScript(prompt: prompt)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.generationState = .failed(error)
                    }
                },
                receiveValue: { episode in
                    self.generatedEpisodes.append(episode)
                    let progress = Double(currentEpisode) / Double(series.numberOfEpisodes)
                    self.generationState = .generating(progress: progress)
                    
                    // Continue with next episode after a delay to avoid rate limits
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        self.generateEpisodesSequentially(series: series, currentEpisode: currentEpisode + 1)
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    /// Generates a single script using Gemini API
    /// Mirrors the Python `generate_script` function
    private func generateScript(prompt: String) -> AnyPublisher<PodcastEpisode, Error> {
        return geminiService.generateContent(prompt: prompt)
            .tryMap { responseText in
                // Parse the JSON response
                guard let data = responseText.data(using: .utf8) else {
                    throw PodcastServiceError.invalidResponse
                }
                
                let podcastResponse = try JSONDecoder().decode(PodcastResponse.self, from: data)
                
                guard let episode = podcastResponse.podcasts.first else {
                    throw PodcastServiceError.invalidResponse
                }
                
                return episode
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Audio Generation
    
    /// Generates audio for a given script
    /// Integrates with Gemini TTS API through Firebase
    func generateAudio(for episode: PodcastEpisode) {
        self.audioState = .generating
        
        geminiService.generateAudio(script: episode.script)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.audioState = .failed(error)
                    }
                },
                receiveValue: { audioData in
                    self.audioState = .ready(audioData)
                }
            )
            .store(in: &cancellables)
    }
    
    func playAudio() {
        if case .ready(_) = audioState {
            self.audioState = .playing
            // Implement audio playback here
        }
    }
}

// MARK: - Errors

enum PodcastServiceError: LocalizedError {
    case invalidResponse
    case networkError
    case apiKeyMissing
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from API"
        case .networkError:
            return "Network error occurred"
        case .apiKeyMissing:
            return "API key is missing"
        }
    }
}