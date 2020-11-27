//
//  MainView.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 27/11/20.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            NowPlayingBar(content: PodcastList()).tabItem {
                Image(systemName: "square.grid.3x3.fill")
                Text("Podcasts")
            }
            
            NowPlayingBar(content: FilterView()).tabItem {
                Image(systemName: "line.horizontal.3.decrease.circle")
                Text("Filters")
            }
            
            NowPlayingBar(content: DiscoverView()).tabItem {
                Image(systemName: "magnifyingglass")
                Text("Discover")
            }
            
            NowPlayingBar(content: ProfileView()).tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
