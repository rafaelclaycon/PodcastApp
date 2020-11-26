//
//  PodcastAppTests.swift
//  PodcastAppTests
//
//  Created by Rafael Schmitt on 25/11/20.
//

import XCTest
@testable import PodcastApp

class PodcastAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetEpisodeListAndCheckCount() throws {
        let e = expectation(description: "Feed load")
        var episodes = [Episode]()
        
        FeedHelper.fetchEpisodeList(feedURL: "https://praiadosossos.libsyn.com/rss") { result, error in
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
    
    func testGetFirstPraiaDosOssosEpisodeAndCheckItsTitle() throws {
        let e = expectation(description: "Feed load")
        var episodes = [Episode]()
        
        FeedHelper.fetchEpisodeList(feedURL: "https://praiadosossos.libsyn.com/rss") { result, error in
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

    /*func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/

}
