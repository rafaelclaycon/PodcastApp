//
//  DiscoverView.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 26/11/20.
//

import SwiftUI

struct DiscoverView: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal) {
                    Text("Podcast A")
                        .padding()
                    
                    Text("Podcast B")
                        .padding()
                    
                    Text("Podcast C")
                        .padding()
                }
                
                Spacer()
            }.navigationBarTitle(Text("Discover"))
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
