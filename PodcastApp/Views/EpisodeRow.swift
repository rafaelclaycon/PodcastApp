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
                Text(episode.releaseDate?.asString() ?? "-")
                    .foregroundColor(.gray)
                    .bold()
                    .font(.footnote)
                
                Text(episode.title)
                    .padding(.top, 0.1)
            }.padding(.leading)
            Spacer()
        }
    }
}

struct EpisodeRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EpisodeRow(episode: Episode(id: "1", title: "Flat-Side Promoter", releaseDate: Date()))
            EpisodeRow(episode: Episode(id: "2", title: "With Four Hands Tied Behind Its Back", releaseDate: Date()))
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
