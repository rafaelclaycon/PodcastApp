//
//  Episode.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import Foundation

struct Episode: Hashable, Codable, Identifiable {
    var id: String
    var podcastID: Int
    var title: String
    var pubDate: Date?
    var duration: Double
    var remoteURL: String
    var localFilePath: String?
}
