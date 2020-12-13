//
//  PodcastDetail.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import KingfisherSwiftUI
import SwiftUI

struct PodcastDetail: View {
    @ObservedObject var viewModel: PodcastDetailViewModel

    var body: some View {
        ZStack {
            VStack {
                Color("podcastHeaderBackground")
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 100)
                Spacer()
            }

            VStack(alignment: .leading) {
                // Header
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
                        .frame(width: 170, height: 170)
                        .cornerRadius(8.0)

//                    VStack(alignment: .leading) {
//                        HStack {
//                            Image(systemName: "checkmark")
//                                .foregroundColor(.gray)
//                            Text("Inscrito")
//                                .foregroundColor(.gray)
//                                .font(.headline)
//                        }
//                    }
//                    .padding()

                    Spacer()
                }
                .frame(height: 100)
                .padding()

                // List
                if viewModel.displayEpisodeList {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.episodes, id: \.id) { episode in
                                EpisodeRow(viewModel: EpisodeRowViewModel(episode: episode))
                                    .padding(.vertical, 5)
                            }
                        }
                    }.padding(.top, 25)
                } else {
                    VStack(alignment: .center) {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("No Episodes")
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct PodcastDetail_Previews: PreviewProvider {
    static var previews: some View {
        PodcastDetail(viewModel: PodcastDetailViewModel(podcast: Podcast(id: 1, title: "Praia dos Ossos", author: "Rádio Novelo", episodes: nil, feedURL: "", artworkURL: "https://i1.sndcdn.com/avatars-l7UAPy4c6vYw4Uzb-zLzBYw-original.jpg")))
    }
}
