//
//  Episode.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import Foundation

struct Episode: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var releaseDate: Date
}
