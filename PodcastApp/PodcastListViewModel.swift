//
//  PodcastListViewModel.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import Combine

class PodcastListViewModel: ObservableObject {
    @Published var podcasts: [Podcast]
    
    init(podcasts: [Podcast]) {
        self.podcasts = podcasts
        self.podcasts.sort {
            $0.name < $1.name
        }
    }
}
