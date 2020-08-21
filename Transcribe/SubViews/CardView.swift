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
                    Image(systemName: "book.circle").resizable()
                        .foregroundColor(.pink)
                        .frame(height: 200, alignment: .center)
                        .aspectRatio(1, contentMode: .fit)
                        .padding(.bottom, 50)
                    CardRow()
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
    
    @State private var show = false
    
    var title: String
    var bodyText: String
    var color: Color
    
    var body: some View {
        VStack {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 150, height: 150, alignment: .center)
            .foregroundColor(color)
            .overlay(Text(bodyText)
                .font(.footnote)
                .foregroundColor(Color(#colorLiteral(red: 0.9603804946, green: 0.9546712041, blue: 0.9647691846, alpha: 1)))
                .padding()
        ).shadow(color: color.opacity(0.5), radius: 7, x: 0, y: 2)
            .onTapGesture {
                self.show = false
            }
            GeometryReader { geometry in
                Text(self.title).padding(.horizontal, 15).padding(.vertical, 7)
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: geometry.frame(in: .local).height / 6)
                        .foregroundColor(.red).opacity(0.9)).position(x: geometry.frame(in: .local).midX * 1.2, y: geometry.frame(in: .local).minY - 30)
                    .rotationEffect(Angle(degrees: self.show ? 50 : 0))
                    .animation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0))
                    .onTapGesture {
                        self.show.toggle()
                }
            }
        }
    }
}

struct CardRow: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(notes) { note in
                    GeometryReader { geometry in
                        SingleCardView(title: note.title ,bodyText: note.bodyText, color: note.color)
                            .rotation3DEffect(Angle(degrees:
                                (Double(geometry.frame(in: .global).minX) / -15) + 5),
                                              axis: (x: 0, y: 20.0, z: 0))
                    }
                    .frame(width: 150, height: 250)
                }.padding(.horizontal, 5)
            }.padding()
        }
        .frame(width: UIScreen.main.bounds.width, height: 250)
    }
}

let notes: [Note] = [
    Note(title: "First Note", bodyText: "This is my first note, this is so cool. SwiftUI is awesome!", audioFilename: "audioFile1.mp3", color: Color("cardColor3")),
    Note(title: "Rap Lyrics", bodyText: "Bust some awesome rhymes, do it everytime-z", audioFilename: "audioFile1.mp3", color: Color("cardColor2")),
    Note(title: "Grocery List", bodyText: "Buy milk, cheese, bread, sour cream, eggs, cake mix, vegetables, fruit", audioFilename: "audioFile1.mp3", color: Color("cardColor1")),
    Note(title: "Note to future self in the world, you've come a long way buddy.", bodyText: "This is your future self telling you to avoid riding your bike at night, especially when it rains", audioFilename: "audioFile1.mp3", color: Color("cardColor2"))
]
