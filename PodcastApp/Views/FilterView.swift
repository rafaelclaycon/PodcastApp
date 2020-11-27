//
//  FilterView.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 26/11/20.
//

import SwiftUI

struct FilterView: View {
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Image(systemName: "clock")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.red)
                        .padding()
                    
                    Text("New Releases")
                    
                    Spacer()
                }
            }.navigationBarTitle(Text("Filters"))
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
