//
//  DataManagerTests.swift
//  PodcastAppTests
//
//  Created by Rafael Schmitt on 01/12/20.
//

@testable import PodcastApp
import XCTest

class DataManagerTests: XCTestCase {
    let storage = LocalStorage()
    var manager: DataManager?
    let testPodcastID: Int = 123
    let testFeedURL = "https://praiadosossos.libsyn.com/rss"

    override func setUpWithError() throws {
        XCTAssertEqual(try storage.getPodcastCount(), 0)
        XCTAssertEqual(try storage.getEpisodeCount(), 0)
    }

    override func tearDownWithError() throws {
        manager = nil
        XCTAssertNoThrow(try storage.deleteAllPodcasts())
        XCTAssertNoThrow(try storage.deleteAllEpisodes())
    }

    func fakePodcastFetch() -> [Podcast] {
        var podcasts = [Podcast]()
        podcasts.append(Podcast(id: testPodcastID, title: "Praia dos Ossos", author: "Rádio Novelo", episodes: nil, feedURL: testFeedURL, artworkURL: ""))
        return podcasts
    }

    func testGetEpisodesWithoutCache() throws {
        // Given that I haven't opened the app before
        let e = expectation(description: "Fetch episodes from remote server")
        var testEpisodes = [Episode]()

        // When I open it
        manager = DataManager(storage: storage, fetchMethod: fakePodcastFetch)

        // Then it fetches all episodes from the remote server
        manager?.getEpisodes(forPodcastID: testPodcastID, feedURL: testFeedURL) { episodes, error in
            guard error == nil else {
                fatalError(error.debugDescription)
            }
            guard let episodes = episodes else {
                return print("Episodes is empty.")
            }
            testEpisodes.append(contentsOf: episodes)
            e.fulfill()
        }

        // And I see a list of episodes for that podcast
        waitForExpectations(timeout: 5.0) { error in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
            XCTAssertEqual(testEpisodes.count, 9)
        }
    }

    func testGetEpisodesWithCache() throws {
        // Given that I have opened the app before
        let e = expectation(description: "Fetch episodes from remote server")
        var testEpisodes = [Episode]()

        try storage.insert(podcast: Podcast(id: testPodcastID, title: "Praia dos Ossos", author: "Rádio Novelo", episodes: nil, feedURL: testFeedURL, artworkURL: ""))
        try storage.insert(episode: Episode(id: "abc", podcastID: testPodcastID, title: "Fake Episode 1", pubDate: Date(), duration: 300, remoteURL: "", localFilePath: nil))
        try storage.insert(episode: Episode(id: "def", podcastID: testPodcastID, title: "Fake Episode 2", pubDate: Date(), duration: 350, remoteURL: "", localFilePath: nil))

        // When I open it
        manager = DataManager(storage: storage, fetchMethod: fakePodcastFetch)

        // Then it fetches all episodes from the local database
        manager?.getEpisodes(forPodcastID: testPodcastID, feedURL: testFeedURL) { episodes, error in
            guard error == nil else {
                fatalError(error.debugDescription)
            }
            guard let episodes = episodes else {
                return print("Episodes is empty.")
            }
            testEpisodes.append(contentsOf: episodes)
            e.fulfill()
        }

        // And I see a list of episodes for that podcast
        waitForExpectations(timeout: 5.0) { error in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
            XCTAssertEqual(testEpisodes.count, 2)
        }
    }
}
