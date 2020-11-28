//
//  Episode.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import Foundation

struct Episode: Hashable, Codable, Identifiable {
    var id: String
    var title: String
    var pubDate: Date?
    var streamURL: String
    var duration: Double
}
