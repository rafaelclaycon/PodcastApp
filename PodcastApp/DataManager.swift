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
}
