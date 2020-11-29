//
//  FilterDetailView.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 29/11/20.
//

import SwiftUI

struct FilterDetailView: View {
    var episodes = [Episode(id: "123", title: "Test Episode", pubDate: nil, duration: 0, remoteURL: "", localFilePath: nil)]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(episodes, id: \.id) { episode in
                    EpisodeRow(episode: episode)
                        .padding(.vertical, 5)
                }
            }
        }.navigationTitle(Text("New Releases"))
    }
}

struct FilterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilterDetailView()
    }
}
