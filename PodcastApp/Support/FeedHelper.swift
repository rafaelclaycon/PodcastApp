//
//  FeedParser.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import Foundation
import FeedKit

class FeedHelper {
    static func getEpisodeList(feedURL: String) throws -> [Episode] {
        guard feedURL != "" else {
            throw FeedParserError.emptyURL
        }
        
        var episodes = [Episode]()
        
        let url = URL(string: feedURL)!
        
        let parser = FeedParser(URL: url)
        
        let result = parser.parse()
        
        switch result {
        case .success(let feed):
            guard let feed = feed.rssFeed else {
                throw FeedParserError.notAnRSSFeed
            }
            guard let items = feed.items else {
                throw FeedParserError.emptyFeed
            }
            
            for item in items {
                episodes.append(self.getEpisodeFrom(rssFeedItem: item))
            }
            
            return episodes
            
        case .failure(let error):
            print(error)
        }
        
        return episodes
    }
    
    static func getEpisodeFrom(rssFeedItem item: RSSFeedItem) -> Episode {
        let episode = Episode(id: item.guid?.value ?? UUID().uuidString, title: item.title ?? "UNTITLED EPISODE", releaseDate: item.pubDate)
        return episode
    }
}

enum FeedParserError: Error {
    case emptyURL
    case parsingError
    case notAnRSSFeed
    case emptyFeed
}
