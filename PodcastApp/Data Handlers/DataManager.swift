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
            guard let url = URL(string: episode.localFilePath!) else {
                fatalError()
            }
            player = Player(url: url, update: { state in
                print(state?.activity as Any)
            })
        } else {
            FeedHelper.fetchEpisodeFile(streamURL: episode.remoteURL, podcastID: "test", episodeID: episode.id) { filePath, error in
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
}
