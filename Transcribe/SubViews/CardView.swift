//
//  CardView.swift
//  Transcribe
//
//  Created by Matthew Martindale on 8/19/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    var body: some View {
        
        ZStack {
            Color("backgroundColor").edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    Image("placeholderImage").resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(50)
                    CardRow().padding(.bottom, 50)
                    CardRow().padding(.bottom, 50)
                    CardRow().padding(.bottom, 50)
                }
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView()
            CardView()
                .environment(\.colorScheme, .dark)
        }
    }
}

struct SingleCardView: View {
    
    var text: String = "Hello"
    
    var body: some View {
        VStack {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 150, height: 150, alignment: .center)
            .foregroundColor(Color("violetColor"))
            .overlay(Text(text).foregroundColor(.white))
            Text("Title")
        }
    }
}

struct CardRow: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(0..<15) { index in
                    GeometryReader { geometry in
                        SingleCardView(text: "\(index)")
                            .rotation3DEffect(Angle(degrees:
                                Double(geometry.frame(in: .global).minX) / -30),
                                              axis: (x: 0, y: 10.0, z: 0))
                    }
                    .frame(width: 150, height: 170)
                }.padding(.horizontal, 5)
            }.padding()
        }
        .frame(width: UIScreen.main.bounds.width, height: 150)
    }
}
