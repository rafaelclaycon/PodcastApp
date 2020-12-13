//
//  NowPlayingView.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 06/12/20.
//

import SwiftUI

struct NowPlayingView: View {
    @Environment(\.presentationMode) var presentationMode
    let artworkSize: CGFloat = 355

    var body: some View {
        ZStack {
            Color("nowPlayingBackgroundColor")
                .edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                        .padding()
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    
                    Text("Now Playing")
                        .foregroundColor(.white)
                        .bold()
                    
                    Text("Notes")
                        .foregroundColor(.gray)
                        .bold()
                        .padding(.leading, 7)

                    Spacer()

                    Button(action: {}) {
                        Image(systemName: "list.triangle")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing)
                }
                .padding(.horizontal, 5)
                .padding(.bottom, 20)

                Image("Cover")
                    .resizable()
                    .frame(width: artworkSize, height: artworkSize)
                    .cornerRadius(8.0)

                VStack {
                    Text("Q&A com espectadores ao vivo")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.bottom, 0.1)

                    Text("The Vergecast")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                .padding()
                
                SeekBar()
                    .padding(.bottom, 25)

                HStack {
                    Button(action: {}) {
                        Image(systemName: "gobackward.15")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())

                    Button(action: {}) {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 90))
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 30)

                    Button(action: {}) {
                        Image(systemName: "goforward.30")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                NowPlayingToolbar()
                    .padding(.top, 30)
            }
        }
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}
