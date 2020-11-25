//
//  PodcastRow.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import SwiftUI

struct PodcastRow: View {
    var podcast: Podcast
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 70, height: 70, alignment: .center)
                    .opacity(0.6)
                
                Text("P")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .opacity(0.8)
            }
            
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
            PodcastRow(podcast: Podcast(id: 1, title: "Praia dos Ossos", author: "Rádio Novelo", episodes: nil, rssFeedURL: ""))
            PodcastRow(podcast: Podcast(id: 2, title: "Accidental Tech Podcast", author: "Marco Arment, Casey Liss, John Siracusa", episodes: nil, rssFeedURL: ""))
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
