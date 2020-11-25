//
//  Podcast.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import Foundation

struct Podcast: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var author: String
    var episodes: [Episode]?
    var rssFeedURL: String
}
