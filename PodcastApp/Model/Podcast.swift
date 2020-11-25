//
//  Podcast.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import Foundation

struct Podcast: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var broadcaster: String
    var episodes: [Episode]?
    var feedURL: String
}
