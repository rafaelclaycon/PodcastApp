//
//  FeedParser.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import Foundation
import FeedKit

class FeedHelper {
    static func getEpisodeList(feedURL: String, completionHandler: @escaping (Result<Feed, ParserError>?, FeedHelperError?) -> Void) {
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
}

enum FeedHelperError: Error {
    case emptyURL
    case parsingError
    case notAnRSSFeed
    case emptyFeed
}
