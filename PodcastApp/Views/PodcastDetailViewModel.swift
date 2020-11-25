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
    @Published var episodes: [Episode]?
    @Published var feedIsEmpty: Bool
    
    init(podcast: Podcast) {
        self.title = podcast.title
        self.author = podcast.author
        self.feedIsEmpty = podcast.episodes != nil
        do {
            self.episodes = try FeedHelper.getEpisodeList(feedURL: podcast.rssFeedURL)
        } catch {
            print(error.localizedDescription)
        }
    }
}
