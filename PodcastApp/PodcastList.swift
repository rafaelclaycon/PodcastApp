//
//  ContentView.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import SwiftUI

struct PodcastList: View {
    @ObservedObject var viewModel = PodcastListViewModel(podcasts: podcastData)
    
    var body: some View {
        List(viewModel.podcasts) { podcast in
            Text(podcast.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastList()
    }
}
