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
                    //print(state?.activity as Any)
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
}

enum DataManagerError: Error {
    case podcastIDNotFound
    case episodeIDNotFound
    case podcastArrayIsUninitialized
}
