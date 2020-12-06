//
//  EpisodeRowViewModel.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 30/11/20.
//

import Combine
import Foundation

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
        podcastID = episode.podcastID
        episodeID = episode.id

        title = episode.title
        pubDate = episode.pubDate?.asFullString().uppercased() ?? "-"
        duration = episode.duration.toDisplayString()
        isAvailableOffline = episode.localFilePath != nil
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
        alertTitle = "Podcast ID Not Found"
        alertMessage = "PodcastApp could not find a podcast with the specified podcast ID."
        displayAlert = true
    }

    private func displayEpisodeIDNotFoundAlert() {
        alertTitle = "Episode ID Not Found"
        alertMessage = "PodcastApp could not find an episode with the specified episode ID."
        displayAlert = true
    }
}
