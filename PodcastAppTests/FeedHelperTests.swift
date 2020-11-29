//
//  FeedHelperTests.swift
//  PodcastAppTests
//
//  Created by Rafael Schmitt on 29/11/20.
//

import XCTest
@testable import PodcastApp

class FeedHelperTests: XCTestCase {
    
    let testFeedURL = "https://praiadosossos.libsyn.com/rss"
    let testFileRemoteURL = "https://traffic.libsyn.com/secure/praiadosossos/PodcastPraiadosOssosTrailer.mp3?dest-id=2261237"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchEpisodeListAndCheckItsCount() throws {
        let e = expectation(description: "Feed load")
        var episodes = [Episode]()
        
        FeedHelper.fetchEpisodeList(feedURL: testFeedURL) { result, error in
            guard error == nil else {
                return XCTFail(error!.localizedDescription)
            }
            
            switch result {
            case .success(let feed):
                guard let feed = feed.rssFeed else {
                    return XCTFail("Not an RSS Feed.")
                }
                guard let items = feed.items else {
                    return XCTFail("Empty feed.")
                }
                
                for item in items {
                    episodes.append(FeedHelper.getEpisodeFrom(rssFeedItem: item))
                }
                
                e.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .none:
                XCTFail("None")
            }
        }
        
        waitForExpectations(timeout: 5.0) { error in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
            XCTAssertEqual(episodes.count, 9)
        }
    }
    
    func testFetchFirstEpisodeAndCheckItsTitle() throws {
        let e = expectation(description: "Feed load")
        var episodes = [Episode]()
        
        FeedHelper.fetchEpisodeList(feedURL: testFeedURL) { result, error in
            guard error == nil else {
                return XCTFail(error!.localizedDescription)
            }
            
            switch result {
            case .success(let feed):
                guard let feed = feed.rssFeed else {
                    return XCTFail("Not an RSS Feed.")
                }
                guard let items = feed.items else {
                    return XCTFail("Empty feed.")
                }
                
                for item in items {
                    episodes.append(FeedHelper.getEpisodeFrom(rssFeedItem: item))
                }
                
                e.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .none:
                XCTFail("None")
            }
        }
        
        waitForExpectations(timeout: 5.0) { error in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
            XCTAssertEqual(episodes.first?.title, "8. Rua Ângela Diniz")
        }
    }
    
    func testFetchPodcastAudioFile() throws {
        let e = expectation(description: "File download")
        var path: String = ""
        let episodeID = "1528797207"
        
        FeedHelper.fetchEpisodeFile(streamURL: testFileRemoteURL, podcastID: episodeID, episodeID: "34148420-9c8a-4f7e-9447-2b0e39f4b7eb") { filePath, error in
            guard error == nil else {
                return XCTFail(error!.localizedDescription)
            }
            guard filePath != nil else {
                return XCTFail("File path is nil.")
            }
            path = filePath!
            e.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { error in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
            XCTAssertTrue(path.contains("/Documents/Podcasts/\(episodeID)/PodcastPraiadosOssosTrailer.mp3"))
        }
    }

}
