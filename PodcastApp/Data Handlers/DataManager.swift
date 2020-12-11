//
//  DataManager.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 28/11/20.
//

import Foundation

class DataManager {
    typealias PodcastFetchMethod = () -> [Podcast]

    private var storage: LocalStorage?

    var podcasts: [Podcast]?

    init(storage injectedStorage: LocalStorage?, fetchMethod: PodcastFetchMethod) {
        guard injectedStorage != nil else {
            return
        }

        storage = injectedStorage

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

            podcasts = try storage?.getAllPodcasts()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    fileprivate func playLocalFile(_ episode: Episode) {
//        print("Local file path name: \(episode.localFilePath!)")
        
//        do {
//            let documentsFolderString = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).absoluteString
//            print(documentsFolderString)
//            let newString = documentsFolderString.replacingOccurrences(of: "file://", with: "")
//            print(newString)
//            let documentsFolderURL = URL(string: newString)
//            let episodeURL = documentsFolderURL!.appendingPathComponent("Podcasts/\(episode.podcastID)/").appendingPathComponent(episode.localFilePath!)
            
            let path = Bundle.main.path(forResource: "PodcastPraiadosOssosTrailer.mp3", ofType: nil)!
            let url = URL(fileURLWithPath: path)
            
            print(url)
            
            player = Player(url: url, update: { state in
                print(state?.activity as Any)
            })
            
//        } catch {
//            print(error.localizedDescription)
//        }
    }
    
    fileprivate func fetchAndPlayRemoteFile(_ episode: Episode) {
        FeedHelper.fetchEpisodeFile(streamURL: episode.remoteURL, podcastID: episode.podcastID, episodeID: episode.id) { [weak self] filePath, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                fatalError()
            }
            guard filePath != nil else {
                fatalError()
            }
            guard let url = URL(string: filePath!) else {
                fatalError()
            }
            
            // Seizes the opportunity to save the local file path onto the episode.
            do {
                try strongSelf.updateLocalFilePath(forEpisode: episode, with: url.lastPathComponent)
            } catch {
                fatalError(error.localizedDescription)
            }
            
            player = Player(url: url, update: { state in
                //print(state?.activity as Any)
            })
            
            player?.togglePlay()
        }
    }
    
    fileprivate func play(episode: Episode) {
        if episode.localFilePath != nil {
            playLocalFile(episode)
        } else {
            fetchAndPlayRemoteFile(episode)
        }
    }

    func playEpisode(byID episodeID: String, podcastID: Int) throws {
        guard let podcast = podcasts?.first(where: { $0.id == podcastID }) else {
            throw DataManagerError.podcastIDNotFound
        }
        guard let episode = podcast.episodes?.first(where: { $0.id == episodeID }) else {
            throw DataManagerError.episodeIDNotFound
        }
        play(episode: episode)
    }

    func addEpisodes(_ episodes: [Episode], podcastID: Int) throws {
        guard podcasts != nil else {
            throw DataManagerError.podcastArrayIsUninitialized
        }
        guard let podcastIndex = podcasts?.firstIndex(where: { $0.id == podcastID }) else {
            throw DataManagerError.podcastIDNotFound
        }
        
        if podcasts![podcastIndex].episodes == nil {
            podcasts![podcastIndex].episodes = [Episode]()
        }
        podcasts![podcastIndex].episodes!.append(contentsOf: episodes)

        for episode in episodes {
            try storage?.insert(episode: episode)
        }
    }

    func getEpisodes(forPodcastID podcastID: Int, feedURL: String, completionHandler: @escaping ([Episode]?, FeedHelperError?) -> Void) {
        guard let podcast = podcasts?.first(where: { $0.id == podcastID }) else {
            return
        }
        
        // 1. First tries to get the episodes from memory.
        if let episodes = podcast.episodes, episodes.count > 0 {
            print("IN-MEMORY FETCH: podcast \(podcastID)")
            completionHandler(episodes, nil)
            return
        }
        
        do {
            let localEpisodes = try storage!.getAllEpisodes(forID: podcastID)

            // 2. If there are no episodes in memory, tries the local DB.
            if localEpisodes.count > 0 {
                print("LOCAL FETCH: podcast \(podcastID)")
                completionHandler(localEpisodes, nil)
                do {
                    try addEpisodes(localEpisodes, podcastID: podcastID)
                } catch {
                    print(error.localizedDescription)
                }
                
            // 3. If that fails, tries to get them from the podcast's hosting server.
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
                    case let .success(feed):
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

                    case let .failure(error):
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
    
    func updateLocalFilePath(forEpisode episode: Episode, with filePath: String) throws {
        // Update it on the in-memory array.
        try updateInMemoryEpisodeLocalFilePath(podcastID: episode.podcastID, episodeID: episode.id, filePath: filePath)
        // Update it on the database.
        storage!.updateLocalFilePath(forEpisode: episode.id, with: filePath)
    }
    
    private func updateInMemoryEpisodeLocalFilePath(podcastID: Int, episodeID: String, filePath: String) throws {
        guard podcasts != nil else {
            throw DataManagerError.podcastArrayIsUninitialized
        }
        guard let podcastIndex = podcasts?.firstIndex(where: { $0.id == podcastID }) else {
            throw DataManagerError.podcastIDNotFound
        }
        guard podcasts![podcastIndex].episodes != nil else {
            throw DataManagerError.episodeArrayIsUninitialized
        }
        guard let episodeIndex = podcasts![podcastIndex].episodes!.firstIndex(where: { $0.id == episodeID }) else {
            throw DataManagerError.episodeIDNotFound
        }
        podcasts![podcastIndex].episodes![episodeIndex].localFilePath = filePath
    }
}

enum DataManagerError: Error {
    case podcastIDNotFound
    case episodeIDNotFound
    case podcastArrayIsUninitialized
    case episodeArrayIsUninitialized
}
