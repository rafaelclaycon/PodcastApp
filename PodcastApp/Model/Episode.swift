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
    var streamURL: String
}

extension Date {
    func asString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}
