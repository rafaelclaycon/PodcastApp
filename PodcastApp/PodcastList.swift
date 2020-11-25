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
        NavigationView {
            List(viewModel.podcasts) { podcast in
                NavigationLink(destination: PodcastDetail()) {
                    PodcastRow(podcast: podcast)
                }
            }
            .navigationBarTitle(Text("Podcasts 🎙"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastList()
    }
}
