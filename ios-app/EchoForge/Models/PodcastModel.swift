import Foundation

// MARK: - Podcast Models

struct PodcastSeries {
    let topic: String
    let language: String
    let numberOfEpisodes: Int
    let wordCount: Int
}

struct PodcastEpisode: Codable, Identifiable {
    let id = UUID()
    let title: String
    let introduction: String
    let script: String
}

struct PodcastResponse: Codable {
    let podcasts: [PodcastEpisode]
}

// MARK: - Generation State

enum PodcastGenerationState {
    case idle
    case generating(progress: Double)
    case completed(episodes: [PodcastEpisode])
    case failed(Error)
}

// MARK: - Audio State

enum AudioState {
    case idle
    case generating
    case ready(Data)
    case playing
    case failed(Error)
}