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
    
    // MARK: - Init
    
    init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!

        do {
            db = try Connection("\(path)/db.sqlite3")
            try createPodcasts()
            try createEpisodes()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func createPodcasts() throws {
        let id = Expression<Int64>("id")
        let title = Expression<String>("title")
        let author = Expression<String>("author")
        let feedURL = Expression<String>("feedURL")
        let artworkURL = Expression<String>("artworkURL")
        
        try db.run(podcasts.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(title)
            t.column(author)
            t.column(feedURL)
            t.column(artworkURL)
        })
    }
    
    private func createEpisodes() throws {
        let id = Expression<String>("id")
        let podcast_id = Expression<Int64>("podcastID")
        let title = Expression<String>("title")
        let pub_date = Expression<Date?>("pubDate")
        let duration = Expression<Double>("duration")
        let remote_url = Expression<String>("remoteURL")
        let local_file_path = Expression<String?>("localFilePath")
        
        try db.run(episodes.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(podcast_id)
            t.column(title)
            t.column(pub_date)
            t.column(duration)
            t.column(remote_url)
            t.column(local_file_path)
        })
    }
    
    // MARK: - Podcast
    
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
    
    // MARK: - Episode
    
    func getEpisodeCount() throws -> Int {
        return try db.scalar(episodes.count)
    }
    
    func insert(episode: Episode) throws {
        let insert = try episodes.insert(episode)
        try db.run(insert)
    }
    
    func getAllEpisodes(forID podcastID: Int) throws -> [Episode] {
        var queriedEpisodes = [Episode]()
        
        let podcast_id = Expression<Int>("podcastID")
        let query = episodes.filter(podcast_id == podcastID)
        
        for episode in try db.prepare(query) {
            queriedEpisodes.append(try episode.decode())
        }
        return queriedEpisodes
    }
    
    func deleteAllEpisodes() throws {
        try db.run(episodes.delete())
    }
}
