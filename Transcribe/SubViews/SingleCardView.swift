//
//  SingleCardView.swift
//  Transcribe
//
//  Created by Matthew Martindale on 8/23/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI

struct SingleCardView: View {
    
    @State private var show = false
    
    var title: String
    var bodyText: String
    var gradientColor1: Color
    var gradientColor2: Color
    
    var body: some View {
        ZStack {
            
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(gradient: Gradient(colors: [gradientColor1, gradientColor2]), startPoint: .top, endPoint: .bottomLeading))
                    .frame(width: 150, height: 150, alignment: .center)
                    .overlay(Button(action: {
                        print("Edit button tapped")
                    }) {
                        Image(systemName: "pencil.circle")
                            .foregroundColor(Color("editButtonColor"))
                            .font(.system(size: 25, weight: .bold))
                            .position(CGPoint(x: 7, y: 7))
                            .shadow(color: Color("editButtonColor").opacity(0.5), radius: 5, x: 4, y: 6)
                    })
                    .overlay(Text(bodyText)
                        .font(.footnote)
                        .foregroundColor(Color(#colorLiteral(red: 0.9603804946, green: 0.9546712041, blue: 0.9647691846, alpha: 1)))
                        .padding()
                ).shadow(color: Color("cardColor1").opacity(0.5), radius: 7, x: 0, y: 2)
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
}

struct SingleCardView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCardView(title: "Hello World!", bodyText: "Body Text", gradientColor1: Color("cardColor1"), gradientColor2: Color("cardColor2"))
    }
}
