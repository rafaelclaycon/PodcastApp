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

    func testGetEpisodeList() throws {
        // Input the feed URL
        // Make the GET request
        
        let e = expectation(description: "Alamofire")
        
        do {
            try FeedParser.loadRSS(feedURL: "https://podcasts.apple.com/br/podcast/praia-dos-ossos/id1528797207")
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        // Catch the list
        // Check list
    }

    /*func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/

}
