//
//  EpisodeRow.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import SwiftUI

struct EpisodeRow: View {
    @ObservedObject var viewModel: EpisodeRowViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.pubDate)
                    .foregroundColor(.gray)
                    .bold()
                    .font(.footnote)

                Text(viewModel.title)
                    .padding(.top, 0.1)

                HStack {
                    if viewModel.isAvailableOffline {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .font(.footnote)
                    } else {
                        Image(systemName: "icloud.and.arrow.down")
                            .foregroundColor(.gray)
                            .font(.footnote)
                    }

                    Text(viewModel.duration)
                        .foregroundColor(.gray)
                        .bold()
                        .font(.footnote)
                }
                .padding(.top, 0.1)
            }
            .padding(.leading)

            Spacer()

            Button(action: {
                viewModel.play()
            }) {
                Image(systemName: "play.circle")
                    .foregroundColor(.red)
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
            .alert(isPresented: $viewModel.displayAlert) {
                Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct EpisodeRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EpisodeRow(viewModel: EpisodeRowViewModel(episode: Episode(id: "1", podcastID: 123, title: "Flat-Side Promoter", pubDate: Date(), duration: 300, remoteURL: "")))
            EpisodeRow(viewModel: EpisodeRowViewModel(episode: Episode(id: "2", podcastID: 456, title: "With Four Hands Tied Behind Its Back", pubDate: Date(), duration: 3600, remoteURL: "")))
        }
        .previewLayout(.fixed(width: 350, height: 70))
    }
}
