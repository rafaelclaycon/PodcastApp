//
//  PodcastAppApp.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import SwiftUI

let isRunningUnitTests = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil

@main
struct PodcastAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
