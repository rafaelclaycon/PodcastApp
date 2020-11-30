//
//  EpisodeRow.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import SwiftUI

struct EpisodeRow: View {
    var episode: Episode
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(episode.pubDate?.asFullString().uppercased() ?? "-")
                    .foregroundColor(.gray)
                    .bold()
                    .font(.footnote)
                
                Text(episode.title)
                    .padding(.top, 0.1)
                
                Text(episode.duration.toDisplayString())
                    .foregroundColor(.gray)
                    .bold()
                    .font(.footnote)
                    .padding(.top, 0.1)
            }.padding(.leading)
            
            Spacer()
            
            Button(action: {
                dataManager.play(episode: episode)
            }) {
                Image(systemName: "play.circle")
                    .foregroundColor(.red)
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
        }
    }
}

struct EpisodeRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EpisodeRow(episode: Episode(id: "1", title: "Flat-Side Promoter", pubDate: Date(), duration: 2.0, remoteURL: ""))
            EpisodeRow(episode: Episode(id: "2", title: "With Four Hands Tied Behind Its Back", pubDate: Date(), duration: 2.5, remoteURL: ""))
        }
        .previewLayout(.fixed(width: 350, height: 70))
    }
}
