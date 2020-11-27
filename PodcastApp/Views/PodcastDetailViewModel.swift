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
    @Published var artworkURL: String
    
    init(podcast: Podcast) {
        self.title = podcast.title
        self.author = podcast.author
        self.feedIsEmpty = podcast.episodes != nil
        self.artworkURL = podcast.artworkURL
        
        FeedHelper.fetchEpisodeList(feedURL: podcast.feedURL) { result, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            
            switch result {
            case .success(let feed):
                guard let feed = feed.rssFeed else {
                    fatalError("Not an RSS Feed.")
                }
                guard let items = feed.items else {
                    fatalError("Empty feed.")
                }
                
                DispatchQueue.main.async {
                    for item in items {
                        self.episodes?.append(FeedHelper.getEpisodeFrom(rssFeedItem: item))
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            case .none:
                fatalError("None")
            }
        }
    }
}
