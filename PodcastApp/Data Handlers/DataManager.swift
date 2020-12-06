//
//  DataManager.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 28/11/20.
//

import Foundation

class DataManager {
    typealias PodcastFetchMethod = () -> [Podcast]
    
    private var storage: LocalStorage? = nil
    
    var podcasts: [Podcast]? = nil
    
    init(storage injectedStorage: LocalStorage?, fetchMethod: PodcastFetchMethod) {
        guard injectedStorage != nil else {
            return
        }
        
        self.storage = injectedStorage
        
        do {
            if try storage?.getPodcastCount() == 0 {
                let podcasts = fetchMethod()
                for podcast in podcasts {
                    do {
                        try storage?.insert(podcast: podcast)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            
            self.podcasts = try storage?.getAllPodcasts()
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
        guard let podcast = podcasts?.first(where: { $0.id == podcastID }) else {
            throw DataManagerError.podcastIDNotFound
        }
        guard let episode = podcast.episodes?.first(where: { $0.id == episodeID }) else {
            throw DataManagerError.episodeIDNotFound
        }
        self.play(episode: episode)
    }
    
    func addEpisodes(_ episodes: [Episode], podcastID: Int) throws {
        guard let _ = podcasts?.first(where: { $0.id == podcastID }) else {
            throw DataManagerError.podcastIDNotFound
        }
        /*if podcast.episodes == nil {
            podcast.episodes = [Episode]()
        }
        podcast.episodes!.append(contentsOf: episodes)*/
        
        for episode in episodes {
            try storage?.insert(episode: episode)
        }
    }
    
    func getEpisodes(forPodcastID podcastID: Int, feedURL: String, completionHandler: @escaping ([Episode]?, FeedHelperError?) -> Void) {
        do {
            let localEpisodes = try storage!.getAllEpisodes(forID: podcastID)
            
            if localEpisodes.count > 0 {
                print("LOCAL FETCH: podcast \(podcastID)")
                completionHandler(localEpisodes, nil)
            } else {
                print("REMOTE FETCH: podcast \(podcastID)")
                FeedHelper.fetchEpisodeList(feedURL: feedURL) { [weak self] result, error in
                    guard let strongSelf = self else {
                        return
                    }
                    
                    guard error == nil else {
                        fatalError(error!.localizedDescription)
                    }
                    
                    switch result {
                    case .success(let feed):
                        guard let feed = feed.rssFeed else {
                            return completionHandler(nil, FeedHelperError.notAnRSSFeed)
                        }
                        guard let items = feed.items else {
                            return completionHandler(nil, FeedHelperError.emptyFeed)
                        }
                        
                        var episodes = [Episode]()
                        
                        for item in items {
                            episodes.append(FeedHelper.getEpisodeFrom(rssFeedItem: item, podcastID: podcastID))
                        }
                        
                        do {
                            try strongSelf.addEpisodes(episodes, podcastID: podcastID)
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                        
                        completionHandler(episodes, nil)
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .none:
                        fatalError("None")
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

enum DataManagerError: Error {
    case podcastIDNotFound
    case episodeIDNotFound
}
