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
    
    override func setUpWithError() throws {
        XCTAssertEqual(storage.getPodcastCount(), 0)
    }

    override func tearDownWithError() throws {
        XCTAssertNoThrow(try storage.deleteAllPodcasts())
    }

    func testInsertPodcastsIntoDB() {
        let podcasts = PodcastAppService.getPodcasts()
        for podcast in podcasts {
            XCTAssertNoThrow(try storage.insert(podcast: podcast))
        }
        XCTAssertEqual(storage.getPodcastCount(), 9)
    }

}
