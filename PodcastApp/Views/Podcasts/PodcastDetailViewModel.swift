//
//  PodcastDetailViewModel.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import Foundation
import Combine

class PodcastDetailViewModel: ObservableObject {
    @Published var title: String
    @Published var author: String
    @Published var episodes = [Episode]()
    @Published var displayEpisodeList: Bool = false
    @Published var artworkURL: String
    
    init(podcast: Podcast) {
        self.title = podcast.title
        self.author = podcast.author
        self.artworkURL = podcast.artworkURL
        dataManager.getEpisodes(forPodcastID: podcast.id, feedURL: podcast.feedURL) { episodes, error in
            guard error == nil else {
                fatalError(error.debugDescription)
            }
            guard let episodes = episodes else {
                return print("Episodes is empty.")
            }
            self.episodes = episodes
        }
        
        DispatchQueue.main.async {
            self.displayEpisodeList = true
        }
    }
}
