//
//  LocalStorageTests.swift
//  PodcastAppTests
//
//  Created by Rafael Schmitt on 29/11/20.
//

import XCTest
@testable import PodcastApp

class LocalStorageTests: XCTestCase {
    
    let storage = LocalStorage()
    let testEpisodes: [Episode]? = nil
    
    override func setUpWithError() throws {
        XCTAssertEqual(try storage.getPodcastCount(), 0)
        XCTAssertEqual(try storage.getEpisodeCount(), 0)
    }

    override func tearDownWithError() throws {
        XCTAssertNoThrow(try storage.deleteAllPodcasts())
        XCTAssertNoThrow(try storage.deleteAllEpisodes())
    }

    func testInsertPodcastsIntoDB() {
        let podcasts = PodcastAppService.getPodcasts()
        for podcast in podcasts {
            XCTAssertNoThrow(try storage.insert(podcast: podcast))
        }
        XCTAssertEqual(try storage.getPodcastCount(), 9)
    }
    
    func testInsertEpisodesIntoDB() {
        var testEpisodes = [Episode]()
        
        testEpisodes.append(Episode(id: "1", podcastID: 1, title: "Lorem ipsum dolor sit amet", pubDate: Date(), duration: 300, remoteURL: "", localFilePath: nil))
        testEpisodes.append(Episode(id: "2", podcastID: 1, title: "Consectetur adipiscing elit", pubDate: Date(), duration: 300, remoteURL: "", localFilePath: nil))
        testEpisodes.append(Episode(id: "3", podcastID: 1, title: "Sed do eiusmod tempor", pubDate: Date(), duration: 300, remoteURL: "", localFilePath: nil))
        
        for episode in testEpisodes {
            XCTAssertNoThrow(try storage.insert(episode: episode))
        }
        
        XCTAssertEqual(try storage.getAllEpisodes(forID: 1).count, 3)
    }

}
