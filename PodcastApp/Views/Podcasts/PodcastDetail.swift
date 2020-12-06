//
//  PodcastDetail.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import SwiftUI
import KingfisherSwiftUI

struct PodcastDetail: View {
    @ObservedObject var viewModel: PodcastDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                KFImage(URL(string: viewModel.artworkURL))
                    .onSuccess { r in
                        print("success: \(r)")
                    }
                    .onFailure { e in
                        print("failure: \(e)")
                    }
                    .placeholder {
                        ZStack {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 70, height: 70)
                                .opacity(0.5)

                            Image(systemName: "waveform")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.white)
                                .opacity(0.5)
                        }
                    }
                    .resizable()
                    .frame(width: 150, height: 150)
                
                VStack(alignment: .leading) {
                    Text(viewModel.title)
                        .font(.title)
                        .bold()

                    Text(viewModel.author)
                        .foregroundColor(.gray)
                        .font(.headline)
                        .padding(.top, 5)
                }
                .padding()
                
                Spacer()
            }
            .padding()
            
            if viewModel.displayEpisodeList {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.episodes, id: \.id) { episode in
                            EpisodeRow(viewModel: EpisodeRowViewModel(episode: episode))
                                .padding(.vertical, 5)
                        }
                    }
                }
            }
        }
    }
}

struct PodcastDetail_Previews: PreviewProvider {
    static var previews: some View {
        PodcastDetail(viewModel: PodcastDetailViewModel(podcast: Podcast(id: 1, title: "Praia dos Ossos", author: "Rádio Novelo", episodes: [Episode(id: "1", podcastID: 123, title: "Flat-Side Promoter", pubDate: Date(), duration: 1.0, remoteURL: ""), Episode(id: "2", podcastID: 345, title: "With Four Hands Tied Behind Its Back", pubDate: Date(), duration: 2.0, remoteURL: "")], feedURL: "", artworkURL: "")))
    }
}