//
//  NowPlayingToolbar.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 13/12/20.
//

import SwiftUI

struct NowPlayingToolbar: View {
    let itemHorizontalPadding: CGFloat = 20
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color("nowPlayingToolbarBackground"))
                .frame(width: 380, height: 60)
            
            HStack {
                Image(systemName: "dial.max.fill")
                    .foregroundColor(.purple)
                    .font(.title2)
                    .padding(.horizontal, itemHorizontalPadding)
                
                Image(systemName: "zzz")
                    .foregroundColor(.gray)
                    .font(.title2)
                    .padding(.horizontal, itemHorizontalPadding)
                
                Image(systemName: "archivebox")
                    .foregroundColor(.gray)
                    .font(.title2)
                    .padding(.horizontal, itemHorizontalPadding)
                
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.gray)
                    .font(.title2)
                    .padding(.horizontal, itemHorizontalPadding)
                
                Image(systemName: "ellipsis")
                    .foregroundColor(.gray)
                    .font(.title2)
                    .padding(.horizontal, itemHorizontalPadding)
            }
        }
    }
}

struct NowPlayingToolbar_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingToolbar()
    }
}
