//
//  LocalStorage.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 28/11/20.
//

import Foundation
import SQLite

class LocalStorage {
    
    private var db: Connection
    private var podcasts = Table("podcasts")
    private var episodes = Table("episodes")
    
    init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!

        do {
            db = try Connection("\(path)/db.sqlite3")
            
            let id = Expression<Int64>("id")
            let title = Expression<String>("title")
            let author = Expression<String>("author")
            //var episodes: [Episode]?
            let feedURL = Expression<String>("feedURL")
            let artworkURL = Expression<String>("artworkURL")
            
            try db.run(podcasts.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(title)
                t.column(author)
                t.column(feedURL)
                t.column(artworkURL)
            })
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getPodcastCount() throws -> Int {
        return try db.scalar(podcasts.count)
    }
    
    func insert(podcast: Podcast) throws {
        let insert = try podcasts.insert(podcast)
        try db.run(insert)
    }
    
    func getAllPodcasts() throws -> [Podcast] {
        var queriedPodcasts = [Podcast]()
        
        for podcast in try db.prepare(podcasts) {
            queriedPodcasts.append(try podcast.decode())
        }
        return queriedPodcasts
    }
    
    func deleteAllPodcasts() throws {
        try db.run(podcasts.delete())
    }
}
