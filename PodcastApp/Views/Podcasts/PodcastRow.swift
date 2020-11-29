//
//  PodcastRow.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import SwiftUI
import KingfisherSwiftUI

struct PodcastRow: View {
    var podcast: Podcast
    
    var body: some View {
        HStack {
            KFImage(URL(string: podcast.artworkURL))
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
                            .opacity(0.6)

                        Image(systemName: "waveform")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                    }
                }
                .resizable()
                .frame(width: 70, height: 70)
            
            VStack(alignment: .leading) {
                Text(podcast.title)
                    .font(.body)
                    .bold()
                    .padding(.leading, 15)
                    .padding(.bottom, 2)
                Text(podcast.author)
                    .padding(.leading, 15)
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            
            Spacer()
        }
        
    }
}

struct PodcastRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PodcastRow(podcast: Podcast(id: 1, title: "Praia dos Ossos", author: "Rádio Novelo", episodes: nil, feedURL: "", artworkURL: ""))
            PodcastRow(podcast: Podcast(id: 2, title: "Accidental Tech Podcast", author: "Marco Arment, Casey Liss, John Siracusa", episodes: nil, feedURL: "", artworkURL: ""))
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
