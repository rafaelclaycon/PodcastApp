//
//  DataManager.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 28/11/20.
//

import Foundation

class DataManager {
    var storage = LocalStorage()
    
    func getUserPodcasts() -> [Podcast] {
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
            
            return try storage.getAllPodcasts()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func play(episode: Episode) {
        if episode.localFilePath != nil {
            player.play(file: episode.localFilePath!)
        } else {
            FeedHelper.fetchEpisodeFile(streamURL: episode.remoteURL, podcastID: "test", episodeID: episode.id) { filePath, error in
                guard error == nil else {
                    fatalError()
                }
                guard filePath != nil else {
                    fatalError()
                }
                player.play(file: filePath!)
            }
        }
    }
}
