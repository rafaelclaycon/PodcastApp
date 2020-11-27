//
//  EpisodeRow.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import SwiftUI
import SwiftySound

struct EpisodeRow: View {
    var episode: Episode
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(episode.releaseDate?.asString() ?? "-")
                    .foregroundColor(.gray)
                    .bold()
                    .font(.footnote)
                
                Text(episode.title)
                    .padding(.top, 0.1)
            }.padding(.leading)
            
            Spacer()
            
            Button(action: {
                FeedHelper.fetchEpisodeFile(streamURL: episode.streamURL, podcastID: "test", episodeID: episode.id) { filePath, error in
                    guard error == nil else {
                        fatalError()
                    }
                    guard filePath != nil else {
                        fatalError()
                    }
                    guard let url = URL(string: filePath!) else {
                        fatalError()
                    }
                    
                    Sound.play(url: url)
                }
            }) {
                Image(systemName: "play.circle")
                    .foregroundColor(.red)
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing, 10)
        }
    }
}

struct EpisodeRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EpisodeRow(episode: Episode(id: "1", title: "Flat-Side Promoter", releaseDate: Date(), streamURL: ""))
            EpisodeRow(episode: Episode(id: "2", title: "With Four Hands Tied Behind Its Back", releaseDate: Date(), streamURL: ""))
        }
        .previewLayout(.fixed(width: 350, height: 70))
    }
}
