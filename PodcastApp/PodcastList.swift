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
        TabView {
            NavigationView {
                List(viewModel.podcasts) { podcast in
                    NavigationLink(destination: PodcastDetail(viewModel: PodcastDetailViewModel(podcast: podcast))) {
                        PodcastRow(podcast: podcast)
                    }
                }
                .navigationBarTitle(Text("Podcasts 🎙"))
            }.tabItem {
                Image(systemName: "square.grid.3x3.fill")
                Text("Podcasts")
            }
            
            NavigationView {
                FilterView()
            }.tabItem {
                Image(systemName: "line.horizontal.3.decrease.circle")
                Text("Filters")
            }
            
            NavigationView {
                DiscoverView()
            }.tabItem {
                Image(systemName: "magnifyingglass")
                Text("Discover")
            }
            
            NavigationView {
                ProfileView()
            }.tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastList()
    }
}
