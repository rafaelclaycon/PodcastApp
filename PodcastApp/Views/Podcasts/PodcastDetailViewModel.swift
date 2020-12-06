//
//  PodcastDetailViewModel.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import Combine
import Foundation

class PodcastDetailViewModel: ObservableObject {
    @Published var artworkURL: String
    @Published var displayEpisodeList: Bool = false
    @Published var episodes = [Episode]()

    init(podcast: Podcast) {
        artworkURL = podcast.artworkURL
        dataManager.getEpisodes(forPodcastID: podcast.id, feedURL: podcast.feedURL) { episodes, error in
            guard error == nil else {
                fatalError(error.debugDescription)
            }
            guard let episodes = episodes else {
                return print("Episodes is empty.")
            }
            self.episodes = episodes
            
            DispatchQueue.main.async {
                self.displayEpisodeList = episodes.count > 0
            }
        }
    }
}
