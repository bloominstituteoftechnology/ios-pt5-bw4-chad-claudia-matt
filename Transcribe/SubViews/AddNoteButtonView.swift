//
//  AddNoteButtonView.swift
//  Transcribe
//
//  Created by Matthew Martindale on 8/25/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI

struct AddNoteButtonView: View {
    var body: some View {
        
        Button(action: {
//            Todo
        }) {
            ZStack {
                Circle()
                .frame(width: 55, height: 55)
                    .foregroundColor(.blue)
                Image(systemName: "plus")
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                .frame(width: 20, height: 20)
                .padding(12)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("cardColor1"), Color("cardColor2")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
                    .shadow(color: Color.white.opacity(0.1), radius: 10, x: -5, y: -5)
            }.opacity(0.8)
        }
    }
}

struct AddNoteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteButtonView()
//            .previewLayout(.sizeThatFits)
//            .background(Color.gray)
    }
}
