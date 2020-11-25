//
//  PodcastDetail.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import SwiftUI

struct PodcastDetail: View {
    @ObservedObject var viewModel: PodcastDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.title)
                    .bold()
                
                Text(viewModel.author)
                    .foregroundColor(.gray)
                    .font(.title3)
            }
            .padding()
            .padding(.leading)
            
            if !viewModel.feedIsEmpty {
                List(viewModel.episodes!) { episode in
                    EpisodeRow(episode: episode)
                }
            }
        }
    }
}

struct PodcastDetail_Previews: PreviewProvider {
    static var previews: some View {
        PodcastDetail(viewModel: PodcastDetailViewModel(podcast: Podcast(id: 1, title: "Praia dos Ossos", author: "Rádio Novelo", episodes: [Episode(id: "1", title: "Flat-Side Promoter", releaseDate: Date()), Episode(id: "2", title: "With Four Hands Tied Behind Its Back", releaseDate: Date())], rssFeedURL: "")))
    }
}
