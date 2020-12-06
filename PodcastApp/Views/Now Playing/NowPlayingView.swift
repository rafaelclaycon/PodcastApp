//
//  NowPlayingView.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 06/12/20.
//

import SwiftUI

struct NowPlayingView: View {
    @Environment(\.presentationMode) var presentationMode

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

                    Spacer()

                    Button(action: {}) {
                        Image(systemName: "list.triangle")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())
                }.padding()

                Image("Cover")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .cornerRadius(8.0)

                Text("Q&A com espectadores ao vivo")
                    .foregroundColor(.white)
                    .bold()
                    .padding()

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
            }
        }
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}
