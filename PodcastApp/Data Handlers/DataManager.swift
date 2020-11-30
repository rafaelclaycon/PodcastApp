//
//  DataManager.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 28/11/20.
//

import Foundation

class DataManager {
    private var storage = LocalStorage()
    
    var podcasts: [Podcast]
    
    init() {
        do {
            if try storage.getPodcastCount() == 0 {
                let podcasts = PodcastAppService.getPodcasts()
                for podcast in podcasts {
                    do {
                        try storage.insert(podcast: podcast)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            
            self.podcasts = try storage.getAllPodcasts()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func play(episode: Episode) {
        if episode.localFilePath != nil {
            guard let url = URL(string: episode.localFilePath!) else {
                fatalError()
            }
            player = Player(url: url, update: { state in
                print(state?.activity as Any)
            })
        } else {
            FeedHelper.fetchEpisodeFile(streamURL: episode.remoteURL, podcastID: episode.podcastID, episodeID: episode.id) { filePath, error in
                guard error == nil else {
                    fatalError()
                }
                guard filePath != nil else {
                    fatalError()
                }
                guard let url = URL(string: filePath!) else {
                    fatalError()
                }
                player = Player(url: url, update: { state in
                    print(state?.activity as Any)
                })
                
                player?.togglePlay()
            }
        }
    }
    
    func playEpisode(byID episodeID: String, podcastID: Int) throws {
        guard let podcast = podcasts.first(where: { $0.id == podcastID }) else {
            throw DataManagerError.podcastIDNotFound
        }
        guard let episode = podcast.episodes?.first(where: { $0.id == episodeID }) else {
            throw DataManagerError.episodeIDNotFound
        }
        self.play(episode: episode)
    }
}

enum DataManagerError: Error {
    case podcastIDNotFound
    case episodeIDNotFound
}
