//
//  EpisodeRowViewModel.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 30/11/20.
//

import Foundation
import Combine

class EpisodeRowViewModel: ObservableObject {
    var podcastID: Int
    var episodeID: String
    
    @Published var title: String
    @Published var pubDate: String
    @Published var duration: String
    @Published var isAvailableOffline: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var displayAlert: Bool = false
    
    init(episode: Episode) {
        self.podcastID = episode.podcastID
        self.episodeID = episode.id
        
        self.title = episode.title
        self.pubDate = episode.pubDate?.asFullString().uppercased() ?? "-"
        self.duration = episode.duration.toDisplayString()
        self.isAvailableOffline = episode.localFilePath != nil
    }
    
    func play() {
        do {
            try dataManager.playEpisode(byID: episodeID, podcastID: podcastID)
        } catch DataManagerError.podcastIDNotFound {
            displayPodcastIDNotFoundAlert()
        } catch DataManagerError.episodeIDNotFound {
            displayEpisodeIDNotFoundAlert()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Error messages
    
    private func displayPodcastIDNotFoundAlert() {
        self.alertTitle = "Podcast ID Not Found"
        self.alertMessage = "PodcastApp could not find a podcast with the specified podcast ID."
        self.displayAlert = true
    }
    
    private func displayEpisodeIDNotFoundAlert() {
        self.alertTitle = "Episode ID Not Found"
        self.alertMessage = "PodcastApp could not find an episode with the specified episode ID."
        self.displayAlert = true
    }
}
