//
//  PodcastAppApp.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import SwiftUI

let dataManager = DataManager()
let player = Player()

let isRunningUnitTests = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil

@main
struct PodcastAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
