//
//  FeedParser.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import Foundation
import FeedKit

class FeedHelper {
    static func fetchEpisodeList(feedURL: String, completionHandler: @escaping (Result<Feed, ParserError>?, FeedHelperError?) -> Void) {
        guard feedURL != "" else {
            return completionHandler(nil, .emptyURL)
        }
        
        let url = URL(string: feedURL)!
        let parser = FeedParser(URL: url)
        
        parser.parseAsync { result in
            completionHandler(result, nil)
        }
    }
    
    static func getEpisodeFrom(rssFeedItem item: RSSFeedItem) -> Episode {
        let episode = Episode(id: item.guid?.value ?? UUID().uuidString, title: item.title ?? "UNTITLED EPISODE", releaseDate: item.pubDate)
        return episode
    }
    
    /*static func fetchPodcastArtwork(_ feedURL: String, completionHandler: @escaping (Result<Feed, ParserError>?, FeedHelperError?) -> Void) {
        guard feedURL != "" else {
            return completionHandler(nil, .emptyURL)
        }
        
        let url = URL(string: feedURL)!
        let parser = FeedParser(URL: url)
        
        parser.parseAsync { result in
            switch result {
            case .success(let feed):
                guard let feed = feed.rssFeed else {
                    completionHandler(nil, .notAnRSSFeed)
                }
                guard let items = feed.items else {
                    completionHandler(nil, .emptyFeed)
                }
                
                guard let image = feed.image else {
                    completionHandler(nil, .noImage)
                }
                
                guard let imageURL = image.url else {
                    completionHandler(nil, .noImage)
                }
                
                
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .none:
                XCTFail("None")
            }
        }
    }*/
}

enum FeedHelperError: Error {
    case emptyURL
    case parsingError
    case notAnRSSFeed
    case emptyFeed
    case noImage
}
