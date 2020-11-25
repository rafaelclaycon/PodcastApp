//
//  FeedParser.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import Foundation
import Alamofire

class FeedParser {
    static func loadRSS(feedURL: String, completionHandler: (() -> Void)) throws {
        guard feedURL != "" else {
            throw FeedParserError.emptyURL
        }
        
        AF.request(feedURL).response { response in
            completionHandler(response)
        }
    }
}

enum FeedParserError: Error {
    case emptyURL
}
