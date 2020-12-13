//
//  SeekBar.swift
//  PodcastApp
//
//  Created by Rafael Schmitt on 13/12/20.
//

import SwiftUI

struct SeekBar: View {
    let playheadSize: CGFloat = 12
    
    var body: some View {
        VStack {
            ZStack {
                Capsule()
                    .fill(Color.gray)
                    .frame(width: 370, height: 4)
                    .opacity(0.6)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: playheadSize, height: playheadSize)
            }
            
            HStack {
                Text("35:43")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("-13:09")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct SeekBar_Previews: PreviewProvider {
    static var previews: some View {
        SeekBar()
            .background(Color("nowPlayingBackgroundColor"))
    }
}
