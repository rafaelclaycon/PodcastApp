//
//  FeedHelperTests.swift
//  PodcastAppTests
//
//  Created by Rafael Schmitt on 29/11/20.
//

@testable import PodcastApp
import XCTest

class FeedHelperTests: XCTestCase {
    let testFeedURL = "https://praiadosossos.libsyn.com/rss"
    let testFileRemoteURL = "https://traffic.libsyn.com/secure/praiadosossos/PodcastPraiadosOssosTrailer.mp3?dest-id=2261237"
    let testPodcastID = 1_528_797_207

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
            case let .success(feed):
                guard let feed = feed.rssFeed else {
                    return XCTFail("Not an RSS Feed.")
                }
                guard let items = feed.items else {
                    return XCTFail("Empty feed.")
                }

                for item in items {
                    episodes.append(FeedHelper.getEpisodeFrom(rssFeedItem: item, podcastID: self.testPodcastID))
                }

                e.fulfill()

            case let .failure(error):
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
            case let .success(feed):
                guard let feed = feed.rssFeed else {
                    return XCTFail("Not an RSS Feed.")
                }
                guard let items = feed.items else {
                    return XCTFail("Empty feed.")
                }

                for item in items {
                    episodes.append(FeedHelper.getEpisodeFrom(rssFeedItem: item, podcastID: self.testPodcastID))
                }

                e.fulfill()

            case let .failure(error):
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

        FeedHelper.fetchEpisodeFile(streamURL: testFileRemoteURL, podcastID: testPodcastID, episodeID: "34148420-9c8a-4f7e-9447-2b0e39f4b7eb") { filePath, error in
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
            // TODO: Clean up the Podcasts folder on tear down.
            XCTAssertTrue(path.contains("/Documents/Podcasts/\(self.testPodcastID)/PodcastPraiadosOssosTrailer.mp3"))
        }
    }
}
