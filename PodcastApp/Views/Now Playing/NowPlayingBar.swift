//
//  NowPlayingBar.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 27/11/20.
//

import SwiftUI

struct NowPlayingBar<Content: View>: View {
    var content: Content
    @State var showBar = (player.state == .playing) || (player.state == .paused)
    
    @ViewBuilder var body: some View {
        ZStack(alignment: .bottom) {
            content
            
            if showBar {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.white.opacity(0.0))
                        .frame(width: UIScreen.main.bounds.size.width, height: 65)
                        .background(Color("backgroundColor"))
                        .shadow(radius: 3, x: 0, y: -0.5)
                    
                    HStack {
                        Button(action: {}) {
                            Image("Cover")
                                .resizable()
                                .frame(width: 48, height: 48)
                                .shadow(radius: 1, x: 0, y: 2)
                                .padding(.leading)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "gobackward")
                                .font(.headline)
                        }
                        .buttonStyle(PlainButtonStyle())
                        //.padding(.horizontal)
                        
                        Button(action: {}) {
                            Image(systemName: "play.circle.fill")
                                .font(.largeTitle)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                        
                        Button(action: {}) {
                            Image(systemName: "goforward")
                                .font(.headline)
                        }
                        .buttonStyle(PlainButtonStyle())
                        //.padding(.horizontal)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "list.triangle")
                                .font(.headline)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing, 20)
                    }
                }
            }
        }
    }
}

struct NowPlayingBar_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingBar(content: ProfileView())
    }
}
