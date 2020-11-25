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
        do {
            let episodes = try FeedHelper.getEpisodeList(feedURL: "https://praiadosossos.libsyn.com/rss")
            
            XCTAssertEqual(episodes.count, 9)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGetFirstPraiaDosOssosEpisodeAndCheckItsTitle() throws {
        do {
            let episodes = try FeedHelper.getEpisodeList(feedURL: "https://praiadosossos.libsyn.com/rss")
            
            XCTAssertEqual(episodes.first?.title, "8. Rua Ângela Diniz")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    /*func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/

}
