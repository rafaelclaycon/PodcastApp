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
    var releaseDate: Date?
    
    init(id: String, title: String, releaseDate: Date?) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
    }
}
