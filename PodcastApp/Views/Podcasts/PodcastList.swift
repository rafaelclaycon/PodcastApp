//
//  ContentView.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 25/11/20.
//

import SwiftUI

struct PodcastList: View {
    @ObservedObject var viewModel = PodcastListViewModel(podcasts: isRunningUnitTests ? nil : dataManager.getUserPodcasts())
    
    var body: some View {
        NavigationView {
            if viewModel.showGrid {
                List(viewModel.podcasts!) { podcast in
                    NavigationLink(destination: PodcastDetail(viewModel: PodcastDetailViewModel(podcast: podcast))) {
                        PodcastRow(podcast: podcast)
                    }
                }
                .navigationBarTitle(Text("Podcasts 🎙"))
                .navigationBarItems(trailing:
                    Button(action: {
                        viewModel.showOptions = true
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.title)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal)
                    .actionSheet(isPresented: $viewModel.showOptions) {
                        ActionSheet(title: Text(""),
                                    message: nil,
                                    buttons: [.default(Text("Sort By")),
                                              .default(Text("Layout")),
                                              .default(Text("Badges")),
                                              .default(Text("Share Podcasts")),
                                              .cancel(Text("Cancel"))])
                    }
                )
            } else {
                Text("No Podcasts")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastList()
    }
}
