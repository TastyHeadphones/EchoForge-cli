import SwiftUI

struct ContentView: View {
    @StateObject private var podcastService = PodcastService()
    
    // Input fields
    @State private var topic = ""
    @State private var language = "eng"
    @State private var numberOfEpisodes = 1
    @State private var wordCount = 1000
    
    // UI state
    @State private var selectedEpisode: PodcastEpisode?
    @State private var showingEpisodeDetail = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                headerView
                
                if case .idle = podcastService.generationState {
                    inputFormView
                } else {
                    generationStateView
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("EchoForge")
        }
        .sheet(isPresented: $showingEpisodeDetail) {
            if let episode = selectedEpisode {
                EpisodeDetailView(episode: episode, audioState: podcastService.audioState) {
                    podcastService.generateAudio(for: episode)
                } onPlayAudio: {
                    podcastService.playAudio()
                }
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 10) {
            Image(systemName: "mic.badge.plus")
                .font(.system(size: 60))
                .foregroundColor(.purple)
            
            Text("AI Podcast Generator")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Create engaging podcast episodes with AI")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
    }
    
    private var inputFormView: some View {
        VStack(alignment: .leading, spacing: 15) {
            Group {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Podcast Topic")
                        .font(.headline)
                    TextField("Enter your podcast topic...", text: $topic, axis: .vertical)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .lineLimit(3, reservesSpace: true)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Language")
                        .font(.headline)
                    Picker("Language", selection: $language) {
                        Text("English").tag("eng")
                        Text("Chinese").tag("zh")
                        Text("Spanish").tag("spa")
                        Text("French").tag("fra")
                        Text("German").tag("deu")
                        Text("Japanese").tag("jpn")
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Episodes")
                            .font(.headline)
                        Stepper("\(numberOfEpisodes)", value: $numberOfEpisodes, in: 1...10)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Words per Episode")
                            .font(.headline)
                        Stepper("\(wordCount)", value: $wordCount, in: 500...5000, step: 250)
                    }
                }
            }
            
            Button(action: generatePodcast) {
                HStack {
                    Image(systemName: "waveform")
                    Text("Generate Podcast")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(topic.isEmpty ? Color.gray : Color.purple)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .disabled(topic.isEmpty)
        }
    }
    
    private var generationStateView: some View {
        VStack(spacing: 20) {
            switch podcastService.generationState {
            case .generating(let progress):
                VStack(spacing: 10) {
                    ProgressView(value: progress)
                        .progressViewStyle(LinearProgressViewStyle())
                    
                    Text("Generating episode \(Int(progress * Double(numberOfEpisodes)) + 1) of \(numberOfEpisodes)...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Button("Cancel") {
                        podcastService.generationState = .idle
                    }
                    .foregroundColor(.red)
                }
                
            case .completed(let episodes):
                VStack(spacing: 15) {
                    Text("✅ Generation Complete!")
                        .font(.headline)
                        .foregroundColor(.green)
                    
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(episodes) { episode in
                                EpisodeRowView(episode: episode) {
                                    selectedEpisode = episode
                                    showingEpisodeDetail = true
                                }
                            }
                        }
                    }
                    
                    Button("Generate New Podcast") {
                        resetForm()
                    }
                    .foregroundColor(.purple)
                }
                
            case .failed(let error):
                VStack(spacing: 10) {
                    Text("❌ Generation Failed")
                        .font(.headline)
                        .foregroundColor(.red)
                    
                    Text(error.localizedDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    Button("Try Again") {
                        resetForm()
                    }
                    .foregroundColor(.purple)
                }
                
            case .idle:
                EmptyView()
            }
        }
    }
    
    private func generatePodcast() {
        podcastService.generatePodcastSeries(
            topic: topic,
            language: language,
            numberOfEpisodes: numberOfEpisodes,
            wordCount: wordCount
        )
    }
    
    private func resetForm() {
        podcastService.generationState = .idle
        topic = ""
        numberOfEpisodes = 1
        wordCount = 1000
    }
}

struct EpisodeRowView: View {
    let episode: PodcastEpisode
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 5) {
                Text(episode.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                Text(episode.introduction)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
    }
}

struct EpisodeDetailView: View {
    let episode: PodcastEpisode
    let audioState: AudioState
    let onGenerateAudio: () -> Void
    let onPlayAudio: () -> Void
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(episode.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Introduction")
                        .font(.headline)
                    Text(episode.introduction)
                        .font(.body)
                    
                    Text("Script")
                        .font(.headline)
                    Text(formatScript(episode.script))
                        .font(.body)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    audioControlsView
                }
                .padding()
            }
            .navigationTitle("Episode Details")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done") {
                // Dismiss modal
            })
        }
    }
    
    private var audioControlsView: some View {
        VStack(spacing: 10) {
            Text("Audio")
                .font(.headline)
            
            switch audioState {
            case .idle:
                Button(action: onGenerateAudio) {
                    HStack {
                        Image(systemName: "waveform")
                        Text("Generate Audio")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                
            case .generating:
                HStack {
                    ProgressView()
                        .scaleEffect(0.8)
                    Text("Generating audio...")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                
            case .ready(_):
                Button(action: onPlayAudio) {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Play Audio")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                
            case .playing:
                HStack {
                    Image(systemName: "speaker.wave.2.fill")
                    Text("Playing...")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
            case .failed(let error):
                VStack {
                    Text("Audio generation failed")
                        .foregroundColor(.red)
                    Text(error.localizedDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    private func formatScript(_ script: String) -> String {
        // Format the script to be more readable
        return script
            .replacingOccurrences(of: "[SPEAKER0]", with: "\n🎙️ Speaker 1: ")
            .replacingOccurrences(of: "[SPEAKER1]", with: "\n🎙️ Speaker 2: ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

#Preview {
    ContentView()
}