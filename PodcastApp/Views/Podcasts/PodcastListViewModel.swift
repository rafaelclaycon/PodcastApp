//
//  PodcastListViewModel.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import Combine

class PodcastListViewModel: ObservableObject {
    @Published var podcasts: [Podcast]?
    @Published var showOptions = false
    @Published var layout: GridLayout = .list
    @Published var showGrid = false

    init(podcasts: [Podcast]?) {
        guard let podcasts = podcasts else {
            return
        }
        self.podcasts = podcasts
        self.podcasts?.sort {
            $0.title.folding(options: .diacriticInsensitive, locale: .current) < $1.title.folding(options: .diacriticInsensitive, locale: .current)
        }
        showGrid = true
    }
}
