//
//  Player.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 29/11/20.
//

import Foundation
import SwiftySound

class Player {
    enum Activity {
        case stopped
        case playing
        case paused
    }
    
    var state: Activity = .stopped
    
    func play(file filePath: String) {
        guard let url = URL(string: filePath) else {
            fatalError()
        }
        Sound.play(url: url)
    }
}
