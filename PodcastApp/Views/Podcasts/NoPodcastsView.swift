//
//  NoPodcastsView.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 06/12/20.
//

import SwiftUI

struct NoPodcastsView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.fill.questionmark")
                .font(.largeTitle)
                .foregroundColor(.green)
                .padding()
            
            Text("No podcasts yet")
                .font(.title)
                .bold()
            
            Text("Add podcasts by searching on the Discover tab.")
                .multilineTextAlignment(.center)
                .padding(20)
        }
    }
}

struct NoPodcastsView_Previews: PreviewProvider {
    static var previews: some View {
        NoPodcastsView()
    }
}
